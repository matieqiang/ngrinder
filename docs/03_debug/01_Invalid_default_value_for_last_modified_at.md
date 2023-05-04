本地调试
===

## 1. Invalid default value for 'last_modified_at'
liquibase.exception.DatabaseException: Invalid default value for 'last_modified_at' [Failed SQL: ALTER TABLE ngrinder.PERF_TEST CHANGE last_modified_date last_modified_at timestamp]

### 解决：
show variables like 'sql_mode';
-- 去掉sql_mode 中的NO_ZERO_IN_DATE,NO_ZERO_DATE

set sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION'

### 参考

### NO_ZERO_DATE
The NO_ZERO_DATE mode affects whether the server permits '0000-00-00' as a valid date. Its effect also depends on whether strict SQL mode is enabled.
• If this mode is not enabled, '0000-00-00' is permitted and inserts produce no warning.
• If this mode is enabled, '0000-00-00' is permitted and inserts produce a warning.
• If this mode and strict mode are enabled, '0000-00-00' is not permitted and inserts produce an error, unless IGNORE is given as well. For INSERT IGNORE and UPDATE IGNORE, '0000-00-00' is permitted and inserts produce a warning.

The ERROR_FOR_DIVISION_BY_ZERO, NO_ZERO_DATE, and NO_ZERO_IN_DATE SQL modes are now deprecated but enabled by default. The long term plan is to have them included in strict SQL mode and to remove them as explicit modes in a future MySQL release.

### NO_ZERO_IN_DATE
The NO_ZERO_IN_DATE mode affects whether the server permits dates in which the year part is nonzero but the month or day part is 0. (This mode affects dates such as '2010-00-01' or '2010-01-00', but not '0000-00-00'. To control whether the server permits '0000-00-00', use the NO_ZERO_DATE mode.) The effect of NO_ZERO_IN_DATE also depends on whether strict SQL mode is enabled.
• If this mode is not enabled, dates with zero parts are permitted and inserts produce no warning.
• If this mode is enabled, dates with zero parts are inserted as '0000-00-00' and produce a warning.
• If this mode and strict mode are enabled, dates with zero parts are not permitted and inserts produce an error, unless IGNORE is given as well. For INSERT IGNORE and UPDATE IGNORE, dates with zero parts are inserted as '0000-00-00' and produce a warning.
