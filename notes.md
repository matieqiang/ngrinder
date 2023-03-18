notes
===
无效的默认值，修改数据库模式
create database ngrinder DEFAULT CHARACTER SET utf8;
-- SET GLOBAL SQL_MODE = 'ALLOW_INVALID_DATES';
set global SQL_MODE = 'NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
show global variables like 'SQL_MODE';

simple web station
docker run --name some-nginx -v /d/docker/nginx:/usr/share/nginx/html:ro -p 80:80 -d nginx
