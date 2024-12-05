SELECT
	m.MOVIE_ID ,
	m.REGDATE ,
	r.REVIEW_NO 
	AVG(r.GRADE),
	COUNT(r.REVIEW_NO)
FROM
	MOVIE m
LEFT JOIN REVIEW r ON
	r.MOVIE_MOVIE_ID = m.MOVIE_ID
GROUP BY
	m.MOVIE_ID ;


SELECT AVG(r.GRADE), COUNT(r.GRADE),r.MOVIE_MOVIE_ID FROM REVIEW r GROUP BY r.MOVIE_MOVIE_ID ;

SELECT
	m.MOVIE_ID ,m.TITLE,review.MOVIE_MNO, review.AVG, review.COUNT,m.REGDATE 
FROM
	MOVIE m
LEFT JOIN (
	SELECT
		AVG(r.GRADE) AS AVG,
		COUNT(r.GRADE) AS COUNT,
		r.MOVIE_MOVIE_ID AS MOVIE_MNO
	FROM
		REVIEW r
	GROUP BY
		r.MOVIE_MOVIE_ID) review ON
	review.MOVIE_MNO = m.MOVIE_ID;

-- movie, review 서브 쿼리만 이용
SELECT m.MOVIE_ID,m.TITLE,m.REGDATE,(SELECT AVG(r.GRADE) FROM REVIEW r WHERE r.MOVIE_MOVIE_ID = m.MOVIE_ID) avg, (SELECT COUNT(r2.REVIEW_NO) FROM REVIEW r2 WHERE r2.MOVIE_MOVIE_ID = m.MOVIE_ID) count FROM MOVIE m ;
	
-- movie, review, movie_image 조인 or 서브쿼리
-- mno, title, regdate(movie)
-- review 수, 평균(review)
-- inum,path,uuid,img_name   Max(inum) 기준 movie_mno

SELECT mi.MOVIE_MOVIE_ID, MAX(mi.IMAGE_ID) FROM MOVIE_IMAGE mi GROUP BY mi.MOVIE_MOVIE_ID;

-- JOIN 서브쿼리 이용
SELECT
	DISTINCT m.MOVIE_ID,
	m.TITLE,
	m.REGDATE,
	review.AVG,
	review.COUNT,
	image.IMNO,
	image."PATH",
	image.UUID
FROM
	MOVIE m
LEFT JOIN (
	SELECT
		AVG(r.GRADE) AS AVG,
		COUNT(r.MOVIE_MOVIE_ID) AS COUNT,
		r.MOVIE_MOVIE_ID AS REVIEW_ID
	FROM
		REVIEW r
	GROUP BY
		r.MOVIE_MOVIE_ID) review ON
	m.MOVIE_ID = review.REVIEW_ID
JOIN (
	SELECT
		max(mi.IMAGE_ID) AS IMNO,
		COUNT(mi.UUID) AS UUID,
--		mi.UUID AS UUID,
		COUNT(mi."PATH") AS "PATH", 
--		mi."PATH" AS "PATH", 
		mi.MOVIE_MOVIE_ID AS IMMID
	FROM
		MOVIE_IMAGE mi
	GROUP BY
		mi.MOVIE_MOVIE_ID
--		,mi."PATH"
--		,mi.UUID
		) image
	ON
	m.MOVIE_ID = image.IMMID
ORDER BY m.MOVIE_ID ASC;

-----------------------------
-- SELECT + WHERE 절 서브쿼리 JOIN 이용
SELECT
	m.MOVIE_ID,
	m.TITLE,
	m.REGDATE,
	(
	SELECT
		AVG(r.GRADE)
	FROM
		REVIEW r
	WHERE
		r.MOVIE_MOVIE_ID = m.MOVIE_ID) avg,
	(
	SELECT
		COUNT(r2.REVIEW_NO)
	FROM
		REVIEW r2
	WHERE
		r2.MOVIE_MOVIE_ID = m.MOVIE_ID) count, mi2.IMG_NAME, mi2.IMAGE_ID, MI2."PATH" 
FROM
	MOVIE m LEFT JOIN MOVIE_IMAGE mi2 ON m.MOVIE_ID = mi2.MOVIE_MOVIE_ID 
	WHERE MI2.IMAGE_ID in (SELECT max(mi.IMAGE_ID) FROM MOVIE_IMAGE mi GROUP BY mi.MOVIE_MOVIE_ID);

SELECT
	m.MOVIE_ID,
	m.TITLE,
	m.REGDATE,
	(
	SELECT
		AVG(r.GRADE)
	FROM
		REVIEW r
	WHERE
		r.MOVIE_MOVIE_ID = m.MOVIE_ID) avg,
	(
	SELECT
		COUNT(r2.REVIEW_NO)
	FROM
		REVIEW r2
	WHERE
		r2.MOVIE_MOVIE_ID = m.MOVIE_ID) count, mi2.IMG_NAME, mi2.IMAGE_ID, MI2."PATH" 
FROM
	MOVIE m LEFT JOIN MOVIE_IMAGE mi2 ON m.MOVIE_ID = mi2.MOVIE_MOVIE_ID 
	WHERE mi2.MOVIE_MOVIE_ID = 2

	
-- 닉네임 변경
UPDATE MOVIE_MEMBER  SET NICK_NAME='nickTwo' WHERE MOVIE_MEMBER.EMAIL = 'user1@naver.com'; 

-- password 변경
UPDATE MOVIE_MEMBER mm SET PASSWORD = '1111' WHERE EMAIL = 'user1@naver.com' AND PASSWORD = '1111';

-- 회원 탈퇴 (=> 리뷰삭제 , 회원삭제)
DELETE FROM REVIEW WHERE MEMBER_MEMBER_ID = 49; 
DELETE FROM MOVIE_MEMBER mm WHERE EMAIL = 'user49@naver.com' AND PASSWORD = '{bcrypt}$2a$10$AWUHiZoSA07A4pE9V740f.gKpy6n5TuyKrtzPFgcftVHbNBFEJfCK';

SELECT * FROM MOVIE_IMAGE mi WHERE mi.PATH = TO_CHAR(SYSDATE -1, 'yyyy/MM/dd');