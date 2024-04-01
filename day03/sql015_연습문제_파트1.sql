-- 1. 박지성이 구매한 도서의 출판사 수(서브쿼리 < 내부조인)
-- 서브쿼리
SELECT COUNT(DISTINCT publisher) AS [박지성 구매 출판사 수]
  FROM Book
 WHERE bookid IN (SELECT bookid
                    FROM Orders
                   WHERE custid = (SELECT custid
                                     FROM Customer
                                    WHERE [name] = '박지성'));

-- 내부조인★
SELECT COUNT(DISTINCT b.publisher) AS [구매책 출판사수]
  FROM Book AS b, Orders AS o, Customer AS c
 WHERE b.bookid = o.bookid
   AND o.custid = c.custid
   AND c.[name] = '박지성';

-- 2. 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
SELECT b.bookname, b.price, o.saleprice
     , (b.price - o.saleprice) AS [정가-판매가]
  FROM Book AS b, Orders AS o, Customer AS c
 WHERE b.bookid = o.bookid
   AND o.custid = c.custid
   AND c.[name] = '박지성';

-- 3. 박지성이 구매하지 않은 도서의 이름
SELECT b.bookname AS [박지성이 구매하지않은 도서]
  FROM Book AS b
 WHERE b.bookid NOT IN (SELECT o.bookid
                          FROM Orders AS o, Customer AS c
                         WHERE o.custid = c.custid
                           AND c.[name] = '박지성');