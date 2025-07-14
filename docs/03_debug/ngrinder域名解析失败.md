域名解析失败
===

## 问题描述：
ngrinder 脚本调试过程出现域名解析异常
```log
ava.util.concurrent.ExecutionException: java.net.UnknownHostException: sandbox-sg-api.example.com
java.net.UnknownHostException: sandbox-sg-api.example.com
at org.apache.hc.core5.reactor.SingleCoreIOReactor.validateAddress(SingleCoreIOReactor.java:285)
at org.apache.hc.core5.reactor.SingleCoreIOReactor.processConnectionRequest(SingleCoreIOReactor.java:313)
at org.apache.hc.core5.reactor.SingleCoreIOReactor.processPendingConnectionRequests(SingleCoreIOReactor.java:302)
at org.apache.hc.core5.reactor.SingleCoreIOReactor.doExecute(SingleCoreIOReactor.java:139)
at org.apache.hc.core5.reactor.AbstractSingleCoreIOReactor.execute(AbstractSingleCoreIOReactor.java:85)
at org.apache.hc.core5.reactor.IOReactorWorker.run(IOReactorWorker.java:44)
2025-07-11 03:46:27,267 INFO  finished 1 run
```
## 分析
### 1. 出问题时的一些信息
检查ngrinder controller /etc/resolv.conf配置

```
search tools.svc.cluster.local svc.cluster.local cluster.local
nameserver 10.96.0.10
options ndots:5
```
### 先解释一下这个配置的含义
#### search 
字段作用：定义域名搜索顺序列表

当查询的主机名不包含点号（如 my-service）时，系统会按顺序尝试追加这些后缀，示例查询 my-service 的实际搜索顺序：
当找不到域名地址映射会向下继续查找，知道找到为止
- my-service.tools.svc.cluster.local
- my-service.svc.cluster.local
- my-service.cluster.local

#### nameserver 
字段作用：指定 DNS 服务器地址，所有 DNS 查询均发送至此服务器

关键特性： 最多可配置 3 个（按顺序尝试） 此处 10.96.0.10 是 Kubernetes 集群的 CoreDNS/kube-dns 服务 IP

#### options ndots:5 
字段作用：控制域名解析策略，减少无效 DNS 查询,工作逻辑：

主机名中的点数量|查询顺序|示例
-|-|-
≥5	|先直接查询，失败后加搜索域	|a.b.c.d.e.f
<5	|先尝试搜索域，最后直接查询	|my-service


## 问题产生原因分析
为什么在pod shell中用telnet 测试是没问题的。

因为telnet 使用系统级解析器，最终还是会尝试原始域名“sandbox-sg-api.example.com”

Kubernetes 默认设置 ndots:5，导致任何包含少于5个点的域名都会先尝试追加搜索域中的配置

对于 sandbox-sg-api.example.com（3个点）实际 DNS 解析顺序：，系统会依次尝试：
- sandbox-sg-api.example.com.tools.svc.cluster.local
- sandbox-sg-api.example.com.svc.cluster.local
- sandbox-sg-api.example.com.cluster.local
- 最后才尝试原始域名

而Java 应用使用 JVM 自带的解析器，JVM DNS 解析过程中，当某个查询失败时，Java 可能直接抛出异常而不继续尝试

## 解决
对于 sandbox-sg-api.example.com 包含2个点，让JVM直接尝试原始域名，不再追加搜索域，就需要设置 ndots:2

controller和agent的 deployment增加 dnsConfig配置如下
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ngrinder-controller
spec:
  template:
    spec:
      dnsConfig:
        searches:   # 精简搜索域
          - example.com  # 您的业务域名
          - cluster.local
        options:
          - name: ndots
            value: "2"   # 降低 ndots 值
```

重新部署Deployment问题解决。
