DROP DATABASE tabledb;
CREATE DATABASE tabledb;
USE tabledb;

DROP TABLE IF EXISTS usertbl;

CREATE TABLE usertbl(
    userID      CHAR(8) NOT NULL PRIMARY KEY,
    name        VARCHAR(10) NOT NULL,
    birthYear   INT NOT NULL,
    addr        CHAR(2) NOT NULL,
    mobile1     CHAR(3) NULL,
    mobile2     CHAR(8) NULL,
    height      SMALLINT NULL,
    mDate       DATE NULL
);

CREATE TABLE buytbl(
    num         INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    userid      CHAR(8) NOT NULL,
    prodName    CHAR(6) NOT NULL,
    groupName   CHAR(4) NULL,
    price       INT NOT NULL,
    amount      SMALLINT NOT NULL,
    FOREIGN KEY(userid) REFERENCES usertbl(userID)
);