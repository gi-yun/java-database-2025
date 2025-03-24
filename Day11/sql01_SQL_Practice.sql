/*
 * 기본 Select 문
 */

-- 문제1. Employees 테이블에서 사원번호, 이름(이름 성 합쳐서 표시), 급여, 업무, 입사일,  상사의 사원번호로 출력하시오(107행)
SELECT e.EMPLOYEE_ID 
	 , e.FIRST_NAME || ' ' || e.LAST_NAME AS "full_name"
	 , e.SALARY
	 , e. JOB_ID 
	 , to_char(e. HIRE_DATE, 'yyyy-MM-dd') AS "hire_date" 
	 , e.MANAGER_ID
  FROM EMPLOYEES e ;

-- 문제2. Employees 테이블에서 모든 사원의 이름(last_name)과 연봉을 '이름: 1 year salary = $연봉' 형식으로
-- 출력하고, 컬럼명을 1 Year Salary로 변경하시오. (107행)

SELECT e.LAST_NAME || ' : 1 year salary :' || 
	   to_char(e.SALARY * 12, '$9999999.99') AS "1 year Salary"
  FROM EMPLOYEES e ;

-- 문제3. 부서별로 담당하는 업무를 한번씩만 출력하시오. (20행)
SELECT DISTINCT  e.DEPARTMENT_ID
	 , e.JOB_ID 
  FROM EMPLOYEES e 
  
/*
 * WHERE절, ORDER BY 절 
 */
  
-- 문제4. EMPLOYEES 에서 급여가 7000~10000 달러 범위인 사람의 이름과 성을 full_name, 급여를 오름차순으로 출력 하시오. (75행)
SELECT e.LAST_NAME || ' '|| e.FIRST_NAME AS "full_name" 
	 , e.SALARY AS "급여"
  FROM EMPLOYEES e 
 WHERE e.SALARY < 7000
	OR e.SALARY > 10000
ORDER BY e.SALARY ASC ;

-- 문제4. 다른 방법 (BETWEEN "" and "")
SELECT e.LAST_NAME || ' '|| e.FIRST_NAME AS "full_name" 
	 , e.SALARY AS "급여"
  FROM EMPLOYEES e 
 WHERE e.SALARY NOT BETWEEN 7000 AND 10000
ORDER BY e.SALARY ASC ;

-- 문제5. 현재 날짜타입을 날짜 함수를 통해서 확인하고,
-- 입사일자가 2000년 5월 20일부터 2004년 5월 20일사이에 입사한 사원의 이름(full_name), 사원번호, 고용일자를 출력일자.
-- 단 입사일을 빠른순으로 정렬하시오. (10행)
SELECT e.FIRST_NAME || ' ' || e.LAST_NAME AS "full_name" 
	 , e.EMPLOYEE_ID 
	 , TO_CHAR(e.HIRE_DATE, 'yyyy-mm-dd') AS "hire_date"
  FROM EMPLOYEES e 
 WHERE e.HIRE_DATE  BETWEEN '2003-05-20' AND '2004-05-20'
 ORDER BY e.HIRE_DATE ASC;

/*
 *  단일행 함수와 변환 함수
 */

-- 문제6. 이번 분기, 60번 IT부서가 지대한 공헌을 했음.
-- IT부서 사원 급여를 15.3% 인상하기로 했다. 정수만 반올림.
-- 출력형식은 사번, 이름과 성(full_name), 급여, 인상된급여(컬럼명 Increased Salary) 출력 (5행)
SELECT e.EMPLOYEE_ID 
	 , e.LAST_NAME || ' ' || e.FIRST_NAME
	 , e.SALARY
	 , ROUND((e.SALARY * 0.153)) AS "인상된 급여"
	 , ROUND((e.SALARY * 1.153)) AS "Increased Salary"
  FROM EMPLOYEES e 
  WHERE e.JOB_ID = 'IT_PROG';

-- 문제7. 모든 사원의 연봉을 표시하는 보고서 작성 
-- 사원 full_name, 급여, 수당여부에 따라 연봉을 표시하시오
-- 수당이 있으면 salary + commission, 없으면 salary only라고 표시. 연봉이 높은순으로 정렬 (107행)
SELECT e.LAST_NAME || ' ' || e.FIRST_NAME AS "full_name"
	 , e.SALARY
	 , (e.salary * 12) + (salary * NVL(e.COMMISSION_PCT, 0)) AS "Annual Salary" 
	 , CASE WHEN e.COMMISSION_PCT IS  NULL THEN 'salary only' 
	 	    WHEN e.COMMISSION_PCT IS  NOT NULL THEN 'salary + commison'
	        END AS "Commison_?"
  FROM EMPLOYEES e 
