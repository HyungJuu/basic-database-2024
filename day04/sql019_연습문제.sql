-- 3-1. 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객 이름
SELECT DISTINCT custid
  FROM Orders
 WHERE bookid IN (SELECT bookid
                    FROM Book
                   WHERE Publisher IN (SELECT b.publisher
                                         FROM Customer AS c, Orders AS o, Book As b
                                        WHERE c.custid = o.custid
                                          AND o.bookid = b.bookid
                                          AND c.[name] = '박지성'));

-- 3-2.

-- 3-3. 전체 고객의 30% 이상이 구매한 도서
SELECT b.custid
     , CONVERT(float, b.custCount) / b.totalCount AS [구매율]
  FROM (SELECT custid
             , COUNT(custid) AS [custCount]
             , (SELECT COUNT(custid) FROM Orders) AS [totalCount]
          FROM Orders
         GROUP BY custid) AS b
 WHERE CONVERT(float, b.custCount) / b.totalCount >= 0.3;

-- 4-1. 새로운 도서('스포츠 세계', '대한미디어', 10,000)가 마당서점에 입고되었다.
--      삽입이 안될 때 필요한 데이터가 더 있는지 찾아보시오.
-- 새로운 도서를 삽입하기 위해서는 bookid가 필수적으로 필요하다
SELECT *
  FROM Book

INSERT INTO Book(bookid, bookname, publisher, price)
     VALUES (14, '스포츠 세계', '대한미디어', 10000);

-- 4-2. '삼성당'에서 출판한 도서를 삭제하시오.
DELETE FROM Book
 WHERE publisher = '삼성당';

-- 4-3. '이상미디어'에서 출판한 도서를 삭제하시오. 삭제가 안된다면 원인을 생각해 보시오.
/* 원인 : Orders 테이블에서 bookid를 외래키로 사용하고 있음.
        즉 '이상미디어'에서 출판한 도서를 지우기 위해서는
        자식테이블(Orders)에서 먼저 삭제 후 부모테이블(Book)에서 삭제해야 함
*/
DELETE FROM Book 
 WHERE  publisher = '이상미디어'

-- 4-4. 출판사 '대한미디어'를 '대한출판사'로 이름을 바꾸시오
UPDATE Book
   SET publisher = '대한출판사'
 WHERE publisher = '대한미디어';

UPDATE Book
   SET publisher = '대한출판사'
 WHERE bookid In (SELECT bookid
                    FROM Book
                   WHERE publisher = '대한미디어');