-- board 테이블 작성
CREATE TABLE BOARD(
	BNO number(8) PRIMARY KEY,
	TITLE VARCHAR2(100) NOT NULL,
	CONTENT VARCHAR2(2000) NOT NULL,
	WRITER VARCHAR2(50) NOT NULL,
	REGDATE DATE DEFAULT SYSDATE
);

CREATE SEQUENCE BOARD_SEQ;

INSERT INTO BOARD(BNO, TITLE, CONTENT, WRITER)
VALUES(BOARD_SEQ.NEXTVAL, 'TITLE1', 'CONTENT1', 'USER1');

INSERT INTO STUDENTTBL(name) values('홍길동');
INSERT INTO STUDENTTBL(name) values('성춘향');

-- Team(부모) 과 TeamMember(자식) 외래키 제약조건

-- insert : 부모 먼저 한다
INSERT INTO TEAM(TEAM_NAME) VALUES ('victory');
INSERT INTO TEAM(TEAM_NAME) VALUES ('hope');

INSERT INTO TEAM_MEMBER(USER_NAME, TEAM_TEAM_ID) VALUES ('홍길동', 1);
INSERT INTO TEAM_MEMBER(USER_NAME, TEAM_TEAM_ID) VALUES ('성춘향', 2);
-- delete : 자식 먼저 한다

SELECT
	t1_0.team_id,
	t1_0.team_name
FROM
	team t1_0
WHERE
	t1_0.team_id =?;
        
-- 왼쪽, 오른쪽 서로 바꿔서 실행 가능
SELECT
	tm1_0.member_id,
	t1_0.team_id,
	t1_0.team_name,
	tm1_0.user_name
FROM
	team t1_0
LEFT JOIN
    team_member tm1_0
            ON
	t1_0.team_id = tm1_0.team_id
WHERE
	tm1_0.member_id = 1;

SELECT *
FROM TODO t
WHERE t.COMPLEATED = 1;

SELECT *
FROM TODO t
WHERE t.COMPLEATED = 0;

SELECT *
FROM TODO t
WHERE t.IMPORTANTED = 1;

-- board 조회

-- writer 가 user5 게시물 조회
SELECT *
FROM BOARD b
WHERE b.WRITER = 'boardWriter test4';

-- title 이 1인 게시물
SELECT *
FROM BOARD b
WHERE b.TITLE = 'boardTitle test2';

SELECT *
FROM BOARD b
WHERE b.TITLE LIKE '%Title%';

-- JPA_ITEM 테이블
-- 집계함수 : SUM, COUNT, MAX, MIN
-- SUM, AVG, MAX, MIN : PRICE
-- COUNT : 아이템 개수
SELECT SUM(j.PRICE), AVG(j.PRICE), MAX(j.PRICE), MIN(j.PRICE), COUNT(j.ITEM_NM)
FROM JPA_ITEM j

-- Team, TeamMember

SELECT *
FROM TEAM_MEMBER tm JOIN TEAM t ON t.TEAM_ID = tm.TEAM_ID
WHERE tm.TEAM_ID = 2;

-- 두개의 테이블 조인
SELECT *
FROM ORDERS o LEFT JOIN MART_MEMBER mm ON o.MEMBER_ID = mm.MEMBER_ID;

-- 세개의 테이블 조인
SELECT *
FROM ORDERS o LEFT JOIN MART_MEMBER mm ON o.MEMBER_ID = mm.MEMBER_ID JOIN ORDER_ITEM oi ON o.ORDER_ID = oi.ORDER_ID;

-- 동일한 주문 번호에 주문한 상품의 총 개수, 주문 내역 조회
SELECT oi.ORDER_ID ,COUNT(oi.ORDER_ID) AS CNT
FROM ORDER_ITEM oi 
GROUP BY oi.ORDER_ID;

-- ORDER_ITEM + ORDERS
SELECT
	o.ORDER_ID,
	o.ORDER_STATUS,
	A.cnt
FROM
	ORDERS o
LEFT JOIN (
	SELECT
		oi. ORDER_ID AS oid,
		count(oi.ORDER_ID) AS cnt
	FROM
		ORDER_ITEM oi
	GROUP BY
		oi.ORDER_ID) A ON
	o.ORDER_ID = A.oid;

