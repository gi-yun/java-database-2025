/*
 * SQL - DML - SELECT 학습
 */


-- 01. HR.employees 테이블의 모든 데이터를 조회하세요.(107건)
SELECT * -- asterik -> ALL로 발음. 모든 컬럼을 다 보여라
  FROM EMPLOYEES e ;
 
-- 02. HR.employees중 employee_id, first_name, last_name, email, hire_date(107행)
SELECT e.EMPLOYEE_ID , e.first_name, e.LAST_NAME, e.EMAIL, e.HIRE_DATE
  FROM EMPLOYEES e;

-- 03. 02번의 쿼리를 컬럼명을 변경해서 출력하시오. '직원번호','이름','성','이메일','입사일자' 로 변경하시오.(107행)
SELECT e.EMPLOYEE_ID AS "직원번호" 
		, e.first_name AS "이름"
		, e.LAST_NAME AS "성"
		, e.EMAIL AS "이메일"
		, e.HIRE_DATE AS "입사일자"
  FROM EMPLOYEES e;

-- 04. employees에서 job_id가 중복되지 않게 출력하시오. (19행)
-- distinct - 중복제거 ,all -전부다.
SELECT DISTINCT e.JOB_ID 
  FROM EMPLOYEES e; 

-- 05. employees 테이블의 이름과 성을 붙여서 full_name으로, phone_number를 출력하시오. (107행)
SELECT e.FIRST_NAME ||' '|| e.LAST_NAME  AS "full_name"
	 , e.PHONE_NUMBER 
  FROM EMPLOYEES e;

-- 06. employees 테이블 직원들 정보를 아래와 같이 나오도록 출력하시오.
/*
 *full_name(emloyee_id) - job-id[hire_date] / phone_number 하나의 컬럼에 
 * stven king(100) - AD_PRES[2003-06-17 00:00:00] / 515.123.4567
 * ...
 */
SELECT E.FIRST_NAME || ' ' || e.LAST_NAME  ||'('|| e.EMPLOYEE_ID || ') - ' 
  		|| e.JOB_ID || '['|| e.HIRE_DATE || ']'|| ' / '
  		|| e.PHONE_NUMBER AS "total info"
  FROM EMPLOYEES e ;

/*
 *  조건절 -Where
 */

-- 연습) employees 테이블에서 employee_id가 110번인 직원을 출력하라(1행)
SELECT *
  FROM EMPLOYEES e
  WHERE e.EMPLOYEE_ID = 110;

-- 연습) 이름이 Fist name이 John으로 찾아라 (3행)
SELECT *
  FROM EMPLOYEES e 
  WHERE e.FIRST_NAME ='John';

-- 연습) hire_date가 2006-02-12인 직원을 출력하시오.
SELECT *
  FROM EMPLOYEES e 
  WHERE e.HIRE_DATE ='2006-02-12'; -- 날짜 타입은 문자열처럼 비교하면 됨.
  
-- 데이터타입 숫자형, 문자형, 날짜형 등
 
  /*
   * WHERE절에 사용하는 사용하는 연산자
   * ● = : equal. 여타 프로그래밍 언어와 달리 = 하나만 사용
   * ● != , <> : not equal 같지 않다.
   * ● >, >=, <, <= : 크다, 크거나 같다, 작다, 작거나 같다.
   * ● BETWEEN a AND b : 특정값이 a이상, b이하에 있다.
   * ● IN(a, b, c) : 특정값이 a 이거나 b 이거나 c 중 하나 이다.
   * ● like : SQL에서 문자열 비교시 특화된 연산자
   * ● NULL비교, IS NULL, IS NOT NULL : NULL값을 검색할 때, NULL값이 아닌 걸 검색할 때
   * ● a AND B = a와 b 조건을 모두 만족해야 True
   * ● a OR B = a와 b 조건을 하나만 만족하면 True
   * ● NOT a : a가 아닌 조건. 반대조건
   */
  
  SELECT *
    FROM EMPLOYEES e 
    WHERE e.HIRE_DATE  != '2006-02-12';
  
 -- between은 초과, 미만이 아님 이상, 이하임!.
  SELECT *
    FROM EMPLOYEES e 
    WHERE e.SALARY BETWEEN 9000 AND 15000;
 -- and와 >= <= 똑같이 구현가능
  SELECT *
    FROM EMPLOYEES e 
    WHERE e.SALARY>=9000 AND e.SALARY <=15000;

 -- 
 SELECT *
   FROM EMPLOYEES e 
   WHERE e.FIRST_NAME  IN ('John','Steven','Neena');
   
 -- or로 in처럼 짤수 있다.
 SELECT *
   FROM EMPLOYEES e 
   WHERE e.FIRST_NAME ='John'
   OR e.FIRST_NAME ='Steven'
   OR e.FIRST_NAME ='Neena';
 
 -- Null비교
 -- NULL은 항상 FALSE만 반환
 SELECT *
   FROM EMPLOYEES e 
   WHERE e.COMMISSION_PCT = NULL;
 
  SELECT *
   FROM EMPLOYEES e 
   WHERE e.COMMISSION_PCT IS NULL;
  
  SELECT *
   FROM EMPLOYEES e 
   WHERE e.COMMISSION_PCT  IS not NULL;
  
 -- LIKE 문자열 패턴으로 검색
  SELECT *
    FROM EMPLOYEES e 
    WHERE e.JOB_ID IN ('ST_MAN','MK_MAN','PU_MAN');
 
 
 SELECT *
   FROM EMPLOYEES e 
   WHERE E.JOB_ID LIKE '%MAN'; -- 앞쪽 문자열이 뭐든지 상관없고 MAN으로 끝나는 무자를 가진 패턴을 찾아라
 
 
  SELECT *
   FROM EMPLOYEES e 
   WHERE E.JOB_ID LIKE '%_%'; -- 문자열에 _ 가지는 문자열을 찾아라

  
 