ORDER BY 3 Desc; -- "Annual Salary" 보다 컬럼순서인 3을 적는게 훨씬 효율적
  
/*
 * 집계함수, MIN, MAX, SUM, AVG, COUNT ...
 */  

-- 문제8. employees에서 각 사원이 소속된 부서별 급여합계, 급여평균, 급여최대값, 급여최소값 집계
-- 출력형식은 여섯자리와 세자리 구분기호, $를 앞에 표시. 부서번호의 오름차순으로 정렬.
-- 단 부서에 소속되지 않은 사원은 제외(11행)
SELECT e.DEPARTMENT_ID
	 , to_char(sum(e.SALARY), 'FM$999,999' )AS "급여합계"
	 , to_char(AVG(e.SALARY), 'FM$999,999.9') AS "급여평균"
	 , to_char(max(e.SALARY), 'FM$999,999' ) AS "급여최대값"	 
	 , to_char(min(e.SALARY), 'FM$999,999') AS "급여최소값"
  FROM EMPLOYEES e 
--  WHERE e.DEPARTMENT_ID IS NOT null
  GROUP BY  e.department_id
  HAVING e.DEPARTMENT_ID IS NOT NULL
  ORDER BY e.DEPARTMENT_ID asc;

/*
 * JOIN
 */
-- 문제9. employees, department, locations 테이블 구조파악
-- Oxford에 근무하는 사원 full_name, 업무, 부서명, 도시명을 출력하시오.(34)

SELECT e.FIRST_NAME || ' ' || e.LAST_NAME AS "full_name"
	 , e.JOB_ID 
	 , e.DEPARTMENT_ID
	 , d.DEPARTMENT_NAME 
  FROM EMPLOYEES e , DEPARTMENTS d , LOCATIONS l 
  WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID 
    AND d.LOCATION_ID =l.LOCATION_ID
    AND l.CITY LIKE 'Oxford';

-- 문제10. 부서가 없는 직원까지 모두 full_name,  업무, 부서명을 출력하세요. (107명)
-- LEFT OUTER JOIN
SELECT e.FIRST_NAME || ' ' || e.LAST_NAME AS "full_name"
	 , e.JOB_ID 
	 , d.DEPARTMENT_NAME
  FROM EMPLOYEES e , DEPARTMENTS d 
 WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID(+);

/*
 * 
 */

-- 문제11. Tucker 사원보다 급여를 많이 받는 사원의 full_name, 업무, 급여를 출력하시오 (15행)
SELECT *
  FROM EMPLOYEES e 
  WHERE e.LAST_NAME LIKE 'Tucker';

SELECT e.FIRST_NAME || ' ' || e.LAST_NAME AS "full_name"
	 , e.JOB_ID
	 , e.SALARY
  FROM EMPLOYEES e 
  WHERE e.SALARY > (SELECT e.SALARY 
			  		FROM EMPLOYEES e 
			 		WHERE e.LAST_NAME LIKE 'Tucker');

-- 문제12. 부서와 업무별 급여합계를 구하여서 급여수준 레벨을 지정하고자 함.
-- 부서별, 업무별 급여합계 및 각 부서별 총합, 각부서별, 업무별 직원수를 출력하시오.
SELECT e.DEPARTMENT_ID 
	 , e.JOB_ID
	 , to_char(sum(e.SALARY), '$999,999') AS "Sum Salary"	 
	 , count(*) "Employees_count"
  FROM EMPLOYEES e 
  GROUP BY ROLLUP (e.DEPARTMENT_ID , e.JOB_ID) ;

SELECT e.DEPARTMENT_ID 
	 , e.JOB_ID
	 , to_char(sum(e.SALARY), 'FM$999,999,999,999') AS "Sum Salary"
	 , count(*) "Employees_count"
  FROM EMPLOYEES e 
  GROUP BY(e.DEPARTMENT_ID , e.JOB_ID) ; 

SELECT *
  FROM EMPLOYEES e 
