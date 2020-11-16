-- ------------------------------------------------------
-- 1. 단일(행) (반환)함수
-- ------------------------------------------------------
-- 단일(행) (반환)함수의 구분:
--
--  (1) 문자 (처리)함수 : 문자와 관련된 특별한 조작을 위한 함수
--      a. INITCAP  - 첫글자만 대문자로 변경
--      b. UPPER    - 모든 글자를 대문자로 변경 
--      c. LOWER    - 모든 글자를 소문자로 변경
--      d. CONCAT   - 두 문자열 연결
--      e. LENGTH   - 문자열의 길이 반환
--      f. INSTR    - 문자열에서, 특정 문자열의 위치(인덱스) 반환
--      g. SUBSTR   - 문자열에서, 부분문자열(substring) 반환
--      h. REPLACE  - 문자열 치환(replace)
--      i. LPAD     - 문자열 오른쪽 정렬 후, 왼쪽의 빈 공간에 지정문자 채우기(padding)
--      j. RPAD     - 문자열 왼쪽 정렬 후, 오른쪽의 빈 공간에 지정문자 채우기(padding)
--      k. LTRIM    - 문자열의 왼쪽에서, 지정문자 삭제(trim)
--      l. RTRIM    - 문자열의 오른쪽에서, 지정문자 삭제(trim)
--      m. TRIM     - 문자열의 왼쪽/오른쪽/양쪽에서, 지정문자 삭제(trim)
--                    (단, 문자열의 중간은 처리못함)
--  (2) 숫자 (처리)함수 : 
--  (3) 날짜 (처리)함수
--  (4) 변환 (처리)함수
--  (5) 일반 (처리)함수
-- ------------------------------------------------------
-- (1) 문자 (처리)함수 - INITCAP
-- ------------------------------------------------------
--     첫글자만 대문자로 변경
-- ------------------------------------------------------
SELECT 
    'ORACLE SQL', 
    initcap('ORACLE SQL')
FROM 
    dual;

SELECT 
    email, 
    initcap(email)
FROM 
    employees;

-- ------------------------------------------------------
-- (2) 문자 (처리)함수 - UPPER
-- ------------------------------------------------------
--     모든 글자를 대문자로 변경
-- ------------------------------------------------------
SELECT 
    'Oracle Sql', 
    upper('Oracle Sql')
FROM 
    dual;          --ORACLE SQL

SELECT 
    last_name, 
    upper(last_name)
FROM 
    employees;     --싹다 대문자

SELECT 
    last_name, 
    salary
FROM 
    employees
--Decommendation: the indexes with the column cannot be used.
-- WHERE upper(last_name) = 'KING';
--Recommendation: the indexes with the column can be used.
WHERE 
    last_name = initcap('KING');

-- ------------------------------------------------------
-- (3) 문자 (처리)함수 - LOWER
-- ------------------------------------------------------
--     모든 글자를 소문자로 변경
-- ------------------------------------------------------
SELECT 
    'Oracle Sql', lower('Oracle Sql')
FROM 
    dual;

SELECT 
    last_name, 
    lower(last_name)
from 
    employees;

-- ------------------------------------------------------
-- (4) 문자 (처리)함수 - CONCAT
-- ------------------------------------------------------
--     두 문자열 연결(Concatenation)
-- ------------------------------------------------------
-- SELECT 'Oracle'||'Sql', concat('Oracle', 'Sql')
SELECT 
    'Oracle'||'Sql'||'third' AS "Using ||",
    concat( concat('Oracle', 'Sql'), 'third')
FROM 
    dual;

SELECT
    last_name||salary, concat(last_name, salary)
FROM 
    employees;

SELECT
    last_name||hire_date, concat(last_name, hire_date)
FROM 
    employees;

-- ------------------------------------------------------
-- (5) 문자 (처리)함수 - LENGTH
-- ------------------------------------------------------
--     문자열의 길이 반환
-- ------------------------------------------------------
--  A. LENGTH   returns Characters
--  B. LENGTHB  returns Bytes
--  C. LENGTHC  returns unicode characters
--  D. LENGTH2  returns Code units
--  E. LENGTH4  returns Code points
-- ------------------------------------------------------
SELECT 
    'Oracle', length('Oracle')
FROM
    dual;       --6

SELECT
    last_name,
    length(last_name)
FROM 
    employees;

SELECT
    unistr('X'),        --x를 유니코드로 바꿔라.
    lengthb(unistr('X')) lengthb,
    lengthc(unistr('X')) lengthc,
    lengthc('X') lengthXC,
    lengthb('X') lengthXB
FROM   
    dual;

SELECT 
    '한글',
    length('한글') AS length,
    lengthb('한글') AS lengthb,
    lengthc('한글') AS lengthc
   --  length2('한글') AS length2,
   --  length4('한글') AS length4
FROM 
   dual;

SELECT
    '한글',
    length(unistr('한글')) AS length,
    lengthb(unistr('한글')) AS lengthb,
    lengthc(unistr('한글')) AS lengthc,
    length2(unistr('한글')) AS length2,
    length4(unistr('한글')) AS LENGTH4
FROM
    dual;

SELECT
    --substr(이름, ?, 총 몇문자까지)
    substr(table_name,1,20) AS tablename,
    length(table_name),
    length2(table_name),
    length4(table_name)
FROM
    user_tables
WHERE
    rownum < 10;

SELECT 
    rownum,     --각 행의 번호!!
    last_name
FROM 
    employees
WHERE
    rownum = 1;

