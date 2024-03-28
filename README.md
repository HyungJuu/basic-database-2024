# basic-database-2024
부경대 2024 IoT 개발자과정 SQL Server 학습 리포지토리

## 1일차
- MS SQL Server 설치(최신버전) https://www.microsoft.com/ko-kr/sql-server/sql-server-downloads
    - DBMS 엔진 &rarr; 개발자 버전
        - ISO 다운로드 후 설치 추천
        - SQL Server에 대한 Azure 확장 비활성화 후 진행
        - 데이터베이스 엔진 구성부터 중요★★★
            - Windows 인증모드 &rarr; 외부에서 접근 불가
            - 혼합모드(sa)에 대한 암호를 지정  
                &rarr; mssql_p@ss (8자 이상 / 대소문자 구분 / 특수문자1자 이상 포함)
            - 데이터루트 디렉토리 변경

    - 개발툴 설치
        - SSMS(SQL Server Management Studio) &rarr; 한국어버전설치 https://learn.microsoft.com/ko-kr/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16
            - DB 접근, 여러 개발작업 툴

    - 데이터베이스 개념
        - 데이터 보관, 관리 ,서비스 시스템
        - Data, Information, Knowlege 개념
        - DBMS > Database > Data(Model)

    - DB언어
        - SQL(Structered Query Language) : 구조화된 질의 언어
            - DDL (Data Definition Language) : 데이터베이스, 테이블, 인덱스 생성
            - DML (Data Manipulation Language) : 검색, 삽입, 수정, 삭제 등 기능
            - DCL (Data Control Language) : 권한, 트랙스액션 부여/제거 기능

    - 기본명령어
        - -- : 주석 /* */(C/C++ 주석도 사용가능)
        - F5 : 실행

## 2일차