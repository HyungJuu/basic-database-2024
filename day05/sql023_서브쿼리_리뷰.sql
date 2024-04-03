-- 서브쿼리 리뷰
-- WHERE절 서브쿼리
-- ALL, ANY(SOME)
-- ANY(SOME)를 쓰는 조건은 아래의 데이터에서 사용하기엔 어려움

-- 3번 고객이 주문한 도서의 최고금액보다 더 비싼 도서를 구입한 다른 주문의 주문번호, 금액표시
-- 3번고객 : 장미란
SELECT *
  FROM Customer;

-- 장미란이 주문한 내역 중 최고금액 : 13000원
SELECT MAX(saleprice) AS [장미란 최고주문내역]
  FROM Orders
 WHERE custid = 3;

-- 13000원보다 비싼 도서를 구입한 주문의 주문번호, 금액 표시
SELECT o1.orderid
     , o1.saleprice
  FROM Orders AS o1
 WHERE o1.saleprice > ALL (SELECT MAX(saleprice)
                             FROM Orders
                            WHERE custid = 3);

-- EXISTS, NOT EXISTS : 열을 명시하지 않음
-- 대한민국 거주 고객에게 판매한 도서의 총판매액
-- 전체 판매액 : 118000 , 대한민국 고객 판매액 : 46000
SELECT SUM(saleprice) AS '대한민국 고객 판매액'
  FROM Orders AS o
 WHERE EXISTS (SELECT *
                 FROM Customer AS c
                WHERE c.address LIKE '%대한민국%'
                  AND c.custid = o.custid);

-- 조인으로도 금액을 찾을 수 있음
SELECT SUM(saleprice) AS '조인도 가능'
  FROM Orders AS o, Customer AS c
 WHERE o.custid = c.custid
   AND c.address LIKE '%대한민국%'

-- SELECT절 서브쿼리,JOIN으로 변경가능(이미 쿼리가 너무 복잡해서 더이상 테이블을 추가하기 힘들 때 많이 사용)
-- 51. 고객별 판매액. GROUP BY가 들어가면 SELECT절에서 반드시 집계함수가 들어가야 함!!
SELECT SUM(o.saleprice) AS '고객별 판매액' -- GROUP BY에서 사용한 속성만 사용 가능
     , o.custid
     , (SELECT [name] FROM Customer WHERE custid = o.custid) AS '고객명'
  FROM Orders AS o
 GROUP BY o.custid; -- GROUP BY와 집계함수 (SUM, AVG, MAX, MIN) 함께사용

-- UPDATE 에서도 사용가능
-- 사전준비
ALTER TABLE Orders ADD bookname VARCHAR(40);

-- 업데이트 : 필요한 필드값을 한테이블에서 다른테이블로 한꺼번에 복사할 때 유용
UPDATE Orders
   SET bookname = (SELECT bookname
                     FROM Book
                    WHERE Book.bookid = Orders.bookid);

-- FROM절 서브쿼리(인라인 뷰[가상테이블])
-- 고객별 판매액으로 고객명과 판매금액 표시(서브쿼리 --> 조인)
-- 52. 고객별 판매액 집계 쿼리가 FROM절에 들어가면 모든 속성(컬럼)에 이름이 지정되어야만 함
SELECT b.total
     , c.name
  FROM (SELECT SUM(o.saleprice) AS 'total'
             , o.custid
          FROM Orders AS o
         GROUP BY o.custid) AS b, Customer AS c
 WHERE b.custid = c.custid;

-- 고객번호가 2 이하인 고객의 판매액을 보이시오. 고객이름, 판매액 표시
-- ★★ GROUP BY에 들어갈 컬럼(속성)은 최소화. 중복 등의 문제가 있으면 결과가 다 틀어짐 ★★
SELECT SUM(o.saleprice) AS '고객별 판매액'
     , (SELECT [name] FROM Customer WHERE custid = c.custid) AS '고객명'
  FROM (SELECT custid
             , [name] 
          FROM Customer
         WHERE custid <= 2) AS c, Orders AS o
 WHERE c.custid = o.custid
 GROUP BY c.custid