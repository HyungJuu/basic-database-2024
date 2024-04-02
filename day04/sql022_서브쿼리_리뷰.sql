-- WHERE 절
-- Order 테이블에서 평균 주문금액 이하의 주문에 대한 주문번호, 금액을 표시
-- 서브쿼리(소괄호 내의 쿼리부터) 먼저 작성
-- 평균 주문금액 : 11800
SELECT orderid
     , saleprice
  FROM Orders
 WHERE saleprice <= (SELECT AVG(saleprice)
                    FROM Orders);

-- 각 고객의 평균 주문금액보다 큰 금액의 주문내역 주문번호, 고객번호, 금액 표시
-- 1번 13000
-- 2번 7500
-- 3번 10333
-- 4번 16500

SELECT o2.custid
     , AVG(saleprice) AS avg_saleprice
  FROM Orders AS o2
 GROUP BY o2.custid

-- 메인쿼리의 컬럼을 서브쿼리의 컬럼과 비교할 때 사용(난이도 높음)
SELECT o1.orderid
     , o1.custid
     , o1.saleprice
  FROM Orders AS o1
 WHERE o1.saleprice > (SELECT AVG(saleprice) AS avg_saleprice
                         FROM Orders AS o2
                        WHERE o1.custid = o2.custid);

-- IN, NOT IN
-- 대한민국에 거주하는 고객에게 판매한 도서의 총판매액
-- 118,000 - 46,000 = 72,000(박지성, 추신수 구매 도서금액)
SELECT FORMAT(SUM(saleprice), '#,#') AS [대한민국 고객 총판매액]
  FROM Orders
 WHERE custid IN (SELECT custid
                    FROM Customer
                   WHERE [address] LIKE '%대한민국%');