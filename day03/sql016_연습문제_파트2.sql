-- 1. 주문하지 않은 고객의 이름(서브쿼리 사용)
SELECT [name]
  FROM Customer
 WHERE custid NOT IN (SELECT DISTINCT custid
                        FROM Orders);

-- 2. 주문 금액의 총액과 주문의 평균금액
SELECT SUM(saleprice) AS [주문 금액]
     , AVG(saleprice) AS [평균 금액]
  FROM Orders;

-- 여기서부터 다시해보기
-- 3. 고객의 이름과 고객별 구매액
SELECT (SELECT [name] FROM Customer c WHERE c.custid = o.custid) AS [고객이름]
     , SUM(o.saleprice) AS [고객별 구매액]
  FROM Orders AS o
 GROUP BY o.custid;
 
-- 4. 고객의 이름과 고객이 구매한 도서 목록
SELECT c.[name], b.bookname
  FROM Customer AS c, Orders AS o, Book AS b
 WHERE c.custid = o.custid
   AND o.bookid = b.bookid
 ORDER BY c.[name] ASC;

-- 5. 도서 가격(Book테이블)과 판매가격(Orders테이블)의 차이가 가장 큰 주문
SELECT TOP 1 o.orderid  -- 1
     , o.saleprice    -- 2
     , b.price  -- 3
     , (b.price - o.saleprice) AS [금액차]  -- 4
  FROM Orders AS o, Book As b
 WHERE o.bookid = b.bookid
 ORDER BY 4 DESC; -- 4번째 컬럼으로 정렬
-- ORDER BY (b.price - o.saleprice) DESC;


-- 6. 도서 판매액의 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
SELECT (SELECT [name] FROM Customer WHERE custid = base.custid) AS [고객명]
     , base.Average
  FROM (SELECT o.custid
             , AVG(o.saleprice) AS Average
          FROM Orders AS o
         GROUP BY o.custid) AS base
 WHERE base.Average >= (SELECT AVG(saleprice)
                          FROM Orders)

