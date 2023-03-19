build.gradle
===

## element
see: https://docs.gradle.org/current/dsl/org.gradle.api.Task.html
see: https://docs.gradle.org/6.3/dsl/


### def
## plugins block vs apply plugin
apply plugin和plugins是使用插件的两种方式，
apply plugin是老的写法，使用相对复杂，但是更灵活。 
plugins是比较新的写法，它将解析和应用两个步骤合并了，也是官方比较推荐的写法，
这种写法的前提是要使用的plugin是核心plugin或者发布在[Gradle plugin repository才可以！也就是说如果你自己写的gradle plugin或者公司的gradle plugin，只要是没有在插件仓库发布过的，都不能用.

