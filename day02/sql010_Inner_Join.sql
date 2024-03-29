-- 두개 이상의 테이블 SQL 쿼리 작성
-- 조건없이 Customer, Orders 테이블을 동시에 조회
SELECT *
	FROM Customer, Orders;

-- custid가 일치하는 조건에서 Customer, Orders 테이블을 동시에 조회
-- RDB(Relation DataBase)에서 가장 중요한 쿼리문 1 = Join(조인)
SELECT *
	FROM Customer, Orders
 WHERE Customer.custid = Orders.custid
 ORDER BY Customer.custid ASC;

 -- Customer.custid => 테이블.테이블속성

-- 주문한 책의 고객이름과 책 판매액 조회
SELECT Customer.[name]
		 , Orders.saleprice
	FROM Customer, Orders
 WHERE Customer.custid = Orders.custid;

-- 고객별로 주문한 모든 도서의 총판매액을 구하고 정렬
SELECT Customer.[name]	-- [] : 키워드의 이름이 같아서
		 , SUM(Orders.saleprice) AS [판매액]
	FROM Customer, Orders
 WHERE Customer.custid = Orders.custid
 GROUP BY Customer.[name]	-- 부모테이블을 기준으로 함
 ORDER BY Customer.[name];

-- 각 테이블의 별명으로 줄여서 쓰는것이 일반적
-- 내부조인(Inner Join) : 양쪽 쿼리에 지정한 속성의 데이터가 있어야 함(일반적으로 JOIN이 내부조인으로 인식됨)
SELECT c.custid
--	 , o.custid
		 , c.[name]
		 , c.[address]
		 , c.phone
		 , o.orderid
		 , o.custid
		 , o.bookid
		 , o.saleprice
		 , o.orderdate
	FROM Customer AS c, Orders AS o
 WHERE c.custid = o.custid
 ORDER BY c.custid ASC;

-- 세개 테이블 조인 : 표준SQL 아님
SELECT *	-- 컬럼별로 나눠적기 생략
	FROM Customer As c, Orders AS o, Book AS b
 WHERE c.custid = o.custid
	 AND o.bookid = b.bookid

-- 실제 표준SQL Inner Join => 복잡함
SELECT *
	FROM Customer AS c
 INNER JOIN Orders AS o
		ON c.custid = o.custid
 INNER JOIN Book AS b
		ON o.bookid = b.bookid;

-- 가격이 20,000원 이상인 도서를 주문한 고객의 이름과 도서명 조회
SELECT c.[name]
		 , b.bookname
		 , o.saleprice
		 , b.price
	FROM Customer AS c, Orders AS o, Book AS b
 WHERE c.custid = o.custid
	 AND o.bookid = b.bookid	-- Join을 위한 조건
	 AND b.price >= 20000	-- 그외 필터링을 위한 조건