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

-- 데이터사전 DBA_USERS 를 사용하여 사용자 정보 조회
SELECT * FROM DBA_USERS WHERE USERNAME = 'SCOTT';

-- scott 에게 VIEW 생성 권한 부여
GRANT CREATE VIEW TO scott;

-- 사용자 관리

-- 1. 사용자 생성 구문
CREATE USER C##JAVA IDENTIFIED BY 12345
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA 10M ON USERS;

-- 2. 권한부여(GRANT)
-- BOARD 테이블의 SELECT,INSERT,DELETE 권한 부여
-- GRANT SELECT,INSERT,DELETE ON BOARD TO C##TEST1;
-- 롤
GRANT CONNECT,RESOURCE TO C##JAVA;

-- 공통 사용자 또는 롤 이름이 부적합합니다.
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER TEST2 IDENTIFIED BY 12345;

SELECT * FROM ALL_USERS
WHERE USERNAME = 'C##TEST1';

-- 비밀번호 변경
ALTER USER C##TEST1 IDENTIFIED BY 54321;

-- 사용자 제거
DROP USER C##TEST1;

-- ORA-01922: 'C##TEST1'(을)를 삭제하려면 CASCADE를 지정하여야 합니다
-- 사용자 스키마에 객체가 존재한다면 CASCADE 옵션 사용해서 제거
DROP USER C##TEST1 CASCADE;





























