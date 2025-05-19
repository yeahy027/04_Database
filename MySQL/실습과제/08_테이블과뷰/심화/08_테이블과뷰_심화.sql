-- 다음 컬럼을 가지는 userTBL과 buyTBL을 정의하세요.
-- ○ 기존에 테이블이 존재하면 삭제함
DROP TABLE IF EXISTS usertbl, buytbl;
CREATE TABLE usertbl (
    userID      CHAR(8) NOT NULL PRIMARY KEY,
    name        VARCHAR(10) NOT NULL,
    birthyear   INT NOT NULL
);
CREATE TABLE buytbl (
    num         INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    userID      CHAR(8) NOT NULL,
    prodName    CHAR(6) NOT NULL,
    FOREIGN KEY(userID) REFERENCES usertbl(userID)
);


-- 다음 조건을 만족하는 userTBL 테이블을 정의하세요.
-- ○ 기존에 usertbl, buytbl을 삭제하세요.
DROP TABLE IF EXISTS usertbl, buytbl;
CREATE TABLE usertbl (
    userID      CHAR(8) NOT NULL PRIMARY KEY,
    name        VARCHAR(10) NOT NULL,
    birthyear   INT NOT NULL,
    email       CHAR(30) NULL UNIQUE
);


-- 다음 조건을 만족하는 userTBL 테이블을 정의하세요.
-- ○ 기존 usertbl을 삭제하세요.
DROP TABLE usertbl;
CREATE TABLE usertbl (
    userID      CHAR(8) NOT NULL PRIMARY KEY,
    name        VARCHAR(10),
    birthyear   INT CHECK (birthyear >= 1900 AND birthyear <= 2023),
    mobile       CHAR(3) NOT NULL
);

-- 다음 조건을 만족하는 userTBL 테이블을 정의하세요.
-- ○ 기존 usertbl을 삭제하세요.
-- ○ 기본값 추가를 확인할 수 있는 데이터를 추가하세요.
DROP TABLE usertbl;
CREATE TABLE usertbl (
    userID      CHAR(8) NOT NULL PRIMARY KEY,
    name        VARCHAR(10) NOT NULL,
    birthYear   INT NOT NULL DEFAULT -1,
    addr        CHAR(2) NOT NULL DEFAULT '서울',
    mobile1     CHAR(3) NULL,
    mobile2     CHAR(8) NULL,
    height      SMALLINT NULL DEFAULT 170,
    mDate       DATE NULL
);
INSERT INTO usertbl VALUES ('KBS', '김범수', default, default, NULL, NULL, default, null);


-- 앞에서 만든 userTBL에 대해서 다음 조건을 처리하도록 수정하세요.
-- ○ mobile1 컬럼을 삭제함
-- ○ name 컬럼명을 uName으로 변경함
-- ○ 기본키를 제거함
ALTER TABLE usertbl
    DROP COLUMN mobile1;

ALTER TABLE usertbl
    CHANGE COLUMN name uName VARCHAR(10);

ALTER TABLE usertbl
    DROP PRIMARY KEY;


-- 모든 문제는 employees 데이터베이스에서 수행한다.
-- 다음 정보를 가지는 직원 정보를 출력하는 EMPLOYEES_INFO 뷰를 작성하세요
CREATE VIEW EMPLOYEES_INFO
AS
    SELECT
        E.emp_no, E.birth_date, E.first_name, E.last_name, E.gender, E.hire_date,
        T.title, T.from_date AS t_from, T.to_date AS t_to,
        S.salary, S.from_date AS s_from, S.to_date AS s_to
    FROM
        employees E
    INNER JOIN
        titles T
        ON E.emp_no = T.emp_no
    INNER JOIN
        salaries S
        ON E.emp_no = S.emp_no;


-- EMPLOYEES_INFO 뷰에서 재직자의 현재 정보만 출력하세요.
SELECT
    *
FROM
    EMPLOYEES_INFO
WHERE
    s_to = '9999-01-01';


-- 다음 정보를 가지는 부서 정보를 출력하는 EMP_DEPT_INFO 뷰를 작성하세요
CREATE VIEW EMP_DEPT_INFO
AS
    SELECT
        DE.emp_no, D.dept_no, D.dept_name, DE.from_date, DE.to_date
    FROM
        departments D
    INNER JOIN
        dept_emp DE
        ON D.dept_no = DE.dept_no
    ORDER BY DE.emp_no;


-- EMP_DEPT_INFO로 현재 재직자의 부서 정보를 출력하세요.
SELECT
    *
FROM
    EMP_DEPT_INFO
WHERE
    to_date = '9999-01-01';