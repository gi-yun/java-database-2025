/*
 * 복수행 함수 마무리
 * 24.7.365 - 서버의 특징 24시간, 7일(일주일), 365일 연중무휴 내내 다 돌아야 한다.
 */

-- GROUP BY
-- 그룹핑시 GROUP BY에 들어가는 컬럼만 SELECT 절에 사용가능
-- WHERE 절은 일반적인 조건들만 비교 HAVING 집계함수를 조건에 사용할 때
SELECT e.DEPARTMENT_ID
	 , SUM(E.SALARY)
  FROM EMPLOYEES e
  WHERE E.DEPARTMENT_ID <= 70
  GROUP BY e.DEPARTMENT_ID
  HAVING SUM(E.SALARY) <= 20000
  ORDER BY 2 aSC; -- sum(e.SALARY)와 동일. selcet절 순서에 따라서
  
  -- RANK() 1, 2, 3, 4, 순
  -- DENSE_RANK() - 1, 2, 2, 3 순
  -- ROW_NUMBER() - 행번호
  -- 전에 employees 에서 급여가 높은 사람부터 순위 매길때
  SELECT E.FIRST_NAME || ' ' || E.LAST_NAME AS "full_name"
       , e.SALARY
       , e. DEPARTMENT_ID
       , RANK() OVER (PARTITION BY e.DEPARTMENT_ID ORDER BY e.SALARY desc ) AS "Rank"
       , dense_rank() OVER (PARTITION BY e.DEPARTMENT_ID ORDER BY e.SALARY  desc) AS "Dense_Rank" -- 일상에서 DENSE_RANK 더 많이 사용
       , row_number() OVER (PARTITION BY e.DEPARTMENT_ID ORDER BY e.SALARY desc) as"Row_num" -- PATITION BY 잘 사용안함.
    FROM EMPLOYEES e 
    WHERE e.SALARY  IS NOT null
    ORDER BY e.DEPARTMENT_ID  DESC;
  
  

