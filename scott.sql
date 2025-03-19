-- RDBMS
-- 기본단위 : 테이블

-- EMP(사원정보 테이블)
-- empno(사번), ename(사원명), job(직책), mgr(직속상관 사원번호), hiredate(입사일), sal(급여), comm(추가수당), deptno(부서번호)
-- NUMBER(4,0) : 전체 자릿수 4자리(소수점 자릿수 0)
-- VARCHARTO2(10) : 문자열 데이터 => 문자열 10byte (VAR : 가변 ex. 7byte 문자열 저장했다면 7byte 공간만 사용)
--					영어 : 10문자 / 한글 : 2byte (utf-8 : 3byte) 할당
-- DATE : 날짜

-- DEPT(부서테이블)
-- deptno(부서번호), dname(부서명), loc(부서위치)

-- SALGRADE(급여테이블)
-- grade(급여 등급), losal(최저급여), hisal(최대급여)

-- 개발자 : CR(read)UD
-- SQL(Structured Query Language : 구조질의언어) : RDBMS 데이터를 다루는 언어
--  ㄴ 모든 RDBMS에서 사용 가능한 표준화된 언어

-- 조회 : cost가 있음(시간이 얼마나 걸리는가) => 시간을 얼마나 빠르게 조회하는가가 중요

-- 사원정보조회
-- 1. 조회(SELECT) - Read : 가장 중요!!
SELECT * FROM EMP e; -- 전체 조회에 필수적인 QUERY문

-- 특정 열 조회
SELECT e.EMPNO, e.ENAME, e.JOB FROM EMP e;

-- 사원번호, 부서번호만 조회
SELECT e.EMPNO, e.DEPTNO FROM EMP e;

-- 중복 데이터는 제외하고 조회
SELECT DISTINCT deptno FROM emp;
-- DISTINCT : 컬럼명 앞에 붙여주면 중복값을 제외하고 보내줌

-- job, deptno 가 완전히 일치해야 안나오지 job 따로 deptno 따로 중복을 돌리지 않음
SELECT DISTINCT job, deptno FROM emp;

-- 별칭 : 컬럼명 뒤에 한칸 띄고 새로운 컬럼명을 지정해주는 것
SELECT ename, sal, sal * 12 + comm annsal, comm -- SELECT절에서 바로 계산 가능 => 없는 컬럼명이기에 그대로 정보를 가져다 씀 ex. SAL*12+COMM
FROM EMP;

-- 별칭 표현 : as 없이 가능 or as 가능 or as " " 가능
SELECT ename, sal, sal * 12 + comm AS "annsal", comm
FROM EMP;

SELECT ename, sal, sal * 12 + comm AS annsal, comm
FROM EMP;

SELECT ename, sal, sal * 12 + comm AS 연봉, comm
FROM EMP;

-- 컬럼명에 공백을 넣을 경우 쌍따옴표("") 필수
SELECT ename 사원명, sal 급여, sal * 12 + comm AS "연 봉", comm 수당 FROM EMP;

-- 원하는 순서대로 출력 데이터를 정렬(오름차순, 내림차순)
-- emp 테이블의 모든 열을 급여 기준으로 오름차순 조회 => 오름차순의 경우 asc 생략 가능 (default 가 오름차순)
SELECT * FROM EMP e ORDER BY e.SAL ASC;
SELECT * FROM EMP e ORDER BY e.SAL;
-- 내림차순
SELECT * FROM EMP e ORDER BY e.sal DESC;

--사번, 이름, 직무만 급여기준으로 내림차순 조회
SELECT e.EMPNO, e.ENAME, e.JOB FROM EMP e ORDER BY e.SAL DESC;

-- 부서번호의 오름차순, 급여의 내림차순
SELECT * FROM EMP e ORDER BY e.DEPTNO  ASC , e.SAL DESC;

SELECT
	e.EMPNO EMPLOYEE_NO,
	e.ENAME EMPLOYEE_NAME,
	e.MGR MANAGER,
	e.SAL SALARY,
	e.COMM COMMISSION,
	e.DEPTNO DEPARTMENT_NO
