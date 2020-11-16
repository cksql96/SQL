-- ------------------------------------------------------
-- 1. DDL (Data Definition Language)
-- ------------------------------------------------------
-- 데이터베이스 구조(= 오라클 객체)를 생성/수정/삭제하는데,
-- 사용하는 SQL문장.
-- ------------------------------------------------------
-- 가. 자동으로 COMMIT 됨. (즉, DB에 자동 영구 반영됨)
-- 나. 데이터 딕셔너리(Data Dictionary) 에 정보 저장.
-- ------------------------------------------------------
-- 다. 오라클 객체(=데이터베이스 구조)의 종류(5가지)
-- ------------------------------------------------------
--  (1) 테이블(Table) - 데이터 저장
--      기본적인 데이터 저장 단위로, 행과 열로 구성된 객체
--  (2) 인덱스(Index) - 데이터 검색성능 향상
--      테이블에 저장된 데이터의 검색 성능 향상 목적을 위한 객체
--  (3) 뷰(View) - 가상의 테이블
--      한 개 이상의 테이블의 논리적인 부분 집합을 표시할 수 있는 객체
--  (4) 시퀀스(Sequence) - 순차번호 생성기
--      테이블의 특정 컬럼값에 숫자 값 자동 생성 목적을 위한 객체
--  (5) 동의어(Synonym) - 테이블의 별칭
--      객체에 대한 동의어를 설정하기 위한 객체
-- ------------------------------------------------------
-- 라. SQL문장 종류
-- ------------------------------------------------------
--  (1) CREATE    - DB객체(= Oracle 객체) 생성
--  (2) ALTER     - DB객체(= Oracle 객체) 변경
--  (3) DROP      - DB객체(= Oracle 객체) 삭제
--  (4) RENAME    - DB객체(= Oracle 객체) 이름 변경
--  (5) TRUNCATE  - DB객체(= Oracle 객체) 정보 절삭
-- ------------------------------------------------------


-- ------------------------------------------------------
-- (1) Table 생성
-- ------------------------------------------------------
--  가. DB에서 가장 중요한 객체
--  나. 관리할 실제 데이터를 저장하는 객체
--  다. 이름은 의미있고 사용하기 쉽게 설정하는 것이 중요
-- ------------------------------------------------------
-- Basic Syntax:
-- 
--  CREATE TABLE [스키마].테이블명 (
--       컬럼명  데이터타입  [DEFAULT 값 | 제약조건][, 
--          ... ]
--  );
--
-- ------------------------------------------------------

-- ------------------------------------------------------
--  * 스키마(Schema)
-- ------------------------------------------------------
--  가. 사용자가 DB에 접근하여, 생성한 객체들의 대표이름!!
--  나. By default, 사용자 계정명과 동일하게 부여됨!!
--  다. 생성한 객체들의 소유자는 해당 객체를 생성한 사용자 계정
--  라. 다른 스키마에 속한 객체 접근은 기본적으로 불가 (접근권한필요)
--  마. 만일 다른 스키마 내의 객체에 대한 접근권한이 있다면,
--      항상 "스키마.객체" 형식으로 사용해야 됨.
--      "스키마"를 생략하면, 현재 자신의 스키마 내에서 객체 찾음
--  바. 자신의 스키마 내의 객체 접근 시에는, 스키마 이름 생략 
-- ------------------------------------------------------
--scott계정일때는 오류 x, 다른 계정일때는 오류.
--접근 권한이 있어야한다.
SELECT
    deptno,
    dname,
    loc
FROM
    SCOTT.dept;

