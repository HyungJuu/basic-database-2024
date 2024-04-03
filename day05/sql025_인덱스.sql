-- 인덱스(책의 목차와 기능이 동일)
-- Book의 bookname 열에 넌클러스터링 인덱스 ix_Book_bookname 생성
CREATE INDEX IX_Book_bookname ON Book(bookname);

-- Customer의 name 옆에 클러스터링 인덱스 CIX_Customer_name 생성
-- 일반적으로 기본키에 클러스터드, 나머지 컬럼 넌클러스터드 인덱스 설정
CREATE CLUSTERED INDEX CIX_Customer_name ON Customer(name);

-- Book의 publisher, price를 동시에 인덱스 IX_Book_pubprice 생성
CREATE INDEX IX_Book_pubprice ON Book(publisher, price);

-- 인덱스 재구성
-- PD인 기본키는 값이 추가되면 자동으로 인덱스 재구성
-- 넌클러스터드 인덱스는 재구성이 필요할 수 있음(DBA 정기적으로 작업)
-- IX_Book_pubprice를 재구성하라
ALTER INDEX IX_Book_pubprice ON Book REBUILD;
ALTER INDEX IX_Book_pubprice ON Book REORGANIZE;    -- 인덱스 재정의

-- 인덱스 삭제
DROP INDEX IX_BOOK ON Book;
DROP INDEX CIX_Customer_name ON Customer;