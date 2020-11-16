-- ------------------------------------------------------
-- 2. UPDATE 문
-- ------------------------------------------------------
--  가. 테이블에 저장된 데이터 수정.
--  나. 한 번 수행으로, 여러 개의 행들을 수정할 수 있음.
--  다. WHERE 절은 *생략가능* (일반적이지 않음)
--      이 경우엔, 해당 테이블의 모든 데이터가 수정됨.
-- ------------------------------------------------------
-- Basic Syntax)
--
--  UPDATE 테이블명     -- 변경(수정)할 테이블명 지정.
--  SET                -- 변경할 한개 이상의 컬럼명=값 형식 지정
--      컬럼명1 = 변경값1,
--      [컬럼명2 = 변경값2],
--      ...
--      [컬럼명n = 변경값n]
--  [WHERE 조건식];
--
-- ------------------------------------------------------
-- * Please refer to the chapter 07, page N.
-- ------------------------------------------------------

SELECT
    *
FROM
    mydept;

UPDATE
    mydept
SET
    dname = '영업',
    loc = '경기'
WHERE
    deptno = 40;

-- ------------------------------------------------------
-- 2-1. 서브쿼리(=부속질의)를 이용한 UPDATE 문
-- ------------------------------------------------------
--  가. UPDATE의 SET 절에서 서브쿼리를 이용하면, 서브쿼리의 실행
--      결과값으로, 테이블 수정가능.
--  나. 이 문장으로, 기존 다른 테이블의 데이터를 이용하여, 혀재
--      지정 테이블의 특정 컬럼값의 변경이 가능.  
-- ------------------------------------------------------
-- Basic Syntax)
--
--  UPDATE 테이블명     -- 변경(수정)할 테이블명 지정.
--  SET                -- 변경할 한개 이상의 컬럼명=값 형식 지정
--      컬럼명1 = (Sub-query 1),    -- 서브쿼리 결과로 컬럼변경
--     [컬럼명2 = (Sub-query 2)],
--      ...
--     [컬럼명n = (Sub-query N)]
--  [WHERE 조건식];
--
-- ------------------------------------------------------
-- Please refer to the chap07, page 30.
-- ------------------------------------------------------

UPDATE
    mydept
SET
    dname = (
        SELECT
            dname
        FROM
            dept
        WHERE
            deptno = 10
    ),
    loc = (
        SELECT
            loc
        FROM
            dept
        WHERE
            deptno=20
    )
WHERE
    deptno = 40;

-- ------------------------------------------------------
-- 3. DELETE 문
-- ------------------------------------------------------
--  가. 테이블에 저장된 데이터 삭제.
--  나. 한번에 여러 행들을 삭제가능.
--  다. WHERE 절은 *생략가능* (**주의**)
--      생략하면, 지정 테이블의 모든 데이터(행)가 삭제됨.
-- ------------------------------------------------------
-- Basic Syntax)
--
--  DELETE FROM 테이블명    -- 데이터를 삭제할 테이블 지정
--  [WHERE 조건식];         -- 조건이 참인 행들만 삭제
-- 
-- ------------------------------------------------------
-- * Please refer to the chapter 07, page N.
-- ------------------------------------------------------

-- ------------------------------------------------------
-- BEGIN       -- To start a transaction.

    DELETE FROM mydept
    WHERE deptno = 30;


    -- TCL: Transaction Control Language.
    ROLLBACK;       -- To roll back all changes.
    -- COMMIT;      -- To save all changes permenantly.

-- END;        -- To end a transaction.
-- ------------------------------------------------------


-- ------------------------------------------------------
-- 3-1. 서브쿼리(=부속질의)를 이용한 DELETE 문
-- ------------------------------------------------------
--  가. DELETE 문의 WHERE 절에서, 서브쿼리 사용.
--  나. 서브쿼리의 실행 결과값으로, 테이블의 데이터 삭제가능.
--  다. 이 방법을 사용하면, 기존 테이블에 저장된 데이터를 사용하여,
--      현재 테이블의 특정 데이터 삭제가능.
--  라. 서브쿼리의 실행결과 값의 개수와 타입이, 메인쿼리의 WHERE절
--      에 지정된 조건식의 컬럼의 개수와 타입이 반드시 동일해야 함.
-- ------------------------------------------------------
-- Basic Syntax)
--
--  DELETE FROM 테이블명        -- 데이터를 삭제할 테이블 지정
--  [ WHERE <**Sub-query**> ]; -- 조건이 참인 행들만 삭제
--
-- ------------------------------------------------------
-- Please refer to the chap07, page 33.
-- ------------------------------------------------------

-- BEGIN       -- To start a transaction.

DELETE FROM
    mydept
WHERE
    loc = (
        SELECT
            loc
        FROM
            dept
        WHERE
            deptno = 20
    );

    -- 다중컬럼 조건식 지정 (Pairwise 방식)
    -- WHERE (loc, dname) = (
    --     SELECT loc, dname
    --     FROM dept
    --     WHERE deptno = 20
    -- );

ROLLBACK;

-- END;        -- To end a transaction.
-- ------------------------------------------------------