-- ------------------------------------------------------
--  * Oracle Data Types (컬럼에 저장되는 데이터의 자료형)
-- ------------------------------------------------------
--  (1) CHAR(size)      - 고정길이 문자저장 (1<= size <= 2000, byte)
--      a. 지정길이보다 작은 데이터 입력 -> 나머지 공간은 공백으로 채워짐
--      b. 입력할 데이터 크기가 유동적 -> 공간낭비 초래
--      c. 고정크기 데이터 저장에 사용 -> 주민번호, 우편번호, 전화번호,... 
--  (2) VARCHAR2(size)  - 가변길이 문자저장 (1<= size <= 4000, byte)
--      a. 지정길이보다 작은 데이터 입력 -> 입력문자열 길이만큼만 공간할당
--      b. 저장공간을 매우 효율적으로 사용가능
--  (3) NVARCHAR2(size) - 가변길이 문자저장 (1<= size <= 4000, byte)
--  (4) NUMBER(p, s)    - 가변길이 숫자저장 (p: 전체자릿수, s: 소수점자릿수)
--      a. p: precision (정밀도), s: scale (스케일)
--  (5) DATE            - 날짜 및 시간 저장
--  (6) ROWID           - 테이블 행의 고유주소(18문자로 구성) 저장
--      a. 테이블에 실제 행이 저장되어 있는 논리적인 주소값
--      b. globally Unique value in the database
--      c. 테이블에 새로운 행이 삽입되면, 자동생성됨
--      d. 인덱스(Index) 내에 저장된 데이터임
--         실제 행이 저장된 주소값을 직접 알 수 있기 때문에, 검색속도가 빠르게 됨.
--      e. 문자구성
--         | 테이블객체 번호(6자리) | 파일 번호(3자리) | 블록 번호(6자리) | 행 번호(3자리) |
--  (7) BLOB            - 대용량 이진데이터 저장 (최대 4GB)
--      a. LOB == Large OBject (3가지: BLOB, CLOB, BFILE)
--      b. 대용량의 텍스트/바이너리 데이터 저장 (ex, 이미지, 동영상, 사운드 데이터)
--  (8) CLOB            - 대용량 텍스트데이터 저장 (최대 4GB)
--      a. 대용량의 텍스트 데이터 저장(ex, e-book)
--  (9) BFILE           - 대용량 이진데이터를 파일형태로 저장 (최대 4GB)
-- ------------------------------------------------------
SELECT
    *
FROM
    dept;

SELECT
    rowid, 
    deptno
FROM
    dept;


-- 테이블 내의 특정 행을, ROWID 값으로, 빠르게 조회가능
-- But 인덱스(index)를 통하여, 간접적으로 ROWID 사용
-- 인덱스 내에 ROWID 저장되어 있기 때문.
SELECT
    *
FROM
    dept
WHERE
    rowid = 'AAAR6uAAMAAAACHAAA';
----------------------------------------------------

CREATE TABLE employee ( --스키마, 객체명 사용가능
    empno NUMBER(4),
    ename VARCHAR2(20),
    hiredate TIMESTAMP,
    sal NUMBER(7,2)
);  --employee table 생성

-- ------------------------------------------------------
--  * Default 옵션
-- ------------------------------------------------------
-- 가. 테이블에 데이터 저장 시, 특정 컬럼에 값을 지정하지 않으면,
--     자동으로 NULL 값이 저장됨
-- 나. 컬럼에 값을 지정하지 않아도, 자동으로 기본값 입력
-- 다. NULL 값이 입력 방지
-- 라. 현재 날짜/성별 같은, 고정된 값만 가지는 컬럼에 대해 사용
-- ------------------------------------------------------

CREATE TABLE employee2 (
    empno NUMBER(4),
    ename VARCHAR2(20),
    hiredate TIMESTAMP DEFAULT sysdate,
    sal NUMBER(7,2)
);      -- DEFAULT 옵션 사용

INSERT INTO
    employee2(empno, ename, sal)
VALUES
    (10, '홍길동', 3000);

commit;

SELECT *
FROM employee2;     -- employee2 테이블 조회

