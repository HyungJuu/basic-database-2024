-- NULL에 대한 고찰
-- MyBook 테이블에서 시작

-- NULL값은 얼마를 더하든 NULL
SELECT bookid
     , price + 100
  FROM MyBook;

-- 합계, 전체의 COUNT는 문제가 되지않음
-- 평균(AVG)과 price COUNT에서는 NULL값을 집계하지 않음 -> 문제될 가능성 O
SELECT SUM(price), AVG(price), COUNT(*), COUNT(price)
  FROM MyBook;

SELECT (10000 + 20000 + 0) / 3;

-- bookid가 없는 데이터로 통계를 낼 때 -> NULL이 나와야 함
SELECT SUM(price), AVG(price), COUNT(*), COUNT(price)
  FROM MyBook
 WHERE bookid >= 4;

-- NULL 비교(★)
-- NULL은 일반 비교연산자로 비교X
-- IS / IS NOT
SELECT *
  FROM MyBook
 WHERE price IS NULL;   -- IS NOT NULL;

-- ISNULL() 함수
-- 사전 작업 (Customer 테이블)
SELECT *
  FROM Customer
 WHERE phone IS NULL;

UPDATE Customer
   SET phone = NULL
 WHERE custid = 2;

-- NULL인 폰번호를 '연락처 없음'으로 대체(치환), 값은 그대로 NULL
SELECT custid
     , [name]
     , [address]
     , ISNULL(phone, '연락처 없음') AS [phone]
  FROM Customer;

-- TOP n : 내장된 키워드(함수x)
-- 정렬된 기준으로 상위 n개
SELECT TOP 3 orderid, custid, saleprice
  FROM Orders
 ORDER BY saleprice DESC;