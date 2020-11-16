-- ------------------------------------------------------
-- (5) 조건 (처리)함수 - DECODE
-- ------------------------------------------------------
-- 조건이 반드시 일치하는 경우에 사용하는 함수
-- 즉, 동등비교연산자(=)가 사용가능한 경우에만 사용가능
-- ------------------------------------------------------
-- 문법) DECODE(
--          column, 
--          비교값1, 결과값1,
--          비교값2, 결과값2,
--          ...
--          비교값n, 결과값n,
--          기본결과값
--      )
-- ------------------------------------------------------
SELECT
    salary,
    decode(                             --if
       salary,                          --salary가
        1000, salary * 0.1,             --1000과 같다면(salary=1000), then, salary에 0.1을 곱해라.
        2000, salary * 0.2,             --2000과 같다면(salary=2000), then, salary에 0.2을 곱해라.
        3000, salary * 0.3,             --3000과 같다면(salary=3000), then, salary에 0.3을 곱해라.
        salary * 0.4                    --아무것도 해당조건이 없으면! salary에 0.4를 곱해라.
   ) AS "DECODE"    --decode
FROM
    employees;

SELECT
    last_name,
    salary,
    decode(                             --if
        salary,                         --salary가
            24000, salary * 0.3,        --24000일 경우, salary * 0.3을 해라.
            17000, salary * 0.2,        --17000일 경우, salary * 0.3을 해라.
            0                           --아무것도 해당조건 없으면, 0을 넣어라.
    )   AS "보너스"
FROM
    employees
ORDER BY
    2 DESC;

SELECT
    count(*) AS "총 인원수",
    sum(decode(                             --sum을 구해라 만약!!
        to_char(hire_date, 'YYYY'),         --hire_date의 YYYY(년도)가!!!
            2001, 1,                        --2001년일경우! 1.
            0                               --아니면 0으로 계산하여 sum을 구해라.
        )) AS "2001",                 
    sum( decode( to_char( hire_date, 'YYYY' ), 2002, 1, 0 ) ) AS "2002",   
    sum( decode( to_char( hire_date, 'YYYY' ), 2003, 1, 0 ) ) AS "2003",   
    sum( decode( to_char( hire_date, 'YYYY' ), 2004, 1, 0 ) ) AS "2004",    
    sum( decode( to_char( hire_date, 'YYYY' ), 2005, 1, 0 ) ) AS "2005",    
    sum( decode( to_char( hire_date, 'YYYY' ), 2006, 1, 0 ) ) AS "2006",    
    sum( decode( to_char( hire_date, 'YYYY' ), 2007, 1, 0 ) ) AS "2007",    
    sum( decode( to_char( hire_date, 'YYYY' ), 2008, 1, 0 ) ) AS "2008"   
FROM
    employees;


-- ------------------------------------------------------
-- (6) 조건 (처리)함수 - CASE
-- ------------------------------------------------------
-- 조건이 반드시 일치하지 않아도,
-- 범위 및 비교가 가능한 경우에 사용하는 함수
-- ------------------------------------------------------
-- 문법1) 조건이 반드시 일치하는 경우
--      CASE column
--          WHEN 비교값1 THEN 결과값1
--          WHEN 비교값2 THEN 결과값2
--          ...
--          ELSE 결과값n
--      END
-- ------------------------------------------------------
SELECT

    CASE salary                                 --만약 salary 가!!
        WHEN 1000 THEN salary * 0.1             --1000일때!, 그러면, salary * 0.1
        WHEN 2000 THEN salary * 0.2             --2000일때!, 그러면, salary * 0.2
        WHEN 3000 THEN salary * 0.3             --3000일때!, 그러면, salary * 0.3
        ELSE salary * 0.4                       --아무것도 아니면, salary * 0.4
    END AS "뽀나스"                             --END!!
FROM
    employees;

-- ------------------------------------------------------
-- 문법2) 조건이 반드시 일치하지 않는 경우
--      CASE 
--          WHEN 조건1 THEN 결과값1
--          WHEN 조건2 THEN 결과값2
--          ...
--          ELSE 결과값n
--      END
-- ------------------------------------------------------
SELECT
    salary,
    --자바에서 사용할때, 가독성을 위해서!! CASE는 한칸 띄워준다.
    CASE                                            --만약!!
        WHEN salary < 1000 THEN salary * 0.1        --salary가 1000미만일 경우, salary * 0.1
        WHEN salary < 2000 THEN salary * 0.2        --위에 미충족 할시, 2000미만인 경우, salary * 0.2
        WHEN salary < 3000 THEN salary * 0.3        --위에 미충족 할시, 3000미만인 경우, salary * 0.3
        ELSE salary * 0.4                           --위에 싹다 미충족 할시, salary * 0.4
    END AS "뽀나스"
FROM
    employees;

SELECT
    last_name,
    salary,

    CASE salary
        WHEN 24000 THEN salary * 0.3
        WHEN 17000 THEN salary * 0.2
        ELSE salary
    END AS "뽀나스"
FROM
    employees
ORDER BY
    "뽀나스" DESC;

SELECT
    last_name,
    salary,
    
    CASE
        WHEN salary >= 20000 THEN 1000
        WHEN salary >= 15000 THEN 2000
        WHEN salary >= 10000 THEN 3000
        ELSE 4000
    END AS "뽀나스"
FROM
    employees
ORDER BY
    2 DESC;

SELECT
    last_name,
    salary,

    CASE
        WHEN salary BETWEEN 20000 AND 25000 THEN '상'
        WHEN salary BETWEEN 10000 AND 20001 THEN '중'
        ELSE '하'
    END AS "등급"
FROM
    employees
ORDER BY
    2 DESC;

SELECT
    last_name,
    salary,

    CASE
        WHEN salary IN (24000, 17000, 14000) THEN '상'          --24000과 17000 과 14000과 같다면!
        WHEN salary IN (13500, 13000) THEN '상'
        ELSE '하'
    END AS "등급"
FROM
    employees
ORDER BY
    2 desc;