-- ------------------------------------------------------
-- 0. The relationship between 
--    parent(=master) table and child(=slave) table
-- ------------------------------------------------------
-- * Please refer to Chapter05 page 2.
-- ------------------------------------------------------

--Child (= Slave) table to refer to others.
DESC employees;

SELECT 
    last_name,
    department_id                       --얘는 department_id를 참조하여 쓰는 자식쪽이다.
FROM
    employees
ORDER BY
    2 ASC;

--Parent(=Master) table to be referred.
DESC departments;

SELECT
    department_id,                      --PK 컬럼인 department_id는 department자신꺼인, 부모쪽이다.
    department_name
FROM
    departments
ORDER BY
    1 ASC;

--특정 직원의 부서번호 찾아내기
SELECT
    last_name,
    department_id
FROM
    employees
WHERE
    last_name = 'Whalen';

--찾아낸 부서번호를 이용하여, 부서명 조회
SELECT
    department_name
FROM
    departments
WHERE
    department_id = 10;

-- ------------------------------------------------------
-- "JOIN" : 필요한 데이터가, 여러 테이블에 분산되어 있을 경우에,
-- 여러 테이블의 공통된 컬럼을 연결시켜, 원하는 데이터를 검색하는
-- 방법을 "조인"이라 한다.
--
-- 따라서, 조인은 검색하고자 하는 컬럼이, 두개 이상의 테이블에
-- 분산되어 있는 경우에 사용된다.
-- ------------------------------------------------------

-- ------------------------------------------------------
-- 1. Oracle Join
-- ------------------------------------------------------
--  가. Oracle에서만 사용되는 조인
--  나. 특징: 여러 테이블을 연결하는 조인조건을 WHERE절에 명시
-- ------------------------------------------------------
--  a. Catesian Product (카테시안 프로덕트)
--  b. Equal(= Equi) Join (동등 조인)
--  c. Non-equal(= Non-equi) Join (비동등 조인)
--  d. Self Join (셀프 조인)
--  e. Outer Join (외부 조인)
-- ------------------------------------------------------
-- * Please refer to page 4.
-- ------------------------------------------------------

-- ------------------------------------------------------
-- A. Catesian Product (카테시안 프로덕트)
-- ------------------------------------------------------
-- 두 개 이상의 테이블을 공통컬럼없이 연결하는 조인으로,
-- 모든 조인에서 가장 먼저 발생하는 조인이자 기본이 됨.
--  가. 유효한 데이터로 사용되지 못함.
--  나. 조인조건이 생략된 경우에 발생.
--
-- * 조인결과: 테이블1 x ... x 테이블n 개의 레코드 생성
-- ------------------------------------------------------
-- Basic Syntax)
--  SELECT 테이블1.컬럼 , 테이블2.컬럼
--  FROM 테이블1, 테이블2
-- ------------------------------------------------------
SELECT
    count(*)
FROM
    employees;          --107

SELECT
    count(*)
FROM
    departments;        --27

SELECT
    count(*)
FROM
    employees,
    departments;        --2889  -->>>(107 * 27)

select * from USER_TABLES;

SELECT
    last_name,
    department_name
FROM
    employees,
    departments;

-- ------------------------------------------------------
-- B. Equal(= Equi) Join (동등 조인)
-- ------------------------------------------------------
-- 가. 가장 많이 사용하는 조인
-- 나. 두 테이블에서, 공통으로 존재하는 컬럼의 값이 일치하는 행들을
--     연결하여 데이터를 반환.
--     일치하지 않는 데이터는 제외됨.
-- 다. 대부분, 기본키(PK)를 가진 테이블(Parent, Master)과
--     참조키(FK)를 가진 테이블(Child, Slave)을 조인할 때 사용
-- ------------------------------------------------------
-- Basic Syntax)
--  SELECT 테이블1.컬럼 , 테이블2.컬럼
--  FROM 테이블1, 테이블2
--  WHERE 테이블1.공통컬럼 = 테이블2.공통컬럼;
-- ------------------------------------------------------
SELECT
    last_name,
    employees.department_id,
    departments.department_id,
    department_name
FROM
    employees,
    departments
WHERE
    employees.department_id = departments.department_id;        --자동적으로, department_id값에 의해 정렬된다.

SELECT
    *
FROM
    employees,
    departments
WHERE
    employees.department_id = departments.department_id;        --자동적으로, department_id값에 의해 정렬된다.

