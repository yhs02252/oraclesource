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


-- 회원, 팀
-- 회원은 단하나의 팀에 소속된다
-- 하나의 팀에는 여러 회원이 소속된다

-- 회원(아이디, 이름, 팀 정보)
-- 팀 (아이디, 팀명)

CREATE TABLE TEAM(
	TEAM_ID VARCHAR2(100) PRIMARY KEY,
	NAME VARCHAR2(100) NOT NULL
);

CREATE TABLE TEAM_MEMBER(
	MEMBER_ID VARCHAR2(100) PRIMARY KEY,
	USERNAME VARCHAR2(100) NOT NULL,
	TEAM_ID VARCHAR2(100) CONSTRAINT FK_MEMBER_TEAM REFERENCES TEAM(TEAM_ID)
);

INSERT INTO TEAM VALUES('team1', '팀1');
INSERT INTO TEAM VALUES('team2', '팀2');

INSERT INTO TEAM_MEMBER VALUES('user1','홍길동','team1');

-- 홍길동이 소속된 팀의 이름 조회
-- 내부 조인
SELECT tm.MEMBER_ID, tm.USERNAME, t.TEAM_ID, t.NAME FROM TEAM_MEMBER tm JOIN TEAM t ON tm.TEAM_ID =t.TEAM_ID ;

    select
        m1_0.id,
        t1_0.id,
        t1_0.name,
        m1_0.user_name 
    from
        team_member m1_0 
    left JOIN  -- <= Hibernate 방식에서는 외부조인으로 가져옴 
        team t1_0 
            on t1_0.id=m1_0.team_id 
    where
        m1_0.id=? --m1_0.id='user1' 
        

-- 회원 조회시 같은 팀에 소속된 회원 조회
-- 팀1
SELECT * FROM TEAM_MEMBER tm ;

SELECT tm.USER_NAME, tm.ID , t.ID , t.NAME 
FROM TEAM_MEMBER tm JOIN TEAM t ON tm.TEAM_ID =t.ID WHERE t.NAME = '팀1';