-- ------------------------------------------------------
-- * 제약조건(Contraints)
-- ------------------------------------------------------
--  가. 테이블에 부적절한 데이터가 저장되는 것을 방지
--  나. 테이블 생성시, 각 컬럼에 대해서 정의하는 규칙
--  다. DB 설계단계에서, 데이터의 무결성을 보장하기 위한 수단
--  라. 예: 성별('남','여'), 부서(NULL 값이 없어야 함)
--  마. 데이터가 저장되기 전에, 무결성을 검사하여,
--      잘못된 데이터가 저장되는 것을 방지
--  바. 테이블에 행이 삽입(INSERT)/수정(UPDATE)/삭제(DELETE)
--      될 때마다 적용
--  사. 필요 시, 제약조건의 기능을 일시적으로, 
--      활성화(Enable)/비활성화(Disable) 가능
--  아. USER_CONSTRAINTS 데이터 딕셔너리에 저장
--  자. 제약조건의 종류:
--      (1) NOT NULL    - Only ( column-level )
--          a. 해당 컬럼값으로 NULL 허용하지 않는다
--      (2) UNIQUE      - Both ( column-level ) and ( table-level )
--          a. 해당 컬럼값은 항상 유일한 값을 갖는다
--          b. ( NOT NULL 허용 )
--      (3) PRIMARY KEY - Both ( column-level ) and ( table-level )
--          a. 해당 컬럼값은 반드시 존재해야 하고 유일해야 한다
--          b. ( NOT NULL + UNIQUE )
--          c. 해당 테이블에서 각 행들을 유일하게 구분해주는 식별기능
--          d. 테이블 당, 반드시 하나만 가질 수 있음
--          e. 단순/복합 컬럼으로 구성 가능
--          f. UNIQUE 성질로 인하여, 자동으로 UNIQUE INDEX 생성됨
--          g. 이 기본키를 이용한 데이터 검색은, 자동생성된 인덱스로 인하여
--             속도가 매우 빠르다
--      (4) FOREIGN KEY - Both ( column-level ) and ( table-level )
--          a. 해당 컬럼의 값이, 다른 테이블의 컬럼의 값을 참조해야 한다
--          b. 참조되는 컬럼에 없는 값은 저장이 불가능하다
--          c. ( NULL 허용 )
--      (5) CHECK       - Both ( column-level ) and ( table-level )
--          a. 해당 컬럼에 가능한, 데이터 값의 범위나 사용자 조건을 지정한다
--  차. 제약조건의 이름짓기
--      a. 명명방법: CONSTRAINT table_column_2자리제약조건종류 (*권장*)
--          - NOT NULL:     table_column_nn
--          - UNIQUE:       table_column_uk
--          - PRIMARY KEY:  table_column_pk
--          - FOREIGN KEY:  table_column_fk
--          - CHECK:        table_column_ck
--      b. 제약조건명으로, 기능을 활성화/비활성화 할 수 있음
--      c. 제약조건명을 직접 지정하지 않으면, 오라클이 자동으로 명명함
--      d. Oracle의 제약조건명 형식: Prefix(SYS_) + 자동이름
-- ------------------------------------------------------
-- * Column-level: 테이블 생성시,
--  가. 각 컬럼을 정의하면서, 같이 제약조건을 지정하는 방법
-- ------------------------------------------------------
-- Basic Syntax:
--
--  CREATE TABLE [스키마].테이블명(
--      컬럼명 데이터타입  [ CONSTRAINT 제약조건명 ]  PRIMARY KEY,
--      컬럼명 데이터타입,
--      ...
--  );
-- ------------------------------------------------------
CREATE TABLE department(
    deptno  NUMBER(2)    CONSTRAINT department_deptno_pk PRIMARY KEY,
    dname   VARCHAR2(15),
    loc     VARCHAR2(15)
);

DESC department;

SELECT *
FROM USER_CONSTRAINTS;

-- ------------------------------------------------------
-- * Table-level: 테이블 생성시,
--  가. 모든 컬럼을 정의하고, 맨 마지막에 제약조건을 추가하는 방법
--  나. 하나의 컬럼에 여러 개의 제약조건을 부여할 경우에 사용
-- ------------------------------------------------------
-- Basic Syntax:
--
--  CREATE TABLE [스키마].테이블명 (
--      컬럼명1 데이터타입,
--      ...
--      컬럼명n 데이터타입,
--      [CONSTRAINT 제약조건명] PRIMARY KEY(컬럼명[,컬럼명2, ...])
--  );
-- ------------------------------------------------------
CREATE TABLE department2 (
    deptno  NUMBER(2),
    dname   VARCHAR2(15),
    loc     VARCHAR2(15),

    CONSTRAINT department2_deptno_pk PRIMARY KEY(deptno)
);

-- ------------------------------------------------------
-- USER_CONSTRAINTS 데이터 사전
-- ------------------------------------------------------
-- 특정 테이블의 제약조건 확인 (어떤 컬럼에 제약조건이 설정되어 있는지 확인불가)
-- 제약조건 타입(CONSTRAINT_TYPE 컬럼):
--  P: PRIMARY KEY, R: FOREIGN KEY, U: UNIQUE, 
--  C: NOT NULL, CHECK (NOT NULL 제약조건은, NULL 값을 체크하는 조건으로 처리)
DESC user_constraints;

SELECT 
    *
FROM
    user_constraints
