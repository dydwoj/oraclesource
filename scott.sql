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
 			8) 데이터 공간을 특정 문자로 채우기
 				LPAD(데이터, 데이터 자릿수, 채울 문자) : 왼쪽에 채울건지
 				RPAD() : 오른쪽에 채울건지
*/
-- Oracle => 10자리로 표현
SELECT
	'Oracle',
	LPAD('Oracle', 10, '#'),
	RPAD('Oracle', 10, '*'),
	LPAD('Oracle', 10),
	RPAD('Oracle', 10)
FROM
	DUAL;

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

-- 9 : 숫자 한자리를 의미
-- 0 : 숫자 한자리를 의미(빈자리를 0으로 채움)
SELECT e.SAL, TO_CHAR(e.sal, '$999,999'), TO_CHAR(e.sal, '$000,999,999')
FROM EMP e; 


-- 문자열 데이터와 숫자 데이터 연산
SELECT 1300-'1500', 1300 + '1500'
FROM dual;

SELECT '1300'-'1500'
FROM dual;

-- ORA-01722: 수치가 부적합합니다
SELECT '1,300'-'1,500'
FROM dual;


-- TO_NUMBER('문자열데이터','인식할숫자형태')
SELECT TO_NUMBER('1,300','999,999') - TO_NUMBER('1,500','999,999')
FROM dual;

-- TO_DATE() : 문자열데이터 => 날짜형식으로 변경
SELECT
	TO_DATE('2025-03-20', 'YYYY-MM-DD') AS DATE1,
	TO_DATE('40270320', 'YYYY/MM/DD') AS DATE2
FROM
	DUAL;


-- NULL
-- 산술연산이나 비교연산자(IS NULL OR IS NOT NULL)가 제대로 수행되지 않음
-- 1) NVL(널여부를 검사할 데이터,널일때 반환할데이터)
-- 2) NVL2(널여부를 검사할 데이터,널이아닐때 반환할 데이터,널일때 반환할데이터)

SELECT e.EMPNO, e.ENAME, e.sal, e.comm, e.sal+e.comm,  NVL(e.comm, 0), e.sal + nvl(e.comm,0)
FROM EMP e;


SELECT
	e.EMPNO,
	e.ENAME,
	e.sal,
	e.comm,
	e.sal + e.comm,
	NVL2(e.comm, 'O', 'X'),
	NVL2(e.comm, e.sal * 12 + e.COMM, e.SAL*12) AS 연봉
FROM
	EMP e;

-- 자바의 if, switch 구문과 유사
-- DECODE
-- DECODE(검사대상이 될 데이터, 
--        조건1, 조건1 만족시 반환할 결과,
--        조건2, 조건2 만족시 반환할 결과,
--        조건1~조건n 일치하지 않을때 반환할 결과
-- )
-- CASE
-- CASE 검사대상이 될 데이터 
--     WHEN  조건1 THEN 조건1 만족시 반환할 결과
--     WHEN  조건2 THEN 조건2 만족시 반환할 결과
--     ELSE  조건1~조건n 일치하지 않을때 반환할 결과
-- END

-- 직책이 MANAGER 인 사원은 급여의 10% 인상
-- 직책이 SALESMAN 인 사원은 급여의 5% 인상
-- 직책이 ANALYST 인 사원은 동결
-- 나머지는 3% 인상

SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	DECODE(e.job, 'MANAGER', e.SAL * 1.1,
	'SALESMAN', e.SAL * 1.05,
	'ANALYST', e.SAL,
	e.SAL * 1.03
	) AS upsal
FROM
	EMP e;


SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	CASE
		e.job
	 WHEN 'MANAGER' THEN e.SAL * 1.1
		WHEN 'SALESMAN' THEN e.SAL * 1.05
		WHEN 'ANALYST' THEN e.SAL
		ELSE e.SAL * 1.03
	END AS upsal
FROM
	EMP e;

-- COMM NULL 인 경우 '해당사항 없음'
-- COMM 0 인 경우 '수당없음'
-- COMM > 0 인 경우 '수당' : 800
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	CASE
	 WHEN e.COMM IS NULL THEN '해당사항 없음'
		WHEN e.COMM = 0 THEN '수당 없음'
		WHEN e.COMM > 0 THEN '수당 : ' || e.COMM 
	END AS COMM_TEXT
FROM
	EMP e;

