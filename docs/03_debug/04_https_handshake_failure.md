---
date:       2025/1/22
author:     matieqiang
---

04_https_handshake_failure
===

本地运行脚本可以正常，但在ngrinder中运行时，出现`Received fatal alert: handshake_failure`错误。

## 脚本运行日志
```
ERROR Received fatal alert: handshake_failure
javax.net.ssl.SSLHandshakeException: Received fatal alert: handshake_failure
	at org.apache.http.conn.ssl.SSLConnectionSocketFactory.createLayeredSocket(SSLConnectionSocketFactory.java:436)
	at org.apache.http.conn.ssl.SSLConnectionSocketFactory.connectSocket(SSLConnectionSocketFactory.java:384)
	at org.apache.http.impl.conn.DefaultHttpClientConnectionOperator.connect(DefaultHttpClientConnectionOperator.java:142)
	at org.apache.http.impl.conn.PoolingHttpClientConnectionManager.connect(PoolingHttpClientConnectionManager.java:376)
	at org.apache.http.impl.execchain.MainClientExec.establishRoute(MainClientExec.java:393)
	at org.apache.http.impl.execchain.MainClientExec.execute(MainClientExec.java:236)
	at org.apache.http.impl.execchain.ProtocolExec.execute(ProtocolExec.java:186)
	at org.apache.http.impl.execchain.RetryExec.execute(RetryExec.java:89)
	at org.apache.http.impl.execchain.RedirectExec.execute(RedirectExec.java:110)
	at org.apache.http.impl.client.InternalHttpClient.doExecute(InternalHttpClient.java:185)
	at org.apache.http.impl.client.CloseableHttpClient.execute(CloseableHttpClient.java:83)
	at org.apache.http.impl.client.CloseableHttpClient.execute(CloseableHttpClient.java:108)
	at org.apache.http.impl.client.CloseableHttpClient.execute(CloseableHttpClient.java:56)
	at org.apache.http.client.HttpClient$execute.call(Unknown Source)
	at demo.TLSSetting.test(TLSCheck.groovy:86)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at net.grinder.scriptengine.groovy.junit.GrinderRunner.run(GrinderRunner.java:164)
	at net.grinder.scriptengine.groovy.GroovyScriptEngine$GroovyWorkerRunnable.run(GroovyScriptEngine.java:147)
	at net.grinder.engine.process.GrinderThread.run(GrinderThread.java:118)
```

## 解决方案
1. 问题原因是`ngrinder`使用的`JDK`版本不支持`TLSv1.2`，需要升级`JDK`版本。
2. 修改`ngrinder`的`agent`配置文件`agent.conf`，添加`-Dhttps.protocols=TLSv1.2`参数。
3. 重启`ngrinder`服务。
