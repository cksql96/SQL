-- ------------------------------------------------------
-- 1. INSERT 문
-- ------------------------------------------------------
--  가. 테이블에 데이터를 저장하기 위한 문장.
--  나. 구분:
--      (1) 단일 행 INSERT문: 한 번에 하나의 행을 테이블에 저장
--      (2) 다중 행 INSERT문: 한 번에 여러 행을 테이블에 저장
--  다. 테이블에 새로운 레코드(행)이 삽입 됨.
--  라. INTO 절에 명시한 컬럼은, VALUES 절에서 지정한 컬럼값과
--      일대일 대응되도록, 순서대로 입력해야 함.
--      So, INTO 절에 명시된 컬럼과 VALUES 절에 명시된 값의 
--      개수와 타입은 같아야 함.
--  마. INTO 절의 컬럼목록은 생략가능.
--      if 생략하면, 테이블 생성시 정의한 컬럼순서와 동일한 순서로
---     모든 컬럼값을 VALUES 절에 지정해야 한다.
--  바. 저장되는 데이터의 타입은, 컬럼의 데이터 타입과 일치해야 함
--  사. 저장되는 데이터의 크기는, 컬럼의 크기보다 같거나 작아야 함
--  아. 기본키(PK) 또는 UNIQUE컬럼은, 동일한 값을 저장할 수 없음.
--  자. INTO 절에서 생략된 컬럼은, 자동으로 널(NULL) 값이 저장됨.
--      따라서, NOT NULL 제약조건이 아닌 컬럼만 INTO절에서 생략가능.
-- ------------------------------------------------------
-- Basic Syntax) 단일 행 INSERT문
--
--  INSERT INTO 테이블명 [ (컬럼명1, 컬럼명2, ...) ]
--  VALUES ( 값1, 값2, ... );
-- ------------------------------------------------------
-- * Please refer to the chapter 07, page 07.
-- ------------------------------------------------------
DELETE FROM
    dept
WHERE
    deptno IN (50,60,70,80);

-- ------------------------------------------------------
-- 1-1. 단일 행 INSERT 문
-- ------------------------------------------------------

-- ------------------------------------------------------
-- BEGIN       -- To begin a transaction
-- ------------------------------------------------------

-- 컬럼명을 명시한 INSERT 문
INSERT INTO dept(deptno, dname, loc)
VALUES (50, '개발', '서울');


-- 컬럼명을 생략한 INSERT 문
INSERT INTO dept
VALUES (60, '인사', '경기');


-- 묵시적으로 널(null) 값 저장
--  1) 묵시적 방법(Implicitly)
INSERT INTO dept(deptno, dname)
VALUES (70, '인사');


-- 명시적으로 널(null) 값 저장:
--  2) 명시적 방법(Explicitly)
INSERT INTO dept(deptno, dname, loc)
VALUES (80, '인사', NULL);

-- ROLLBACK;
COMMIT;

-- ------------------------------------------------------
--END;        -- To end a transaction
-- ------------------------------------------------------
desc dept;


-- ------------------------------------------------------
-- 1-2. 복수 행 INSERT 문
-- ------------------------------------------------------
-- 가. 하나의 INSERT 문장으로, 한번에 여러 행 저장
-- 나. VALUES 절 대신에, 서브쿼리(= 부속질의) 사용
-- 다. 서브쿼리를 사용하여, 기존 테이블의 데이터를 복사한 후에,
--     INSERT 문으로 새로운 행 생성.
-- 라. (*주의할 점*) 
--     INTO 절에서 지정한 컬럼의 개수와 타입에 맞추어,
--     서브쿼리의 수행결과가 반드시 동일해야 함.
-- ------------------------------------------------------
-- Basic Syntax)
--
-- INSERT INTO 테이블명 [ (컬럼명1, 컬럼명2, ..., 컬럼n) ]
-- Subquery;
--
-- ------------------------------------------------------
-- Please refer to the chap07, page17.
-- ------------------------------------------------------

-- ------------------------------------------------------
-- (1) 기존 테이블을 이용하여, 새로운 테이블 생성 (CTAS)
-- ------------------------------------------------------
-- * CTAS: 기존 테이블 스키마 복사 시, NOT NULL 제약조건을 제외
--         한, 그 외 제약조건은 복사되지 않음.
-- ------------------------------------------------------
-- Basic Syntax) 
--
--  CREATE TABLE 테이블명 [(컬럼명,컬럼명2)]
--  AS
--  Subquery;
-- ------------------------------------------------------

DROP TABLE mydept;