FROM
	EMP e;

SELECT
	*
FROM
	EMP e
ORDER BY
	e.DEPTNO DESC,
	e.ENAME ASC;

-- where 문 : 조회조건 부여
-- 부서번호가 30번인 사원들을 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.DEPTNO = 30;

-- 사원번호가 7782인 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.EMPNO = 7782;

-- 부서번호가 30이고 직책이 salesman인 사람 조회
-- 오라클에서 문자는 호따옴표('') 만 허용, 대소문자 구별
SELECT
	*
FROM
	EMP e
WHERE
	e.DEPTNO = 30
	AND e.JOB = 'SALESMAN';

-- 사원번호가 7499 이고 부서번호가 30번인 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.EMPNO = 7499
	OR e.DEPTNO = 30;

 
/* 연산자
 1) 산술연산자 : +, -, *, /
 2) 비교연산자 : >, <, >=, <=, =
 3) 등가비교연산자 : =, 같지 않다의 형태는 많음 : !=, <>, ^=
 4) 논리부정연산자 : NOT
 5) 			  : IN
 6) 범위연산자 : BETWEEN A AND B
 7) 검색연산자 : LIKE 연산자와 와일드카드(_ , %)
 8) IS NULL : 널과 같다
 9) 집합연산자
 	UNION(합집합) : 타입 일치만 확인 => 타입이 맞는다면 연결
 		=> UNION : 중복 제외하고 출력
 		=> UNION ALL : 중복 데이터도 출력
 	MINUS(차집합)
 	INTERSECT(교집합)
 		=> 컬럼의 갯수가 서로 동일해야 한다
*/

-- 연봉(SAL*12)이 36000 인 사원 조회
SELECT *
FROM EMP e 
WHERE e.sal*12 = 36000;

-- 급여가 3000이상인 사원 조회
SELECT *
FROM EMP e 
WHERE e.sal >= 3000;

-- 급여가 2500 이상이고 직업이 analyst인 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL >= 2500
	AND e.JOB = 'ANALYST';

-- 문자의 대소비교
-- 사원명이 첫 문자가 F와 같거나 F보다 뒤에 있는 사원 조회
SELECT
	*
FROM
	EMP e
WHERE e.ENAME >= 'F';

-- 급여가 3000이 아닌 사원 조회
SELECT *
FROM EMP e 
WHERE e.sal != 3000;

SELECT *
FROM EMP e 
WHERE e.sal <> 3000;

SELECT *
FROM EMP e 
WHERE e.sal ^= 3000;

SELECT
	*
FROM
	EMP e
WHERE
	NOT e.sal = 3000;

-- job 이 MANAGER 이거나, SALESMAN 이거나, CLERK 사원 조회
SELECT *
FROM EMP e 
WHERE e.JOB = 'MANAGER' OR e.JOB = 'SALESMAN' OR e.JOB = 'CLERK';

-- 5) IN 연산자로 단순화
SELECT
	*
FROM
	EMP e
WHERE
	e.JOB IN ('MANAGER', 'SALESMAN', 'CLERK');

-- 급여 2000 이상 3000 이하
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL >= 2000
	AND e.SAL <= 3000;

-- 6) BETEWEEN A AND B 구문 이용
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL BETWEEN 2000 AND 3000;

-- 급여 2000 이상 3000 이하 아닌
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL NOT BETWEEN 2000 AND 3000;

-- 7) LIKE : 검색
-- _ : 어떤 값이든 상관없이 한개의 문자열 데이터를 의미
-- % : 길이와 상관없이(문자 없는 경우도 포함) 모든 문자열 데이터를 의미

-- 사원명이 S 로 시작하는 사원을 조회
SELECT *
FROM EMP e 
WHERE e.ENAME LIKE 'S%';

-- 사원명의 두번째 글자가 L 인 사원 조회
SELECT *
FROM EMP e 
WHERE e.ENAME LIKE '_L%';

