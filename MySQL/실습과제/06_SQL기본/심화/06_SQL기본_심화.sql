-- 1. 다음 결과가 나오도록 buytbl에 대한 SQL 문을 각각 작성하세요.
SELECT userID AS '사용자 아이디', SUM(amount) AS '총 구매 개수'
FROM buytbl
GROUP BY userID;

SELECT userID AS '사용자 아이디', SUM(price*amount) AS '총 구매액'
FROM buytbl
GROUP BY userID;


-- 2. 다음 결과가 나오도록 buytbl에 대한 SQL 문을 각각 작성하세요.
SELECT AVG(amount) AS '평균 구매 개수'
FROM buytbl;


SELECT userID, AVG(amount) AS '평균 구매 개수'
FROM buytbl
GROUP BY userID;


-- 3. 다음 결과가 나오도록 usertbl에 대한 SQL 문을 작성하세요.
-- ○ 가장 키가 큰 사람과 가장 키가 작은 사람을 출력함
SELECT name, height
FROM usertbl
WHERE height = (SELECT MAX(height) FROM usertbl)
    OR height = (SELECT MIN(height) FROM usertbl);


-- 4. 다음 결과가 나오도록 usertbl에 대한 SQL 문을 작성하세요.
SELECT COUNT(mobile1) AS '휴대폰이 있는 사용자'
FROM usertbl;


-- 5. buytbl 테이블로 다음을 처리하세요.
-- ○ 사용자별 총 구매액을 출력하세요.
SELECT userID AS '사용자', SUM(price*amount) AS '총 구매액'
FROM buytbl
GROUP BY userID;

-- ○ 총 구매액이 1,000이상인 사용자만 출력하세요.
SELECT userID AS '사용자', SUM(price*amount) AS '총 구매액'
FROM buytbl
GROUP BY userID
HAVING SUM(price*amount) >= 1000;


-- 6. world 데이터베이스에서 다음 질문을 처리하세요.
-- ○ city 테이블에서 국가코드가 'KOR'인 도시들의 인구수 총합을 구하시오.
SELECT SUM(Population)
FROM city
WHERE CountryCode = 'KOR';

-- ○ city 테이블에서 국가코드가 'KOR'인 도시들의 인구수 중 최소값을 구하시오.
-- 단, 결과를 나타내는 테이블의 필드는 "최소값"으로 표시하시오.
SELECT MIN(Population) AS '최소값'
FROM city
WHERE CountryCode = 'KOR';

-- ○ city 테이블에서 국가코드가 'KOR'인 도시들의 인구수 평균을 구하시오.
SELECT AVG(Population)
FROM city
WHERE CountryCode = 'KOR';

-- ○ city 테이블에서 국가코드가 'KOR'인 도시들의 인구수 중 최대값을 구하시오.
-- 단, 결과를 나타내는 테이블의 필드는 "최대값"으로 표시하시오.
SELECT MAX(Population) AS '최대값'
FROM city
WHERE CountryCode = 'KOR';

-- ○ country 테이블 각 레코드의 Name 칼럼의 글자수를 표시하시오.
SELECT length(Name)
FROM country;

-- ○ country 테이블의 나라명(Name칼럼)을 앞 세 글자만 대문자로 표시하시오.
SELECT UPPER(MID(Name, 1, 3))
FROM country;

-- ○ country 테이블의 기대수명(LifeExpectancy)을 소수점 첫째자리에서 반올림해서 표시하시오.
SELECT ROUND(LifeExpectancy)
FROM country;


-- 7. employees db에서 각 부서별 관리자를 출력하세요.
-- ○ 단, 현재 재직자만 출력한다.
SELECT *
FROM dept_manager
WHERE to_date = '9999-01-01';


-- 8. 부서번호 d005부서의 핸재 관리자 정보를 출력하세요.
SELECT *
FROM employees
WHERE emp_no = (
    SELECT emp_no
    FROM dept_manager
    WHERE dept_no = 'd005'
    AND to_date = '9999-01-01'
    );

-- 9. employees 테이블에서 페이지네이션으로 페이지를 추출하려고 한다. 다음 조건하에서 8번 페이지의 데이터를 출력하세요.
-- ○ 입사일을 내림차순으로 정렬한다.
-- ○ 한 페이지당 20명의 정보를 출력한다.
SELECT *
FROM employees
ORDER BY hire_date DESC
LIMIT 140, 20;


-- 10. employees db에서 재직자의 총 수를 구하시오
-- ○ 재직자의 to_date 값은 '9999-01-01'로 저장되어 있음
SELECT COUNT(*)
FROM dept_emp
WHERE to_date = '9999-01-01';


-- 11. employees db에서 재직자의 평균 급여를 출력하시오.
SELECT AVG(salary)
FROM salaries
WHERE to_date = '9999-01-01';

-- 12. 재직자 전체 평균 급여보다 급여를 더 많이 받는 재직자를 출력하세요.
SELECT *
FROM salaries
WHERE to_date = '9999-01-01'
    AND salary > (
        SELECT AVG(salary)
        FROM salaries
        WHERE to_date = '9999-01-01'
    );


-- 12. employees db에서 각 부서별 재직자의 수를 구하시오.
-- ○ 부서 번호로 구분하고, 부서 번호로 오름차순 정렬하여 출력한다.
SELECT dept_no, COUNT(*)
FROM dept_emp
WHERE to_date = '9999-01-01'
GROUP BY dept_no
ORDER BY dept_no;