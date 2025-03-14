/*
 * UPDATE/DELETE
 * 데이터변경/데이터 삭제 
 */

-- 삭제
SELECT COUNT(*)
  FROM PROFESSOR_NEW pn;

DELETE FROM PROFESSOR_NEW PN
  WHERE PN.profno =  1001;

-- 삭제시 WHERE절 빼는 것은 극히 주의!!!
DELETE FROM PROFESSOR_NEW ; -- TRUNCATE와 동일하나 테이블 초기화는 없음

-- 변경
-- PROFNO 4002인 수잔 서랜든의 아이디를 기존 Shrandon에서 SusanS로, 급여를 330에서 350으로 올리시오.
-- 변경시 WHERE절 빼는 것은 극히 주의!!!
UPDATE PROFESSOR_new SET
		ID = 'SusanS'
	  , Pay = 350;
WHERE profno = 4002

SELECT *
 FROM PROFESSOR_NEW pn;