SELECT
    employees.*,
    departments.*,
FROM
    employees,
    departments
WHERE
    employees.department_id = departments.department_id;        --자동적으로, department_id값에 의해 정렬된다.

--ERROR.
--column ambiguously defined    --> column이 불확실하게 defined되었다.
SELECT
    last_name,
    department_name,
    department_id           -->>>>얘가 오류 원인.
FROM
    employees,
    departments
WHERE
    employees.department_id = departments.department_id;

SELECT
    last_name,
    department_name,
    employees.department_id
FROM
    employees,
    departments
WHERE
    employees.department_id = departments.department_id;

-- ------------------------------------------------------
-- 테이블에 별칭 사용
-- ------------------------------------------------------
-- 가. SELECT 절에서, 컬럼 별칭(Column Alias)을 사용했듯이,
--     FROM 절에서도, 테이블 별칭(Table Alias)을 사용가능하다.
-- 나. 테이블명이 길거나, 식별이 힘든 경우에 유용하다.
-- 다. (*주의*) 테이블 별칭을 지정한 경우에는, 반드시 이 별칭을
--     사용하여, 컬럼을 참조해야 한다.
--     만일, 테이블 별칭을 사용하지 않고, 테이블명으로 컬럼을
--     참조하면, 테이블명을 별칭(Alias)으로 인식하기 때문에,
--     오류 발생.
-- ------------------------------------------------------
-- Basic Syntax)
--      SELECT alias1.컬럼 , alias2.컬럼
--      FROM 테이블1 alias1, 테이블2 alias2
--      WHERE alias1.공통컬럼 = alias2.공통컬럼;
-- ------------------------------------------------------
SELECT
    emp.last_name,
    department_name,
    emp.department_id
FROM
    employees emp,
    departments dept
WHERE
    emp.department_id = dept.department_id;

--별칭 사용시 주의할점... From절에는 AS를 붙이지 못한다. 
--FROM절에서 별칭을 사용할 시 무조건 그 별칭으로만 써야된다.


-- ------------------------------------------------------
-- 검색조건 추가
-- ------------------------------------------------------
-- 가. Oracle 조인에서는, WHERE절에 AND / OR 연산자를 사용하여
--     조인조건에 검색조건(체크조건)을 추가할 수 있다.
-- 나. 이로인해, WHERE의 어떤 조건이 조인조건이고, 어떤 조건이
--     검색조건인지, 쉽게 파악이 안되어, 가독성이 떨어짐
-- 다. (*주의*) 따라서, 조인조건을 우선 명시하고, 나중에 검색조건
--     을 명시하는 방법으로, 가독성을 향상 시켜야 한다.
-- 라. 결과: 조인조건의 결과 중에서, 검색조건으로 필터링 된 결과
--          를 반환
-- ------------------------------------------------------
SELECT
    t1.last_name,
    t1.salary,
    t2.department_name
FROM
    employees t1,
    departments t2
WHERE
    t1.department_id = t2.department_id      --조인조건  (JOIN  조건)
    AND t1.last_name='Whalen';               --검색조건  (check 조건)

SELECT
    t2.department_name AS 부서명,
    count(t1.employee_id) AS 인원수
FROM
    employees t1,
    departments t2
WHERE
    t1.department_id = t2.department_id             --조인조건
    AND to_char( t1.hire_date, 'YYYY') <= 2005      --체크조건
GROUP BY
    t2.department_name;

-- ------------------------------------------------------
-- C. Non-equal(= Non-equi) Join (비동등 조인)
-- ------------------------------------------------------
-- 가. WHERE절에 조인조건을 지정할 때, 동등연산자(=) 이외의,
--     비교 연산자(>,<,>=,<=,!=)를 사용하는 조인
-- ------------------------------------------------------
-- * Please refer to the chapter 05, page 13.
-- ------------------------------------------------------
CREATE TABLE job_grades (
    grade_level VARCHAR2(3) 
        CONSTRAINT job_gra_level_pk PRIMARY KEY,     --월급여등급  
    lowest_sal  NUMBER,             --최소 월급여
    highest_sal NUMBER              --최대 월급여
);

INSERT INTO job_grades VALUES('A', 1000, 2999);
INSERT INTO job_grades VALUES('B', 3000, 4999);
INSERT INTO job_grades VALUES('C', 5000, 9999);
INSERT INTO job_grades VALUES('D', 10000, 14999);
INSERT INTO job_grades VALUES('E', 15000, 24999);
INSERT INTO job_grades VALUES('F', 25000, 40000);

