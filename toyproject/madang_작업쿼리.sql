-- madang 로그인

-- 조회
SELECT *
  FROM STUDENTS s ;

-- 더미데이터 삽입
INSERT INTO STUDENTS(STD_ID, STD_NAME, STD_MOBILE, STD_REGYEAR) 
VALUES (SEQ_STUDENT.nextval, '홍길동', '010-9999-8888', 1997);
INSERT INTO STUDENTS(STD_ID, STD_NAME, STD_MOBILE, STD_REGYEAR) 
VALUES (SEQ_STUDENT.nextval, '홍길순', '010-9999-8877', 2000);

-- 조회
SELECT s.std_id, s.std_name
	 , s.STD_MOBILE , s.STD_REGYEAR
 FROM STUDENTS s
 
-- 추가
 INSERT INTO MADANG.STUDENTS (std_id, std_name, std_mobile, std_regyear)
VALUES(SEQ_STUDENT.NEXTVAL, :v_std_name, :v_std_mobile, :v_std_regyear);


-- 수정
UPDATE MADANG.STUDENTS
   SET STD_NAME= :v_std_name
     , STD_MOBILE=:v_std_mobile
     , STD_REGYEAR=:v_std_regyear
WHERE STD_ID= :v_std_id


-- 삭제
DELETE FROM MADANG.STUDENTS
WHERE STD_ID= :v_std_id