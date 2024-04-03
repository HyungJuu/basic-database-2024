# basic-database-2024
부경대 2024 IoT 개발자과정 SQL Server 학습 리포지토리

## 1일차
- [MS SQL Server 설치(최신버전)](https://www.microsoft.com/ko-kr/sql-server/sql-server-downloads)
    - DBMS 엔진 &rarr; 개발자 버전
        - ISO 다운로드 후 설치 추천
        - SQL Server에 대한 Azure 확장 비활성화 후 진행
        ![기능선택](https://raw.githubusercontent.com/HyungJuu/basic-database-2024/main/images/db001.png)
        - 데이터베이스 엔진 구성부터 중요★★★
            - Windows 인증모드 &rarr; 외부에서 접근 불가
            - 혼합모드(sa)에 대한 암호를 지정  
                &rarr; mssql_p@ss (8자 이상 / 대소문자 구분 / 특수문자1자 이상 포함)
            - 데이터루트 디렉토리 변경

    - 개발툴 설치
        - [SSMS(SQL Server Management Studio)](https://learn.microsoft.com/ko-kr/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16) &rarr; 한국어버전설치 
            - DB 접근, 여러 개발작업 툴

    - 데이터베이스 개념
        - 데이터 보관, 관리 ,서비스 시스템
        - Data, Information, Knowlege 개념
        - DBMS > Database > Data(Model)

    - DB언어
        - SQL(Structered Query Language) : 구조화된 질의 언어
            - DDL (Data Definition Language) : 데이터베이스, 테이블, 인덱스 생성 &rarr; CREATE, ALTER, DROP
            - DML (Data Manipulation Language) : 검색(SELECT), 삽입(INSERT), 수정(UPDATE), 삭제(DELETE) 등 기능★
            - DCL (Data Control Language) : 권한 부여/제거 기능 &rarr; GRANT, REVOKE
            - TCL (Transaction Control Language) : 트랜스액션(트랜잭션) 제어 기능 &rarr; COMMIT, ROLLBACK

    - 기본사용법
        - -- : 주석 /* */(C/C++ 주석도 사용가능)
        - F5 : 실행
            - 실행하고자 하는 부분반 드래그하여 실행가능
    
    - SQL 기본학습
        - SSMS 실행
        - 특이사항 : SSMS 쿼리창에서 소스코드 작성시, 빨간색 오류 밑줄이 가끔 표현(전부 오류는 아님)

        ![SSMS로그인](https://raw.githubusercontent.com/HyungJuu/basic-database-2024/main/images/db002.png)


    - DML 학습
        - SQL 명령어 키워드 : SELECT, INSERT, UPDATE, DELETE
        - IT개발 표현언어 : Request, Create, Update, Delete(CRUD라고 부름)
            - CRUD로 개발하라 &rarr; 검색, 삽입, 수정, 삭제할 수 있는 기능을 개발하라는 것
        - SELECT
            ```sql
            -- 들여쓰기를 키워드 끝에 맞춰서 함
            -- 순서 확인
             SELECT [All | DISTINCT] 속성이름(들)
               FROM 테이블이름(들)
             [WHERE 검색조건(들)]
             [GROUP BY 속성이름(들)]
            [HAVING 검색조건(들)]
             [ORDER BY 속성이름(들) [ASC | DESC]]
            ```
        - SELECT문 학습
            - 기본, 조건검색 학습 중

## 2일차
- Database 학습
    - DB 개발시 사용할 수 있는 툴
        - SSMS(기본)
        - Visual Studio - 아무 설치 없이 개발 가능
        - Visual Studio Code - SQL Server(mssql) 플러그인 설치 필요
            - 실행 : ctrl + shift + E
    - ServerName(HostName) - [본인 컴퓨터의 이름 | 네트워크 주소 | 127.0.0.1(LoopBack IP) | localhost(LoopBack URL)] 중 선택 사용

    - 관계 데이터 모델
        - 릴레이션 : 행과 열로 구성된 테이블
            - 행(튜플), 열(속성), 스키마(속성이름), 인스턴스

        - 매핑되는 이름 테이블(실제 DB)
            - 행(레코드), 열(컬럼, 필드), 내포(컬럼이름), 외연(데이터)

        - 차수(degree) - 속성의 개수
        - 카디널리티(cardinality) - 튜플의 개수

        - 릴레이션 특징
            1. 속성은 단일값을 가짐 (책이름이 여러번 X)
            2. 속성은 서로 다른 이름을 가짐 (책이름이라는 속성이 여러번 X)
            3. 한 속성의 값은 모두 같은(정의된) 도메인 값을 가짐 (대학교 학년에 5학년 X)
            4. 속성의 순서는 상관없음
            5. 릴레이션 내의 중복된 튜플 허용하지 않음 (같은 책 정보를 두번 X)
            6. 튜플 순서 상관없음 (1, 3, 7, 5, 2, ...)

        - 관계 데이터 모델 구성요소
            - 릴레이션(Relation)
            - 제약조건(Contraints)
            - 관계대수(Relational algebra)

- DML 학습
    - SELECT문
        - 복합조건
        - 집계함수와 Group by
            - SUM(총합), AVG(평균), COUNT(개수), MIN(최소), MAX(최대)

            ```sql
            -- COUNT()는 *을 사용할 수 있다
            -- 나머지 집계함수는 열(컬럼) 하나만 지정해서 사용할 것★★
            SELECT COUNT(saleprice) AS [주문개수]
                , SUM(saleprice) AS [총 판매액]
                , AVG(saleprice) AS [판매액 평균]
                , MIN(saleprice) AS [주문도서 최소금액]
                , MAX(saleprice) AS [주문도서 최대금액]
            FROM Orders
            ```
            ![집계함수](https://raw.githubusercontent.com/HyungJuu/basic-database-2024/main/images/db004.png)

            - 집계함수 외 일반 컬럼은 Group by 절에 속한 컬럼만 SELECT문에 사용가능
            - HAVING : 집계함수 필터. GROUP BY 뒤에 작성. WHERE절과 필터링이 다름

            ```sql
            SELECT custid, COUNT(*) AS [구매수]
              FROM Orders
             WHERE saleprice >= 8000 
             GROUP BY custid
            HAVING COUNT(*) >= 2; -- 별칭 [구매수] 사용불가 / 열(속성)이 아님
            ```

            - 두개 이상의 테이블 질의(Query)
                - 관계형 DB에서 가장 중요한 기법 중 하나★
                - INNER JOIN(내부 조인) [참조](https://sql-joins.leopard.in.ua/)
                - LEFT|RIGHT OUTER JOIN(외부 조인) : 어느 테이블이 기준인지에 따라 결과가 상이

            ![외부조인](https://raw.githubusercontent.com/HyungJuu/basic-database-2024/main/images/db005.png)

## 3일차
- Database 학습
    - 관계 데이터 모델
        - 무결성 제약조건
            - 슈퍼키
                - 튜플을 유일한 값으로 구분지을 수 있는 속성 또는 속성의 집합  
                (고객번호 | 주민번호 | 고객번호/이름 | 고객번호/주소 | 고객번호/이름/전화번호 ...)
            - 후보키
                - 튜플을 유일한 값으로 구분지을 수 있는 최소한의 속성집합 (고객번호 | 주민번호)
            - 복합키
                - 후보키 중 속성을 2개 이상 집합으로 하는 키
            - 기본키(Primary Key)★★
                - 여러 후보키 중에서 하나를 선정하여 대표로 삼는 키 (고객번호)  
                &rarr; 고려사항 : 고유한값(Unique), NULL 불가(Not Null), 최소 속성의 집합, 개인정보 등 보안사항은 사용 자제
            - 대리키★
                - 기본키가 여러개의 속성으로 구성되어 복잡하거나, 보안문제가 생길 때 새롭게 생성하는 키
            - 대체키
                - 기본키로 선정되지 않은 후보키
            - 외래키(Foriegn Key)★★
                - 기본키를 참조하여 사용하는 키  
                &rarr; 고려사항 : 다른 릴레이션과의 관계, 다른 릴레이션의 기본키를 호칭, 서로 같은 값이 사용, 기본키가 변경되면 외래키 또한 변경되어야 함  
                &rarr; NULL, 중복 허용(NOT NULL의 경우도 존재), 자기자신의 기본키를 외래키로 사용 가능, 외래키가 기본키의 속성 중 하나가 될 수 있음

            ![키](https://raw.githubusercontent.com/HyungJuu/basic-database-2024/main/images/db006.png)

            - 데이터 무결성(Integrity) : DB에 저장된 데이터의 일관성과 정확성을 지키는 것
                - 도메인 무결성 제약조건  
                    &rarr; 데이터타입(type), 널(NULL/NOT NULL), 기본값(default), 체크(check) 등 특성을 지키는 것
                - 개체 무결성 제약조건 (=기본키 제약조건)  
                    &rarr; Unique + NOT NULL(값이 중복되면 안되고, 빠져도 안됨)
                - 참조 무결성 제약조건 (=외래키 제약조건)  
                    &rarr; 부모의 키가 아닌값은 사용할 수 없음 (외래키가 바뀔때 기본키의 값이 아닌 것은 제약을 받음)
                    - RESTRICT : 자식에서 키를 사용하고 있으면 부모 삭제 금지
                    - CASCADE : 부모가 지워지면 해당 자식도 같이 삭제
                    - DEFAULT : 부모가 지워지면 자식은 지정된 기본값으로 변경
                    - NULL : 부모가 지워지면 자식의 해당값을 NULL로 변경
                - 유일성 제약조건  
                    &rarr; 일반 속성의 값이 중복되면 안되는 제약조건. NULL값은 허용

- DML 학습
    - SELECT문
        - JOIN
            - OUTER JOIN(외부조인)
                - LEFT | RIGHT | FULL(거의 사용 X)  
                &rarr; [왼쪽|오른쪽|양쪽] 테이블을 기준으로 조건에 일치하지 않는 [왼쪽|오른쪽|양쪽] 테이블 데이터 모두 표시(LEFT | RIGHT | FULL OUTER JOIN)
            
            - 부속질의(SubQuery)
                - 쿼리 내에 다시 쿼리를 작성하는 것
                - 서브쿼리를 쓸 수 있는 위치
                    - SELECT절 : 한컬럼에 하나의 값
                    ```sql
                    -- 서브쿼리(SELECT절)
                    -- 무조건 한건에 1컬럼만 연결가능
                    -- 조인으로 가능(조인보다 성능에 취약)
                    SELECT o.orderid
                         , o.custid
                         , (SELECT [name] FROM Customer WHERE custid = o.custid) AS '고객명'
                         , o.bookid
                         , (SELECT bookname FROM Book WHERE bookid = o.bookid) AS '도서명'
                         , o.saleprice
                         , o.orderdate
                      FROM Orders AS o;
                    ```

                    - FROM절 : 가상테이블 사용
                    ```sql
                    -- 서브쿼리(FROM절)
                    -- SELECT로 만들 실행결과(가상의 테이블)를 마치 DB에 있는 테이블처럼 사용가능
                    SELECT t.*
                      FROM (
                            SELECT b.bookid
                                 , b.bookname
                                 , b.price
                                 , b.publisher
                                 , o.orderdate
                                 , o.orderid
                              FROM Book AS b, Orders AS o
                             WHERE b.bookid = o.bookid
                           ) AS t
                    ```

                    - WHERE절 : 여러 조건에 사용 &rarr; IN 또는 =
                    ```sql
                    -- 대한미디어에서 출판한 도서를 구매한 고객의 이름을 조회
                    -- 서브쿼리 두번
                    -- 조인으로 가능
                    SELECT [name] AS '고객명'
                      FROM Customer
                     WHERE custid IN (SELECT custid
                                        FROM Orders
                                       WHERE bookid IN (SELECT bookid
                                                          FROM Book
                                                         WHERE publisher = '대한미디어'));
                    ```

            - 집합연산 : JOIN도 집합이지만, 속성별로 가로로 병합하기 때문에 집합이라고 부르지 않음. 집합은 데이터를 세로로 합치는 것
                - 차집합(EXCEPT) &larr; 거의 사용x : 하나의 테이블에서 교집합 값을 뺀 나머지
                - 합집합(UNION, UNION ALL) ★★ : UNION(중복제거), UNION ALL(중복허용)
                - 교집합(INTERSECT) &larr; 거의 사용x : 두 테이블에 모두 존재하는 값
                - EXISTS :데이터 자체의 존재여부

- DDL 학습 : SSMS에서 마우스로 조작하는 것이 편리
    - CREATE
        - 객체(데이터베이스, 테이블, 뷰, 사용자 등)를 생성하는 구문
        ```sql
        -- 테이블 생성에 한정
        CREATE TABLE 테이블명
        ({속성이름 데이터타입
            [NOT NULL]
            [UNIQUE]
            [DEFAULT 기본값]
            [CHECK 체크조건]
         }
            [PRIMARY KEY 속성이름(들)]
            {[FORIEGN KEY 속성이름 REFERENCES 테이블이름(속성이름)]
                [ON UPDATE [NO ACTION | CASCADE | SET NULL | SET DEFAULT]]
            }
        );
        ```

    - ALTER
        - 객체를 변경(수정)하는 구문
        ```sql
        ALTER TABLE 테이블명
            [ADD 속성이름 데이터타입]
            [DROP COLUMN 속성이름]
            [ALTER COLUMN 속성이름 데이터타입]
            [ALTER COLUMN 속성이름 [NULL | NOT NULL]]
            [ADD PRIMARY KEY(속성이름)]
            [[ADD | DROP] 제약조건이름];
        ```

    - DROP
        - 객체를 삭제하는 구문
        ```sql
        DROP TABLE 테이블명;

        ```
        
        - 외래키로 사용되는 기본키가 있으면, 외래키를 사용하는 테이블을 삭제 후 기본키의 테이블을 삭제해야 함★

## 4일차
- 관계 데이터 모델
    - 관계대수 : 릴레이션에서 원하는 결과를 얻기위해 수학의 대수와 같은 연산을 사용하여 기술하는 언어
        - 셀렉션(σ) : 조건에 맞는 튜플 추출
        - 프로젝션(π) : 조건에 맞는 속성만 추출
        - 합집합(∪)
        - 차집합(−)
        - 조인(⋈)
            - 세타조인(theta join)
            - 동등조인(equi join)
            - 외부조인(outer join)
            - 세미조인

        - 카티션 프로덕트 : 두 릴레이션을 연결하여 하나로 합칠 때 사용  
            &rarr; 결과 릴레이션의 차수 = 두 릴레이션의 차수 합  
            &rarr; 카디널리티 = 두 릴레이션 카디널리티이 곱

        - 디비전(division) : 릴레이션의 속성 값의 집합, 연산 수행

- DML 학습(SELECT 외)
    - INSERT : 새 데이터 추가

    ```sql
    INSERT INTO 테이블이름[(속성리스트)]
         VALUES (값리스트);
    ```

    - UPDATE : 기존 데이터를 갱신 &rarr; 사용에 주의★

    ```sql
    -- 트랜잭션을 걸어 복구 대비
    UPDATE 테이블이름
       SET 속성이름1=값[, 속성이름2=값, ...]
    [WHERE <검색조건>]  -- 실무에서는 빼면 안됨★
    ```

    - DELETE : 기존 데이터 삭제 &rarr; 사용에 주의★
    
    ```sql
    -- 트랜잭션을 걸어 복구 대비
    DELETE FROM 테이블이름
     WHERE <검색조건> -- 실무에서는 빼면 안됨★
    ```

- SQL 고급
    - 내장함수
        - 수학함수, 문자열함수, 날짜/시간함수, 변환함수 ,커서함수(★), 보안함수, 시스템함수 등
        - NULL(★)
    - 서브쿼리 리뷰
        - SELECT : 단일행, 단일열 (스칼라 서브쿼리)
        - FROM : 다수행, 다수열
        - WHERE : 다수행, 다수열(일반적)
            - 비교연산, 집합연산, 한정여산, 존재연산 가능

## 5일차
- SQL 고급
    - 서브쿼리 리뷰       
    - 뷰 : 하나이상의 테이블을 합하여 만든 가상 테이블(JOIN, UNION)
        - 편리성(및 재사용성) : 자주 사용되는 복잡한 질의를 뷰로 미리 정의
        - 보안성 : 각 사용자별로 필요한 데이터만 선별. 중요한 질의내용 암호화 가능  
            &rarr; 개인정보(주민번호)나 급여, 건강정보같은 민감한 정보를 제외하여 테이블 생성
        - 논리적독립성 : 개념 스키마의 데이터베이스 구조가 변해도 외부 스키마에 영향을 주지 않도록 논리적 데이터 독립성 제공

        - 원본데이터가 변경되면 같이 변경되고, 인덱스 생성은 어려움
        - CUD(INSERT, UPDATE, DELETE) 연산에 제약이 있음
        
        ```sql
        -- 생성
        CREATE VIEW 뷰이름 [(열이름 [, ...])]
        AS <SELECT 쿼리문>;

        -- 수정
        ALTER VIEW 뷰이름 [(열이름 [, ...])]
        AS <SELECT 쿼리문>;

        -- 삭제
        DROP VIEW 뷰이름;
        ```

    - 인덱스

    ```sql
    -- 생성
    CREATE [UNIQUE] [CLUSTERED | NONCLUSTERED] INDEX 인덱스이름
    ON 테이블명 (속성이름 [ASC | DESC] [, ...n]);

    -- 수정
    ALTER INDEX {인덱스이름 | ALL}
    ON 테이블명 { REBUILD | DISABLE | REORGANIZE };

    -- 삭제
    DROP INDEX 인덱스이름 ON 테이블명;
    ```

- 파이썬 SQL Server 연동 프로그래밍
    - PyQT GUI 생성
    - SQL Server 데이터 핸들링

- 데이터베이스 모델링