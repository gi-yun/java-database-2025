/*단일행 함수*/
--
SELECT  concat('Hello', 'Oracle') -- 한행한열만 출력되는 값을 = 스칼라(Scalar) 값
  FROM dual;

-- SUBSTR() - Python substring() 함수와 동일,
-- 인덱스가 1부터, 일반프로그래밍언어의 배열이 0부터 시작하는 것과의 차이

SELECT substr(email, 1, 2) --진짜 진짜 많이 씀
	 , SUBSTR(email, -2, 2)
	 , e.EMAIL
  FROM EMPLOYEES e ;

-- 전화번호자를 때, 주민번호자를때 SUBSTR()활용

-- INSTR(체크할문자열, 찾는글자, 시작위치, 몇번째)
SELECT '010-9999-8888'
	 , INSTR('010-9999-8888', '-', 1, 1)
  FROM dual;

-- LPAD(문자열, 자리수, 채울문자)
-- 2025-11-23
-- 2025-3-12 -> 2025-03-12
-- 0000100 규칙인데
-- 101 -> 0000101

SELECT LPAD('100',7,'0') -- 진짜 많이 씀
	 , RPAD('ABC', 7, '-') -- 
  FROM DUAL;

-- TRIM() 함수 트리플. == 파이썬 STRIP() 함수와 동일 * 웹사이트 만들 때 꽤 많이 사용함.
-- LTRIM(), RTRIM(), TRIM()
SELECT '<<<' || '     Hello Oracle     ' || '>>>'
	 , '<<<' || ltrim('     Hello Oracle     ') || '>>>'
	 , '<<<' || rtrim('     Hello Oracle     ') || '>>>'
	 , '<<<' || trim('     Hello Oracle     ') || '>>>' -- 진짜  많이 씀
  FROM dual;

-- REPLACE(), 파이썬에도 동일하게 존재
SELECT E.PHONE_NUMBER
	 , REPLACE(e.PHONE_NUMBER, '123', '786') -- 많이 씀
  FROM EMPLOYEES e ;

/* 숫자 함수, 집계함수와 같이 사용 */

-- ROUND() 반올림 함수 - 파이썬 존재
-- CEIL() 올림함수, FLOOR() 내림함수, TRUNc() 내림함수 소수점
-- MOD() 나누기 나머지값 - 파이썬 mode(), %연산과 동일
-- POWER() 파이썬 math.pow() power(), 2^10 승수 계산
SELECT 786.5477 AS res1
	 , round(786.5427) AS round0 -- 소수점없이
	 , round(786.5427, 1) AS round1-- 소수점 첫째 자리
	 , round(786.5427, 2) AS round2 -- 소수점 둘째 자리
	 , round(786.5427, 3) AS round4-- 소수점 셋째 자리
	 , ceil(786.5427) AS ceilRes-- 올림함수 
	 , floor(786.5427)AS floorRes -- 내림함수
	 , Trunc(786.5427,1)AS truncRes -- 내림함수
	 ,mod(10, 4) AS "나머지"
	 ,power(2, 10) AS "2의 10승"
  FROM dual;

/*
 * 날짜함수, 나라마다 표현방식이 다름
 * 2025-03-12 아시아...
 * March/12.2025 미국, 캐나다...
 * 12/March/2025 유럽, 인도,베트남...
 * 포맷팅을 많이 함.
 */

-- 오늘날짜
SELECT sysdate -- GMT기준, +09필요
	-- 날짜 포맷팅 사용되는 YY, YYYY, MM, DD, DAY 년월일
	-- AM/PM, HH, HH24, MI, SS, W, Q(분기)
	 , TO_CHAR(sysdate, 'YYYY-MM-DD DAY') AS 한국식
	 , TO_CHAR(sysdate, 'AM/PM HH24:MI:SS') AS 시간 -- HH24 로 쓰는게 좋다 그렇지 않으면 오전 오후 구별하기 힘들다.
	 , TO_CHAR(SYSDATE, 'MON/DD/YYYY') AS 미국식
	 , TO_CHAR(SYSDATE, 'DD/MM/YYYY') AS 영국식
  FROM dual;

-- ADD_MONTHS() 날짜에 월을 추가함수.
-- MON, TUE, WED, TUR, FRI, SAT, SUN
SELECT e.HIRE_DATE 
	 , ADD_MONTHS(E.HIRE_DATE, 3) AS 정규직일자
	 , to_char(ADD_MONTHS(E.HIRE_DATE, 3), 'yyyy-mm-dd')  AS "정규직일자(년월일)"
	 , NEXT_DAY(e.HIRE_DATE, '월') AS "돌아오는_월요일"
	 , LAST_DAY(SYSDATE) AS "달의_마지막날"
	 , TO_CHAR(LAST_DAY(SYSDATE), 'YYYY-MM-DD') AS "달의_마지막날1"
  FROM EMPLOYEES e ;

