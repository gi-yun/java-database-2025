-- 사번 입력으로 급여를 인상하는 프로시저
-- empno에 해당하는 사원의 급여를 10% 인상하는 프로시저 작성
SELECT * FROM emp WHERE empno = 7900;

CREATE OR REPLACE PROCEDURE up_sal
(
	v_empno 	emp.empno%TYPE 
)
--AS
--DECLARE
IS
	cnt_emp 	NUMBER(1,0);
BEGIN
	SELECT count(*) INTO cnt_emp
	  FROM emp
	 WHERE empno = v_empno;
	IF cnt_emp > 0 THEN
		UPDATE emp SET
			sal =sal+(sal*0.1)
		WHERE empno = v_empno;
		DBMS_OUTPUT.PUT_LINE('업데이트 완료');
	ELSE
		DBMS_OUTPUT.PUT_LINE('데이터없음');
	END IF;
END;

-- 프로시저 실행

-- 월급 950으로 초기화
CALL SAMPLEUSER.UP_SAL(7900);
-- 월급 10% 인상
CALL SAMPLEUSER.UP_SAL2(7900);
-- 7900 번 조회
SELECT * FROM emp WHERE empno = 7900;