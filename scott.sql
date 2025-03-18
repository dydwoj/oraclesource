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

-- IN 연산자로 단순화
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

-- BETEWEEN A AND B 구문 이용
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

-- LIKE : 검색
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