-- [실습]
-- 1. EMPNO 7369 => 73**, ENAME SMITH => S****
-- EMPNO, 마스킹 EMPNO, ENAME, 마스킹처리 ENAME
-- 내꺼
SELECT
	e.EMPNO ,
	SUBSTR(e.EMPNO, 1, 2) || '**' AS MASKING_EMPNO,
	e.ENAME ,
	SUBSTR(e.ENAME, 1, 1) || '****' AS MASKING_ENAME
FROM
	EMP e;

SELECT
	e.EMPNO ,
	RPAD(SUBSTR(e.EMPNO, 1, 2), LENGTH(e.EMPNO), '*') AS MASKING_EMPNO,
	e.ENAME ,
	RPAD(SUBSTR(e.ENAME, 1, 1), LENGTH(e.ENAME), '*') AS MASKING_ENAME
FROM
	EMP e;

-- 강사님꺼
SELECT
	e.EMPNO ,
	REPLACE(e.EMPNO ,SUBSTR(e.EMPNO, 3), '**') AS MASKING_EMPNO,
	e.ENAME ,
	REPLACE(e.ENAME  ,SUBSTR(e.ENAME , 2), '****') AS MASKING_ENAME
FROM
	EMP e;

-- 2. EMP 테이블에서 사원의 월 평균 근무일수는 21일이다.
-- 하루 근무시간을 8시간으로 보았을 때 사원의 하루급여 (DAY_PAY)와 시급(TIME_PAY)를
-- 계산하여 출력한다. (단, 하루급여는 소수 셋째자리에서 버리고, 시급은 둘째자리에서 반올림)
-- 출력형태) EMPNO, ENAME, SAL, DAY_PAY, TIME_PAY
SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	TRUNC(e.SAL / 21, 2) AS DAY_PAY,
	ROUND(e.SAL / 168, 1) AS TIME_PAY
FROM
	EMP e;

-- 3. 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다.
-- 사원이 정직원이 되는 날짜(R_JOB)을 YYYY-MM-DD 형식으로 출력한다.
-- 단, 추가수당이 없는 사원의 추가수당은 N/A 로 출력
-- EMPNO, ENAME, HIREDATE, R_JOB, COMM

