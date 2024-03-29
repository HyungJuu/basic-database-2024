-- 조회 복합조건
-- 축구에 관한 도서이며 가격이 20,000원 이상인 도서 조회
SELECT bookid
		 , bookname
		 , publisher
		 , price
	FROM Book
 WHERE bookname Like '%축구%'
	 AND price >= 20000;

-- 출판사가 굿스포츠 또는 대한미디어인 도서 검색
SELECT *
	FROM Book
 WHERE publisher = '굿스포츠'
		OR publisher = '대한미디어';

-- 정렬
-- 기본적으로 ASC(ending : 오름차순) 생략가능
-- DESC(ending : 내림차순) 생략불가
SELECT *
	FROM Book
 ORDER BY bookname;

-- 도서를 가격순으로 검색하고, 가격이 같으면 이름역순으로 검색
SELECT *
	FROM Book
 ORDER BY price ASC, bookname DESC;

SELECT *
	FROM Book
 ORDER BY price ASC, bookname ASC;

-- 도서 가격은 내림차순, 출판사는 오름차순으로 검색
SELECT *
	FROM Book
 ORDER BY price DESC, publisher ASC;

-- 최근에 등록한 도서부터 오래된 순으로 검색
SELECT *
	FROM Book
 ORDER BY bookid DESC;