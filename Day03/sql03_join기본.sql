/*
 * JOIN
 * */

-- 개념
-- 정규화되어 나누어진 테이블의 데이터를 한꺼번에 모아서 쉽게 출력하기 위한 기법
SELECT *
  FROM EMPLOYEES e
  WHERE E.DEPARTMENT_ID= 20;

SELECT *
  FROM DEPARTMENTS d 
  WHERE d.DEPARTMENT_ID = 100;

SELECT *
  FROM EMPLOYEES e , DEPARTMENTS d
  WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID;


-- 총 데이터수가 2889개 출력
-- 카테시안 곱
SELECT *
  FROM EMPLOYEES e ,DEPARTMENTS d ;

-- 오라클 방식. 표준방식이 아님. 편하게 쿼리를 작성하라고 만든 편법
SELECT d.DEPARTMENT_NAME
  FROM EMPLOYEES e , DEPARTMENTS d 
  WHERE e.DEPARTMENT_ID =d.DEPARTMENT_ID;

-- ANSI 표준 문법
SELECT *
  FROM EMPLOYEES e 
  INNER JOIN DEPARTMENTS d 
      ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- 필요컬럼만 명세
SELECT E.EMPLOYEE_ID
	 , E.FIRST_NAME || ' '|| E.LAST_NAME AS "full_name"
	 , e.EMAIL
	 , e.PHONE_NUMBER
	 , e.HIRE_DATE
	 , e.JOB_ID
	 , d.DEPARTMENT_NAME
  FROM EMPLOYEES e 
  INNER JOIN DEPARTMENTS d 
      ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- 내부조인(INNER JOIN)
SELECT E.EMPLOYEE_ID
	 , E.FIRST_NAME || ' '|| E.LAST_NAME AS "full_name"
	 , e.EMAIL
	 , e.PHONE_NUMBER
	 , e.HIRE_DATE
	 , e.JOB_ID
	 , d.DEPARTMENT_NAME
	 , l.CITY
	 , l.STATE_PROVINCE
	 , l.STREET_ADDRESS
  FROM EMPLOYEES e , DEPARTMENTS d , LOCATIONS l 
  WHERE e.DEPARTMENT_ID =d.DEPARTMENT_ID
   AND l.LOCATION_ID =d.LOCATION_ID
   AND d.DEPARTMENT_ID = 60; 
--   AND d.DEPARTMENT_NAME LIKE 'IT'
   
-- 외부조인(OUTER JOIN)
-- 보통 PK와 FK간의 일치하는 조건의 데이터를 찾는것 - 내부조인
-- PK와 FK간의 일치하지 않는 조건의 데이터도 찾는것 - 외부조인
-- 테이블1, OUTER JOIN 테이블 2
-- 테이블1번을 기준으로 외부조인 LEFT OUTER JOIN
-- 테이블2번을 기준으로 외부조인 RIGHT OUTER JOIN

-- ANSI 표준문법
-- EMPLOYEES 테이블에는 있는데 DEPARTMENTS테이블에는 없는 데이터를 같이 출력해줘

SELECT *
  FROM employees e
 inner JOIN departments d
    ON e.department_id = d.department_id
 WHERE e.DEPARTMENT_ID IS NULL;

-- ANSI 표준문법
-- employees테이블에는 있는데 departments테이블에는 없는 데이터를 같이 출력해줘
SELECT *
  FROM employees e
  LEFT OUTER JOIN departments d
    ON e.department_id = d.department_id
 WHERE e.DEPARTMENT_ID IS NULL;

-- departments테이블에는 있는데 employees 테이블에 없는 데이터를 같이 출력해줘
SELECT *
  FROM employees e
 RIGHT OUTER JOIN departments d
    ON e.department_id = d.department_id;

-- Oracle 문법
-- (+)만족하지 않는 조건도 더 나오게 한다는 뜻
-- LEFT OUTER JOIN
SELECT *
  FROM employees e, departments d
 WHERE e.department_id = d.department_id(+);

-- RIGHT OUTER JOIN
SELECT *
  FROM employees e, departments d
 WHERE e.department_id(+) = d.department_id;
   
-- INNER JOIN은 INNER를 생략가능
-- OUTER JOIN에만 LEFT, RIGHT존재하므로 OUTER 생략가능
    
-- 셀프조인: 자기자신을 두번 사용하는 조인
SELECT e1.employee_id
	 , e1.first_name || ' ' || e1.LAST_NAME AS "full_emp_name"
     , e1.job_id
     , e1.manager_id
     , e2.first_name || ' ' || e2.LAST_NAME AS "full_mng_name"
     , e2.JOB_ID
  FROM employees e1, employees e2
 WHERE e1.manager_id = e2.employee_id(+)
 ORDER BY e1.manager_id;