COMMIT;

DESC job_grades;

SELECT
    *
FROM
    job_grades;

-----------
SELECT
    t1.last_name,
    t1.salary,
    t2.grade_level
FROM
    employees t1,
    job_grades t2
WHERE
    t1.salary BETWEEN t2.lowest_sal AND t2.highest_sal;

SELECT
    t1.last_name,
    t1.salary,
    t2.department_name,
    t3.grade_level
FROM
    employees t1,
    departments t2,
    job_grades t3
WHERE
    t1.department_id = t2.department_id
    AND t1.salary BETWEEN t3.lowest_sal AND t3.highest_sal;

-- ------------------------------------------------------
-- D. Self Join (셀프 조인)
-- ------------------------------------------------------
-- 하나의 테이블만 사용하여, 자기자신을 조인할 수도 있는데, 이를
-- Self Join 이라고 한다.
--  가. FROM 절에 같은 테이블을 사용해야 함
--  나. 따라서, 반드시 테이블 별칭을 사용해야 함
--  다. 테이블 하나를, 두 개 이상으로 Self 조인가능
--  라. 하나의 테이블을, 마치 여러 테이블을 사용하는 것처럼,
--      테이블 별칭을 사용하여, 조인하는 방법을 의미
-- ------------------------------------------------------
SELECT
    last_name,
    manager_id
FROM
    employees;

SELECT
    last_name, 
    manager_id
FROM
    employees e
ORDER BY
    2 ASC;

SELECT
    employee_id,
    last_name
FROM
    employees e
ORDER BY
    1 ASC;


SELECT
    e.employee_id AS 사원번호,
    e.manager_id AS 관리자번호,
    e.last_name AS 사원명,
    m.last_name AS 관리자명
FROM
    employees e,        -- 사원 정보
    employees m         -- 관리자 정보(가상)
WHERE
    e.manager_id = m.employee_id;               --managerID가 employeeID와 같을때...


-- ------------------------------------------------------
-- E. Outer Join (외부 조인)
-- ------------------------------------------------------
-- Join 조건에 부합하지 않아도, 결과값에 누락된 데이터를 포함시키
-- 는 방법:
--  가. Inner Join (Equal, Non-Equal, Self Join):
--      조인결과는 반드시, 조인조건을 만족하는 데이터만 포함하는 조인
--  나. (+) 연산자를 사용한다.
--  다. (+) 연산자는, 조인대상 테이블들 중에서, 한번만 사용가능
--  라. (+) 연산자는, 일치하는 데이터가 없는 쪽에 지정
--  마. (+) 연산자의 지정:
--      내부적으로, 한 개 이상의 NULL 가진 행이 생성되고,
--      이렇게 생성된 NULL 행들과 데이터를 가진 테이블들의 행들
--      이 조인하게 되어, 조건이 부합하지 않아도, 결과값에 포함됨
-- ------------------------------------------------------
-- Basic Syntax)
--
--  SELECT 테이블1.컬럼 , 테이블2.컬럼
--  FROM 테이블1 , 테이블2
--  WHERE 테이블1.공통컬럼 = 테이블2.공통컬럼 (+);
-- ------------------------------------------------------
-- * Please refer to the chapter 05, page 19.
-- ------------------------------------------------------
SELECT
    e.employee_id AS 사원번호,
    e.manager_id AS 관리자번호,
    e.last_name AS 사원명,
    m.last_name AS 관리자명
    -- count(e.employee_id)        --106
FROM
    employees e,
    employees m
WHERE   --참조함 = 참조당함
    e.manager_id = m.employee_id;

SELECT
    e.employee_id AS 사원번호,
    e.manager_id AS 관리자번호,
    e.last_name AS 사원명,
    m.last_name AS 관리자명
    -- count(e.employee_id)        --107
FROM
    employees e,
    employees m
WHERE   --참조함 = 참조당함
    e.manager_id = m.employee_id (+);

--------------------------------------------------------
SELECT
    e.last_name AS 사원명,
    m.last_name AS 관리자명,
    mm.last_name AS "관리자의 관리자명"
FROM
    employees e,
    employees m,
    employees mm
WHERE
    e.manager_id = m.employee_id
    AND m.manager_id = mm.employee_id;