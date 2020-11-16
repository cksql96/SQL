-- ------------------------------------------------------
-- 3. 단순컬럼과 그룹 (처리)함수 - 주의: 함께 사용불가!!!
-- ------------------------------------------------------
-- a. 단순컬럼 : 그룹 함수가 적용되지 않음
-- b. 그룹함수 : 여러 행(그룹) 또는 테이블 전체에 대해 적용
--              하나의 값을 반환
-- ------------------------------------------------------
SELECT
    max(salary)
FROM
    employees;

--불가능
--ERROR at line 15: ORA-00937: not a single-group group function
SELECT
    last_name,              --return 107 values
    max(salary)             --return 1 values
FROM
    employees;


-- ------------------------------------------------------
-- 4. GROUP BY clause
-- ------------------------------------------------------
-- (Basic syntax)
--   SELECT
--      [단순컬럼1, ]
--      ..
--      [단순컬럼n, ]
--
--      [표현식1, ]
--      ..
--      [표현식n, ]
--
--      그룹함수1,
--      그룹함수2,
--      ...
--      그룹함수n
--   FROM table
--   [ GROUP BY { 단순컬럼1, .., 단순컬럼n | 표현식1, .., 표현식n } ]
--   [ HAVING 조건식 ]
--   [ ORDER BY caluse ];
-- ------------------------------------------------------
-- *주의할 점1: 
--   GROUP BY뒤에, Column alias or index 사용불가!!!  --> 셀렉절이 더 늦게 수행되기 때문에.
-- *주의할 점2:
--   GROUP BY뒤에 명시된 컬럼은, 
--   SELECT절에 그룹함수와 함께 사용가능!!
-- *주의할 점3:
--   ORDER BY절의 다중정렬과 비슷하게, 다중그룹핑 가능
-- *주의할 점4:
--   WHERE 절을 사용하여, 그룹핑하기 전에, 행을 제외시킬 수 있다!!      -->where가 더 빨리 수행되므로, 그 전에 짤라낼수 있다.
-- *주의할 점5:
--   HAVING 절을 사용하여, 그룹핑한 후에, 그룹들을 제외시킬 수 있다!!   -->2차 필터링을 한다.
-- *주의할 점6:
--   WHERE 절에는 그룹함수를 사용할 수 없다!!                           -->where가 더 빨리 수행된다.
-- *주의할 점7:
--   GROUP BY 절은 NULL 그룹도 생성함!!
-- ------------------------------------------------------
-- *** Chapter04 Page 10 참고할 것
-- ------------------------------------------------------
SELECT DISTINCT 
    department_id
FROM
    employees;

SELECT
    department_id AS "부서번호",    --그룹생성 단순컬럼                         --주의할점 2번으로 인해, 사용 가능!
    avg(salary) AS 평균월급         --각 그룹마다 적용될 그룹함수
FROM
    employees
GROUP BY
    department_id                   --NULL도 그룹으로 생성    -각 부서별로 그룹핑한다.
ORDER BY
    1 ASC;

SELECT
    department_id AS 부서번호,              --그룹생성 단순컬럼
    max(salary) AS 최대월급,                --각 그룹마다 적용될 그룹함수1
    min(salary) AS 최소월급                 --각 그룹마다 적용될 그룹함수2
FROM
    employees
GROUP BY
    department_id                           --OK
    --1                                     --X
    --부서번호                              --X
ORDER BY
    부서번호 ASC;                           --OK
    --1 ASC;                                --OK
    --department_id ASC;                    --OK


--다중 컬럼 --> 각 년도 월 별로 그룹을 해서 salary의 합을 구한다.
SELECT
    to_char( hire_date, 'YYYY') AS 년,
    to_char( hire_date, 'MM') AS 월,
    sum(salary)
FROM
    employees
GROUP BY
    to_char( hire_date, 'YYYY'),
    to_char( hire_date, 'MM')
ORDER BY
    년 ASC;


-- ------------------------------------------------------
-- 5. HAVING 조건식
-- ------------------------------------------------------
-- GROUP BY 절에 의해 생성된 결과(그룹들) 중에서, 지정된 조건에
-- 일치하는 데이터를 추출할 때 사용
--  
--  (1) 가장 먼저, FROM 절이 실행되어 테이블이 선택되고,
--  (2) WHERE절에 지정된 검색조건과 일치하는 행들이 추출되고,
--  (3) 이렇게 추출된 행들은, GROUP BY에 의해 그룹핑 되고,
--  (4) HAVING절의 조건과 일치하는 그룹들이 추가로 추출된다!!!
--
-- 이렇게, HAVING 절까지 실행되면, 테이블의 전체 행들이, 2번의
-- 필터링(filtering)이 수행된다.
-- ( WHERE절: 1차 필터링, HAVING절: 2차 필터링 )
-- ------------------------------------------------------
-- *** Chapter04 Page 13 참고할 것
-- ------------------------------------------------------
SELECT--------------------------4th
    department_id,
    sum(salary)
FROM----------------------------1st
    employees
GROUP BY------------------------2nd
    department_id
HAVING--------------------------3rd
    sum(salary) >= 90000
ORDER BY------------------------5th
    1 ASC;

--각 부서별, 직원수 구하기
SELECT
    department_id,
    count(employee_id)
FROM
    employees
GROUP BY
    department_id
HAVING
    count(salary) >= 6              --OK:
    -- salary >= 3000               --XX: 각 그룹에 대해, 단순 컬럼들만 사용
    -- department_id IN (10,20)     --OK:GROUP BY 절에 나열된 단순 컬럼들은 사용 가능   
    -- department_id > 10           --OK:GROUP BY 절에 나열된 단순 컬럼들은 사용 가능  
    -- department_id IS NULL        --OK:NULL 그룹도 가능.
ORDER BY
    1 ASC;

DESC employees;


SELECT
    department_id,                      --5.찍어내라
    sum(salary)
FROM
    employees                           --1. employees테이블에서
WHERE
    salary >= 3000                      --2.        월급이 3000이상인 사람들을
GROUP BY
    department_id                       --3.그룹핑을 한다.
HAVING
    sum(salary) >= 90000                --4.그 그룹핑 한놈들 중에서 합계가 90000이상이면
ORDER BY
    1 ASC;                              --1번셀렉문장을 asc로 정렬해라

    