-- 사원명에 AM이 포함된 사원 조회
SELECT *
FROM EMP e 
WHERE e.ENAME LIKE '%AM%';

-- 사원명에 AM이 포함되지 않는 사원 조회
SELECT *
FROM EMP e 
WHERE e.ENAME NOT LIKE '%AM%';

-- 8) IS NULL
-- COMM이 NULL 인 사원 조회
SELECT *
FROM EMP e 
WHERE e.COMM IS NULL;

-- MGR이 NULL 인 사원 조회
SELECT *
FROM EMP e 
WHERE e.MGR IS NULL;

-- 직속 상관이 있는 사원 조회
SELECT *
FROM EMP e 
WHERE NOT e.MGR IS NULL;

-- 집합연산자
-- UNION
-- 부서번호 10, 20 조회
SELECT * FROM EMP e WHERE e.DEPTNO = 10 OR e.DEPTNO = 20;
SELECT * FROM EMP e WHERE e.DEPTNO IN ('10', '20');

SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO FROM EMP e WHERE e.DEPTNO = 10
UNION
SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO FROM EMP e WHERE e.DEPTNO = 20;

-- 타입 일치만 확인 => 타입이 맞는다면 연결
SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO FROM EMP e WHERE e.DEPTNO = 10
UNION
SELECT e.SAL, e.JOB, e.DEPTNO, e.EMPNO FROM EMP e WHERE e.DEPTNO = 20;

-- UNION / UNION ALL
SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO FROM EMP e WHERE e.DEPTNO = 10
UNION 
SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO FROM EMP e WHERE e.DEPTNO = 10;

SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO FROM EMP e WHERE e.DEPTNO = 10
UNION ALL
SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO FROM EMP e WHERE e.DEPTNO = 10;

-- MINUS
-- 부서가 10번인 것만 제외
SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO FROM EMP e
MINUS
SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO FROM EMP e WHERE e.DEPTNO = 10;

-- INTERSECT
-- 부서가 10인 것만 나옴
SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO FROM EMP e
INTERSECT
SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO FROM EMP e WHERE e.DEPTNO = 10;

/* < 오라클 함수 >
 	- 내장함수
 		1. 문자함수
 			1) 대소문자를 바꿔주는 함수
 				upper()
 				lower()
 				initcap()
 			2) 문자의 길이를 구하는 함수
 				LENGTH()
 				LENGTHB() : 문자열 바이트 수 반환
 			3) 문자열 일부 추출
 				SUBSTR(문자열데이터, 시작위치, 추출길이)
 					=> 시작위치
 						양수 : 왼쪽부터 => 1
 						음수 : 오른쪽부터 => 맨끝부터 -1
 			4) 문자열 데이터 안에서 특정 문자 위치 찾기
 				INSTR(대상문자열, 위치를 찾으려는 문자, 시작위치, 시작위치에서 찾으려는 문자가 몇번째인지)
 			5) 특정 문자를 다른 문자로 변경
 				REPLACE(원본 문자열, 찾을 문자열, 변경 문자열)
 					=> 변경 문자열을 안주면 해당 문자열 자리 삭제
 			6) 두 문자열 데이터를 합치기
 				CONCAT(문자열1, 문자열2)
 					=> 두개밖에 못해서 범용성 떨어짐
 				|| : 합칠 수 있음!
 			7) 특정 문자 제거
 				TRIM(삭제옵션(선택사항), 삭제할 문자(선택사항), FROM 원본 문자열(필수))
 				LTRIM() : 왼쪽 제거
 				RTRIM() : 오른쪽 제거
*/

-- 사원이름을 대문자, 소문자, 첫문자만 대문자로 변경
SELECT e.ENAME, UPPER(e.ENAME), LOWER(e.ENAME), INITCAP(e.ENAME)
FROM EMP e;

