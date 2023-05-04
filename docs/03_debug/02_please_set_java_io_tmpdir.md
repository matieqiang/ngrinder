IDEA 启动NGrinderControllerStarter 提示 Please set `java.io.tmpdir` property
===

## 控制台提示
ERROR
Please set `java.io.tmpdir` property like following. tmpdir should be different from the OS default tmpdir.
`java -Djava.io.tmpdir=${NGRINDER_HOME}/lib -jar ngrinder-controller.war`

FAILURE: Build failed with an exception.

* What went wrong:
  Execution failed for task ':ngrinder-controller:NGrinderControllerStarter.main()'.
> Process 'command '/usr/local/java/jdk-11.0.12.jdk/Contents/Home/bin/java'' finished with non-zero exit value 1

* Try:
  Run with --stacktrace option to get the stack trace. Run with --info or --debug option to get more log output. Run with --scan to get full insights.

* Get more help at https://help.gradle.org

## 原因


NGrinderControllerStarter有个check临时目录的方法checkTmpDirProperty，对比jvm java.io.tmpdir和系统TMPDIR的路径是否一致，如果一致就会提示修改

## 解决
1. 在系统环境变量配置NGRINDER_HOME  export NGRINDER_HOME=/Users/matieqiang/ngrinder-controller
2. idea增加 vm options,-Djava.io.tmpdir=${NGRINDER_HOME}/lib，配置位置“edit configurations > build and run > Modify options > ad vm options”
3. ngrinder获取工作目录,参考NGrinderControllerStarter.cleanupPreviouslyUnpackedFolders

