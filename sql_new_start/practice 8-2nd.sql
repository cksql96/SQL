-- ------------------------------------------------------
-- 4. 테이블 변경
-- ------------------------------------------------------
-- 가. 생성된 테이블의 구조를 변경
--     a. 컬럼의 추가/삭제
--     b. 컬럼의 타입/길이 변경
--     c. 컬럼의 제약조건 추가/삭제
-- 나. ALTER TABLE 문장 사용
-- 다. 테이블의 구조변경은 기존 저장된 데이터에 영향을 주게 됨
-- ------------------------------------------------------
CREATE TABLE emp04
AS
SELECT * FROM emp;

DESC emp04;

-- ------------------------------------------------------
-- (1) 컬럼 추가 (ALTER TABLE ADD 문장)
-- ------------------------------------------------------
-- a. 기존 테이블에 새로운 컬럼 추가
-- b. 추가된 컬럼은, 테이블의 마지막에 추가
-- c. 데이터는 자동으로 null 값으로 저장됨
-- d. DEFAULT 옵션 설정도 가능
-- ------------------------------------------------------
-- Basic Syntax:
--
--  ALTER TABLE 테이블명
--  ADD ( 컬럼명1 데이터타입 [, ..., 컬럼명n 데이터타입] );
-- ------------------------------------------------------
ALTER TABLE
    emp04
ADD(
    email VARCHAR2(10), 
    address VARCHAR2(20)
);

desc emp04;

-- ------------------------------------------------------
-- (2) 컬럼 변경 (ALTER TABLE MODIFY 문장)
-- ------------------------------------------------------
-- a. 기존 테이블에 기존 컬럼 변경
-- b. 컬럼의 타입/크기/DEFAULT값 변경가능
--    숫자/문자 컬럼의 전체길이의 증가/축소, 타입변경도 가능
-- c. DEFAULT 값 변경의 경우, 이후 입력되는 행에 대해서만 적용
-- ------------------------------------------------------
-- Basic Syntax:
--
--  ALTER TABLE 테이블명
--  MODIFY ( 컬럼명1 데이터타입 [, ..., 컬럼명n 데이터타입] );
-- ------------------------------------------------------
ALTER TABLE
    emp04
MODIFY (
    email VARCHAR2(40)
);

-- ------------------------------------------------------
-- (2) 컬럼 삭제 (ALTER TABLE DROP 문장)
-- ------------------------------------------------------
-- a. 기존 테이블에 기존 컬럼 삭제
-- b. 컬럼은 값의 존재여부와 상관없이, 무조건 삭제됨
-- c. 동시에 여러 컬럼삭제가 가능
-- d. 최소한 1개의 컬럼은 반드시 존재해야 됨
-- ------------------------------------------------------
-- Basic Syntax:
--
--  ALTER TABLE 테이블명
--  DROP ( 컬럼명1, [컬럼명n] );
-- ------------------------------------------------------
ALTER TABLE
    emp04
DROP(
    email
);
desc emp04;

-- ------------------------------------------------------
-- 5. 제약조건 추가 (ALTER TABLE 문장)
-- ------------------------------------------------------
-- 가. 기존 테이블에 제약조건 추가
-- 나. PK/FK/UK/CK 제약조건 추가 -> ALTER TABLE ADD 문 사용
-- 다. NN 제약조건 추가 -> ALTER TABLE MODIFY 문 사용
-- 라. 기존 테이블에 추가적인 제약조건도 추가 가능
-- ------------------------------------------------------
-- Basic Syntax:
--
--  ALTER TABLE 테이블명
--  ADD [CONSTRAINT 제약조건명] 제약조건타입(컬럼명);
-- ------------------------------------------------------


-- ------------------------------------------------------
-- (1) PRIMARY KEY 제약조건 추가
-- ------------------------------------------------------
CREATE TABLE dept03 (
    deptno  NUMBER(2),
    dname   VARCHAR2(15),
    loc     VARCHAR2(15)
);

DESC dept03;

--테이블에 제약조건 추가
ALTER TABLE
    dept03
ADD 
    CONSTRAINT dept03_deptno_pk PRIMARY KEY(deptno);
    --dpetno에, PRIMARY KEY를 준다.

SELECT
    table_name,
    constraint_type,
    constraint_name,
    r_constraint_name
FROM
    user_constraints
WHERE
    table_name IN('DEPT03');

-- ------------------------------------------------------
-- (2) NOT NULL 제약조건 추가 (CK/PK/FK 제약조건 추가도 동일)
-- ------------------------------------------------------
-- Basic Syntax:
--
--  ALTER TABLE 테이블명
--  MODIFY ( 컬럼명 데이터타입 [CONSTRAINT 제약조건명] NOT NULL );
-- ------------------------------------------------------
DESC dept03;

ALTER TABLE
    dept03
MODIFY(
    dname VARCHAR2(15)  CONSTRAINT dept03_dname_nn NOT NULL
);

SELECT
    table_name,
    constraint_type,
    constraint_name,
    r_constraint_name
FROM
    user_constraints
WHERE
    table_name IN('DEPT03');

