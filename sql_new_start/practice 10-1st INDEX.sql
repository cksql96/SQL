-- ------------------------------------------------------
-- Index (인덱스)
-- ------------------------------------------------------
--  가. 데이터베이스 성능에서 매우 중요한 역할 담당
--  나. 단순컬럼 또는 복합컬럼에 대해 인덱스 객체 생성가능
--  다. 인덱스 객체 안에는 크게 아래의 두가지 정보를 가지고 있음:
-       (1) ROWID - 테이블의 각 행의 논리적인 주소값 저장
--      (2) 단순/복합 컬럼 - 인덱스를 생성한 컬럼 데이터
--  라. 실제 데이터(각 행)의 논리적 주소인 ROWID를 사용하면,
--      Table Full Scan 방식이 아닌, Index Scan 방식을 사용하여,
--      검색된 데이터를 테이블에서 랜덤하게 블록에서 접근가능.
--  마. ROWID(각 행의 논리적 주소값)를 저장하고 있는 오라클 객체가 인덱스임
--  바. 인덱스 안의 ROWID 정보를 이용하여, 필요한 데이터를 검색하는 방식
--      이를, Index Scan 이라 한다.
--  사. 인덱스는 ROWID + Column Datas 를, B-tree 구조로 저장
--      (B-tree.jpg 이미지 참고)
-- ------------------------------------------------------
--  * 사전 필요지식:
--    a. Oracle Block
--      - 가장 최소단위의 논리적인 구조, 입출력(I/O) 단위
--      - 기본크기: 8KB (설정으로 조정가능)
--      - ***실제 데이터(행들)를 block 단위로 관리***
--      - 각 block 마다, **고유한 아이디(id)** 부여 (= block id)
--      - 한 block 내에, 최대크기(8kb)내에서, **여러 행들 저장**
--      - 한 block 내의 각 행들에, **고유한 행번호** 부여 (= row id)
--    b. Table Full Scan 방식 (Index 객체가 없거나, 사용하지 않을 때)
--      - 검색할 모든 데이터(행들)를 접근하기 위해, 
--        처음부터 끝까지 **모든 block들을 검색**
--    c. Index Scan 방식 (Index 객체를 사용하여, 실제 데이터에 접근)
--      - 검색된 데이터(행들)을 가장 빠르게 찾는 방법
--      - 블록 아이디(block id)와 행번호(row id) 이용해서,
--        검색된 데이터(행들)에 접근
--    d. 검색된 데이터(행들)를 제대로 접근(access)하기 위해서는,
--       아래의 **4가지 정보가 반드시 필요** :
--      (1) 파일 아이디 - 어느 *.dbf 파일에 저장되어 있는가?
--          - 실제 데이터가 저장되어 있는 물리적인 파일
--          - 각 DBF 파일마다, **파일 아이디** 부여 (식별위해)
--          - $ORACLE_HOME/oradata/<cdbname>/*.dbf
--          - $ORACLE_HOME/oradata/<cdbname>/<pdbname>/*.dbf
--          - 테이블들 저장
--      (2) 객체 아이디 - 어느 table 에 저장되어 있는가?
--          - 각 테이블 마다, **객체 아이디** 부여 (식별위해)
--          - 테이블 내에, 실제 데이터가 최종적으로 저장/관리됨
--      (3) 블록 아이디 - 어느 blocks 에 저장되어 있는가?
--          - 각 테이블 내의 실제 데이터(행들)는, 다시
--            해당 테이블의 최소 입/출력 단위인, block 내에 저장됨
--          - 각 block 마다, **block id** 부여 (식별위해)
--      (4) 행 번호 - 찾은 blocks 내에서, 몇번 째로 저장되어 있는가?
--          - 각 block 내에는, 최대8kb 내에서, 여러행 들 저장
--          - 각 block 내의 각 행마다, **row num** 부여 (식별위해)
--    e. ROWID (의사컬럼) - 각 행의 논리적인 주소를 가진 의사컬럼
--      - 위 d 의 4가지 정보(파일아이디/객체아이디/블록아이디/행번호)를 가지고 있음
--      - 인덱스(Index) 객체가 ROWID 를 하나의 요소로 가지고 있음
--      - 인덱스는 안에 있는 ROWID를 이용하여, 검색된 데이터를 빠르게 접근가능
-- ------------------------------------------------------

SELECT
    ROWID,
    ROWNUM,
    empno
FROM
    emp;

-- ------------------------------------------------------
-- 1. Index 생성
-- ------------------------------------------------------
--  가. 빠른 데이터 검색을 위해 존재하는 오라클 객체
--  나. 명시적으로 생성하지 않아도, 자동 생성되기도 함
--      (PK/UK 제약조건 생성시, Unique Index 자동생성)
--  다. PK/UK 제약조건에 따른, 자동생성 Unique Index:
--      a. 데이터 무결성을 확인하기 위해, 수시로 데이터 검색 필요
--      b. 따라서, 빠른 검색이 요구됨
--  라. 명시적인 인덱스 생성이 우리가 할 일!!!
-- ------------------------------------------------------
-- Basic syntax:
--
--  CREATE [UNIQUE] INDEX 인덱스명
--  ON 테이블(컬럼1[, 컬럼2, ...]);
--
--
--  (1) Unique Index
--      a. CREATE UNIQUE INDEX 문으로 생성한 인덱스
--      b. Index 내의 Key Columns에 중복값 허용하지 않음
--      c. 성능이 가장 좋은 인덱스
--      d. (*주의*) 중복값이 허용되는 테이블 컬럼에는 절대로 사용불가!!
--
--  (2) Non-unique Index
--      a. CREATE INDEX 문으로 생성한 인덱스
--      b. 중복값이 허용되는 테이블 컬럼에 대해,
--         일반적으로 생성하는 인덱스
-- ------------------------------------------------------

-- Index 없이, Table Full Scan 방식을 통한, 데이터 조회

SELECT 
    *
FROM
    emp
WHERE
    ename = 'WARD';


-- 특정 쿼리의 실행계획(Execute Plan) 보기 
-- (반드시, Oracle SQL*Developer에서 수행)

-- DQL 문장에 대해, 실행계획 생성
EXPLAIN PLAN
    SET
        statement_id = 'ex_plan1'
        INTO plan_table
FOR
    SELECT
        *
    FROM
        emp
    WHERE
        ename = 'WARD';

-- 생성된 실행계획 정보 출력
DESC plan_table;            -- 실행계획 저장 테이블 스키마 보기

SELECT *
FROM plan_table;            -- 실행계획 테이블 모두 조회
-------------------------------------------------
SELECT * 
FROM table( DBMS_XPLAN.display() );

SELECT plan_table_output
FROM table( DBMS_XPLAN.display() );

SELECT plan_table_output
  FROM table( DBMS_XPLAN.display(NULL,'ex_plan1', 'BASIC') );

SELECT cardinality "Rows",
   lpad(' ', level-1)||operation||' '||options||' '||object_name "Plan"
FROM plan_table
CONNECT BY
    prior id = parent_id
    AND prior statement_id = statement_id
START WITH id = 0
    AND statement_id = 'ex_plan1'
ORDER BY
    id;

-- ------------------------------------------------------
-- Index 생성하여, Index Scan 방식을 통한 데이터 조회
DROP INDEX emp_ename_idx;

CREATE INDEX 
    emp_ename_idx
ON 
    emp(ename);

-- 특정 쿼리의 실행계획(Execute Plan) 보기 
-- (반드시, Oracle SQL*Developer에서 수행)

-- DQL 문장에 대해, 실행계획 생성
EXPLAIN PLAN
    SET statement_id = 'ex_plan2'
    INTO plan_table
FOR
    SELECT *
    FROM emp
    WHERE ename = 'WARD';

-- 생성된 실행계획 정보 출력
DESC plan_table;            -- 실행계획 저장 테이블 스키마 보기

SELECT *
FROM plan_table;            -- 실행계획 테이블 모두 조회

SELECT * 
FROM table( DBMS_XPLAN.display() );

SELECT plan_table_output
FROM table( DBMS_XPLAN.display() );

SELECT plan_table_output
  FROM table( DBMS_XPLAN.display(NULL,'ex_plan2', 'BASIC') );

SELECT cardinality "Rows",
   lpad(' ', level-1)||operation||' '||options||' '||object_name "Plan"
FROM plan_table
CONNECT BY
    prior id = parent_id
    AND prior statement_id = statement_id
START WITH id = 0
    AND statement_id = 'ex_plan2'
ORDER BY
    id;

-- sample3.sql


-- ------------------------------------------------------
-- 2. USER_INDEXES 데이터 사전
-- ------------------------------------------------------
--  가. 생성된 인덱스의 정보 저장
-- ------------------------------------------------------
DESC user_indexes;

-- USER_INDEXES 데이터 사전조회 (emp, dept table의 인덱스 정보)
SELECT 
    index_name, 
    table_name
FROM 
    user_indexes
WHERE 
    table_name IN ('EMP', 'DEPT');


-- ------------------------------------------------------
-- 3. USER_IND_COLUMNS 데이터 사전
-- ------------------------------------------------------
--  가. 생성된 인덱스의 정보 저장
--  나. 인덱스가 생성된 테이블의 컬럼에 대한 정보까지 저장
-- ------------------------------------------------------
DESC user_ind_columns;

-- USER_IND_COLUMNS 데이터 사전조회 (emp, dept table의 인덱스 정보)
SELECT 
    index_name, 
    table_name, 
    column_name
FROM 
    user_ind_columns
WHERE 
    table_name IN ('EMP','DEPT');

-- ------------------------------------------------------
-- 4. Index 적용시점
-- ------------------------------------------------------
--  가. Index 를 사용하면, 검색속도 향상 기대가능
--  나. (**주의1**)index 를 사용한다고, 무조건 검색속도가 향상되는 것은 아님!!
--      - 한 테이블에 너무 많은 인덱스를 생성하면, 오히려 성능저하 발생!!
--  다. (**주의2**) 컬럼의 NULL 값은, 해당 컬럼에 인덱스 생성시, 인덱스에 저장안됨!!
--      - 따라서, 생성된 Index의 크기가 감소가능. 
--      - 그러므로, 이런 컬럼에 인덱스 생성 권고(필요시)
--  라. (**주의3**) 테이블에 DML 작업이 많은 경우, 해당 테이블의 컬럼에 대해서
--      관련된 모든 인덱스도 함께 변경되어야 함 -> 검색/DML 속도 모두 저하!!
--      - DML 작업이 많다 > 테이블 변경이 자주발생 > 인덱스의 B트리구조가 변경
--        > 매우 큰 성능저하 발생
--  마. (**주의4**) Index 가 생성된 컬럼일지라도, 함수를 사용하여 컬럼을 가공하거나,
--      NOT과 같은 부정 논리연산자를 사용하면, Index 적용이 안됨.
-- ------------------------------------------------------

-- ------------------------------------------------------
-- 4-1. Index 적용시점 (언제 index를 생성/사용해야 하는가?)
-- ------------------------------------------------------
--  a. 테이블 데이터가 많을 때.
--  b. 특정 컬럼값의 범위가 넓을 경우.
--  c. WHERE절에 사용되는 컬럼
--  d. Join 조건에 사용되는 컬럼
--  e. DQL 쿼리결과의 크기가, 전체 데이터의 2 ~ 4 % 이내를
--     검색하는 경우
--  f. NULL 값을 많이 포함하는 컬럼의 경우
-- ------------------------------------------------------


-- ------------------------------------------------------
-- 4-2. Index 비적용시점 (언제 index를 사용하지 말아야 하는가?)
-- ------------------------------------------------------
--  a. 테이블 데이터가 적을 때.
--  b. 특정 컬럼값의 범위가 좁을 경우.
--  c. WHERE절에 사용되는 컬럼이 자주 사용되지 않는 경우.
--  d. 테이블에 DML 수행이 많은 경우.
--  e. DQL 쿼리결과의 크기가, 전체 데이터의 10 ~ 15 % 이상을
--     검색하는 경우
--  f. Index 가 생성된 컬럼이, 함수/NOT(부정) 연산자와 같이
--     사용되는 경우
-- ------------------------------------------------------

-- To create a index for emp.ename column
DROP INDEX emp_ename_idx;

CREATE INDEX emp_ename_idx
ON emp(ename);

-- To select data NOT using index for emp.empno
-- 사유) 인덱스가 걸린 컬럼에 대해서, 함수로 가공처리
SELECT *
FROM emp
WHERE to_number(empno) = 7369;

-- ------------------------------------------------------

-- 특정 쿼리의 실행계획(Execute Plan) 보기 
-- (반드시, Oracle SQL*Developer에서 수행)

-- DQL 문장에 대해, 실행계획 생성
EXPLAIN PLAN
    SET statement_id = 'ex_plan3'
    INTO plan_table
FOR
    SELECT *
    FROM emp
    WHERE to_number(empno) = 7369;


-- 생성된 실행계획 정보 출력
SELECT * 
FROM table( DBMS_XPLAN.display() );

SELECT plan_table_output
  FROM table( DBMS_XPLAN.display(NULL, 'ex_plan3', 'BASIC') );

-- ------------------------------------------------------

-- 부정 연산자 적용시 인덱스 사용불가
SELECT *
FROM emp
WHERE empno != 7369;    -- PK 컬럼에 비동등비교연산자(!=) 사용

-- 특정 쿼리의 실행계획(Execute Plan) 보기 
-- (반드시, Oracle SQL*Developer에서 수행)

-- DQL 문장에 대해, 실행계획 생성
EXPLAIN PLAN
    SET statement_id = 'ex_plan4'
    INTO plan_table
FOR
    SELECT *
    FROM emp
    WHERE empno != 7369;


-- 생성된 실행계획 정보 출력
SELECT * 
FROM table( DBMS_XPLAN.display() );

SELECT plan_table_output
FROM table( DBMS_XPLAN.display(NULL, 'ex_plan4', 'BASIC') );
------------------------------------------------

DROP INDEX emp_ename_idx;

CREATE INDEX emp_ename_sal_idx
ON emp(ename, sal);

SELECT
    *
FROM
    emp
WHERE
--    ename = 'WARD';                       --OK
--    sal > 1000;                           --OK
--    sal > 1000 AND comm IS NOT NULL;      --sal OK,,,, comm NO
--    comm IS NOT NULL AND sal > 1000;      --sal OK,,,, comm NO
--    sal > 1000 AND comm IS NULL;          --sal OK,,,, comm NO
--    ename LIKE 'J%';                      --OK
--    trim(ename) LIKE '%J' AND sal > 1000; --access predicates에 나온것들만 확인한다. 그러므로, sal만 OK, ename NO
    ename LIKE 'J%' AND sal > 1000;