-- GMT +9 : 서울시간
-- 인터벌 숫자뒤 에는 HOUR, DAY, MONTH, YEAR
SELECT TO_CHAR(SYSDATE + INTERVAL '9' HOUR, 'YYYY-MM-DD HH24:MI:SS') AS SEOUL_TIME
  FROM DUAL;

/*형 변환 함수*/

-- TO_CHAR()
-- 숫자형을 문자형으로 변경
SELECT 12345 AS 원본
	 , TO_CHAR(12345, '9999999') AS "원본+두자리"
	 , TO_CHAR(12345, '0999999') AS "원본+두자리0"
	 , TO_CHAR(12345, '$999999') AS "통화+원본"
	 , TO_CHAR(12345, '99999.99') AS "소수점"
	 , TO_CHAR(12345, '99,999') AS "천단위쉽표" -- 진짜 많이 씀
  FROM DUAL;

-- TO_NUMBER() 문자형으로 된 데이터를 숫자형으로 변경
SELECT '5.0'*5
	 , TO_NUMBER('5.0') AS "숫자형"
--	 , TO_NUMBER('Hello') -- 숫자로 변경 할 수 없는 형태
  FROM DUAL;
	 
-- TO_DATE() 날짜형태를 문자형으로
SELECT '2025-03-12'
	 , TO_DATE('2025-03-12') + 10 -- 날짜형으로 바꾸면 연산가능
  FROM DUAL;

/*일반함수*/

-- NVL(컬림|데이터, 바꿀값) NULL값을 다른값으로 치환
SELECT E.COMMISSION_PCT
	 , NVL(E.COMMISSION_PCT, 1) -- 꽤 쓰임
  FROM EMPLOYEES e;

SELECT NVL(E.HIRE_DATE, SYSDATE) -- 입사일자가 비어있으면 오늘날짜로 대체
  FROM EMPLOYEES e;

-- NVL2(컬럼|데이터, 널이아닐때처리, 널일때처리할부분)
SELECT E.COMMISSION_PCT
	 , E.SALARY
	 , NVL2(E.COMMISSION_PCT, E.SALARY + (E.SALARY *E.COMMISSION_PCT), E.SALARY)
  FROM EMPLOYEES e;

-- DECODE(A, B, '1','2') A가 B일경우 1 아니면 2
-- 오라클만 있는 함수
SELECT E.EMAIL, E.PHONE_NUMBER , E.JOB_ID
	 , DECODE(E.JOB_ID, 'IT_PROG', '개발자만쉐', '나머진 다죽어') AS 캐치프레이즈
  FROM EMPLOYEES e;
--  WHERE E.JOB_ID  = 'IT_PROG';
 
 /* CASE 구문, 정말 중요!!
  * if, elif의 중복된 구문과 유사 - 적절하게 사용중
  */
  SELECT CASE e.JOB_ID  WHEN 'AD_PRES'THEN '사장' 
  						WHEN 'AD_VP' THEN '부사장'
  						WHEN 'IT_PROG' THEN '프로그래머'
  						WHEN 'SA_MAN' THEN '영업사원'
  						ELSE '미분류'
  		END AS 직급
  	  , e.EMPLOYEE_ID
  	  , e.JOB_ID
    FROM EMPLOYEES e;

 /*
  * 정규식(Regula Expression) - 문자열 패턴을 가지고, 동일한 패턴 데이터 추출 사용
  * ^, $, . , * , [] , [^], { } 패턴인식할때 필요한 키워드.
  */
 
 SELECT *
   FROM EMPLOYEES e 
   WHERE e.PHONE_NUMBER LIKE '%.%.%'; -- 세자리 전화, 네자리 전화번호가 구분안됨.

 SELECT *
   FROM EMPLOYEES e 
   WHERE e.PHONE_NUMBER LIKE '5__.___.%'; -- 5로 시작하고 3자리 3자리 나머지
   
-- 전화번호가 .로 구분되는 세자리 전화번호만 필터링
-- '[0-9]{6}-[0-9]{7}' 주민번호 정규식 패턴
 SELECT *
   FROM EMPLOYEES e 
   WHERE REGEXP_LIKE(e.phone_number ,'[0-9]{3}.[0-9]{3}.[0-9]{4}');

 -- first_name이 J로 시작하고, 두번째 글자가 a나 o로 나오는것을 찾기
 SELECT *
   FROM EMPLOYEES e 
   WHERE REGEXP_LIKE(e.first_name ,'^J(a|o)'); -- 
   
   
   