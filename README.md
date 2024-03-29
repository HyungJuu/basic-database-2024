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
                - INNER JOIN(내부 조인)
                - LEFT|RIGHT OUTER JOIN(외부 조인) : 어느 테이블이 기준인지에 따라 결과가 상이

            ![외부조인](https://raw.githubusercontent.com/HyungJuu/basic-database-2024/main/images/db005.png)