-- 제목 orcle 검색
-- LIKE '%oracle%' OR LIKE '%ORACLE%' OR LIKE '%Oracle%'
-- 단순화 => SELECT * FROM board WHERE upper(title) = upper('oracle')

-- LENGTH
-- 사원명 길이 구하기
SELECT e.ENAME, LENGTH(e.ENAME)
FROM EMP e ;

-- 사원명이 5글자 이상인 사원 조회
SELECT *
FROM EMP e 
WHERE LENGTH(e.ENAME) >= 5;

-- LENGTHB() : 문자열 바이트 수 반환
-- XE 버전 한글의 바이트 수 : 3byte
-- DUAL : sys 소유 테이블 (임시 연산이나 함수의 결과값 확인 용도로 사용)
SELECT LENGTH('한글'), LENGTHB('한글')
FROM DUAL;

-- 
SELECT e.JOB, SUBSTR(e.JOB, 1, 2), SUBSTR(e.JOB, 5)
FROM EMP e ;

SELECT
	e.JOB,
	SUBSTR(e.JOB, -LENGTH(e.JOB)),
	SUBSTR(e.JOB, -LENGTH(e.JOB), 2), 
	SUBSTR(e.JOB, 3)
FROM
	EMP e ;

-- INSTR(①대상문자열, ②위치를 찾으려는 문자, ③시작위치, ④시작위치에서 찾으려는 문자가 몇번째인지)
-- ①, ② 필수
SELECT
	INSTR('HELLO, ORACLE!', 'L') AS instr_1,
	INSTR('HELLO, ORACLE!', 'L', 5) AS instr_2,
	INSTR('HELLO, ORACLE!', 'L', 2, 2) AS instr_3
FROM
	DUAL; 

-- 사원 이름에 S 가 있는 사원 조회
SELECT *
FROM EMP e 
WHERE e.ENAME LIKE '%S%';

SELECT *
FROM EMP e 
WHERE INSTR(e.ENAME, 'S') > 0;

-- REPLACE
SELECT
	'010-1234-5678' AS REPLAE_BEFORE,
	REPLACE('010-1234-5678', '-', ' ') AS REPLACE1,
	REPLACE('010-1234-5678', '-') AS REPLACE1
FROM
	DUAL
	
-- 사번 : 사원명
SELECT CONCAT(e.EMPNO, CONCAT(' : ', e.ENAME))
FROM EMP e;

SELECT e.EMPNO || ' : ' || e.ENAME
FROM EMP e;

-- TRIM() 
SELECT
	'[' || TRIM(' __Oracle__ ') || ']' AS trim,
	'[' || TRIM(LEADING FROM ' __Oracle__ ') || ']' AS trim_Leading,
	'[' || TRIM(TRAILING FROM ' __Oracle__ ') || ']' AS trim_Trailing,
	'[' || TRIM(BOTH FROM ' __Oracle__ ') || ']' AS trim_both
FROM
	DUAL;

-- LTRIM()
SELECT
	'[' || TRIM(' __Oracle__ ') || ']' AS trim,
	'[' || LTRIM(' __Oracle__ ') || ']' AS Ltrim,
	'[' || RTRIM(' __Oracle__ ') || ']' AS Rtrim,
	'[' || RTRIM('<__Oracle__>', '>_') || ']' AS Rtrim2
FROM
	DUAL;

/* 숫자 함수
 	ROUND(지정 문자열, 몇번째에서 할지) : 반올림
 	TRUNC(지정 문자열, 몇번째에서 할지) : 버림
 	CEIL() : 가장 큰 정수
 	FLOOR() : 가장 작은 정수
 	MOD() : 나머지
 */

-- ROUND
--	  -2 -1 0 1 2
-- 1 2 3 4  . 5 6 7 8
SELECT
	ROUND(1234.5678) AS ROUND,
	ROUND(1234.5678, 0) AS ROUND1,
	ROUND(1234.5678, 1) AS ROUND2,
	ROUND(1234.5678, 2) AS ROUND3,
	ROUND(1234.5678, -1) AS ROUND4,
	ROUND(1234.5678, -2) AS ROUND5
