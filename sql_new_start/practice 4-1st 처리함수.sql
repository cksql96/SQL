-- ------------------------------------------------------
-- (1) 그룹 (처리)함수 - SUM
-- ------------------------------------------------------
-- 해당 열의 총합계를 구한다 (** NULL 값 제외하고 **)
-- ------------------------------------------------------
-- 문법) SUM( [ DISTINCT | ALL ] column )
--          DISTINCT : excluding duplicated values.
--          ALL : including duplicated values.
--                (if abbreviated, default)
-- ------------------------------------------------------
SELECT
    sum(DISTINCT salary) AS "DISTINCT",
    sum(ALL salary) AS "ALL",
    sum(salary) AS babo
FROM
    employees;

-- ------------------------------------------------------
-- (2) 그룹 (처리)함수 - AVG
-- ------------------------------------------------------
-- 해당 열의 평균을 구한다 (** NULL 값 제외하고 **)
-- ------------------------------------------------------
-- 문법) AVG( [ DISTINCT | ALL ] column )
--          DISTINCT : excluding duplicated values.
--          ALL : including duplicated values.
--                (if abbreviated, default)
-- ------------------------------------------------------
SELECT
    sum(salary),
    avg(DISTINCT salary),
    avg(ALL salary),
    avg(salary)
FROM
    employees;

-- ------------------------------------------------------
-- (3) 그룹 (처리)함수 - (** NULL 값 제외하고 **)
--      MAX : 해당 열의 총 행중에 최대값을 구한다
--      MIN : 해당 열의 총 행중에 최소값을 구한다
-- ------------------------------------------------------
-- 문법) MAX( [ DISTINCT | ALL ] column )
--      MIN( [ DISTINCT | ALL ] column )
--          DISTINCT : excluding duplicated values.
--          ALL : including duplicated values.
--                (if abbreviated, default)
-- ------------------------------------------------------
SELECT
    max(salary),
    min(salary)
FROM
    employees;

SELECT
    min(hire_date),
    max(hire_date)
FROM
    employees;

-- ------------------------------------------------------
-- (4) 그룹 (처리)함수 - COUNT
-- ------------------------------------------------------
-- 행의 개수를 카운트한다(* 컬럼명 지정하는 경우, NULL값 제외 *)
-- ------------------------------------------------------
-- 문법) COUNT( { [[ DISTINCT | ALL ] column] | * } )
--          DISTINCT : excluding duplicated values.
--          ALL : including duplicated values.
--                (if abbreviated, default)
-- ------------------------------------------------------
SELECT
    count(last_name),
    count(commission_pct),
    count(*)
FROM
    employees;

SELECT
    count(job_id),
    count(DISTINCT job_id)
FROM
    employees;

--해당 테이블의 전체 레코드 개수 구하기(주의)
SELECT
    count(*),                       --비추
    count(commission_pct),          --경고(removed all nulls)
    count(employee_id)              --추천(primary key = unique + not null)
FROM
    employees;
