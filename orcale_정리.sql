
/* ORACLE 기본
 
 1. RDBMS
	 기본단위 : 테이블

	* EMP(사원정보 테이블)
	* empno(사번), ename(사원명), job(직책), mgr(직속상관 사원번호), hiredate(입사일), sal(급여), comm(추가수당), deptno(부서번호)
	* NUMBER(4,0) : 전체 자릿수 4자리(소수점 자릿수 0)
	* VARCHARTO2(10) : 문자열 데이터 => 문자열 10byte (VAR : 가변 ex. 7byte 문자열 저장했다면 7byte 공간만 사용)
		 			   영어 : 10문자 / 한글 : 2byte (utf-8 : 3byte) 할당
	* DATE : 날짜
	* DEPT(부서테이블)
	* deptno(부서번호), dname(부서명), loc(부서위치)
	* SALGRADE(급여테이블)
	* grade(급여 등급), losal(최저급여), hisal(최대급여)

	* 개발자 : CR(read)UD
	* SQL(Structured Query Language : 구조질의언어) : RDBMS 데이터를 다루는 언어
 	 ㄴ 모든 RDBMS에서 사용 가능한 표준화된 언어

	* 조회 : cost가 있음(시간이 얼마나 걸리는가) => 시간을 얼마나 빠르게 조회하는가가 중요
	* SQL 구문 실행 순서
		① FROM => ② WHERE => ③ SELECT => ④ ORDER by
		
	* XE 버전 한글의 바이트 수 : 3byte

 << 연산자 >>
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

 << 오라클 함수 >>
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
 				INSTR(①대상문자열, ②위치를 찾으려는 문자, ③시작위치, ④시작위치에서 찾으려는 문자가 몇번째인지)
 					=> ①, ② 필수
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
 					
 		2. 숫자 함수
 			1) ROUND(지정 문자열, 몇번째에서 할지) : 반올림
 			2) TRUNC(지정 문자열, 몇번째에서 할지) : 버림
 			3) CEIL() : 가장 큰 정수
 			4) FLOOR() : 가장 작은 정수
 			5) MOD() : 나머지
 	
		3. 날짜 함수
 			1) SYSDATE : 오늘날짜/시간
 			2) ADD_MONTHS() : 몇개월 이후 날짜 구하기
 			3) MONTHS_BETWEEN() : 두 날짜간의 개월 수 차이 구하기
 			4) NEXT_DAY() / LAST_DAY : 돌아오는 요일, 달의 마지막 날짜 구하기
 	
 		4. 자료형을 변환하는 형변환 함수
 			1) TO_CHAR() : 숫자 또는 날짜 데이터를 문자열 데이터로 반환
 				-날짜(SYSDATE) 형변환
 					TO_CHAR(SYSDATE, 'MM'), => 03
					TO_CHAR(SYSDATE, 'MON'), => 3월 
					TO_CHAR(SYSDATE, 'MONTH'), => 3월 
					TO_CHAR(SYSDATE, 'DD'), => 19
					TO_CHAR(SYSDATE, 'DY'), => 수
					TO_CHAR(SYSDATE, 'DAY'), => 수요일
					TO_CHAR(SYSDATE, 'HH24:MI:SS'), => 17:59:04
					TO_CHAR(SYSDATE, 'HH12:MI:SS AM'), => 05:59:04 오후
					TO_CHAR(SYSDATE, 'HH:MI:SS PM') => 05:59:04 오후
		
					* 12시간제 이므로 HH24 라고 명시하지 않으면 05:59:04 식으로 도출
					* AM, PM => 아무거나 주면 오전/오후 나옴
 			2) TO_NUMBER) : 문자열 데이터를 숫자 데이터로 반환
 			3) TO_DATE() : 문자열 데이터를 날짜 데이터로 반환
 	
 				* NUMBER + '문자숫자' => 덧셈 가능 => 자동형변환
*/