WHERE
    table_name IN ('DEPARTMENT', 'DEPARTMENT2');

-- ------------------------------------------------------
-- USER_CONS_COLUMNS 데이터 사전
-- ------------------------------------------------------
-- 어떤 컬럼에 제약조건이 설정되어 있는지 확인가능
DESC user_cons_columns;

SELECT
    *
FROM
    user_cons_columns
WHERE
    table_name IN ('DEPARTMENT', 'DEPARTMENT2');

-- ------------------------------------------------------
-- (1) PRIMARY KEY 제약조건
-- ------------------------------------------------------

CREATE TABLE department3(
    deptno      NUMBER(2)       CONSTRAINT department3_deptno_pk PRIMARY KEY,
    dname       VARCHAR2(15),
    loc         VARCHAR2(15)
);

CREATE TABLE department4(
    deptno  NUMBER(2),
    dname   VARCHAR2(15),
    loc     VARCHAR2(15),

    CONSTRAINT department4_deptno_pk PRIMARY KEY(deptno, loc)
);


-- ------------------------------------------------------

-- 중복저장 불가 (Primary Key)
INSERT INTO
    department(deptno, dname, loc)
VALUES
    (10, '인사', '서울');

--ORA-00001: unique constraint (SCOTT.DEPARTMENT_DEPTNO_PK) violated
INSERT INTO
    department(deptno, dname, loc)
VALUES
    (10, '개발', '경기');

--ORA-01400: cannot insert NULL into ("SCOTT"."DEPARTMENT"."DEPTNO")
INSERT INTO
    department(deptno, dname, loc)
VALUES
    (NULL, '개발', '경기');

SELECT
    *
FROM
    department;

-- ------------------------------------------------------
-- (2) UNIQUE 제약조건
-- ------------------------------------------------------
-- 가. 기본키가 아닌 경우에도, 컬럼의 모든 데이터가 유일해야 하는
--     경우에 지정
-- 나. 자동으로 UNIQUE INDEX 생성 -> 빠른 검색효과
-- 다. 기본키(Primary Key)와의 차이점:
--     a. 하나의 테이블에, 여러개의 UNIQUE 제약조건 지정가능
--     b. null 값도 저장가능***
-- 라. 제약조건명 형식: table_column_uk
-- 마. 단순/복합 컬럼에 대해 지정가능
-- ------------------------------------------------------

-- ------------------------------------------------------
-- Basic Syntax1: column-level
--
--  CREATE TABLE [스키마].테이블명 (
--      컬럼명1 데이터타입 [CONSTRAINT 제약조건명] UNIQUE,
--      컬럼명2 데이터타입,
--      ...
--  );
-- ------------------------------------------------------
CREATE TABLE department5 (
    deptno  NUMBER(2)       CONSTRAINT department5_deptno_pk    PRIMARY KEY,
    dname   VARCHAR2(15)    CONSTRAINT department5_dname_uk     UNIQUE,
    loc     VARCHAR2(15)
);

--중복저장 불가 + NOT NULL (Primary Key)
INSERT INTO
    department5(deptno, dname, loc)
VALUES
    (10, '인사', '서울');

--ORA-00001: unique constraint (SCOTT.DEPARTMENT5_DNAME_UK) violated
INSERT INTO
    department5(deptno, dname, loc)
VALUES
    (20, '인사', '경기');

--NULL값 가능
INSERT INTO
    department5(deptno, dname, loc)
VALUES
    (30, NULL, '서울');

--NULL값 가능
INSERT INTO
    department5(deptno, dname, loc)
VALUES
    (40, NULL, '서울');


CREATE TABLE department6(
    deptno  NUMBER(2)       CONSTRAINT department6_deptno_pk PRIMARY KEY,
    dname   VARCHAR2(15),
    loc     VARCHAR2(15),

    CONSTRAINT department6_dname_uk UNIQUE(dname, loc)      --두개 다 겹쳐야지만 중복으로 생각한다.
);

--중복저장 불가 + NOT NULL (Primary Key)
INSERT INTO
    department6(deptno, dname, loc)
VALUES
    (10, '인사', '서울');

--가능... 왜냐??? dname은 같으나, loc은 다르므로!! 가능하다.
INSERT INTO
    department6(deptno, dname, loc)
VALUES
    (20, '인사', '경기');

