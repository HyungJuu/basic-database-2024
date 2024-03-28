-- 모든 도서의 이름과 가격을 검색하시오
-- ctrl + shift + U : 대문자 변환 / ctrl + shift + L : 소문자 변환
SELECT bookname, price
	FROM Book;

-- 모든 도서의 가격과 이름을 검색하시오 -> 순서변경 : 가상의 테이블로 구현 가능함
SELECT price, bookname
	FROM Book;

-- 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오
SELECT *
	FROM Book;

-- ★★실무에서는 속성, 컬럼명을 다 적는것이 일반적★★
SELECT bookid, bookname, publisher,price
	FROM Book;

-- 도서에서 출판사를 검색하시오(중복 제거)
SELECT DISTINCT publisher
	FROM Book;

-- 조건검색(조건 연산자 사용)
-- 가격이 20,000원 미만인 도서를 검색하시오
SELECT *
	FROM Book
 WHERE price < 20000

-- 가격이 10,000원 이상, 20,000원 이하인 도서를 검색하시오
SELECT *
	FROM Book
 WHERE price >= 10000 AND price <= 20000;

SELECT *
	FROM Book
 WHERE price BETWEEN 10000 AND 20000;
-- BETWEEN/AND : 이상/이하 조건은 가능, but 초과/미만은 불가능

-- 출판사가 굿스포츠와 대한미디어의 도서를 검색하시오
SELECT *
	FROM Book
 WHERE publisher IN ('굿스포츠', '대한미디어');

-- 출판사가 굿스포츠와 대한미디어가 아닌 도서를 검색하시오
SELECT *
	FROM Book
 WHERE publisher NOT IN ('굿스포츠', '대한미디어');

-- 축구의 역사를 출판한 출판사를 검색하시오
SELECT bookname, publisher
  FROM Book
 WHERE bookname = '축구의 역사';

-- 도서 이름에 축구가 포함된 도서의 출판사를 검색하시오
SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '축구%';	-- 축구% : 축구라는 글자로 시작하는 것

SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '축구%';	-- %축구 : 축구라는 글자로 끝나는 것

-- ★★실무에서는 이렇게 사용★★
-- 축구라는 글자가 들어가는 모든 도서의 출판사를 검색하시오
SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '%축구%';

-- 두글자이면서 구로 끝나는 단어로 시작되는 도서의 출판사를 검색하시오
SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '_구%';	-- _(무슨 글자든 언더바 개수만큼 글자가 들어간) 구라는 글자로 시작하는 것 -> 변화구 : 검색안됨