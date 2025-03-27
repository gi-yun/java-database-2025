-- 문제1. 회원테이블에서 이메일, 모바일, 이름, 주소 순으로 나오도록 검색하시오.
-- (결과는 아래와 동일하게 나와야 하며, 전체 행의 개수는 23개 입니다.)

SELECT M.EMAIL, M.MOBILE, M.NAMES, M.ADDR
  FROM MEMBERTBL m ;

-- 문제2. 함수를 사용하여 아래와 같은 결과가 나오도록 쿼리를 작성하시오.
-- 함수를 사용하여 아래와 같은 결과가 나오도록 쿼리를 작성하시오.
-- (전체 행의 개수는 59개입니다.)

SELECT b.NAMES AS "도서명"
	 , b.AUTHOR AS "저자"
	 , b.ISBN AS "ISBN"
	 , b.PRICE AS "정가"
  FROM BOOKSTBL b 
 ORDER BY b.ISBN ASC;


-- 문제3.다음과 같은 결과가 나오도록 SQL 문을 작성하시오. 
-- (책을 한번도 빌린적이 없는 회원을 뜻합니다. 11명이 나옵니다.)
SELECT ALL m.NAMES AS "비대여자명"
	 , m.LEVELS AS "등급"
	 , m.ADDR AS "주소"
	 , r.RENTALDATE AS "대여일"
  FROM RENTALTBL r , MEMBERTBL m 
  WHERE m.IDX =r.MEMBERIDX  (+)
     and r.RENTALDATE IS null ;
  

-- 문제4. 다음과 같은 결과가 나오도록 SQL 문을 작성하시오.
SELECT nvl(d.NAMES, '--합계--' ) AS "장르"
  	 , to_char(sum(b.PRICE), 'FM999,999,999') || '원' AS "총 합계금액"
  FROM BOOKSTBL b , DIVTBL d 
  WHERE d.DIVISION = b.DIVISION
  GROUP BY rollup(d.NAMES);



------------------------------------------
-- ******괄호를 빼먹지 말자*********
SELECT d.NAMES AS "장르"
  	 , sum(b.PRICE) AS "총 합계금액"
  FROM BOOKSTBL b , DIVTBL d 
  WHERE d.DIVISION = b.DIVISION
  GROUP BY ROLLUP(d.NAMES);

------------------------------------------

SELECT DISTINCT d.NAMES AS "장르"
	 , b.PRICE 
  	 , to_char(sum(b.PRICE), 'FM999,999,999 원') AS "총 합계금액"
--  	 , count(*)
  FROM BOOKSTBL b , DIVTBL d 
  WHERE d.DIVISION = b.DIVISION
  GROUP BY rollup (d.NAMES, b.PRICE );

SELECT *
FROM MEMBERTBL m 
