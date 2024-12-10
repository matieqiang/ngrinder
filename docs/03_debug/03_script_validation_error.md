script validation error
===


原因是oshi错误，仅发生在docker container环境
目前，基于JDK版本已更改为11。因此，更新oshi版本以与JDK 11一起使用。
并且预计此更改还将解决oshi问题。

ngrinder-3.5.9已经解决次问题，
ngrinder-3.5.9-p1-20240613增加了安全依赖修复

https://github.com/naver/ngrinder/issues/940


