/*
 * 내장 함수
 */


-- 문자(열)함수

-- INITCAP()
SELECT INITCAP('hello world') AS "result"
  FROM dual; -- 실제하지 않는 테이블(Oracle만!)
  
-- LOWER(), 모든글자 소문자 UPPER() 모든글자 대문자
SELECT LOWER(e.first_name) AS "first_name"
  	 , e.FIRST_NAME
  	 , UPPER(e.LAST_NAME) "last_name"
  	 , e.LAST_NAME
  FROM EMPLOYEES e ;

-- LENGTH()/ LENGTHB() 함수
SELECT LENGTH('Hello oracle') -- 영어는 글자길이 12
  	 , LENGTHB('Heelo oracle') -- 12byte
  	 , LENGTH('반가워요 오라클') -- 한글 글자길이 8
  	 , LENGTHB('반가워요 오라클') -- 22byte, 한글 7자 x 3byte = 21byte + 공백 1byte
  	 , ASCII('A')
  	 , ASCII('a')
  	 , ASCII('가')
  FROM dual;

-- CONCAT() == ||와 동일기능
SELECT CONCAT(e.FIRST_NAME,e.LAST_NAME )
  FROM EMPLOYEES e 