-- SELECT 절
SELECT
	o.ORDER_ID,
	o.ORDER_STATUS,
	(
	SELECT
		count(oi.ORDER_ID)
	FROM
		ORDER_ITEM oi
	WHERE
		o.ORDER_ID = oi.ORDER_ID
	GROUP BY
		oi.ORDER_ID) AS cnt
FROM
	ORDERS o;

SELECT o.ORDER_ID ,COUNT(oi.ORDER_ID) AS CNT, o.ORDER_STATUS
FROM ORDER_ITEM oi RIGHT JOIN ORDERS o ON oi.ORDER_ID = o.ORDER_ID
GROUP BY oi.ORDER_ID, o.ORDER_STATUS, o.ORDER_ID;

-- 더미 데이터 넣기 (book)
INSERT INTO BOOKTBL (PRICE, AUTHOR, CREATED_DATE, TITLE, UPDATED_DATE)
(SELECT PRICE, AUTHOR, CREATED_DATE, TITLE, UPDATED_DATE FROM BOOKTBL);

-- board 조회
-- bno, title, reply개수, createdDate
-- 내꺼
SELECT
	b.BNO,
	b.TITLE,
	count(r.REPLYER),
	b.CREATED_DATE
FROM
	BOARDTBL b
LEFT JOIN REPLY r ON
	BOARD_ID = BNO
GROUP BY
	b.BNO,
	b.TITLE,
	b.CREATED_DATE;

-- 강사님꺼
SELECT
	b.BNO,
	b.TITLE,
	(
	SELECT
		COUNT(r.RNO)
	FROM
		REPLY r
	WHERE
		r.BOARD_ID = b.BNO
	GROUP BY
		r.BOARD_ID) AS reply_cnt,
	b.CREATED_DATE,
	m.NAME
FROM
	BOARDTBL b
JOIN BOARD_MEMBER m ON
	b.MEMBER_ID = m.EMAIL;

SELECT * FROM REPLY r WHERE r.BOARD_ID = 1;

------------------------------------------------------------------

SELECT
	DISTINCT m.MNO,
	mi.IMG_NAME,
	m.TITLE,
	(
	SELECT
		COUNT(r.MOVIE_MNO)
	FROM
		REVIEW r
	WHERE
		r.MOVIE_MNO = m.MNO
	GROUP BY
		r.MOVIE_MNO) AS review_cnt,
	(
	SELECT
		ROUND(AVG(r.GRADE), 1)
	FROM
		REVIEW r
	WHERE
		r.MOVIE_MNO = m.MNO
	GROUP BY
		r.MOVIE_MNO) AS grade_avg,
	m.CREATED_DATE
FROM
	MOVIE m
LEFT JOIN MOVIE_IMAGE mi ON
	MOIVE_MNO = MNO;

--------------------------------------------------------------------------------------

-- movie img 추출
SELECT
	mi.*,
	m.*,
	(
	SELECT
		count(r.rno)
	FROM
		REVIEW r
	WHERE
		r.MOVIE_MNO = mi.MOIVE_MNO) AS cnt,
	(
	SELECT
		avg(r.grade)
	FROM
		REVIEW r
	WHERE
		r.MOVIE_MNO = mi. MOIVE_MNO) AS avg
FROM
	MOVIE_IMAGE mi
LEFT JOIN MOVIE m ON
	m.MNO = mi.MOIVE_MNO
WHERE
	mi.INUM IN (
	SELECT
		MIN(mi.INUM)
	FROM
		MOVIE_IMAGE mi
	GROUP BY
		mi.MOIVE_MNO);

SELECT
	m.TITLE,
	(
	SELECT
		count(r.rno)
	FROM
		REVIEW r
	WHERE
		r.MOVIE_MNO = mi.MOIVE_MNO) AS review_cnt,
	(
	SELECT
		avg(r.grade)
	FROM
		REVIEW r
	WHERE
		r.MOVIE_MNO = mi. MOIVE_MNO) AS avg,
		mi.IMG_NAME
FROM
	MOVIE_IMAGE mi
LEFT JOIN MOVIE m ON
	m.MNO = mi.MOIVE_MNO
WHERE mi.MOIVE_MNO = 2;

-- 리뷰 조회
SELECT *
FROM REVIEW r
WHERE r.MOVIE_MNO = 2;

SELECT
	*
FROM
	MOVIE_IMAGE mi
WHERE
	mi.path = to_char(sysdate, 'yyyy\mm\dd');











































































































































































































