SELECT
    *
FROM
    mydept;

-- ------------------------------------------------------
-- 4. MERGE 문
-- ------------------------------------------------------
--  가. 스키마(구조)가 같은 두 개의 테이블을 비교하여,
--  나. 하나의 테이블로 합침.
--  다. INTO 절 -> 병합결과가 저장될 테이블명 지정.
--  라. USING 절 -> 병합할 대상 테이블/뷰/서브쿼리 지정.
--  마. ON 절 -> INTO 절의 테이블1과 USING 절의 테이블2 간의
--               조인조건 지정.
--  바. WHERE 절로 조건지정 가능.
--  사. DELETE 문도 사용가능.
--  아. ** 앞의 INSERT/UPDATE/DELETE문과의 차이점:
--      저장 또는 수정 대상 테이블을 INTO 절에 지정.
--  자. 응용분야:
--      대표적인 경우, 전자상거래의 물품판매회사가,
--      월별로 판매현황관리, 연말에 월별판매현황 데이터 병합
-- ------------------------------------------------------
-- Basic Syntax)
--
--  MERGE INTO 테이블1 별칭
--      USING (테이블명2 | 뷰 | 서브쿼리) 별칭
--      ON (조인조건)
--
--      --------------------------------------
--      (1) 조인 조건식이 일치(참이면)하면...
--      --------------------------------------
--      WHEN MATCHED THEN
--          --------------------------------------
--          -- (1-1). MERGE 테이블의 기존 데이터 변경(갱신).
--          --------------------------------------
--          UPDATE SET
--              컬럼명1 = 값1,
--              ...
--              컬럼명n = 값n
--          [WHERE 조건식]
--
--          --------------------------------------
--          -- (1-2). MERGE 테이블의 기존 데이터 삭제.
--          --------------------------------------
--          [DELETE WHERE 조건식]
--
--      --------------------------------------
--      (2) 조인 조건식이 비일치(거짓이면)하면 ...
--      --------------------------------------
--      WHEN NOT MATCHED THEN
--          --------------------------------------
--          -- (2-1). MERGE 테이블에 새로운 데이터 생성.
--          --------------------------------------
--          INSERT (컬럼목록)
--          VALUES (값목록)
--          [WHERE 조건식];
-- 
-- ------------------------------------------------------
-- * Please refer to the chapter 07, page 34.
-- ------------------------------------------------------

-- ------------------------------------------------------
-- 4-1. 실습용 테이블 및 데이터 생성.
-- ------------------------------------------------------

CREATE TABLE pt_01 (
    판매번호    VARCHAR2(8),
    제품번호    NUMBER,
    수량        NUMBER,
    금액        NUMBER
);  --pt_01

CREATE TABLE pt_02 (
    판매번호    VARCHAR2(8),
    제품번호    NUMBER,
    수량        NUMBER,
    금액        NUMBER
);  --pt_02

CREATE TABLE p_total(
    판매번호    VARCHAR2(8),
    제품번호    NUMBER,
    수량        NUMBER,
    금액        NUMBER
);  --p_total

INSERT INTO pt_01 VALUES('20170101', 1000, 10, 500);
INSERT INTO pt_01 VALUES('20170102', 1001, 10, 400);
INSERT INTO pt_01 VALUES('20170103', 1002, 10, 300);

INSERT INTO pt_02 VALUES('20170201', 1003, 5, 500);
INSERT INTO pt_02 VALUES('20170202', 1004, 5, 400);
INSERT INTO pt_02 VALUES('20170203', 1005, 5, 300);

COMMIT;

SELECT *
FROM pt_01;

SELECT *
FROM pt_02;


-- ------------------------------------------------------
-- 4-2. MERGE 문 수행 #1
-- ------------------------------------------------------
TRUNCATE TABLE p_total;

MERGE INTO p_total total   --MERGE결과 저장 테이블 지정.
    --MERGE대상 테이블 지정(ALIAS 가능, 이때, AS키워드 사용 불가)
    USING
        pt_01 p01
        ON (total.판매번호 = p01.판매번호)  --동등 조인 조건

        --JOIN조건에 일치하는 행들은...
        --p01을 이용하여, total의 데이터를 변경(갱신)
        WHEN MATCHED THEN
            UPDATE SET
                total.제품번호 = p01.제품번호
        
        --JOIN조건에 일치하지 않는 행들은...
        --p01을 이용하여, total의 데이터를 신규생성
        WHEN NOT MATCHED THEN
            INSERT 
                VALUES(p01.판매번호, p01.제품번호, p01.수량, p01.금액);


SELECT * FROM pt_01;

SELECT * FROM p_total;

---------------------------------------------------------------
MERGE INTO p_total total
    USING pt_02 p02
    ON(total.판매번호 = p02.판매번호)
    WHEN MATCHED THEN
        UPDATE SET
            total.제품번호 = p02.제품번호
    WHEN NOT MATCHED THEN
        INSERT
            VALUES(p02.판매번호, p02.제품번호, p02.수량, p02.금액);

SELECT * FROM pt_02;

SELECT * FROM p_total;

COMMIT;