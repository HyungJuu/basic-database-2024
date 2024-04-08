-- 'sql031_인덱스예제.sql' 에서 잘못만든 데이터 모두 초기화
-- 삭제
DELETE FROM Users;  -- WHERE 절이 없으면 모두 삭제
-- 단, DELETE FROM으로 데이터를 삭제하면, 데이터를 다시 집어넣을 때 1부터 시작하지 않고 마지막번호 다음부터 들어간다

-- indentity(1, 1) 로 설정한 테이블에서 1부터 다시 넣도록 설정하려면
-- 모두 지우고 테이블 초기화까지
TRUNCATE TABLE Users;

-- 200만건으로 줄여서 다시시작
DECLARE @i INT;
SET @i = 0;

WHILE (@i < 2000000)
BEGIN
    SET @i = @i + 1;
    INSERT INTO Users (username, guildno, regdate)
    VALUES (CONCAT('user', @i), @i/100, DATEADD(dd, -@i/100, GETDATE()));
END;

-- 인덱스가 없는 상태
-- 100 만건 정도의 데이터 조회시 5~8초 시간이 소요

-- 인덱스를 걸기 위해서 userid에 기본키(PK)를 설정
ALTER TABLE Users ADD PRIMARY KEY(userid);

-- PK에 클러스터드 인덱스가 설정됨
CREATE INDEX IX_Users_username ON Users(username);

-- !WHERE 에 검색을 위해서 username을 사용함
-- 인덱스를 PK에 거는 것이 아니라 username
CREATE CLUSTERED INDEX IX_Users_username ON Users(username);

DROP INDEX IX_Users_username ON Users;

-- 인덱스는 대량의 데이터에서 찾고자하는 데이터를 빨리 찾게해주는 것이 목적
-- WHERE절, JOIN의 ON절에 들어가는 컬럼에 인덱스를 설정하는 것이 속도개선에 도움
-- 1번 PK, 2번 FK, 3번 WHERE절에 검색시 들어가는 컬럼에 인덱스를 설정
-- 단, NULL값 또는 중복이 많은 컬럼에 인덱스를 걸면, 성능 도움 X