CREATE 
    TABLE mydept AS
SELECT      --서브 쿼리
    *
FROM
    dept
WHERE
    1 = 2;      --기존 테이블의 스키마만 복사(데이터 제외)


desc mydept;

-- ------------------------------------------------------
-- (2) 복수 행 INSERT 문 수행
-- ------------------------------------------------------
INSERT 
    INTO mydept
SELECT          --서브 쿼리
    deptno,
    dname,
    loc
FROM 
dept;

-- ------------------------------------------------------
-- 1-3. 다중 테이블, 복수 행 INSERT 문 (= INSERT ALL 문)
-- ------------------------------------------------------
--  가. 하나의 INSERT 문장으로, 한번에 한 개 이상의 테이블에,
--      여러 개의 행을 저장하는 문장.
--  나. INSERT ALL 문장이라고 부름.
--  다. 서브쿼리의 실행결과가 INTO절에 지정한 테이블(1..N)에
--      자동으로 INSERT 됨.
--  라. ** WHEN 절은 생략가능 ** (= 무조건 INSERT ALL 문)
--  마. WHEN절이 있는 경우, 조건식이 참일 때에만, 지정된 테이블에
--      서브쿼리의 결과가 INSERT 됨.
--      (이땐, "조건 INSERT ALL 문" 이라고 부름)
--  바. (**주의사항**) VALUES 절에 사용된 컬럼명과 Subquery에서
--      사용된 컬럼명이 반드시 동일해야 함.
--  사. 구분:
--      (1) 무조건 INSERT ALL문 : WHEN 절이 생략된 경우.
--      (2) 조건 INSERT ALL문   : 
--          WHEN 절의 조건식의 참일 경우에만, INSERT 수행.
--          여러 WHEN 절이 중복되어 참인 경우에는,
--          각 테이블에 모두 해당 행이 INSERT 됨. 
--      (3) 조건 INSERT FIRST문 :
--          WHEN 절에 지정된 조건이 중복되어 참인 경우에, 
--          처음조건에 일치하는 테이블에만 해당 행이 저장되고,
--          이후 조건이 일치해도, 해당 테이블에 저장하지 않는 문장.
-- ------------------------------------------------------
-- Basic Syntax)
--
-- INSERT ALL
--  [WHEN 조건식 THEN]
--  INTO 테이블1 VALUES (컬럼명1, 컬럼명2, ..., 컬럼명n)
--  [WHEN 조건식2 THEN]
--  INTO 테이블2 VALUES (컬럼명1, 컬럼명2, ..., 컬럼명n)
--  ..
--  [WHEN 조건식n THEN]
--  INTO 테이블n VALUES (컬럼명1, 컬럼명2, ..., 컬럼명n)
-- Subquery;
--
-- ------------------------------------------------------
-- Please refer to the chap07, page21.
-- ------------------------------------------------------

-- ------------------------------------------------------
-- 1-3-1. 무조건 INSERT ALL 문
-- ------------------------------------------------------

-- ------------------------------------------------------
-- (1) 기존 테이블을 이용하여, 새로운 테이블 생성 (CTAS)
-- ------------------------------------------------------
-- * CTAS: 기존 테이블 스키마 복사 시, NOT NULL 제약조건을 제외
--         한, 그 외 제약조건은 복사되지 않음.
-- ------------------------------------------------------
-- Basic Syntax) 
--
--  CREATE TABLE 테이블명 [(컬럼명,컬럼명2)]
--  AS
--  Subquery;
-- ------------------------------------------------------

DROP TABLE myemp_hire;

CREATE 
    TABLE myemp_hire AS
SELECT          --서브 쿼리
    empno,
    ename,
    hiredate,
    sal
FROM
    emp
WHERE
    1=2;        --스키마만 복사(데이터는 x)

DESC myemp_hire;

DROP TABLE myemp_mgr;

CREATE 
    TABLE myemp_mgr AS
SELECT          --서브쿼리
    empno,
    ename,
    mgr
FROM
    emp
WHERE
    1 = 2;      --스키마만 복사

DESC myemp_mgr;

--무조건 INSERT ALL 문장(when절이 없다.)
--주의 사항: values절에 사용된 컬럼명과, 서브쿼리에서 사용된
--컬럼명이 무조건 동일해야됨.
INSERT ALL
    INTO myemp_hire VALUES(empno, ename, hiredate, sal)
    INTO myemp_mgr  VALUES(empno, ename, mgr)
    SELECT      --서브쿼리
        empno,
        ename,
        hiredate,
        sal,
        mgr
    FROM
        emp;

