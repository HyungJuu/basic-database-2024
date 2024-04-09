/* 6. HR부서에서는 급여(salary)와 수당률(commission_pct)에 대한 지출 보고서를 작성하려고 한다.  
      수당을 받는 모든 사원의 성과 이름(Name), 급여, 업무, 수당률을 출력하시오.
      이때, 급여가 큰 순서로 정렬하되, 급여가 같으면 수당률이 큰 순서로 정렬하시오. */
SELECT FIRST_NAME + ' ' + LAST_NAME AS [Name]
     , SALARY
     , JOB_ID
     , COMMISSION_PCT
  FROM employees
 WHERE COMMISSION_PCT IS NOT NULL
 ORDER BY SALARY DESC, COMMISSION_PCT DESC;

-- 단일행 함수 및 변환 함수

/* 샘플문제. 60번 IT 부서의 사원 급여를 12.3% 인상하여 정수(반올림)만 표시하는 보고서 작성.
   출력 형식은 사번, 이름과 성(Name), 급여, 인상된 급여(Increased Salary) 순으로 출력 */
SELECT EMPLOYEE_ID
     , FIRST_NAME + ' ' + LAST_NAME AS [Name]
     , SALARY
     , CONVERT(INT,ROUND(SALARY * 1.123, 0)) AS [Increased Salary] -- CONVERT(INT, ) -> 형변환
  FROM employees
 WHERE DEPARTMENT_ID = 60;

/* 7. 사원의 성이 s로 끝나는 사원의 이름과 업무를 아래와 같이 출력하라
      이름과 성의 첫글자는 대문자, 업무는 대문자로 출력, 머리글은 "Employee JOBs." 표기
      Michael Rogers is a ST_CHERK */
SELECT FIRST_NAME + ' ' + LAST_NAME + ' is a ' + JOB_ID AS [Employee JOBs.]
  FROM employees
 WHERE LAST_NAME LIKE '%s';

/* 8. 사원의 성과 이름(Name), 급여, 수당 여부에 따른 연봉을 포함하여 출력.
      수당이 있으면 "Salary + Commission"
      없으면 "Salary only" 표시
      출력은 연봉이 높은 순(107행) */


/* 9. 모든 사원의 성과 이름(Name), 입사일, 입사일의 요일 출력.
      주(week)의 시작인 일요일부터 출력되도록 정렬(107행) */
-- 요일문제 TODO
SELECT FIRST_NAME + ' ' + LAST_NAME AS [Name]
     , HIRE_DATE
     , DATENAME(WEEKDAY, DATEPART(DW, HIRE_DATE)) AS [Day of the week]
  FROM employees
 ORDER BY DATEPART(DW, HIRE_DATE);

-- 집계함수 : SUM, COUNT, AVG, MAX, MIN ...

/* 11. 사원들의 업무별 전체 급여 평균이 10,000$ 보다 큰 경우를 조회하여 업무, 급여 평균을 출력하시오.
       단, 업무에 사원(CLERK)이 포함된 경우는 제외하고 전체 급여평균이 높은순서대로 출력(7행) */
SELECT JOB_ID
     , '$' + FORMAT(AVG(SALARY), '#,#') AS [Avg Salary]
  FROM employees
 GROUP BY JOB_ID
HAVING AVG(SALARY) > 10000
 ORDER BY [Avg Salary] DESC;

-- JOIN
/* 12. Employees, Department 조인, 사원수가 5명 이상인 부서의 부서명, 사원수 출력, 사원수 내림차순(5행) */
/* 13 문제도 풀수 있음 */
SELECT d.department_name
     , COUNT(*) AS [사원수]
  FROM employees AS e, departments AS d
 WHERE e.DEPARTMENT_ID = d.department_id
 GROUP BY d.department_name
HAVING COUNT(*) >= 5
 ORDER BY COUNT(*) DESC;

-- 서브쿼리
/* 사원의 급여 정보 중 업무별 최소 급여를 받는 사원의 이름, 업무, 급여, 입사일 출력(21행) */
SELECT e.FIRST_NAME + ' ' + e.LAST_NAME AS [Name]
     , e.JOB_ID
     , e.SALARY
     , e.HIRE_DATE
  FROM employees AS e
 WHERE e.SALARY <= (SELECT MIN(SALARY) AS [salary]
                      FROM employees
                     WHERE JOB_ID = e.JOB_ID
                     GROUP BY JOB_ID);

-- CASE 연산자 (프로그래밍적인)
/* 107명의 직원 중 HR_REP(10%), MK_REP(12%), PR_REP(15%), SA_REP(18%), IT_PROG(20%) */
SELECT EMPLOYEE_ID
     , FIRST_NAME + ' ' + LAST_NAME AS [NAME]
     , JOB_ID
     , SALARY
     , CASE JOB_ID WHEN 'HR_REP' THEN SALARY * 1.10
                   WHEN 'MK_REP' THEN SALARY * 1.12
                   WHEN 'PR_REP' THEN SALARY * 1.15
                   WHEN 'SA_REP' THEN SALARY * 1.18
                   WHEN 'IT_PROG' THEN SALARY * 1.20
       ELSE SALARY END AS [New Salary]
  FROM employees;

-- ROLLUP, CUBE : GROUP BY 마지막에 WITH ROLLUP
-- 부서와 업무별 급여합계를 구하여 신년 급여수준레벨을 지정하고자 함
-- 부서번호, 업무를 기준으로 그룹별로 나누고 급여합계와 인원수를 출력 (20행)
-- CUBE보다 ROLLUP을 많이 씀
SELECT DEPARTMENT_ID
     , JOB_ID
     , COUNT(EMPLOYEE_ID) AS [count EMPs]
     , '$' + FORMAT(SUM(SALARY), '#,#') AS [Salary SUM]
  FROM employees
 GROUP BY DEPARTMENT_ID, JOB_ID
 ORDER BY DEPARTMENT_ID;

SELECT DEPARTMENT_ID
    , ISNULL(JOB_ID, '--합계--') AS JOB_ID
    , COUNT(EMPLOYEE_ID) AS [count EMPs]
    , '$' + FORMAT(SUM(SALARY), '#,#') AS [Salary SUM]
FROM employees
GROUP BY DEPARTMENT_ID, JOB_ID WITH ROLLUP;
-- GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID);

-- RANK, ROW_NUMBER, FIRST_VALUE
-- 사원들의 부서별 급여 기준으로 내림차순으로 정렬, 순위를 표시하시오.(107행)
SELECT EMPLOYEE_ID
     , LAST_NAME
     , SALARY
     , DEPARTMENT_ID
     , RANK() OVER (ORDER BY Salary DESC)   -- 동등순위 중복증가 타입
     , DENSE_RANK() OVER (ORDER BY Salary DESC) -- 동등순위 순차증가 타입
  FROM employees
 ORDER BY SALARY DESC;

-- 각 행의 번호를 가져오는 함수
SELECT ROW_NUMBER() OVER (ORDER BY EMPLOYEE_ID ASC)
     , *
  FROM employees
 ORDER BY EMPLOYEE_ID ASC;