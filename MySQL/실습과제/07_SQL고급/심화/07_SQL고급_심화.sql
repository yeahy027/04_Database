-- 1. 앞에서 정의한 3개의 테이블을 이용해서 다음을 처리하세요.
-- ○ 학생 테이블, 동아리 테이블, 학생 동아리 테이블을 이용해서 학생을 기준으로
-- 학생 이름/지역/가입한 동아리/동아리방을 출력하세요.
SELECT
    S.stdName AS 이름,
    S.addr AS 지역,
    SC.clubName AS '가입한 동아리',
    C.roomNo AS 동아리방
FROM
    stdtbl S
INNER JOIN
    stdclubtbl SC
    ON S.stdName = SC.stdName
INNER JOIN
    clubtbl C
    ON SC.clubName = C.clubName
ORDER BY
    S.stdName;

-- ○ 동아리를 기준으로 가입한 학생의 목록을 출력하세요.
--  출력정보 : clubName, roomNo, stdName, addr
SELECT
    C.clubName AS 동아리,
    C.roomNo AS 동아리방,
    S.stdName AS 이름,
    S.addr AS 지역
FROM
    clubtbl C
INNER JOIN
    stdclubtbl SC
    ON C.clubName = SC.clubName
INNER JOIN
    stdtbl S
    ON SC.stdName = S.stdName;


-- 2. 앞에서 추가한 테이블에서 '우대리'의 상관 연락처 정보를 확인하세요.
--  출력정보 : 부하직원, 직속상관, 직속상관연락처
SELECT
    A.emp AS '부하직원',
    B.emp AS '직속상관',
    B.empTel AS '직속상관연락처'
FROM
    emptbl A
INNER JOIN
    empTbl B
    ON A.manager = B.emp
WHERE
    A.emp = '우대리';


-- 3. 현재 재직 중인 직원의 정보를 출력하세요.
-- ○ 출력 항목 : emp_no, first_name, last_name, title
SELECT
    E.emp_no,
    E.first_name,
    E.last_name,
    T.title
FROM
    employees E
INNER JOIN
    titles T
    ON E.emp_no = T.emp_no
    AND T.to_date = '9999-01-01';


-- 4. 현재 재직 중인 직원의 정보를 출력하세요.
-- ○ 출력항목: 직원의 기본 정보 모두, title, salary
SELECT
    E.*,
    T.title,
    S.salary
FROM
    employees E
INNER JOIN
    titles T
    ON E.emp_no = T.emp_no
    AND T.to_date = '9999-01-01'
INNER JOIN
    salaries S
    ON E.emp_no = S.emp_no
    AND S.to_date = '9999-01-01';


-- 5. 현재 재직 중인 직원의 정보를 출력하세요.
-- ○ 출력항목: emp_no, first_name, last_name, department
-- ○ 정렬: emp_no 오름차순
SELECT
    E.emp_no,
    E.first_name,
    E.last_name,
    D.dept_name
FROM
    employees E
INNER JOIN
    dept_emp
    ON dept_emp.emp_no = E.emp_no
    AND dept_emp.to_date = '9999-01-01'
INNER JOIN
    departments D
    ON dept_emp.dept_no = D.dept_no
ORDER BY
    E.emp_no;


-- 6. 부서별 재직 중인 직원의 수를 출력하세요.
-- ○ 출력항목: 부서번호, 부서명, 인원수
-- ○ 정렬: 부서번호 오름차순
SELECT
    D.dept_no,
    D.dept_name,
    COUNT(DE.emp_no)
FROM
    dept_emp DE
INNER JOIN
    departments D
    ON DE.dept_no = D.dept_no
    AND DE.to_date = '9999-01-01'
GROUP BY
    DE.dept_no
ORDER BY
    DE.dept_no;


-- 7. 직원 번호가 10209인 직원의 부서 이동 히스토리를 출력하세요.
-- ○ 출력항목: emp_no, first_name, last_name, dept_name, from_date, to_date
SELECT
    E.emp_no,
    E.first_name,
    E.last_name,
    D.dept_name,
    DE.from_date,
    DE.to_date
FROM
    employees E
INNER JOIN
    dept_emp DE
    ON E.emp_no = DE.emp_no
INNER JOIN
    departments D
    ON D.dept_no = DE.dept_no
WHERE
    DE.emp_no = '10209';