SELECT *
   FROM EMPLOYEES e 
   WHERE E.LAST_NAME  LIKE 'Ra%'; -- 뒤쪽 문자열은 상관없고 Ra로 시작하는 패턴을 가진 문자열을 찾아라
   
SELECT *
   FROM EMPLOYEES e 
   WHERE E.LAST_NAME  LIKE 'Ra__'; --총 네글자 중 Ra로 시작하는 패턴을 찾아달라.
   
 SELECT *
   FROM EMPLOYEES e 
   WHERE E.JOB_ID LIKE '__%_%'; -- 앞에 2글자만 들어오고 중간에 _ 가 들으며 뒤쪽엔 무슨 문자열이 와도 상관없는 패턴을 찾아라.
   
   
-- 07. employyees 에서 hir_date 가 2005-01-01 이후에 입사했고, salary가 10000이상인 직원을 출력하시오.
-- 이름과 이메일, 전화번호, 입사일, 급여 표시
SELECT e.FIRST_NAME ||' ' || e.LAST_NAME AS "이름"
  	 , e.EMAIL AS "이메일"
     , e.PHONE_NUMBER  AS "전화번호"
     , e.HIRE_DATE AS "입사일"
     , e.SALARY AS "급여"
  FROM EMPLOYEES e 
  WHERE e.HIRE_DATE >'2005-01-01'
  AND e.SALARY >=10000;

/*
 * 정렬 -ORDER BY
 * ASCending - (오름차순)
 * DSECending - (내림차순)
 */

SELECT *
 FROM EMPLOYEES e 
 ORDER BY e.SALARY;

SELECT *
 FROM EMPLOYEES e 
 ORDER BY e.SALARY ASC;

SELECT *
 FROM EMPLOYEES e 
 ORDER BY e.SALARY DESC;

SELECT *
 FROM EMPLOYEES e 
 ORDER BY e.COMMISSION_PCT;

SELECT *
 FROM EMPLOYEES e 
 ORDER BY e.COMMISSION_PCT desc;


SELECT *
 FROM EMPLOYEES e 
 ORDER BY e.JOB_ID, e.SALARY DESC  ;

/*
 * 집합, UNION, UNION ALL, INTERSECT, MINUS
 */
-- SELECT * FROM DEPARTMENTS d
-- departments 에서 departments_id가 50 이하인 부서아이디와 부서명 데이터
-- employees에서 employee_id가 110에 150 사이인 직원아이디와 직원명(first_name||' '||last_name)를 합쳐서 출력하시오.

SELECT d.DEPARTMENT_ID, d.DEPARTMENT_NAME  
  FROM DEPARTMENTS d
  WHERE d.DEPARTMENT_ID  <=50
 UNION 
SELECT e.EMPLOYEE_ID, e.FIRST_NAME || ' '||e.LAST_NAME AS "full_name"
  FROM EMPLOYEES e 
  WHERE e.EMPLOYEE_ID BETWEEN 110 AND 150;