--ORA-00001: unique constraint (SCOTT.DEPARTMENT6_DNAME_UK) violated
--불가능.. 왜냐??? dname과 loc이 같다.
INSERT INTO
    department6(deptno, dname, loc)
VALUES
    (30, '인사', '서울');

--NULL값 가능
INSERT INTO
    department6(deptno, dname, loc)
VALUES
    (40, NULL, '수원');

INSERT INTO
    department6(deptno, dname, loc)
VALUES
    (50, '개발', NULL);

INSERT INTO
    department6(deptno, dname, loc)
VALUES
    (60, NULL, NULL);

CREATE TABLE department7(
    deptno  NUMBER(2)       CONSTRAINT department7_deptno_pk    PRIMARY KEY,
    dname   VARCHAR2(15)    CONSTRAINT department7_dname_uk     UNIQUE,
    loc     VARCHAR2(15)    CONSTRAINT department7_loc_nn       NOT NULL
);

--ORA-01400: cannot insert NULL into ("SCOTT"."DEPARTMENT7"."LOC")
INSERT INTO
    department7(deptno, dname, loc)
VALUES
    (30, '인사', NULL);

-- ------------------------------------------------------
-- (5) FOREIGN KEY 제약조건 (= 참조무결성 제약조건)
-- ------------------------------------------------------
-- 가. '외래키' 또는 '참조키' 라고 부름
-- 나. 자식 테이블에서 부모 테이블을 참조할 때, 올바른 데이터만
--     참조 가능하도록 제약하는 방법
-- 다. null 값 허용
-- 라. 제약조건명 형식: table_column_fk
-- ------------------------------------------------------
SELECT 
    empno, deptno
FROM
    emp;

SELECT
    *
FROM
    dept;

INSERT INTO
    emp(empno, ename, deptno)
VALUES
    (9000, 'John', 91);

DESC user_constraints;

SELECT
    table_name,
    constraint_type,
    constraint_name,
    r_constraint_name
FROM
    user_constraints
WHERE
    table_name IN ('DEPT', 'EMP');

-- ------------------------------------------------------
-- Basic Syntax1: column-level
--
--  CREATE TABLE [스키마].테이블명 (
--      컬럼명1 데이터타입 [CONSTRAINT 제약조건명] REFERENCES 부모테이블명(컬럼명),
--      컬럼명2 데이터타입,
--      ...
--  );
--
-- ** 주의1 ** :
-- 참조하는 부모테이블의 컬럼은, 반드시 1) 기본키(Primary Key) 
-- 또는 2) UNIQUE 제약조건이 설정된 컬럼 이어야 함!!!
--
-- PK/UK 아닌 컬럼을, 왜래키 제약조건으로 설정 시도 -> 오류발생
--
-- ** 주의2 ** :
-- 외래키는, 부모 테이블과 자식 테이블 간의 참조 무결성을 위한
-- 제약조건이기 때문에, 자식 테이블에서 참조하게 되는 컬럼을
-- 부모 테이블에서 기본키 또는 UNIQUE로 지정해 두어야 함!!!
-- ------------------------------------------------------
DROP TABLE dept02;

CREATE TABLE dept02 (
    deptno  NUMBER(2)        CONSTRAINT dept02_deptno_pk PRIMARY KEY,
    dname   VARCHAR2(15),
    loc     VARCHAR2(15)
);

INSERT INTO
    dept02(deptno, dname, loc)
VALUES
    (10, '인사', '서울');

INSERT INTO
    dept02(deptno, dname, loc)
VALUES
    (20, '개발', '광주');

INSERT INTO
    dept02(deptno, dname, loc)
VALUES
    (30, '관리', '부산');

INSERT INTO
    dept02(deptno, dname, loc)
VALUES
    (40, '영업', '경기');

COMMIT;
---------------------------

CREATE TABLE emp02 (
    empno   NUMBER(4)       CONSTRAINT emp02_empno_pk PRIMARY KEY,
    ename   VARCHAR2(15),
    deptno  NUMBER(2)       CONSTRAINT emp02_deptno_fk REFERENCES dept02(deptno)
);

INSERT INTO
    emp02(empno, ename, deptno)
VALUES
    (1000, 'John', 10);

INSERT INTO
    emp02(empno, ename, deptno)
VALUES
    (2000, 'Smith', 20);

INSERT INTO
    emp02(empno, ename, deptno)
