/*
 * 복수행, GROUP BY와 가장 많이 사용
 * COUNT(), SUM(),AVG(), MIN(), MAX(), STDDEV() ...
 * ROLLUP, CUBE, RANK, DENSE_RANK...
 */

-- COUNT() -- 무지무지무지 많이 씀
SELECT COUNT(*) AS "count" -- scalar value : 딱 하나의 행만 나오는 것
 FROM EMPLOYEES e;

SELECT COUNT(e.EMPLOYEE_ID) AS "count" -- scalar value 
 FROM EMPLOYEES e;

-- SUM(숫자형컬럼) 합계
-- employees 206 salary 8300 삭제
SELECT sum(e.SALARY)
  FROM EMPLOYEES e;

-- avg(숫자형컬럼) 평균
SELECT avg(e.SALARY)
  FROM EMPLOYEES e ;

SELECT ROUND(avg(e.SALARY),3)
  FROM EMPLOYEES e ;

-- 전체 사람이 107명 이였는데 null 이 있어서 106명이 나온다.
-- 컬럼에 NULL값이 있으면 제외하고 계산하기 때문에 잘못된 값이 도출한다. 
-- 금액이나 수량을 계산하는 컬럼의 null값은 전처리해줘야 함.
SELECT count(e.SALARY) 
  FROM EMPLOYEES e ;

-- min(숫자형컬럼|문자형도가능), max(숫자형컬럼|문자형도가능)
SELECT max(e.SALARY), min(e.SALARY)
  FROM EMPLOYEES e ;

-- avg(숫자형컬럼) 평균
SELECT max(e.FIRST_NAME), min(e.FIRST_NAME)
  FROM EMPLOYEES e ;

/*
 * GROUP BY 연계, 그룹화.
 * GROUP BY를 사용하면 SELECT절에는 GROUP BY 사용한 컬럼과 집계함수 및 일반함수만 사용할 수 있다.
 * */

-- 아래의 경우 DEPARTMENT_ID 이외의 컬럼은 사용불가
SELECT E.DEPARTMENT_ID
	 , AVG(E.SALARY) AS "부서별_평균"
	 , TO_CHAR(ROUND(AVG(E.SALARY),1), '99,999.9') AS "부서별평균급여" 
	 , SUM(E.SALARY) AS "부서별급여총액"
  FROM EMPLOYEES e 
GROUP BY E.DEPARTMENT_ID
ORDER BY "부서별평균급여" DESC ;

-- employees에서 부서와 직군별 급여총액과 직원수를 출력하는데
-- DEPARTMENT_ID가 30에서 90사이이고, 부서직군별급여총액이 20,000달러 이상인 데이터만 보일것.
SELECT e.DEPARTMENT_ID, E.JOB_ID
	 , SUM(E.SALARY) AS "부서직군별급여총액"
	 , COUNT(*)	 
-- ORDER BY에는 컬럼의 순번(1부터 시작)으로 컬럼명을 대체가능
  FROM EMPLOYEES e
  WHERE E.DEPARTMENT_ID BETWEEN 30 AND 90
--    and SUM(E.SALARY) >= 20000 -- 집계함수는 where에 사용불가
  GROUP BY e.DEPARTMENT_ID, E.JOB_ID
  HAVING  SUM(E.SALARY) >= 20000	  
  ORDER BY	DEPARTMENT_ID ;


-- ROLLUP 그룹별 소개와 총계를 표시해주는 기능
-- ROLLUP 쓸땐 ORDER BY를 사용하지 않음.
SELECT e.DEPARTMENT_ID, E.JOB_ID
	 , SUM(E.SALARY) AS "부서직군별급여총액"
	 , COUNT(*)	 
  FROM EMPLOYEES e
  WHERE E.DEPARTMENT_ID BETWEEN 30 AND 90
  GROUP BY ROLLUP (e.DEPARTMENT_ID, E.JOB_ID);
  
-- PIVOT() 엑셀에 동일한 기능
-- PIVOT() 안쓰고 각 달별로 입사한 사원의 수를 표시. 12행
-- 각 입사일자에서 달만 추출
SELECT TO_CHAR(E.HIRE_DATE, 'MM')
  FROM EMPLOYEES e ;

-- 입사 달별로 그룹핑
SELECT TO_CHAR(E.HIRE_DATE, 'MM')
	 , COUNT(*)
  FROM EMPLOYEES e
  GROUP BY TO_CHAR(E.HIRE_DATE, 'MM');

SELECT TO_CHAR(E.HIRE_DATE, 'MM') AS "월별"
	 , COUNT(*) AS "인원"
  FROM EMPLOYEES e
  GROUP BY TO_CHAR(E.HIRE_DATE, 'MM')
  ORDER BY TO_CHAR(E.HIRE_DATE, 'MM');

