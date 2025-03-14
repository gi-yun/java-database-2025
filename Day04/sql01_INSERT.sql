/*
 * DML 중 SELECT 이외
 * INSERT, UPDATE, DELETE
 */

-- INSERT
SELECT *
  FROM NEW_TABLE nt;

-- INSERT QUERY 기본
INSERT INTO NEW_TABLE ("NO" ,NAME,JUMIN ,BIRTH ,SALARY )
VALUES (1, '홍길동', '810205-1825697', '1981-02-05', 5000);

-- 테이블 컬럼리스트와 동일한 순서, 동일한 값을 넣을 때
-- 단, 컬럼리스트와 순서도 다르고, 값리스트 갯수도 다르면 컬럼리스트 생략 불가!
INSERT INTO NEW_TABLE ("NO" ,NAME,JUMIN ,BIRTH ,SALARY )
VALUES (2, '홍길순', '820205-2825697', '1981-02-05', 5000);

-- 컬럼 리스트 순서가 다를때,
INSERT INTO NEW_TABLE (JUMIN ,NAME,"NO" )
VALUES ('760921-1825899' , '성유고', 3);


INSERT INTO NEW_TABLE ("NO" ,NAME,JUMIN ,BIRTH ,SALARY )
VALUES (4, '홍동서', '920205-1825397', NULL, NULL);

-- 한 테이블에 있는 데이터를 모두 옮기면서 새로운 테이블 생성
-- PK는 복사가 안됨.
CREATE TABLE PROFESSOR_NEW
    AS
SELECT *
  FROM PROFESSOR p ;

SELECT *
  FROM PROFESSOR_NEW pn 
  
-- 만들어진 테이블에 데이터 한꺼번에 옮기기
  

-- 새로 만들어진 테이블 PROFESSOR_NEW 데이터를 삽입 테스트
INSERT INTO PROFESSOR_NEW (PROFNO ,NAME, ID, "POSITION", PAY, HIREDATE)
VALUES (4008, 'Tom Cruise', 'Cruise', 'instructor', 310, '2025-03-14');

-- 새로 만들어진 테이블 PROFESSOR_NEW는 PK가 없기 때문에 같은 값이 들어감
INSERT INTO PROFESSOR_NEW (PROFNO ,NAME, ID, "POSITION", PAY, HIREDATE)
VALUES (4008, 'Tom Holland', 'Holland', 'instructor', 310, '2025-03-14');

-- 대량의 데이터를 삽입
-- # 알아두면 좋음 #
INSERT All
	INTO NEW_TABLE VALUES (5, '홍길일', '810205-1825697', '1981-02-05', 5000)
	INTO NEW_TABLE VALUES (6, '홍길이', '810205-1825697', '1981-02-05', 5000)
	INTO NEW_TABLE VALUES (7, '홍길삼', '810205-1825697', '1981-02-05', 5000)
	INTO NEW_TABLE VALUES (8, '홍길사', '810205-1825697', '1981-02-05', 5000)
	INTO NEW_TABLE VALUES (9, '홍길오', '810205-1825697', '1981-02-05', 5000)
SELECT * FROM dual;

SELECT  * FROM NEW_TABLE nt;





