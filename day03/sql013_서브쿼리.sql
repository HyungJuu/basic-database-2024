-- 가격이 가장 비싼 책
SELECT MAX(price)
  FROM Book;

-- 35,000원 책을 찾아보자
SELECT *
  FROM Book
 WHERE price = 35000;

-- 서브쿼리를 사용하면 한번에 실행 가능(SELECT절, WHERE절, FROM절)
-- 서브쿼리
SELECT *
  FROM Book
 WHERE price = (SELECT MAX(price)
                  FROM Book);

-- 도서를 구매한 적이 있는 고객이름 검색
-- 서브쿼리(WHERE절)
SELECT [name] AS '고객이름'
  FROM Customer
 WHERE custid NOT IN (SELECT DISTINCT custid -- 하위쿼리에 값이 2개이상이면 (=)을 쓸 수 없음 -> IN
                    FROM Orders);

-- 내부조인
SELECT DISTINCT c.[name] AS '고객이름'
  FROM Customer AS c, Orders AS o
 WHERE c.custid = o.custid;

-- 구매한적 없는 고객
-- 외부조인
SELECT DISTINCT c.[name] AS '고객이름'
  FROM Customer AS c LEFT OUTER JOIN Orders AS o
    ON c.custid = o.custid
 WHERE o.orderid IS NULL;

-- 서브쿼리(FROM절)
SELECT b.bookid
     , b.bookname
     , b.publisher
     , o.orderdate
     , o.orderid
  FROM Book AS b, Orders AS o
 WHERE b.bookid = o.bookid;