-- 내꺼
SELECT
	e.EMPNO,
	e.ENAME,
	e.HIREDATE,
	TO_CHAR(NEXT_DAY(ADD_MONTHS(e.HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
	CASE
		WHEN e.COMM IS NULL THEN 'N/A'
		ELSE TO_CHAR(e.COMM)
		END AS COMM
	FROM
		EMP e;

-- 강사님꺼
SELECT
	e.EMPNO,
	e.ENAME,
	e.HIREDATE,
	TO_CHAR(NEXT_DAY(ADD_MONTHS(e.HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
	NVL(TO_CHAR(e.COMM), 'N/A') AS COMM
FROM
	EMP e;

-- 4. 직속상관의 사원번호가 없을때 : 0000
-- 직속상관의 사원번호 앞 두자리가 75일 때 : 5555
-- 직속상관의 사원번호 앞 두자리가 76일 때 : 6666
-- 직속상관의 사원번호 앞 두자리가 77일 때 : 7777
-- 직속상관의 사원번호 앞 두자리가 78일 때 : 8888
-- 그 외 직속상관 사원 번호일 때 : 본래 직속상관 사원번호 그대로 출력
-- 출력형태) EMPNO, ENAME, MGR, CHG_MGR

-- 내꺼
SELECT
	e.EMPNO,
	e.ENAME,
	e.MGR,
	CASE
		WHEN e.MGR IS NULL THEN '0000'
		WHEN SUBSTR(e.MGR, 1, 2) = '75' THEN '5555'
		WHEN SUBSTR(e.MGR, 1, 2) = '76' THEN '6666'
		WHEN SUBSTR(e.MGR, 1, 2) = '77' THEN '7777'
		WHEN SUBSTR(e.MGR, 1, 2) = '78' THEN '8888'
		ELSE TO_CHAR(e.MGR)
	END AS CHG_MGR
FROM
	EMP e;

-- 강사님꺼

SELECT
	e.EMPNO,
	e.ENAME,
	e.MGR,
	DECODE(SUBSTR(TO_CHAR(NVL(e.MGR, 0)), 1, 2),
	'0', '0000',
	'75', '5555',
	'76', '6666',
	'77', '7777',
	'78', '8888',
	SUBSTR(TO_CHAR(e.MGR), 1)) AS CHG_MGR
FROM
	EMP e;

SELECT
	e.EMPNO,
	e.ENAME,
	e.MGR,
	DECODE(SUBSTR(TO_CHAR(e.MGR, 0), 1, 2),
	NULL, '0000',
	'75', '5555',
	'76', '6666',
	'77', '7777',
	'78', '8888',
	SUBSTR(TO_CHAR(e.MGR), 1)) AS CHG_MGR
FROM
	EMP e;

/* 하나의 열에 출력 결과를 담는 다중행 함수
 	모두 NULL 값 제외하고 연산해줌
 	1) sum() : 합
 	2) count()
 	3) max()
 	4) min()
 	5) avg()
 	
 	* ALL 은 중복된 거 포함 할건지 안할 건지의 의미
*/
SELECT SUM(e.SAL) FROM EMP e;

-- 중복된 급여는 제외한 합
SELECT SUM(e.SAL), sum(DISTINCT e.SAL), sum(ALL e.SAL) FROM EMP e;

-- ORA-00937: 단일 그룹의 그룹 함수가 아닙니다 => sum 은 1개만 나오고 e.name 은 다중으로 나와서 그럼
-- 같이 출력하면 안되는 함수를 넣은 것 => 해결 : GROUP BY 절에 사용한 컬럼만 가능
-- SELECT e.ENAME ,SUM(e.SAL) FROM EMP e 

-- 사원의 수
SELECT COUNT(e.EMPNO), COUNT(e.COMM), COUNT(ALL e.COMM)
FROM EMP e;

-- 급여의 최대값과 최소값
SELECT MAX(e.SAL), MIN(e.SAL)
FROM EMP e;

-- 10번 부서 사원 중 급여 최대값
SELECT MAX(e.SAL), MIN(e.SAL)
FROM EMP e
WHERE e.DEPTNO = 10;

-- 20번 부서의 입사일 중 최근 입사일 출력
SELECT MAX(e.HIREDATE), MIN(e.HIREDATE)
FROM EMP e
WHERE e.DEPTNO = 10;

-- 부서번호가 30인 사원의 평균 급여
SELECT AVG(e.SAL)
FROM EMP e 
WHERE e.DEPTNO = 30;

-- 부서별 직책별 평균 급여 조회
SELECT e.DEPTNO, e.JOB, AVG(e.SAL)
FROM EMP e 
GROUP BY e.DEPTNO, e.JOB
ORDER BY e.DEPTNO;

-- 결과값을 원하는 열로 묶어 출력할 때 조건 추가 : GROUP BY = HAVING

-- 부서별, 직책별 평균 급여 조회 + 평균 급여 >= 2000
SELECT e.DEPTNO, e.JOB, AVG(e.SAL)
FROM EMP e 
GROUP BY e.DEPTNO, e.JOB HAVING AVG(e.SAL) >= 2000
ORDER BY e.DEPTNO;

-- SQL Error [934] [42000]: ORA-00934: 그룹 함수는 허가되지 않습니다
-- WHERE 절 그룹함수 안됨
SELECT e.DEPTNO, e.JOB, AVG(e.SAL)
FROM EMP e 
WHERE AVG(e.SAL) >= 2000
GROUP BY e.DEPTNO, e.JOB HAVING AVG(e.SAL) >= 2000
ORDER BY e.DEPTNO;

-- 같은 직무에 종사하는 사원이 3명 이상인 직책과 인원 수 출력
-- SALESMAN  4

SELECT e.JOB, COUNT(e.EMPNO)
FROM EMP e 
GROUP BY e.JOB HAVING COUNT(e.EMPNO) >= 3;

-- 사원들의 입사년도를 기준으로 부서별로 몇명이 입사했는지 출력
-- 1987 20 1
-- 1987 30 1
SELECT TO_CHAR(e.HIREDATE, 'YYYY'), e.DEPTNO, COUNT(e.EMPNO)
FROM EMP e 
GROUP BY TO_CHAR(e.HIREDATE, 'YYYY'), e.DEPTNO;


/* 조인 (join
 	=> 여러 종류의 데이터를 다양한 테이블에 나누어 저장하기 때문에 여러 테이블의 데이터를 조합하여 출력할 때가 많다.
 		이 때 사용하는 방식이 조인(join)
 
 	- 종류
 		1) 내부조인(inner join) : 연결이 안되는 데이터는 제외
 			=> 일치하거나 내부에 있어야 조인이 됨
 			1. 등가조인 : 같은지 여부
 			2. 비등가 조인 : 부등호 표현
 			3. 자체(self) 조인 : 내꺼에 내꺼 연결
 			
 		2) 외부조인(outer join) : 연결 안되는 데이터 보기
 			1. 왼쪽 외부조인(left outer join) : 오른쪽 테이블의 데이터 존재 여부와 상관없이 왼쪽 테이블 기준으로 출력
 				=> 왼쪽을 기준으로 뽑으면 left
 			2. 오른쪽 외부조인(right outer join) : 왼쪽 테이블의 데이터 존재 여부와 상관없이 오른쪽 테이블 기준으로 출력
 				=> 오른쪽을 기준으로 뽑으면 right
 				
 		- 표준 문법을 사용한 조인
 			1) 내부조인
 				inner 조인(내부조인)
 					=> (INNER) JOIN 테이블명 ON 조인 조건
 					=> INNER 생략 가능
 			2) 외부조인
 				OUTER 조인(외부조인)
 					=> LEFT/RIGHT OUTER JOIN 테이블명 ON 조인조건
 				
*/

-- 사원별 부서정보 조회
SELECT *
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO;

SELECT e.ENAME, e.DEPTNO, d.DNAME , d.LOC
FROM EMP e , DEPT d 
WHERE e.DEPTNO = d.DEPTNO;

-- 나올 수 있는 모든 조합 출력
SELECT e.EMPNO, e.DEPTNO, e.SAL, d.DNAME, d.LOC
FROM EMP e , DEPT d;

-- 사원별 부서정보 조회
SELECT e.EMPNO, e.DEPTNO, e.SAL, d.DNAME, d.LOC
FROM EMP e , DEPT d 
WHERE e.DEPTNO = d.DEPTNO AND e.SAL  >= 3000;

-- 사원별 부서정보 조회 + 사원별 급여 <= 2500 + 사원번호 9999이하
SELECT e.EMPNO, e.DEPTNO, e.SAL, d.DNAME, d.LOC
FROM EMP e , DEPT d 
WHERE e.DEPTNO = d.DEPTNO AND e.SAL  <= 2500 AND e.EMPNO <= 9999;

-- 비등가조인
-- 사원별 정보 + SALGRADE GRAD
SELECT *
FROM EMP e , SALGRADE s 
WHERE e.SAL >= s.LOSAL AND e.SAL <= s.HISAL;

SELECT *
FROM EMP e , SALGRADE s 
WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL;

-- 자체조인
-- 사원정보 + 직속상관 정보
SELECT e1.EMPNO, e1.ENAME, e1.MGR, e2.ENAME AS MGR_ENAME
FROM EMP e1 ,EMP e2
WHERE e1.MGR = e2.EMPNO;

-- left outer join
SELECT e1.EMPNO, e1.ENAME, e1.MGR, e2.ENAME AS MGR_ENAME
FROM EMP e1 ,EMP e2
WHERE e1.MGR = e2.EMPNO(+);

-- right outer join
SELECT e1.EMPNO, e1.ENAME, e1.MGR, e2.ENAME AS MGR_ENAME
FROM EMP e1 ,EMP e2
WHERE e1.MGR(+) = e2.EMPNO;

-- 표준 문법을 사용한 조인
-- JOIN ~ ON : inner 조인(내부조인)
-- JOIN 테이블명 ON 조인 조건
SELECT
	e.ENAME,
	e.DEPTNO,
	d.DNAME ,
	d.LOC
FROM
	EMP e
JOIN DEPT d 
ON
	e.DEPTNO = d.DEPTNO;

-- 내부조인
SELECT
	*
FROM
	EMP e
JOIN SALGRADE s 
ON
	e.SAL BETWEEN s.LOSAL AND s.HISAL;

-- left outer join 테이블명 on 조인조건
SELECT
	e1.EMPNO,
	e1.ENAME,
	e1.MGR,
	e2.ENAME AS MGR_ENAME
FROM
	EMP e1
LEFT OUTER JOIN EMP e2 
ON
	e1.MGR = e2.EMPNO;

SELECT
	e1.EMPNO,
	e1.ENAME,
	e1.MGR,
	e2.ENAME AS MGR_ENAME
FROM
	EMP e1
RIGHT OUTER JOIN EMP e2 
ON
	e1.MGR = e2.EMPNO;

SELECT *
FROM EMP e1 JOIN EMP e2 ON e1.EMPNO  = e2.EMPNO JOIN EMP e3 ON e2.EMPNO = e3.EMPNO;


-- 급여가 2000을 초과한 사원 부서정보, 사원정보 출력
-- 출력) 부서번호, 부서명, 사원번호, 사원명, 급여
SELECT
	e.DEPTNO,
	d.DNAME,
	e.EMPNO,
	e.ENAME,
	e.SAL
FROM
	EMP e
JOIN DEPT d 
ON
	e.DEPTNO = d.DEPTNO
WHERE
	e.SAL > 2000
ORDER BY
	e.DEPTNO;

-- 모든 부서정보와 사원정보를 부서번호, 사원번호 순서로 정렬하여 출력
-- 출력) 부서번호, 부서명, 사원번호, 사원명, 직무, 급여
SELECT
	e.DEPTNO,
	d.DNAME,
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL
FROM
	EMP e
JOIN DEPT d
ON
	e.DEPTNO = d.DEPTNO
ORDER BY
	e.DEPTNO,
	e.EMPNO;

-- 모든 부서정보, 사원정보, 급여등급 정보, 각 사원의 직속상관 정보를
-- 부서번호, 사원번호, 순서로 정렬하여 출력
-- 출력) 부서번호, 부서명, 사원번호, 사원명, 매니저번호, 급여, LOSAL, HISAL, GRADE, 매니저EMPNO, 매니저이름


-- 강사님꺼
SELECT
	e1.DEPTNO,
	d.DEPTNO,
	e1.EMPNO,
	e1.ENAME,
	e1.MGR,
	e1.SAL,
	s.LOSAL,
	s.HISAL,
	s.GRADE,
	e2.EMPNO AS MGR_EMPNO,
	e2.ENAME AS MGR_ENAME
FROM
	EMP e1
LEFT OUTER JOIN EMP e2 ON
	e1.MGR = e2.EMPNO
JOIN DEPT d ON
	e1.DEPTNO = d.DEPTNO
JOIN SALGRADE s ON
	e1.SAL BETWEEN s.LOSAL AND s.HISAL
ORDER BY e1.DEPTNO, e1.EMPNO;


-- 부서별 평균급여, 최대급여, 최소급여, 사원 수 출력
-- 출력) 부서번호, 부서명, avg_sal, min_ sal, cnt
SELECT
	e.DEPTNO,
	d.DNAME,
	AVG(e.SAL) AS AVG_SAL,
	MAX(e.SAL) AS MAXSAL,
	MIN(e.SAL) AS MIN_SAL,
	COUNT(e.EMPNO) AS CNT
FROM
	EMP e
JOIN DEPT d 
ON
	e.DEPTNO = d.DEPTNO
GROUP BY
	e.DEPTNO, d.DNAME;

-- 서브쿼리
-- 이름이 JONES 인 사원의 급여보다 높은 급여를 받는 사원 조회
SELECT e.SAL 
FROM EMP e 
WHERE e.ENAME = 'JONES';

-- JONES 보다 많이 받는 사원 조회
SELECT *
FROM EMP e 
WHERE e.SAL > 2975;

-- 서브쿼리로 변경
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL > (
	SELECT
		e.SAL
	FROM
		EMP e
	WHERE
		e.ENAME = 'JONES');

-- ALLEN 보다 빨리 입사한 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.HIREDATE < (
	SELECT
		e.HIREDATE
	FROM
		EMP e
	WHERE
		e.ENAME = 'ALLEN')

-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받은 사원정보(사번, 이름, 직무, 급여)
-- 소속부서정보(부서번호, 부서명, 부서위치) 조회
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	d.DEPTNO,
	d.DNAME,
	d.LOC
FROM
	EMP e
JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO
WHERE
	e.DEPTNO = 20
	AND e.SAL > (
	SELECT
		AVG(e.SAL)
	FROM
		EMP e);
		
-- 전체사원의 평균급여보다 적거나 같은 급여를 받는 20번 부서 정보 조회
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	d.DEPTNO,
	d.DNAME,
	d.LOC
FROM
	EMP e
JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO
WHERE
	e.DEPTNO = 20
	AND e.SAL <= (
	SELECT
		AVG(e.SAL)
	FROM
		EMP e);

-- 다중행 서브쿼리
-- 부서별 최고급여와 같은 급여를 받는 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL IN (
	SELECT
		MAX(e.SAL)
	FROM
		EMP e
	GROUP BY
		e.DEPTNO);

-- ANY, SOME
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL = ANY (
	SELECT
		MAX(e.SAL)
	FROM
		EMP e
	GROUP BY
		e.DEPTNO);

-- < ANY , < SOME
-- 30번 부서의 (최대)급여보다 적은 급여를 받는 사원조회 (다중행)
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL < ANY (
	SELECT
		e.SAL
	FROM
		EMP e
	WHERE
		e.DEPTNO = 30)
ORDER BY
	e.SAL,
	e.EMPNO;

-- 30번 부서의 (최대)급여보다 적은 급여를 받는 사원조회 (단일행)
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL < (
	SELECT
		MAX(e.SAL)
	FROM
		EMP e
	WHERE
		e.DEPTNO = 30)
ORDER BY
	e.SAL,
	e.EMPNO;

-- 30번 부서의 (최소)급여보다 적은 급여를 받는 사원조회 (다중행)
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL < ALL (
	SELECT
		e.SAL
	FROM
		EMP e
	WHERE
		e.DEPTNO = 30);

-- 30번 부서의 (최소)급여보다 적은 급여를 받는 사원조회 (단일행)
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL < (
	SELECT
		MIN(e.SAL)
	FROM
		EMP e
	WHERE
		e.DEPTNO = 30);

-- EXISTS
SELECT * FROM EMP e WHERE EXISTS (SELECT d.DNAME FROM DEPT d WHERE d.DEPTNO = 10);

SELECT * FROM EMP e WHERE EXISTS (SELECT d.DNAME FROM DEPT d WHERE d.DEPTNO = 50);

-- 비교할 열이 여러개인 다중열 서브쿼리
-- 부서별 최대급여와 같은 급여를 받는 사원조회
SELECT
	*
FROM
	EMP e
WHERE
	(e.DEPTNO,
	e.SAL) IN (
	SELECT
		e.DEPTNO,
		MAX(e.SAL)
	FROM
		EMP e
	GROUP BY
		e.DEPTNO);

-- SELECT 절에 사용하는 서브쿼리(결과가 반드시 하나만 반환)
-- 사원정보, 급여등급, 부서명 조회 => 조인 or 서브쿼리
SELECT
	e.EMPNO,
	e.JOB,
	e.SAL,
	(
	SELECT
		s.GRADE
	FROM
		SALGRADE s
	WHERE
		e.SAL BETWEEN s.LOSAL AND s.HISAL ) AS SALGRADE,
	e.DEPTNO,
	(
	SELECT
		d.DNAME
	FROM
		DEPT d
	WHERE
		e.DEPTNO = d.DEPTNO ) AS DNAME
FROM
	EMP e ;

-- 10 번 부서에 근무하는 사원 중 30번 부서에 없는 직책인 사원의 사원 정보(사번, 이름, 직무, 부서정보(부서번호, 부서명, 위치)) 조회
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.DEPTNO,
	d.DNAME,
	d.LOC
FROM
	EMP e
JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO
WHERE
	e.JOB NOT IN (
	SELECT
		e.JOB
	FROM
		EMP e
	WHERE
		e.DEPTNO = 30)
	AND e.DEPTNO = 10;


-- 직책이 SALESMAN인 사람의 최고급여보다 많이 받는 사람의 사원정보, 급여등급정보를 조회
-- 다중행 함수를 사용하는 방법과 사용하지 않는 방법 2가지로 작성
-- 출력 : 사번, 이름, 급여, 등급
SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	(
	SELECT
		s.GRADE
	FROM
		SALGRADE s
	WHERE
		e.SAL BETWEEN s.LOSAL AND s.HISAL) AS SALGRADE
FROM
	EMP e
WHERE
	e.sal > ALL (
	SELECT
		MAX(e.SAL)
	FROM
		EMP e
	WHERE
		e.JOB = 'SALESMAN')
ORDER BY
	e.EMPNO
		
-- 다중행 사용 X
SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	(
	SELECT
		s.GRADE
	FROM
		SALGRADE s
	WHERE
		e.SAL BETWEEN s.LOSAL AND s.HISAL) AS SALGRADE
FROM
	EMP e
WHERE
	e.sal > (
	SELECT
		MAX(e.SAL)
	FROM
		EMP e
	WHERE
		e.JOB = 'SALESMAN')
ORDER BY
	e.EMPNO