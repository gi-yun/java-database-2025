/*
 * 인덱스 - DB검색을 ㅎ율적으로 빠르게 처리하는 기술
 */

-- 기본 테이블 생성
CREATE TABLE test_noindex (
	id NUMBER NOT NULL,
	name varchar(20) NOT NULL,
	phone varchar(20) NULL,
	rdate DATE DEFAULT sysdate
);

-- 인덱스 테이블 생성
CREATE TABLE TEST_INDEX (
	id NUMBER NOT NULL PRIMARY KEY,
	name varchar(20) NOT NULL,
	phone varchar(20) NULL,
	rdate DATE DEFAULT sysdate
);

-- 유니크인덱스 테이블 생성 (유니크인덱스)
CREATE TABLE TEST_unqINDEX (
	id NUMBER NOT NULL ,
	name varchar(20) NOT NULL unique,
	phone varchar(20) NULL,
	rdate DATE DEFAULT sysdate
);

-- 인덱스 생성 쿼리 테스트용 테이블 생성
CREATE TABLE test_index2 (
	id NUMBER NOT NULL,
	name varchar(20) NOT NULL,
	phone varchar(20) NULL,
	rdate DATE DEFAULT sysdate
);

-- 인덱스 생성 쿼리
CREATE INDEX idx_id ON test_index2(id);

CREATE INDEX idx_name_phone ON test_index2(name, phone);

CREATE INDEX idx_id_name2 ON test_index2(id, name);

/*
 * 인덱스 테스트. 인덱스가 없을 때 검색쿼리 실행 소요시간,
 * 인덱스 구성후 검색쿼리 실행소요시간 비교
 */


-- 인덱스 테스트 sample_t
-- 번호가 중복된게 있는지 확인 쿼리
SELECT count(st.ID1)
  FROM SAMPLE_T st 
 GROUP BY st.ID1
 HAVING count(st.id1) >1;

SELECT count(*) FROM sample_t;

SELECT *
  FROM SAMPLE_T st WHERE id1 = 100000;

-- 검색
SELECT *
  FROM SAMPLE_T st 
  WHERE st.ID1 IN (976453, 934564, 174555, 6785, 146789, 897554);

SELECT *
  FROM SAMPLE_T
 WHERE id1 BETWEEN 100000 AND 300000;

SELECT *
  FROM SAMPLE_T st 
  WHERE st.ID1 BETWEEN '2011-01-01' AND '2012-12-31';

SELECT *
  FROM SAMPLE_T st ;

-- sample_t pk 추가
ALTER TABLE sample_t ADD PRIMARY KEY(id1);

-- data1번에서의 조회
-- 0.45초 소요 인덱스 생성 후 0.019초 소요
SELECT *
  FROM SAMPLE_T st
  WHERE st.date1 = '20171206';

CREATE INDEX idx_date1 ON sample_t(date1);

-- test3 컬럼값 조회
-- 
SELECT *
  FROM SAMPLE_T st
  WHERE st.TEST3  = 'A678';

-- autocommit을 끄고 나면 DDL(), DML(select이외) 작업후 필히 commit; 수행 후 파일 저장
COMMIT;