SELECT
    *
FROM
    myemp_hire;

SELECT
    *
FROM
    myemp_mgr;


-- ------------------------------------------------------
-- 1-3-2. 조건 INSERT ALL 문
-- ------------------------------------------------------

-- ------------------------------------------------------
-- (1) 기존 테이블을 이용하여, 새로운 테이블 생성 (CTAS)
-- ------------------------------------------------------
-- * CTAS: 기존 테이블 스키마 복사 시, NOT NULL 제약조건을 제외
--         한, 그 외 제약조건은 복사되지 않음.
-- ------------------------------------------------------
-- Basic Syntax) 
--
--  CREATE TABLE 테이블명 [(컬럼명,컬럼명2)]
--  AS
--  Subquery;
-- ------------------------------------------------------
CREATE
    TABLE myemp_hire2 AS
SELECT
    empno,
    ename,
    hiredate,
    sal
FROM
    emp
WHERE
    1 = 2;

DESC myemp_hire2;

CREATE 
    TABLE myemp_mgr2 AS
SELECT          --서브쿼리
    empno,
    ename,
    mgr
FROM
    emp
WHERE
    1 = 2;      --스키마만 복사

DESC myemp_mgr2;

-- ------------------------------------------------------
-- (2) 조건 INSERT ALL 문장 수행
-- ------------------------------------------------------
-- (**주의사항**) VALUES 절에 사용된 컬럼명과 Subquery에서
--      사용된 컬럼명이 반드시 동일해야 함.
-- ------------------------------------------------------
INSERT ALL
    WHEN sal > 3000 THEN
        INTO myemp_hire2 VALUES(empno, ename, hiredate, sal)
    WHEN mgr = 7698 THEN
        INTO myemp_mgr2  VALUES(empno, ename,mgr)
    SELECT
        empno,
        ename,
        hiredate,
        sal,
        mgr
    FROM
        emp;

SELECT
    *
FROM
    myemp_hire2;

SELECT
    *
FROM
    myemp_mgr2;


-- ------------------------------------------------------
-- 1-3-3. 조건 INSERT FIRST 문
-- ------------------------------------------------------

-- ------------------------------------------------------
-- (1) 기존 테이블을 이용하여, 새로운 테이블 생성 (CTAS)
-- ------------------------------------------------------
-- * CTAS: 기존 테이블 스키마 복사 시, NOT NULL 제약조건을 제외
--         한, 그 외 제약조건은 복사되지 않음.
-- ------------------------------------------------------
-- Basic Syntax) 
--
--  CREATE TABLE 테이블명 [(컬럼명,컬럼명2)]
--  AS
--  Subquery;
-- ------------------------------------------------------

CREATE
    TABLE myemp_hire3 AS
SELECT
    empno,
    ename,
    hiredate,
    sal
FROM
    emp
WHERE
    1 = 2;

DESC myemp_hire3;

CREATE 
    TABLE myemp_mgr3 AS
SELECT          --서브쿼리
    empno,
    ename,
    mgr
FROM
    emp
WHERE
    1 = 2;      --스키마만 복사

DESC myemp_mgr3;

-- ------------------------------------------------------
-- (2) 조건 INSERT *FIRST* 문장 수행
-- ------------------------------------------------------
-- (**주의사항**) VALUES 절에 사용된 컬럼명과 Subquery에서
--      사용된 컬럼명이 반드시 동일해야 함.
-- ------------------------------------------------------
INSERT ALL
    --sal = 800인 사원은 아래 두 when절의 조건식을 모두 만족.
    --이때, 첫번째 WHEN절에서만 insert가 수행되고, 
    --두번째 WHEN절은 설령 조건이 참이어도, INSERT는 수행되지않음.
    WHEN sal = 800 THEN
        INTO myemp_hire3 VALUES(empno, ename, hiredate, sal)
    WHEN sal < 2500 THEN
        INTO myemp_mgr3 VALUES(empno, ename, mgr)
    SELECT
        empno,
        ename,
        hiredate,
        sal,
        mgr
    FROM
        emp;

SELECT
    *
FROM 
    myemp_hire3;


SELECT
    *
FROM
    myemp_mgr3;



------------------------------------------------
SELECT
    m.empno,
    m.ename,
    m.mgr,
    e.sal
FROM
    myemp_mgr3 m JOIN emp e
    on m.empno = e.empno;

-------------------------------------------------
SELECT
    empno,
    m.ename,
    m.mgr,
    e.sal
FROM
    myemp_mgr3 m JOIN emp e
    USING(empno);