-- ------------------------------------------------------
-- (6) 문자 (처리)함수 - INSTR
-- ------------------------------------------------------
--     문자열에서, 특정 문자열의 (시작)위치(시작 인덱스) 반환
-- ------------------------------------------------------
-- 주의) Oracle 의 인덱스 번호는 1부터 시작함!!!
-- ------------------------------------------------------
SELECT
    --instr(문자열, 찾을 문자, 시작지점, 찾은 문자중 몇번째를 찾을꺼냐.)
    instr('MILLER', 'L', 1, 2),  
    instr('MILLER', 'R', 1, 2)    
FROM
    dual;

-- ------------------------------------------------------
-- (7) 문자 (처리)함수 - SUBSTR
-- ------------------------------------------------------
--     문자열에서, 부분문자열(substring) 반환
-- ------------------------------------------------------
-- 주의) Oracle 의 인덱스 번호는 1부터 시작함!!!
-- ------------------------------------------------------
SELECT
    --substr(문자열, 시작지점, 몇개나 가져올꺼냐)
    substr('123456-1234567', 8, 1)
FROM
    dual;

SELECT
-- In the Oracle SQL Developer  --기준으로 둬라.
    hire_date AS 입사일,
    substr(hire_date, 1, 2) AS 입사년도

--In the Visual Source Code
    -- to_char(hire_date) AS 입사일,
    -- substr( to_char(hire_date), 8,2 ) AS 입사년도
FROM
    employees;

SELECT
    --substr(문자열, 시작지점)  --길이가 지정 안되면 끝까지 뽑아내라.
    '900303-1234567',
    substr('900303-1234567', 8)
FROM
    dual;

SELECT
    '900303-1234567',
    substr('900303-1234567',-7)
FROM
    dual;

-- ------------------------------------------------------
-- (8) 문자 (처리)함수 - REPLACE
-- ------------------------------------------------------
--     문자열 치환(replace)
-- ------------------------------------------------------
SELECT
    replace('JACK and JUE', 'J', 'BL')
FROM
    dual;

-- ------------------------------------------------------
-- (9) 문자 (처리)함수 - LPAD
-- ------------------------------------------------------
--      문자열 오른쪽 정렬 후, 
--      왼쪽의 빈 공간에 지정문자 채우기(padding)
-- ------------------------------------------------------
SELECT
    --맨 끝 부터 왼쪽으로 1개씩 센다.
    --lpad(문자, 몇개나 셀꺼야?, 공백은 뭘로 채울꺼야?)
    lpad('MILLER', 10, '*')
FROM
    dual;

-- ------------------------------------------------------
-- (10) 문자 (처리)함수 - RPAD
-- ------------------------------------------------------
--      문자열 왼쪽 정렬 후, 
--      오른쪽의 빈 공간에 지정문자 채우기(padding)
-- ------------------------------------------------------
SELECT
    rpad('MILLER', 10, '*')
FROM
    dual;

SELECT
    substr('900303-1234567',1,8) || '******' AS 주민번호
FROM
    dual;

SELECT
    '900303-1234567',
    rpad(substr('900303-1234567', 1, 8), 14, '*' ) AS 주민번호
FROM
    dual;

-- ------------------------------------------------------
-- (11) 문자 (처리)함수 - LTRIM
-- ------------------------------------------------------
--    문자열의 왼쪽에서, 지정문자 삭제(trim)
-- ------------------------------------------------------
SELECT      --왼쪽에서삭제한다. 단 연달아서 있어야 삭제 가능.
--  ltrim(문자, 어떤걸 삭제할래)
    ltrim('MMMIMLLER', 'M')
FROM
    dual;

SELECT
--  litrm(문자)     --지정문자가 없으면 공백을 다 삭제한다.
    ltrim('  Miller  '),
    length( ltrim('  MILLER  '))
FROM
    dual;

-- ------------------------------------------------------
-- (12) 문자 (처리)함수 - RTRIM
-- ------------------------------------------------------
--    문자열의 오른쪽에서, 지정문자 삭제(trim)
-- ------------------------------------------------------
SELECT  --ltrim 반대임.
    rtrim('MILLRERR', 'R')
FROM
    dual;

SELECT
    rtrim('  MILLER  '),
    length( rtrim('  MILLER  '))
FROM
    dual;

-- ------------------------------------------------------
-- (13) 문자 (처리)함수 - TRIM
-- ------------------------------------------------------
--    문자열의 왼쪽/오른쪽/양쪽에서, 지정문자 삭제(trim)
--    (단, 문자열의 중간은 처리못함)
-- ------------------------------------------------------
-- 문법)
--    1. TRIM( LEADING 'str' FROM 컬럼명|표현식 )
--    2. TRIM( TRAILING 'str' FROM 컬럼명|표현식 )
--    3. TRIM( BOTH 'str' FROM 컬럼명|표현식 )
--    4. TRIM( 'str' FROM 컬럼명|표현식 )     -- BOTH (default)
-- ------------------------------------------------------
SELECT  --양쪽다 제거함. 
--  trim(뭘제거할꺼야. FROM '이 문자열에서')    --4번문법 사용
    trim( '0' FROM '0001234567000' )
FROM
    dual;

SELECT 
    trim( LEADING '0' FROM '0001234567000')
FROM
    dual;

SELECT
    trim( TRAILING '0' FROM '0001234567000')
FROM
    dual;

SELECT      --공백제거해라.
    trim('   1234567   ')
FROM
    dual;