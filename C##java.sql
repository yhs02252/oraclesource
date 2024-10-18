CREATE TABLE usertbl(
	userid varchar2(20) PRIMARY KEY,
	name varchar2(20) NOT NULL,
	password varchar2(20) NOT NULL,
	age number(3) NOT NULL,
	email varchar2(20) NOT NULL
);

INSERT INTO USERTBL values('hong123', '홍길동','hong123',25,'hong123@naver.com');

ALTER TABLE USERTBL MODIFY email varchar2(50);

-- userid 와 password 가 일치하는 회원 조회
SELECT USERID, NAME FROM USERTBL WHERE USERID='hong123' AND PASSWORD='hong123';

-- 회원 전체조회
SELECT USERID,NAME,AGE,EMAIL FROM USERTBL;

--DELETE FROM USERTBL WHERE userid = 'cake104'

-- 비밀번호 변경
-- 아이디와 현재 비밀번호가 일치하면 새 비밀번호로 변경
UPDATE USERTBL SET PASSWORD = 'make123!@#' WHERE USERID = 'cake104' AND PASSWORD = 'make123!#'

-- 사용자 삭제
DELETE FROM USERTBL WHERE userid = 'hong123' AND password = 'hong456'

-- booktbl
-- code number(4) pk
-- title text (50)
-- writer text (30)
-- price number (10)

-- 1000 자바의 정석 신용균 25000
-- 1001 자바의 신 강신용 29000
-- 1002 자바 1000제 남궁성 32000
-- 1003 오라클 박응용 33000
-- 1004 점프투파이썬 신기성 35000

CREATE TABLE booktbl (
	code number(4) PRIMARY KEY,
	title varchar2(50) NOT NULL,
	writer varchar2(30) NOT NULL,
	price number(10) NOT NULL
);

ALTER TABLE BOOKTBL ADD description VARCHAR2(1000);

INSERT INTO BOOKTBL values(1000, '자바의 정석', '신용균', 25000, null);
INSERT INTO BOOKTBL values(1001, '자바의 신', '강신용', 29000);
INSERT INTO BOOKTBL values(1002, '자바 1000제', '남궁성', 32000);
INSERT INTO BOOKTBL values(1003, '오라클', '박응용', 33000);
INSERT INTO BOOKTBL values(1004, '점프투파이썬', '신기성', 35000);

-- 전체 조회
SELECT * FROM BOOKTBL

-- 도서번호 1000번인 도서 조회
SELECT  * FROM BOOKTBL WHERE code = 1000

-- 도서번호 1001번인 도서 가격 수정
UPDATE BOOKTBL SET PRICE = 35000 WHERE code = 1001

-- 도서 가격 및 상세 설명까지 수정
UPDATE BOOKTBL SET PRICE = 35000, DESCRIPTION='상세설명'  WHERE code = 1001

-- 도서번호 1004 번 도서 삭제
DELETE FROM BOOKTBL WHERE code = 1004

-- 도서명에 '자바' 키워드가 들어있는 도서 조회
SELECT * FROM BOOKTBL WHERE title LIKE '%자바%'


-- 더미 데이터 삽입
CREATE SEQUENCE book_seq
START WITH 2000;


INSERT INTO BOOKTBL(CODE,TITLE,WRITER,PRICE)
(SELECT book_seq.NEXTVAL,TITLE,WRITER,PRICE FROM BOOKTBL);


SELECT COUNT(*) FROM BOOKTBL; 

-- 검색(조회)
-- title에 자바 키워드가 포함된 도서 조회 후 도서코드로 내림차순 정렬
SELECT * FROM BOOKTBL WHERE title LIKE '%자바%' ORDER BY CODE ASC;

SELECT * FROM BOOKTBL WHERE title LIKE '%%' ORDER BY CODE ASC;


CREATE TABLE MEMBERTBL (
	USERID VARCHAR2(20) PRIMARY KEY, 
	NAME VARCHAR2(20) NOT NULL, 
	PASSWORD VARCHAR2(20) NOT NULL
	)

INSERT INTO MEMBERTBL(USERID,NAME,PASSWORD) VALUES('hong123','홍길동','hong123');

-- 아이디와 비밀번호가 일치하는 회원 조회
SELECT * FROM MEMBERTBL WHERE USERID='hong123' AND PASSWORD='hong123';

-- 중복 아이디 검사
--
SELECT * FROM MEMBERTBL WHERE USERID ='hong123';

-- 비밀번호 변경
UPDATE MEMBERTBL SET PASSWORD='jofw212' WHERE USERID='hong123' AND PASSWORD ='hong123'



-- board
-- bno, name(var2 20), password(var2 20), title(var2 100), content(var2 2000), file(var2 100), re_ref, re_lev, re-seq, readcnt, regdate(date-sysdate)
CREATE TABLE BOARD (
	BNO NUMBER PRIMARY KEY,
	NAME VARCHAR2(20) NOT NULL,
	PASSWORD VARCHAR2(20) NOT NULL,
	TITLE VARCHAR2(100) NOT NULL,
	CONTENT VARCHAR2(2000) NOT NULL,
	ATTACH VARCHAR2(100) NOT NULL,
	RE_REF NUMBER NOT NULL,
	RE_LEV NUMBER NOT NULL,
	RE_SEQ NUMBER NOT NULL,
	READCNT NUMBER DEFAULT 0,
	REGDATE DATE DEFAULT SYSDATE
);

-- 시퀀스 생성 board_seq
CREATE SEQUENCE board_seq;