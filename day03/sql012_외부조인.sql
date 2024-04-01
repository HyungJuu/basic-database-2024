-- Customer를 기준으로 Orders 테이블과 외부조인하기
SELECT c.custid
     , c.[name]
     , c.[address]
     , c.phone
     , o.orderid
     , o.custid -- OUTER JOIN에서 이 외래키는 필요X
     , o.bookid
     , o.saleprice
     , o.orderdate
  FROM Customer AS c LEFT OUTER JOIN Orders AS o    -- LEFT, RIGHT, FULL 등 변경하면서 실행
    ON c.custid = o.custid
-- 박지성, 김연아, 장미란, 추신수는 교집합. 박세리는 밖 -> NULL값(phone은 원래 NULL)