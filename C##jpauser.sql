-- memo 테이블 생성
-- 메모번호(mno - pk), 메모내용(memo_text - not null)
CREATE TABLE MEMO (
	MNO NUMBER(20) PRIMARY KEY,
	MEMO_TEXT VARCHAR(200) NOT NULL
);

-- 메모번호는 시퀀스(memo_seq) 입력
CREATE SEQUENCE MEMO_SEQ;

DROP TABLE MEMO;
DROP SEQUENCE MEMO_SEQ;

INSERT INTO MEMO VALUES (memo_seq.nextval,'오늘의 할일');
