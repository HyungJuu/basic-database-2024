-- 차집합
-- 전체 고객 중 도서를 구매하지 않은 고객의 이름을 조회
-- [전체고객] - [도서구매고객] = [도서를 구매하지않은 고객]
SELECT [name]
  FROM Customer
EXCEPT 
SELECT [name]
  FROM Customer
 WHERE custid IN (SELECT DISTINCT custid FROM Orders);

-- 합집합
SELECT [name]
  FROM Customer
 UNION
SELECT [name]
  FROM Customer
 WHERE custid IN (SELECT DISTINCT custid FROM Orders);

-- 합집합(중복 허용)
SELECT [name]
  FROM Customer
 UNION ALL
SELECT [name]
  FROM Customer
 WHERE custid IN (SELECT DISTINCT custid FROM Orders);

-- 교집합
   SELECT [name]
     FROM Customer
INTERSECT
   SELECT [name]
     FROM Customer
    WHERE custid IN (SELECT DISTINCT custid FROM Orders);

-- UNION : 각 컬럼의 타입형이 각각 일치해야 함
SELECT bookid   -- int
     , bookname -- varchar(40)
  FROM Book
 UNION
SELECT custid   -- int
     , [name]   -- varchar(40)
  FROM Customer;

--EXISTS : 하나의 테이블에 존재하는 값만 보고싶다
SELECT [name]
     , address
  FROM Customer AS c
 WHERE EXISTS(SELECT *
                FROM Orders AS o
               WHERE o.custid IS NOT NULL);
