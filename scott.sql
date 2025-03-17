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