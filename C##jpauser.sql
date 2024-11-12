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

UPDATE MART_ITEM SET QUANTITY = 30 WHERE ITEM_ID = 1;
UPDATE MART_ITEM SET QUANTITY = 38 WHERE ITEM_ID = 2;
UPDATE MART_ITEM SET QUANTITY = 50 WHERE ITEM_ID = 3;

ALTER TABLE SPORTS_MEMBER DROP COLUMN LOCKER_LIST_LOCKER_ID;

DELETE FROM SPORTS_LOCKER sl WHERE SPORTS_MEMBER_MEMBER_ID = 1;
DELETE FROM SPORTS_LOCKER sl WHERE SPORTS_MEMBER_MEMBER_ID = 2;
DELETE FROM SPORTS_LOCKER sl WHERE SPORTS_MEMBER_MEMBER_ID = 3;
DELETE FROM SPORTS_LOCKER sl WHERE SPORTS_MEMBER_MEMBER_ID = 4;

UPDATE PARENT SET NAME = '부모5' WHERE ID = 5;

--PARENT 삭제
--무결성 제약조건이 위배되었습니다- 자식 레코드가 발견되었습니다
DELETE FROM PARENT p WHERE ID = 4;

-- ProBoard ID 기준으로 내림차순
SELECT * FROM PRO_BOARD pb ORDER BY PB.ID DESC ;

SELECT * FROM PRO_BOARD pb ;
SELECT * FROM PRO_BOARD pb WHERE PB.ID > 0 ORDER BY PB.ID DESC ;

-- 실행계획
-- 1) FULL
-- 2) INDEX(RANGE SCAN)

-- Member 와 Team 내부조인 : 팀명이 team2 인 경우
SELECT * FROM JPQL_MEMBER jm JOIN JPQL_TEAM jt ON JM.TEAM_TEAM_ID = jt.TEAM_ID WHERE jt.TEAM_NAME = 'team2';

-- mart_orders, mart_member, mart_order_item 조인
SELECT * FROM MART_ORDERS mo JOIN MART_MEMBER mm ON mo.MEMBER_MEMBER_ID = mm.MEMBER_ID JOIN ORDER_ITEM oi ON mo.ORDER_ID = oi.ORDER_ORDER_ID ;

SELECT
	*
FROM
	MART_ORDERS mo
JOIN MART_MEMBER mm ON
	mo.MEMBER_MEMBER_ID = mm.MEMBER_ID
LEFT JOIN ORDER_ITEM oi ON
	mo.ORDER_ID = oi.ORDER_ORDER_ID ;

-- 주문번호에 따른 주문 상품의 개수 추출
SELECT oi.ORDER_ORDER_ID, COUNT(oi.COUNT) AS cnt , SUM(oi.COUNT) AS sum FROM ORDER_ITEM oi GROUP BY oi.ORDER_ORDER_ID ;

-- 서브쿼리
-- 1) from 에 서브쿼리 사용(인라인뷰)
-- 2) where 에 서브쿼리 사용(중첩 서브쿼리)
-- 3) select 에 서브쿼리 사용(스칼라)

-- 주문내역 + 주문아이템
-- join 할 때 같이 쓰는 서브쿼리
SELECT
	mo.ORDER_ID, mo.STATUS, A.cnt, A.sum
FROM
	MART_ORDERS mo
LEFT JOIN (
	SELECT
		oi.ORDER_ORDER_ID AS OrderId,
		COUNT(oi.COUNT) AS cnt ,
		SUM(oi.COUNT) AS sum
	FROM
		ORDER_ITEM oi
	GROUP BY
		oi.ORDER_ORDER_ID) A ON
	mo.ORDER_ID = a.OrderId;

-- 쿼리문 자체를 서브쿼리와 함께 작성
SELECT
	mo.ORDER_ID,
	mo.STATUS,
	-- SELECT 절에 넣는 서브쿼리는 하나의 컬럼만 작성 가능
	(
	SELECT
		COUNT(oi.ORDER_ORDER_ID)
	FROM
		ORDER_ITEM oi
	WHERE
		mo.ORDER_ID = oi.ORDER_ORDER_ID
	GROUP BY
		oi.ORDER_ORDER_ID) AS cnt
	-- 두번째 컬럼이 필요하면 새로운 서브쿼리 작성 필요
FROM
	MART_ORDERS mo JOIN MART_MEMBER mm ON mo.MEMBER_MEMBER_ID = mm.MEMBER_ID ;