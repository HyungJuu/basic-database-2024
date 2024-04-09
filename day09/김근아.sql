-- 1. 회원 테이블에서 이메일, 모바일, 이름, 주소 순으로 나오도록 검색하시오.(31행)
--		결과가 문제의 이미지와 동일해야 함
SELECT Email
		 , Mobile
		 , Names
		 , Addr
	FROM membertbl
 ORDER BY addr DESC, Email ASC;

-- 2. 함수를 사용하여 아래와 같은 결과가 나오도록 쿼리를 작성하시오.(59행)
SELECT Names AS [도서명]
		 , Author AS [저자]
		 , ISBN
		 , Price AS [정가]
	FROM bookstbl
 ORDER BY Price DESC;

-- 3. 다음과 같은 결과가 나오도록 SQL문을 작성하시오.(책을 한번도 빌린적이 없는 회원)
-- TODO
SELECT m.Names AS [회원명]
		 , m.Levels AS [회원등급]
		 , m.Addr AS [회원주소]
		 , r.returnDate AS [대여일]
	FROM rentaltbl AS r, membertbl AS m
-- WHERE r.memberIdx = m.memberIdx
-- WHERE r.returnDate IS NULL
 ORDER BY m.Names ASC;

SELECT *
	FROM rentaltbl

-- 4. 다음과 같은 결과가 나오도록 SQL문을 작성하시오.
SELECT d.Names AS [책 장르]
		 , FORMAT(SUM(b.Price), '#,#') + ' 원' AS [총합계금액]
	FROM divtbl AS d, bookstbl AS b
 WHERE d.Division = b.Division
 GROUP BY d.Names;


-- 5. 다음과 같은 결과가 나오도록 SQL문을 작성하시오.
SELECT d.Names AS [책 장르]
		 , COUNT(d.Division) AS [권수]
		 , FORMAT(SUM(b.Price), '#,#') + ' 원' AS [총합계금액]
	FROM divtbl AS d, bookstbl AS b
 WHERE d.Division = b.Division
 GROUP BY d.Names