-- ------------------------------------------------------
-- 6. 제약조건 삭제 (ALTER TABLE DROP 문)
-- ------------------------------------------------------
--  가. 제약조건명 이용
--      USER_CONSTRAINTS, USER_CON_COLUMNS 조회하여,
--      제약조건명 조회
--  나. CASCADE 옵션
--      모든 종속적인 제약조건을 같이 삭제
--  다. 기본적으로, 제약조건명을 이용하여, 제약조건 삭제
--  라. 기본키(PK)와 UNIQUE(UK) 제약조건명 없이, 
--      키워드만 사용하여 삭제가능
--      NN/CK/FK 제약조건 삭제 -> CONSTRAINT 제약조건명 지정하여 삭제
-- ------------------------------------------------------
-- Basic Syntax:
--
--  ALTER TABLE 테이블명
--  DROP PRIMARY KEY | UNIQUE(컬럼) | CONSTRAINT 제약조건명 [CASCADE];
-- ------------------------------------------------------

-- ------------------------------------------------------
-- (1) PK 제약조건 삭제 (2가지 방법 하지만 1번 방법을 해라)
-- ------------------------------------------------------
--1st
ALTER TABLE
    dept03
DROP
    PRIMARY KEY;

--2nd
ALTER TABLE 
    dept03
DROP 
    CONSTRAINT dept03_deptno_pk;

-- ------------------------------------------------------
-- (2) NN 제약조건 삭제
-- ------------------------------------------------------
ALTER TABLE
    dept03
DROP
    CONSTRAINT dept03_dname_nn;


SELECT
    table_name,
    constraint_type,
    constraint_name,
    r_constraint_name
FROM
    user_constraints
WHERE
    table_name IN('DEPT03');

-- ------------------------------------------------------
-- (3) CASCADE 옵션 적용
-- ------------------------------------------------------
CREATE TABLE dept05 (
    deptno  NUMBER(2)       CONSTRAINT dept05_deptno_pk PRIMARY KEY,
    dname   VARCHAR2(15),
    loc     VARCHAR2(15)
);

INSERT INTO
    dept05(deptno, dname, loc)
VALUES
    (10, '인사', '서울');

COMMIT;
------------------------

CREATE TABLE emp05 (
    empno   NUMBER(4)       CONSTRAINT emp05_empno_pk PRIMARY KEY,
    ename   VARCHAR2(15),
    deptno  NUMBER(2)       CONSTRAINT emp05_deptno_fk REFERENCES dept05(deptno)
);

INSERT INTO 
    emp05 (empno, ename, deptno) 
VALUES 
    (1000, 'John', 10);

COMMIT;

-- 참조키에 의한 기본 키 삭제 불가
-- 자식테이블에서 부모테이블을 참조하고 있는 경우, 부모테이블의 
-- 기본키(PK)를 삭제하면, 에러가 발생

-- ORA-02273: this unique/primary key is referenced by some foreign keys
ALTER TABLE
    dept05
DROP
    PRIMARY KEY;

-- 부모테이블의 PK/UK 제약조건 삭제시, 자식테이블의 FK 제약조건을 연쇄삭제위해 
-- CASCADE 옵션 사용
ALTER TABLE 
    dept05
DROP 
    PRIMARY KEY CASCADE;


-- ------------------------------------------------------
-- 7. 제약조건 활성화/비활성화
-- ------------------------------------------------------
--  가. 기존 테이블의 제약조건을 필요에 의해 Enable/Disable 가능
--  나. 제약조건은 데이터의 무결성은 보장받을 수 있으나,
--      성능은 떨어뜨림
--  다. 예: 데이터의 무결성이 보장되는 방대한 데이터를, 테이블에
--          저장시 사용 
-- ------------------------------------------------------
-- Basic Syntax:
--
--  ALTER TABLE 테이블명
--  DISABLE | ENABLE CONSTRAINT 제약조건명 [CASCADE];
--
--  * ENABLE: 제약조건 활성화
--  * DISABLE: 제약조건 비활성화
--  * CASCADE: 해당 제약조건과 관련된 모든 제약조건을 연쇄적으로 비활성화
-- ------------------------------------------------------

-- PK 제약조건 비활성화
ALTER TABLE
    emp05
DISABLE
    CONSTRAINT emp05_empno_pk;

SELECT
    table_name,
    constraint_type,
    constraint_name,
    status
FROM
    user_constraints
WHERE
    table_name IN ('EMP05');

-- ------------------------------------------------------

-- PK 제약조건 활성화
ALTER TABLE
    emp05
ENABLE
    CONSTRAINT emp05_empno_pk;

-- ------------------------------------------------------
-- 8. 데이터 사전(Data Dictionary View) 3종류
-- ------------------------------------------------------
-- (1) DBA_XXXX : 데이터베이스 관리자만 접근가능한 객체 등의 정보조회
-- (2) ALL_XXXX : 자신계정 소유 또는 권한을 부여받은 객체 등에 관한 정보조회
-- (3) USER_XXXX: 자신의 계정이 소유한 객체 등에 관한 정보조회
-- ------------------------------------------------------

-- ------------------------------------------------------
-- * 데이터 사전(Data Dictionary View)에 저장되는 정보 *
-- ------------------------------------------------------
--  가. DB의 물리적 구조 또는 객체의 논리적 구조
--  나. Oracle 사용자와 스키마 객체명
--  다. 각 사용자에게 부여된 권한과 롤(role)
--  라. 무결성 제약조건
--  마. 컬럼 기본값
--  바. 스키마 객체에 할당된 영역의 크기와
--      현재 사용중인 영역의 크기
--  사. DB 이름/버전/생성날짜/시작모드/인스턴스명 같은 일반정보
-- ------------------------------------------------------