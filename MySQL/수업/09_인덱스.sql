CREATE DATABASE scoula_db;

DROP USER IF EXISTS 'scoula'@'%';

CREATE USER 'scoula'@'%' IDENTIFIED BY '1234';

GRANT ALL PRIVILEGES ON scoula_db.* TO 'scoula'@'%';
GRANT ALL PRIVILEGES ON sqldb.* TO 'scoula'@'%';

FLUSH PRIVILEGES;