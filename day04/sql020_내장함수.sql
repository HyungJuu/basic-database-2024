-- 내장함수
-- 수학함수 들
-- 함수의 결과값은 (열 이름 없음) -> 이름 지정 필요
SELECT ABS(-5), ABS(5);

-- 올림, 내림, 반올림, n승
SELECT CEILING(4.01) AS [올림]
     , FLOOR(4.4) AS [내림]
     , ROUND(4.4, 0) AS [반올림]
     , POWER(2, 10) AS [n승];

-- 고객별 평균 주문금액
SELECT custid
     , SUM(saleprice) AS [총 주문금액]
     , AVG(saleprice) AS [고객별 평균주문금액]
     , COUNT(*) AS [고객별 주문수]
     , ROUND(SUM(saleprice) / COUNT(*), 0) AS [평균금액]    -- 굳이 
  FROM  Orders
 GROUP BY custid

-- 문자열함수 들
-- 도서제목에 '야구'를 '농구'로 바꿔서 출력
-- 바꿔서 출력하면 열 이름 없음 으로 나옴 -> 이름지정 필요
-- FORMAT(VAL, '포맷값')
SELECT bookid
     , REPLACE(bookname, '야구', '농구') AS bookname
     , publisher
     , FORMAT(price, '#,#') AS price
  FROM Book

-- 영문자 단어, 코드 변환시 유용하게 많이 사용
SELECT bookname AS '제목'
     , LEN(bookname) AS [제목별 길이]
  FROM Book
 WHERE publisher = '굿스포츠';

-- 공백제거
-- LTRIM, RTRIM, TRIM
SELECT '|' + LTRIM('     HELLO     ') + '|'
     , '|' + RTRIM('     HELLO     ') + '|'
     , '|' + TRIM('     HELLO     ')  + '|'

-- LEFT(), RIGHT(), SUBSTRING()
SELECT LEFT('HELLO WORLD!', 5)
     , RIGHT('HELLO WORLD!', 5)
     , SUBSTRING('HELLO WORLD!', 7, 5);

-- CHARINDEX() 문자 찾기
SELECT CHARINDEX('sql', 'Microsoft SQL Server 2022');

-- SUBSTRING() 연계
SELECT SUBSTRING('Microsoft SQL Server 2022',
       CHARINDEX('sql', 'Microsoft SQL Server 2022'),
       LEN('sql'));

-- SUBSTRING : DB는 인덱스가 1부터 시작★★
SELECT SUBSTRING([name], 1, 1) AS [성씨]
     , COUNT(*) AS [성씨별 인원수]
  FROM Customer
 GROUP BY SUBSTRING([name], 1, 1);

-- 날짜 및 시간 함수
SELECT GETDATE();

SELECT DAY(GETDATE()) AS [일]
     , MONTH(GETDATE()) AS [월]
     , YEAR(GETDATE()) AS [년];

SELECT FORMAT(GETDATE(), 'yyyy-MM-dd');      -- 날짜 포맷을 원하는 형태로 변경가능 (년-월-일)
SELECT FORMAT(GETDATE(), 'HH : mm : ss');    -- 시간포맷을 원하는형태로 변경가능 (시:분:초)

-- 주문 테이블에서 주문 10일 후에 각 주문을 확정짓는다. 확정일자 출력
-- dd(날짜), mm(달), yy(년), qq(분기), wk(주)
SELECT orderid
     , saleprice
     , orderdate AS [주문일자]
     , DATEADD(dd, 10, orderdate) AS [확정일자]
     , DATEADD(mm, 1, orderdate) AS [통계일자]
  FROM Orders