-- DDL : 데이터 정의 언어
-- 객체 생성, 수정, 삭제

-- 1. NewBook이라는 테이블을 생성하라
/*
    bookid(도서번호 : 기본키) - int
    bookname(도서이름) - varchar(20)
    publisher(출판사) - varchar(20)
    price(가격) - int

    -- 타입종류
    INT[정수], BIGINT[INT보다 큰 정수], BINARY(50)[이진데이터], BIT[0|1], 
    CHAR(n)[고정문자열], VARCHAR(n)[가변문자열], NCHAR(n) | NVARCHAR(n) N- [유니코드],
    DATE[날짜], DATETIME[날짜&시간], DECIMAL(18, 0)[소수점 표현 실수, FLOAT보다 정확도 높음], FLOAT[실수]
    IMAGE[이미지 바이너리], SMALLINT[255까지의 정수], TEXT[2GB까지의 텍스트], NTEXT[유니코드 2G]

    ★★ ex) username : CHAR(10) / VARCHAR(10) -> 'hugo'
                char(10) = 'hugo      ' => 문자열을 넣고 빈 공간은 스페이스(' ') 입력
                VARCHAR(10) = 'hugo' => 문자열을 넣고 빈 공간은 전부 없앰
    
    -- 가장 많이 쓰는 타입
    INT, CHAR, VARCHAR, DATETIME, DECIMAL, FLOAT, TEXT 외에는 잘 안씀
*/

DROP TABLE NewBook; -- 테이블 삭제(새로 만들기 위해서는 먼저 삭제해야함)

CREATE TABLE NewBook (
    bookid INT,
    bookname varchar(20),
    publisher varchar(20),
    price INT,
    PRIMARY KEY (bookid)    -- 기본키 : bookid 지정
);

-- 기본키 통합
CREATE TABLE NewBook (
    bookid INT PRIMARY KEY,
    bookname varchar(20),
    publisher varchar(20),
    price INT
);

-- 기본키가 두개 이상이면
CREATE TABLE NewBook (
    bookid INT,
    bookname varchar(20),
    publisher varchar(20),
    price INT,
    PRIMARY KEY (bookid, bookname)  -- 기본키를 두개이상 지정
);

-- 각 컬럼에 제약조건을 걸면
CREATE TABLE NewBook (
    bookname VARCHAR(20) NOT NULL,
    publisher VARCHAR(20) UNIQUE,   -- 유니크 제약조건
    price INT DEFAULT 10000 CHECK(price > 1000) -- 기본키 제약조건, 체크 제약조건
    PRIMARY KEY (bookname, publisher)   -- 개체 무결성 제약조건
);

-- 새 고객테이블 생성(기본키)
CREATE TABLE NewCustomer (
    custid INT PRIMARY KEY,
    custname VARCHAR(40),
    custaddress VARCHAR(255),
    phone VARCHAR(30)
);

-- 새 주문테이블 생성(기본키 + 외래키)
CREATE TABLE NewOrder (
    orderid     INT,
    custid      INT NOT NULL,
    bookid      INT NOT NULL,
    saleprice   INT,
    orderdate   DATE,
    PRIMARY KEY (orderid),
    FOREIGN KEY (custid) REFERENCES NewCustomer(custid) ON DELETE CASCADE
);

-- 2. 테이블 변경 / 수정 ALTER
CREATE TABLE MyBook (
    bookid      INT,
    bookname    VARCHAR(20),
    publisher   VARCHAR(20),
    price       INT
);

-- MyBook에 isbn(일련번호)이라는 컬럼 추가
ALTER TABLE MyBook ADD isbn VARCHAR(13);

-- isbn을 INT형으로 변경
ALTER TABLE MyBook ALTER COLUMN isbn INT;

-- isbn 컬럼 삭제
ALTER TABLE MyBook DROP COLUMN isbn;

-- bookname의 제약조건을 NOT NULL로 적용
ALTER TABLE MyBook ALTER COLUMN bookname INT NOT NULL;

-- bookid 기본키 설정
ALTER TABLE MyBook ALTER COLUMN bookid INT NOT NULL;
ALTER TABLE MyBook ADD PRIMARY KEY(bookid);

-- 3. 테이블 삭제
DROP TABLE MyBook;

-- 자식테이블을 삭제하기 전에는 삭제 불가
DROP TABLE NewOrder;    -- 자식테이블 : NewCustomer의 속성을 외래키로 사용중 
DROP TABLE NewCustomer; 

DROP TABLE NewBook;