VALUES
    (3000, 'Sam', NULL);

--ORA-02291: integrity constraint (SCOTT.EMP02_DEPTNO_FK) violated - parent key not found 
INSERT INTO
    emp02(empno, ename, deptno)
VALUES
    (4000, 'Mike', 50);

COMMIT;

-- USER_CONSTRAINTS 데이터 사전
DESC user_constraints;


SELECT
    table_name,
    constraint_type,
    constraint_name,
    r_constraint_name
FROM
    user_constraints
WHERE
    table_name IN ('DEPT02', 'EMP02');
-- ------------------------------------------------------
-- Basic Syntax2: table-level
--
--  CREATE TABLE [스키마].테이블명 (
--      컬럼명1 데이터타입,
--      컬럼명2 데이터타입,
--      ...,
--      [CONSTRAINT 제약조건명] FOREIGN KEY(컬럼명n) REFERENCES 부모테이블명(컬럼명)
--  );
--
-- ** 주의1 ** :
-- 참조하는 부모테이블의 컬럼은, 반드시 1) 기본키(Primary Key) 
-- 또는 2) UNIQUE 제약조건이 설정된 컬럼 이어야 함!!!
--
-- PK/UK 아닌 컬럼을, 왜래키 제약조건으로 설정 시도 -> 오류발생
--
-- ** 주의2 ** :
-- 외래키는, 부모 테이블과 자식 테이블 간의 참조 무결성을 위한
-- 제약조건이기 때문에, 자식 테이블에서 참조하게 되는 컬럼을
-- 부모 테이블에서 기본키 또는 UNIQUE로 지정해 두어야 함!!!
-- ------------------------------------------------------
CREATE TABLE emp03 (
    empno   NUMBER(4)       CONSTRAINT emp03_empno_pk PRIMARY KEY,
    ename   VARCHAR2(15),
    deptno  NUMBER(2),

    CONSTRAINT emp03_deptno_fk FOREIGN KEY(deptno) REFERENCES dept02(deptno)
);

INSERT INTO
    emp03(empno, ename, deptno)
VALUES
    (1000, 'John', 10);

INSERT INTO
    emp03(empno, ename, deptno)
VALUES
    (2000, 'Smith', 20);

INSERT INTO
    emp03(empno, ename, deptno)
VALUES
    (3000, 'Sam', NULL);

--ORA-02291: integrity constraint (SCOTT.EMP03_DEPTNO_FK) violated - parent key not found
INSERT INTO
    emp03(empno, ename, deptno)
VALUES
    (4000, 'Mike', 50);

COMMIT;

-----------------------------------------------------------
--USER_CONSTRAINTS 데이터 사전
DESC user_constraints;

SELECT
    table_name,
    constraint_type,
    constraint_name,
    r_constraint_name
FROM
    user_constraints
WHERE
    table_name IN ('DEPT02', 'EMP02', 'EMP03');


-- 참조 무결성 제약조건 위배

-- 특정부서(부모)를 참조하고 있는 사원(자식)들이 있으므로, 부서를 삭제할 수 없음 (참조관계 존재)
-- ORA-02292: integrity constraint (SCOTT.EMP02_DEPTNO_FK) violated - child record found
DELETE FROM dept02
WHERE deptno = 10;      -- 부모 테이블의 특정부서 삭제


-- 해결방법(2가지)
-- ------------------------------------------------------
-- 1) ON DELETE CASCADE
-- ------------------------------------------------------
-- 참조하는 부모테이블의 행이 삭제되면, 해당 행을 참조하는 
-- 자식테이블의 행도 연쇄삭제 됨.
-- ------------------------------------------------------
DROP TABLE emp02;
DROP TABLE emp03;

INSERT INTO 
    dept02(deptno, dname, loc)
VALUES
    (10, '인사', '서울');

CREATE TABLE emp02 (
    empno   NUMBER(4) CONSTRAINT emp02_empno_pk PRIMARY KEY,
    ename   VARCHAR2(15),
    deptno  NUMBER(2),

    CONSTRAINT emp02_deptno_fk FOREIGN KEY(deptno) 
        REFERENCES dept02( deptno ) ON DELETE CASCADE
);

INSERT INTO
    emp02(empno, ename, deptno)
VALUES
    (1000, 'John', 10);

INSERT INTO
    emp02(empno, ename, deptno)
