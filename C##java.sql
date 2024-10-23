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
	ATTACH VARCHAR2(100) NOT NULL, -- 파일 경로입력을 위해 varchar2로 저장
	RE_REF NUMBER NOT NULL,
	RE_LEV NUMBER NOT NULL,
	RE_SEQ NUMBER NOT NULL,
	READCNT NUMBER DEFAULT 0,
	REGDATE DATE DEFAULT SYSDATE
);

-- 시퀀스 생성 board_seq
CREATE SEQUENCE board_seq;

SELECT BNO,NAME,TITLE,READCNT,REGDATE FROM BOARD ORDER BY BNO DESC;

-- board attach not null ==> null 가능
ALTER TABLE BOARD MODIFY ATTACH varchar2(100) NULL;

INSERT INTO BOARD(BNO,NAME,PASSWORD,TITLE,CONTENT,RE_REF,RE_LEV,RE_SEQ) VALUES(board_seq.nextval, 'hong','12345','board 작성','board 작성',board_seq.currval,0,0);

SELECT * FROM BOARD WHERE BNO = 1;

-- 수정
-- bno와 password가 일치 시 title,content 수정
UPDATE BOARD SET TITLE = 'dskods', CONTENT ='dsandlsa' WHERE BNO = 1 AND PASSWORD = 12345;

DELETE FROM BOARD WHERE BNO = 10 AND PASSWORD = 12345;

UPDATE BOARD SET READCNT = READCNT + 1 WHERE BNO = 3;

-- 더미 데이터
INSERT INTO BOARD(BNO,NAME,PASSWORD,TITLE,CONTENT,RE_REF,RE_LEV,RE_SEQ)
(SELECT board_seq.NEXTVAL,NAME,PASSWORD,TITLE,CONTENT,board_seq.CURRVAL,RE_LEV,RE_SEQ FROM BOARD);

-- 댓글 처리

-- 가장 최신글에 댓글 처리
SELECT * FROM BOARD WHERE BNO = (SELECT MAX(bno) FROM BOARD)

-- 그룹 개념

-- 댓글 추가(re_ref : 부모글의 re_ref 넣어주기)
-- re_lev : 부모글 re_lev + 1
-- re_seq : 부모글 re_seq + 1
INSERT INTO BOARD(BNO,NAME,PASSWORD,TITLE,CONTENT,RE_REF,RE_LEV,RE_SEQ)
VALUES(board_seq.nextval, 'hong','12345','board 작성','board 작성',663,1,1);
--VALUES(board_seq.nextval, 'hong','12345','board 작성','board 작성',663,0,0);

UPDATE BOARD SET RE_LEV = 2, RE_SEQ = 10 WHERE BNO = 676;

-- 원본글과 댓글 함께 조회
SELECT * FROM BOARD WHERE RE_REF = 663;

-- 두번째 댓글 추가(최신순 조회 : re_seq)
-- re_seq가 낮을수록 최신글이라면

-- 원본글
--  ㄴ댓글2
--    ㄴ댓글2-1
--  ㄴ댓글1

-- 댓글2 추가
-- 먼저 들어간 댓글이 있다면 re_seq 값을 + 1 해야 함 
-- UPDATE BOARD SET RE_SEQ = RE_SEQ + 1 WHERE RE_REF = 부모글 RE_REF AND RE_SEQ > 부모글 RE_SEQ;
UPDATE BOARD SET RE_SEQ = RE_SEQ + 1 WHERE RE_REF = 663 AND RE_SEQ > 0;

INSERT INTO BOARD(BNO,NAME,PASSWORD,TITLE,CONTENT,RE_REF,RE_LEV,RE_SEQ)
VALUES(board_seq.nextval, 'hong','12345','board 작성4','board 작성4',663,1,1);

SELECT * FROM BOARD WHERE RE_REF = 663 ORDER BY RE_REF DESC, RE_SEQ ASC;

-- 검색
-- 조건 title or content or name

SELECT BNO,NAME,TITLE,READCNT,REGDATE,RE_LEV FROM BOARD WHERE TITLE LIKE '%board%' ORDER BY RE_REF DESC, RE_SEQ ASC;

-- 오라클 페이지 나누기
-- 정렬이 완료된 후 번호를 매겨서 일부분 추출

SELECT rownum,BNO,NAME,TITLE,READCNT,REGDATE,RE_LEV FROM BOARD ORDER BY RE_REF DESC, RE_SEQ ASC;
SELECT rownum,BNO,NAME,TITLE,READCNT,REGDATE,RE_LEV FROM BOARD ORDER BY BNO DESC;

SELECT RNUM,BNO,NAME,TITLE,READCNT,REGDATE,RE_LEV 
FROM (SELECT ROWNUM RNUM,BNO,NAME,TITLE,READCNT,REGDATE,RE_LEV 
	  FROM(SELECT BNO,NAME,TITLE,READCNT,REGDATE,RE_LEV FROM BOARD ORDER BY RE_REF DESC, RE_SEQ ASC) 
	  WHERE ROWNUM <= 20)
WHERE RNUM>10;

-- 1 page 요청 : rownum <= 10 rnum > 0;
-- 2 page 요청 : rownum <= 20 rnum > 10;
-- 3 page 요청 : rownum <= 30 rnum > 20;

-- rownum : 1page * = 10 = 10
-- rnum : (1page - 1) * 10