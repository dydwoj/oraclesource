-- 오라클 관리자
-- system, sys(최고권한)
--	 DUAL : sys 소유 테이블 (임시 연산이나 함수의 결과값 확인 용도로 사용)

-- 사용자 이름 : sys as sysdba
-- 비밀번호 : 엔터

-- 오라클 12c 버전부터 사용자계정 생성시 접두어(c##)를 요구함
-- c##hr
-- c## 사용하지 않을 때 아래 코드 사용
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

-- 비밀번호 변경
-- 비밀번호만 대소문자 구별
ALTER USER hr IDENTIFIED BY hr;

-- 계정 잠금 해제
ALTER USER 해제하려는 유저명 account unlock;
-- ex. ALTER USER hr account unlock;