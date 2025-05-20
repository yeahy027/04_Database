-- sqldb 데이터베이스에 다음과 같은 컬럼을 가지는 테이블 tbl1을 생성하고, 자동 생성된 인덱스 목록을 확인하세요.
-- ○ 컬럼목록
--  a INT PRIMARY KEY
--  b INT
--  c INT
USE sqldb;
CREATE TABLE tbl1 (
    a   INT PRIMARY KEY,
    b   INT,
    c   INT
);
SHOW INDEX from tbl1;


-- sqldb 데이터베이스에 다음과 같은 컬럼을 가지는 테이블 tbl2를 생성하고, 자동 생성된 인덱스 목록을 확인하세요.
-- ○ 컬럼목록
--  a INT PRIMARY KEY
--  b INT UNIQUE
--  c INT UNIQUE
--  d INT
CREATE TABLE tbl2 (
    a   INT PRIMARY KEY,
    b   INT UNIQUE,
    c   INT UNIQUE,
    d   INT
);
SHOW INDEX from tbl2;


-- sqldb 데이터베이스에 다음과 같은 컬럼을 가지는 테이블 tbl3를 생성하고, 자동 생성된 인덱스 목록을 확인하세요.
-- ○ 컬럼목록
--  a INT UNIQUE,
--  b INT UNIQUE,
--  c INT UNIQUE,
--  d INT
CREATE TABLE tbl3 (
    a   INT UNIQUE,
    b   INT UNIQUE,
    c   INT UNIQUE,
    d   INT
);
SHOW INDEX from tbl3;


-- sqldb 데이터베이스에 다음과 같은 컬럼을 가지는 테이블 tbl4를 생성하고, 자동 생성된 인덱스 목록을 확인하세요.
-- ○ 컬럼목록
--  a INT UNIQUE NOT NULL,
--  b INT UNIQUE,
--  c INT UNIQUE,
--  d INT
CREATE TABLE tbl4 (
    a INT UNIQUE NOT NULL,
    b INT UNIQUE,
    c INT UNIQUE,
    d INT
);
SHOW INDEX from tbl4;


-- sqldb 데이터베이스에 다음과 같은 컬럼을 가지는 테이블 tbl5를 생성하고, 자동 생성된 인덱스 목록을 확인하세요.
-- ○ 컬럼목록
--  a INT UNIQUE NOT NULL,
--  b INT UNIQUE,
--  c INT UNIQUE,
--  d INT PRIMARY KEY
CREATE TABLE tbl5 (
    a INT UNIQUE NOT NULL,
    b INT UNIQUE,
    c INT UNIQUE,
    d INT PRIMARY KEY
);
SHOW INDEX from tbl5;


-- testdb에 다음 컬럼 목록을 가지는 usertbl을 만드세요.
-- ○ 컬럼목록
--  userID CHAR(8) NOT NULL PRIMARY KEY
--  name VARCHAR(10) NOT NULL
--  birthYear INT NOT NULL
--  addr NCHAR(2) NOT NULL
CREATE DATABASE testdb;
USE testdb;
CREATE TABLE usertbl (
    userID      CHAR(8) NOT NULL PRIMARY KEY,
    name        VARCHAR(10) NOT NULL,
    birthYear   INT NOT NULL,
    addr        NCHAR(2) NOT NULL
);


-- 아래 데이터를 추가하고, 클러스터형 인덱스의 테이블 내용을 확인하세요.
INSERT INTO usertbl VALUES ('LSG', '이승기', 1987, '서울');
INSERT INTO usertbl VALUES ('KBS', '김범수', 1979, '경남');
INSERT INTO usertbl VALUES ('KKH', '김경호', 1971, '전남');
INSERT INTO usertbl VALUES ('JYP', '조용필', 1950, '경기');
INSERT INTO usertbl VALUES ('S나', '성시경', 1979, '서울');
SELECT * FROM usertbl;


-- ALTER를 사용하여 usertbl에서 PRIMARY KEY 제약조건을 제거하고,
-- name 컬럼에 pk_name이라는 제약조건명으로 기본키를 설정하세요.
ALTER TABLE usertbl
    DROP PRIMARY KEY;
ALTER TABLE usertbl
    CHANGE COLUMN name pk_name VARCHAR(10) NOT NULL PRIMARY KEY;


-- usertbl의 내용을 출력하여, 새로운 클러스터형 인덱스를 확인하세요
SELECT * FROM usertbl;