-- 1월달에 입사한 사람 카운팅
SELECT CASE TO_CHAR(E.HIRE_DATE, 'MM') WHEN '01' THEN COUNT(*) ELSE 0 END AS "1월"
  FROM EMPLOYEES e
  GROUP BY TO_CHAR(E.HIRE_DATE, 'MM');

-- 옆으로 각 달별로 스프레드
-- 1월달에 입사한 사람 카운팅
SELECT CASE TO_CHAR(E.HIRE_DATE, 'MM') WHEN '01' THEN COUNT(*) ELSE 0 END AS "1월"
     , CASE TO_CHAR(E.HIRE_DATE, 'MM') WHEN '02' THEN COUNT(*) ELSE 0 END AS "2월"
     , CASE TO_CHAR(E.HIRE_DATE, 'MM') WHEN '03' THEN COUNT(*) ELSE 0 END AS "3월"
     , CASE TO_CHAR(E.HIRE_DATE, 'MM') WHEN '04' THEN COUNT(*) ELSE 0 END AS "4월"
     , CASE TO_CHAR(E.HIRE_DATE, 'MM') WHEN '05' THEN COUNT(*) ELSE 0 END AS "5월"
     , CASE TO_CHAR(E.HIRE_DATE, 'MM') WHEN '06' THEN COUNT(*) ELSE 0 END AS "6월"
     , CASE TO_CHAR(E.HIRE_DATE, 'MM') WHEN '07' THEN COUNT(*) ELSE 0 END AS "7월"
     , CASE TO_CHAR(E.HIRE_DATE, 'MM') WHEN '08' THEN COUNT(*) ELSE 0 END AS "8월"
     , CASE TO_CHAR(E.HIRE_DATE, 'MM') WHEN '09' THEN COUNT(*) ELSE 0 END AS "9월"
     , CASE TO_CHAR(E.HIRE_DATE, 'MM') WHEN '10' THEN COUNT(*) ELSE 0 END AS "10월"
     , CASE TO_CHAR(E.HIRE_DATE, 'MM') WHEN '11' THEN COUNT(*) ELSE 0 END AS "11월"
     , CASE TO_CHAR(E.HIRE_DATE, 'MM') WHEN '12' THEN COUNT(*) ELSE 0 END AS "12월"
  FROM EMPLOYEES e
  GROUP BY TO_CHAR(E.HIRE_DATE, 'MM')
  ORDER BY TO_CHAR(E.HIRE_DATE, 'MM');

SELECT DECODE(TO_CHAR(E.HIRE_DATE, 'MM') , '01', COUNT(*), 0 ) AS "1월"
     , DECODE(TO_CHAR(E.HIRE_DATE, 'MM') , '02', COUNT(*), 0 ) AS "2월"
     , DECODE(TO_CHAR(E.HIRE_DATE, 'MM') , '03', COUNT(*), 0 ) AS "3월"
     , DECODE(TO_CHAR(E.HIRE_DATE, 'MM') , '04', COUNT(*), 0 ) AS "4월"
     , DECODE(TO_CHAR(E.HIRE_DATE, 'MM') , '05', COUNT(*), 0 ) AS "5월"
     , DECODE(TO_CHAR(E.HIRE_DATE, 'MM') , '06', COUNT(*), 0 ) AS "6월"
     , DECODE(TO_CHAR(E.HIRE_DATE, 'MM') , '07', COUNT(*), 0 ) AS "7월"
     , DECODE(TO_CHAR(E.HIRE_DATE, 'MM') , '08', COUNT(*), 0 ) AS "8월"
     , DECODE(TO_CHAR(E.HIRE_DATE, 'MM') , '09', COUNT(*), 0 ) AS "9월"
     , DECODE(TO_CHAR(E.HIRE_DATE, 'MM') , '10', COUNT(*), 0 ) AS "10월"
     , DECODE(TO_CHAR(E.HIRE_DATE, 'MM') , '11', COUNT(*), 0 ) AS "11월"
     , DECODE(TO_CHAR(E.HIRE_DATE, 'MM') , '12', COUNT(*), 0 ) AS "12월"
  FROM EMPLOYEES e
  GROUP BY TO_CHAR(E.HIRE_DATE, 'MM')
  ORDER BY TO_CHAR(E.HIRE_DATE, 'MM');

-- RANK() 등수 공동등수 번호가 띄위기, DENSE_RANL() 등수번호가 순차적으로 올라감
-- ROW_NUMBER() 현재 데이터 행번호 출력
SELECT e.EMPLOYEE_ID ,E.LAST_NAME, E.SALARY
	 , RANK() OVER(ORDER BY e.SALARY DESC ) AS "랭크" -- 잘 안씀 *공동순위가 잇을경우 다음순서가 그에 맞춰 밀려는 걸 볼 때 사용
	 , DENSE_RANK() OVER(ORDER BY e.SALARY DESC ) AS "랭크" --  일반적으로  많이 사용 
	 , ROW_NUMBER() OVER (ORDER BY E.SALARY DESC ) AS "행번호"
  FROM EMPLOYEES e
  