VALUES
    (2000, 'Smith', 20);

INSERT INTO
    emp02(empno, ename, deptno)
VALUES
    (3000, 'Sam', NULL);

COMMIT;


SELECT 
    *
FROM 
    dept02;

DELETE FROM 
    dept02
WHERE 
    deptno = 10;      -- 부모 테이블의 특정부서 삭제

SELECT 
    *
FROM 
    emp02;

-- ------------------------------------------------------
-- 2) ON DELETE SET NULL
-- ------------------------------------------------------
-- 참조하는 부모 테이블의 행이 삭제되면, 해당 행을 참조하는 자식
-- 테이블의 컬럼값을 NULL로 설정한다.
-- ------------------------------------------------------
DROP TABLE emp02;
DROP TABLE emp03;

INSERT INTO 
    dept02(deptno, dname, loc)
VALUES
    (10, '인사', '서울');

CREATE TABLE emp02 (
    empno   NUMBER(4)       CONSTRAINT emp02_empno_pk PRIMARY KEY,
    ename   VARCHAR2(15),
    deptno  NUMBER(2),

    CONSTRAINT emp02_deptno_fk FOREIGN KEY(deptno)
        REFERENCES dept02(deptno) ON DELETE SET NULL
);

INSERT INTO
    emp02(empno, ename, deptno)
VALUES
    (1000, 'John', 10);

INSERT INTO
    emp02(empno, ename, deptno)
VALUES
    (2000, 'Smith', 20);

INSERT INTO
    emp02(empno, ename, deptno)
VALUES
    (3000, 'Sam', NULL);
    
COMMIT;

SELECT
    *
FROM 
    dept02;

DELETE FROM 
    dept02
WHERE 
    deptno = 10;

SELECT 
    *
FROM 
    emp02;

-- ------------------------------------------------------
-- 2. 테이블 삭제
-- ------------------------------------------------------
-- 가. 삭제되는 테이블에 저장된 모든 데이터/관련 인덱스/외래키
--     제약조건을 제외한, 모든 제약조건이 같이 삭제된다.
-- 나. 외래키 제약조건은 자동으로 삭제되지 않기 때문에, 자식 테이블
--     에서 부모테이블을 참조하는 상황에서, 부모 테이블을 삭제하면,
--     종속성에 의해서, 삭제가 안됨.
--
--     이 경우에 CASCADE CONSTRAINTS 옵션을 지정하여 삭제하면,
--     연쇄적으로 제약조건도 함께 삭제되기 때문에, 부모 테이블 삭제가능
-- ------------------------------------------------------
-- Basic Syntax:
--
--  DROP TABLE 테이블명 [CASCADE CONSTRAINTS];
-- ------------------------------------------------------

-- 참조키에 의한 테이블 삭제불가.
-- 자식 테이블이 참조하는 상황에서, 부모 테이블 삭제시도
DROP TABLE dept02;

DROP TABLE dept02 CASCADE CONSTRAINTS;

DESC user_constraints;

SELECT
    table_name,
    constraint_type,
    constraint_name,
    r_constraint_name
FROM
    user_constraints
WHERE
    table_name IN ('DEPT02', 'EMP02', 'EMP03');

-- ------------------------------------------------------
-- 3. Flashback Drop
-- ------------------------------------------------------
-- 가. 삭제된 테이블을 복구하는 방법 (from Oracle10g)
-- 나. 테이블 삭제할 때, (DROP TABLE tablename;)
--     삭제된 테이블은 휴지통(RECYCLEBIN)이라는 특별한 객체에,
--     'BIN$' prefix가 붙은, 이름으로 저장됨.
-- 다. 삭제된 테이블을 다시 복구하고 싶을 때, Flashback Drop
--     복구기술을 이용하여, 휴지통(RECYCKEBIN) 객체에서, 삭제된
--     테이블을 복구할 수 있다.
-- ------------------------------------------------------


-- ------------------------------------------------------
-- * Flashback Drop Commands *
-- ------------------------------------------------------
SHOW RECYCLEBIN;            --recyclebin 객체정보 조회
select * from recyclebin;   --visual studio에서 보기.

FLASHBACK TABLE emp02 TO BEFORE DROP;   --삭제된 테이블 복구

DROP TABLE dept02 PURGE;     --테이블 완전삭제(복구 불가)

PURGE RECYCLEBIN;   --휴지통 비우기