-- sqldb에서 usertbl 테이블에서 다음 내용들을 확인하세요
-- ○ usertbl의 내용 확인
USE sqldb;
SELECT *
FROM usertbl;

-- ○ usertbl의 인덱스 목록 확인
SHOW INDEX from usertbl;

-- ○ usertbl의 데이터 크기와 인덱스의 크기 확인
SHOW TABLE STATUS LIKE 'usertbl';


-- usertbl의 addr 컬럼에 대해 idx_usertbl_addr 이름으로 인덱스를 만들고, 인덱스 목록을 확인하세요.
CREATE INDEX idx_usertbl_addr
    ON usertbl(addr);
SHOW INDEX from usertbl;


-- usertbl의 상태를 출력하여 인덱스의 내용이 만들어졌는지 확인하고, 내용이 없다면 실제 적용되도록 한 후, 인덱스의 크기를 확인하세요.
SHOW TABLE STATUS LIKE 'usertbl';
ANALYZE TABLE usertbl;
SHOW TABLE STATUS LIKE 'usertbl';


-- usertbl에 대해 다음을 처리하세요.
-- ○ birthYear 컬럼에 대해 idx_usertbl_birthYear 이름의 인덱스를 만드세요
--  에러가 난다면 그 이유를 설명하세요.
-- birthYear에 중복된 값이 존재해서 고유 인덱스를 만들 수 없다.
CREATE UNIQUE INDEX idx_usertbl_birthYear
    ON usertbl(birthYear);

-- name 컬럼에 대해 idx_usertbl_name 이름의 인덱스를 만드세요
CREATE INDEX idx_usertbl_name
    ON usertbl(name);

-- 생성된 인덱스의 목록을 확인하세요
SHOW INDEX from usertbl;


-- usertbl에 대해 다음을 처리하세요.
-- ○ name 컬럼에 대한 보조 인덱스를 삭제하세요
DROP INDEX idx_usertbl_name ON usertbl;

-- ○ name과 birthYear 컬럼 조합으로 idx_usertbl_name_birthYear 이름의 인덱스를 생성하세요
CREATE INDEX idx_usertbl_name_birthYear
    ON usertbl(name, birthYear);

-- ○ 인덱스의 목록을 확인하세요
SHOW INDEX from usertbl;


-- usertbl에서 앞에서 만든 인덱스를 삭제하세요.
DROP INDEX idx_usertbl_addr ON usertbl;
DROP INDEX idx_usertbl_name_birthYear ON usertbl;


-- 다음과 같이 실습 데이터베이스 및 사용자를 생성하고, 해당 데이터베이스에 대해 모든 권한을 부여하세요.
-- ○ 데이터베이스 명 : scoula_db
-- ○ 사용자 명 : scoula
-- ○ 비밀번호 : 1234
-- ○ 접속 호스트 : 제한 없음

-- scoula_db 데이터베이스(스키마) 생성
DROP DATABASE IF EXISTS scoula_db;
CREATE DATABASE scoula_db;

-- 모든 호스트에서 접속 가능한 사용자 scoula 생성
DROP USER IF EXISTS 'scoula'@'%';
CREATE USER 'scoula'@'%' IDENTIFIED BY '1234';

-- scoula 계정에 scoula_db 모든 권한 부여
GRANT ALL PRIVILEGES ON scoula_db.* TO 'scoula'@'%';

-- 권한 적용
FLUSH PRIVILEGES