FROM
	DUAL;

-- TRUNC
SELECT
	TRUNC(1234.5678) AS TRUNC,
	TRUNC(1234.5678, 0) AS TRUNC1,
	TRUNC(1234.5678, 1) AS TRUNC2,
	TRUNC(1234.5678, 2) AS TRUNC3,
	TRUNC(1234.5678, -1) AS TRUNC4,
	TRUNC(1234.5678, -2) AS TRUNC5
FROM
	DUAL;

-- CEIL, FLOOR
SELECT
	CEIL(3.14),
	FLOOR(3.14),
	CEIL(-3.14),
	FLOOR(-3.14)
FROM
	DUAL;

-- MOD
SELECT MOD(15,6), MOD(10,2), MOD(11,2)
FROM DUAL;

-- 날짜함수
-- 오늘 날짜/시간 : SYSDATE
-- 몇개월 이후 날짜 구하기 : ADD_MONTHS()
-- 두 날짜간의 개월 수 차이 구하기 : MONTHS_BETWEEN()
-- 돌아오는 요일, 달의 마지막 날짜 구하기 : NEXT_DAY() / LAST_DAY
SELECT
	SYSDATE AS NOW,
	SYSDATE - 1 YESTERDAY,
	SYSDATE + 1 AS TOMORROW,
	CURRENT_DATE AS CURRENT_DATE,
	CURRENT_TIMESTAMP AS CURRENT_TIMESTAMP
FROM
	DUAL;

-- ADD_MONTHS
-- 오늘 날짜 기준으로 3개월 이후 날짜 구하기 
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3)
FROM DUAL;

-- 입사한지 40년이 넘은 사원 출력
SELECT *
FROM EMP e 
WHERE ADD_MONTHS(e.HIREDATE, 480) < SYSDATE;

-- MONTHS_BETWEEN()
-- 오늘 날짜와 입사일자의 차이 구하기
SELECT
	e.EMPNO,
	e.ENAME,
	e.HIREDATE,
	SYSDATE,
	MONTHS_BETWEEN(e.HIREDATE, SYSDATE) AS month1,
	MONTHS_BETWEEN(SYSDATE, e.HIREDATE) AS month2,
	TRUNC(MONTHS_BETWEEN(e.HIREDATE, SYSDATE)) AS month3,
	TRUNC(MONTHS_BETWEEN(SYSDATE, e.HIREDATE)) AS month4
FROM
	EMP e;

-- NEXT_DAY() / LAST_DAY
SELECT SYSDATE, NEXT_DAY(SYSDATE, '월요일'), LAST_DAY(SYSDATE)
FROM DUAL;

/* 자료형을 변환하는 형변환 함수
 TO_CHAR() : 숫자 또는 날짜 데이터를 문자열 데이터로 반환
 TO_NUMBER) : 문자열 데이터를 숫자 데이터로 반환
 TO_DATE() : 문자열 데이터를 날짜 데이터로 반환
 */

-- NUMBER + '문자숫자' => 덧셈 가능 => 자동형변환
SELECT e.EMPNO, e.ENAME , e.EMPNO + '500'
FROM EMP e 
WHERE e.ENAME = 'SMITH';

-- 날짜(SYSDATE) 형변환
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD')
FROM DUAL;

SELECT
	SYSDATE,
	TO_CHAR(SYSDATE, 'MM'),
	TO_CHAR(SYSDATE, 'MON'),
	TO_CHAR(SYSDATE, 'MONTH'),
	TO_CHAR(SYSDATE, 'DD'),
	TO_CHAR(SYSDATE, 'DY'),
	TO_CHAR(SYSDATE, 'DAY'),
	TO_CHAR(SYSDATE, 'HH24:MI:SS'),
	TO_CHAR(SYSDATE, 'HH12:MI:SS AM'),
	TO_CHAR(SYSDATE, 'HH:MI:SS PM')
FROM
	DUAL;