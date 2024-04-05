-- 테이블 생성
-- basic2024 데이터베이스 사용
USE basic2024;
Go

-- 유저 테이블
CREATE TABLE Users (
			 userid BIGINT IDENTITY(1,1) NOT NULL -- 유저아이디 IDENTITY(1,1) : 자동증가. INSERT문에 VALUES에 추가할 필요없음
		 , username NVARCHAR(40) NOT NULL -- 유저이름
		 , guildno INT DEFAULT 0
		 , regdate DATETIME DEFAULT GETDATE() -- 등록일시
);
GO

-- 인벤토리 테이블 생성
CREATE TABLE Inventory (
			 itemno BIGINT NOT NULL
		 , userid BIGINT NOT NULL
		 , itemid INT NOT NULL
		 , regdate DATETIME DEFAULT GETDATE()
);
GO

-- 1000만건 더미데이터 생성
DECLARE @i INT; -- DECLARE : 변수 정의 / @i : 변수(INT타입)
SET @i = 0; -- i = 0으로 초기화

WHILE (@i < 10000000) -- WHILE 반복문
BEGIN -- 반복문 시작
	SET @i = @i + 1; -- 반복문이 돌아가는 동안 i에 1씩 증가
	INSERT INTO Users (username, guildno, regdate)
	VALUES (CONCAT('user', @i), @i/100, DATEADD(dd,-@i/100, GETDATE()));

END;	-- 반복문 종료

SELECT *
	FROM Users;

-- 완전 삭제
TRUNCATE TABLE Users;	-- 1부터 초기화
