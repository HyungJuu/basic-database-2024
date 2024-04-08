-- HR 데이터베이스 실습
-- 데이터 검색 : SELECT

-- 샘플문제. 사원정보 테이블에서 사번, 이름, 급여, 입사일, 상사의 사원번호를 출력하시오.(107개)
SELECT EMPLOYEE_ID
     , FIRST_NAME + ' ' + LAST_NAME AS [name]
     , SALARY
     , HIRE_DATE
     , MANAGER_ID
  FROM Employees;

/* 1. 사원정보 테이블에서 사원의 성과 이름을 name으로, 업무는 job, 급여는 salary, 
      연봉에 $100 보너스를 추가 계산한 연봉은 Increased Ann Salary,
      급여(월급)에 $100 보너스를 추가하여 계산한 연봉은 Increased Salary의 별칭으로 출력하시오. */
SELECT FIRST_NAME + ' ' + LAST_NAME AS [name]
     , JOB_ID AS [job]
     , SALARY
     , (SALARY * 12) + 100 AS [Increased Ann Salary]
     , (SALARY + 100) * 12 AS [Increased Salary]
  FROM employees;

/* 2. 사원정보 테이블에서 모든 사원의 성(last_name)과 연봉을 "성 : 1 Year Salary = $연봉" 형식으로 출력하고
      "1 Year Salary"라는 별칭을 붙여 출력하시오.(107행) */
SELECT LAST_NAME + ' : 1 Year Salary = $' + CONVERT(VARCHAR, SALARY * 12) AS [1 Year Salary]
  FROM employees;

/* 3. 부서별로 담당하는 업무를 한 번씩만 출력하시오.(20행) */
SELECT DISTINCT DEPARTMENT_ID
     , JOB_ID
  FROM employees;

-- 데이터 제한 및 정렬 : WHERE, ORDER BY

/* 샘플문제. HR 부서에서 예산 편성문제로 급여 정보 보고서를 작성하려고 한다.
    사원정보 테이블에서 급여가 $7000 ~ $10000 범위 이외인 사람의 성과 이름(Name 별칭) 및 급여를
    급여가 작은 순으로 출력하시오.(75행) */
SELECT FIRST_NAME + ' ' + LAST_NAME AS [Name]
     , SALARY
  FROM employees
 WHERE SALARY NOT BETWEEN 7000 AND 10000
 ORDER BY SALARY ASC;

/* 1. 사원의 이름 중에 'e' 및 'o' 글자가 포함된 사원을 출력하시오.
      이때 머리글은 'e and o Name'라고 출력하시오.(10행) */
SELECT LAST_NAME AS [e and o Name]
  FROM employees
 WHERE LAST_NAME LIKE '%e%' AND LAST_NAME LIKE '%o%';

/* 2. 현재 날짜 타입을 날짜 함수를 통해 확인하고, 2006년 05월 20일부터 2007년 05월 20일 사이에 고용된 사원들의
      성과 이름(Name 별칭), 사원번호, 고용일자를 출력하시오.
      단, 입사일이 빠른 순으로 정렬하시오.(18행) */
SELECT GETDATE();

SELECT FIRST_NAME + ' ' + LAST_NAME AS [Name]
     , EMPLOYEE_ID
     , HIRE_DATE
  FROM employees
 WHERE HIRE_DATE BETWEEN '2006-05-20' AND '2007-05-20'
 ORDER BY HIRE_DATE ASC;