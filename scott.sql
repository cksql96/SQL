SELECT *
FROM EMP;
DESC EMP;
create table student(
stu_no      char(9),
stu_name    varchar2(12),
stu_dept    varchar2(20),
stu_grade   number(1),
stu_class   char(1),
stu_gender  char(1),
stu_height  number(5,2),
stu_weight  number(5,2),
  constraint p_stu_no primary key(stu_no));

create table subject(
sub_no char(3),
sub_name  varchar2(30),
sub_prof  varchar2(12),
sub_grade number(1),
sub_dept  varchar2(20),
  constraint p_sub_no primary key(sub_no));

create table enrol(
sub_no    char(3),
stu_no    char(9),
enr_grade number(3),
  constraint p_course primary key(sub_no,stu_no));

insert into student values(20153075, '옥한빛','기계',1,'C','M',177,80);
insert into student values(20153088, '이태연','기계',1,'C','F',162,50);
insert into student values(20143054, '유가인','기계',2,'C','F',154,47);
insert into student values(20152088, '조민우','전기전자',1,'C','M',188,90);
insert into student values(20142021, '심수정','전기전자',2,'A','F',168,45);
insert into student values(20132003, '박희철','전기전자',3,'B','M',null,63);
insert into student values(20151062, '김인중','컴퓨터정보',1,'B','M',166,67);
insert into student values(20141007, '진현무','컴퓨터정보',2,'A','M',174,64);
insert into student values(20131001, '김종헌','컴퓨터정보',3,'C','M',null,72);
insert into student values(20131025, '옥성우','컴퓨터정보',3,'A','F',172,63);

insert into subject values('111','데이터베이스','이재영',2 ,'컴퓨터정보');
insert into subject values('110','자동제어','정순영',2 ,'전기전자');
insert into subject values('109','자동화설계','박민영',3 ,'기계');
insert into subject values('101','컴퓨터개론','강종영',3 ,'컴퓨터정보');
insert into subject values('102','기계공작법','김태영',1 ,'기계');
insert into subject values('103','기초전자실험','김유석',1 ,'전기전자');
insert into subject values('104','시스템분석설께','강석현',3 ,'컴퓨터정보');
insert into subject values('105','기계요소설계','김명성',1 ,'기계');
insert into subject values('106','전자회로실험','최영민',3 ,'전기전자');
insert into subject values('107','CAD응용실습','구봉규',2 ,'기계');
insert into subject values('108','소프트웨어공학','권민성',1 ,'컴퓨터정보');

insert into enrol values('101','20131001','80');
insert into enrol values('104','20131001','56');
insert into enrol values('106','20132003','72');
insert into enrol values('103','20152088','45');
insert into enrol values('101','20131025','65');
insert into enrol values('104','20131025','65');
insert into enrol values('108','20151062','81');
insert into enrol values('107','20143054','41');
insert into enrol values('102','20153075','66');
insert into enrol values('105','20153075','56');
insert into enrol values('102','20153088','61');
insert into enrol values('105','20153088','78');

--중복행 제거하는 방법
SELECT STU_DEPT
FROM STUDENT;

SELECT DISTINCT STU_DEPT
FROM STUDENT;

SELECT STU_GRADE,STU_CLASS
FROM STUDENT;

SELECT DISTINCT STU_GRADE,STU_CLASS
FROM STUDENT;

--SELEECT ()에서 연산이 가능한 기능.
SELECT STU_NO,SUB_NO,ENR_GRADE,ENR_GRADE+10,
ENR_GRADE-10,ENR_GRADE*10,ENR_GRADE/10
FROM ENROL;

--SELECT()에서 ALLIAS사용방법
SELECT STU_NO AS ID,STU_NAME AS NAME
FROM STUDENT;

--연결 연산자를 이용하는 방법
SELECT * FROM STUDENT;
SELECT STU_DEPT ||'과'|| STU_NAME ||'입니다.' AS 학과성명
FROM STUDENT;

SELECT 10+5
FROM DUAL;

--조건검색
SELECT * FROM STUDENT;

SELECT *
FROM STUDENT
WHERE STU_DEPT='컴퓨터정보';
--논리연산자에 의한 조건검색
SELECT *
FROM STUDENT
WHERE STU_HEIGHT>=175;
--학생테이블에서 컴퓨터정보과의 2학년 학생들을 검색하시오.
SELECT *
FROM STUDENT
WHERE STU_DEPT='컴퓨터정보' AND STU_GRADE=2;

--학생테이블에서 체중이 60~70KG 사이의 학생들을 검색하라.
SELECT *
FROM STUDENT
WHERE STU_WEIGHT>=60 AND STU_WEIGHT<=70;

--학생테이블에서 학번이 20140001~20149999의 학생들을 구하라.
SELECT *
FROM STUDENT
WHERE STU_NO BETWEEN 20140001 AND 20149999;
--위와 같이 BETWEEN 을 사용해도 되고 AND를 이용해서 두번 써도 상관없다.

--LIKE를 이용한 검색방법
--김씨성을 가진 학생들의 정보를 와일드카드문자를 이용하여 검색하라.
SELECT *
FROM STUDENT
WHERE STU_NAME LIKE '김%';
-- % = 와일드카드문자

--두번째 문자가 '수'인 학생의 이름을 검색하는 질의문을 작성하라.
SELECT *
FROM STUDENT
WHERE STU_NAME LIKE '_수%';
-- _ = 와일드카드문자

--학생테이블에서 '2014' 학번을 모두검색하라.(LIKE 함수 이용)
SELECT *
FROM STUDENT
WHERE STU_NO LIKE '2014%';

--널값 처리하는 방법
SELECT STU_NAME,STU_HEIGHT
FROM STUDENT;
--학생테이블의 STU_HEIGHT에서 널값인 학생들을 검색하라.
SELECT *
FROM STUDENT
WHERE STU_HEIGHT IS NULL;
--널값이 아닌 학생들의 경우 'IS' 가 'IS NOT' 이 된다.

--IN 의 사용법
SELECT *
FROM STUDENT
WHERE STU_DEPT IN('기계','전기전자');

--정렬하는 방법
SELECT STU_NO,STU_NAME
FROM STUDENT
ORDER BY STU_NO ASC;
-- ASC = 오름차순 (DEFAULT(기본)상태가 오름차순이기에 굳이 써줄 필요는 없다.)
SELECT STU_NO,STU_NAME
FROM STUDENT
ORDER BY STU_NO DESC ;
-- DESC = 내림차순

--1.학생들의 신상을 학번의 내림차순으로 검색하시오.
--2.학생테이블에서 STU_WEIGHT를 -5를 뺀 후 TARGET으로 별칭으로 주고 TARGET으로 정렬하시오.
--3.위의 2번 문제에서 정렬을 STU_DEPT와 TARGET을 가지고 정렬하시오.
SELECT STU_NAME,STU_WEIGHT-5 AS TARGET
FROM STUDENT
ORDER BY TARGET;

SELECT STU_DEPT,STU_NAME,STU_WEIGHT-5 AS TARGET
FROM STUDENT
ORDER BY STU_DEPT,TARGET;
-- 'AS'를 생략해도 된다.

--TARGET을 이용하지 않고 구할 때.
SELECT *
FROM STUDENT
ORDER BY STU_DEPT;

--SELECT()에서 함수 사용법.
--단일행함수 [숫자함수/문자함수/날짜함수/변환함수/일반함수]
--ROUND 반올림
SELECT ROUND(345.678),ROUND(345.678,0),ROUND(345.678,1),
ROUND(345.678,-1)
FROM DUAL;

--소숫값 정해주기, 1이 붙으면 1자리까지. -1은 1의자리 버리기. 0이나 안붙으면 소숫점 X
SELECT TRUNC(345.678),TRUNC(345.678,0),TRUNC(345.678,1),
TRUNC(345.678,-1)
FROM DUAL;

--CEIL 올림, FLOOR 내림
SELECT CEIL(3.01),CEIL(-3.98),FLOOR(3.98),FLOOR(-3.0001)
FROM DUAL;
--MODULUS %
SELECT MOD(10,3)
FROM DUAL;
--ABSOLUTE 절댓값
SELECT ABS(-100)
FROM DUAL;


--단일행함수에서 문자함수란?
SELECT LOWER('ABCDEFG')
FROM DUAL;

SELECT UPPER('abcdefg')
FROM DUAL;

--맨앞에만 대문자
SELECT INITCAP('abcdefg')
FROM DUAL;

--두개 붙이기
SELECT CONCAT(STU_NAME,STU_NO) 이름학번
FROM STUDENT;

SELECT * FROM EMP;

SELECT SUBSTR(ENAME,2,2)
FROM EMP;

SELECT LENGTH(ENAME) 문자이름길이
FROM EMP;

SELECT LPAD(ENAME,10,'*')
FROM EMP;

SELECT RPAD(ENAME,10,'*')
FROM EMP;

--날짜함수
SELECT SYSDATE+15
FROM DUAL;

SELECT MONTHS_BETWEEN(SYSDATE,HIREDATE)
FROM EMP;

SELECT ENAME,ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE))
FROM EMP;

SELECT LAST_DAY(SYSDATE)
FROM DUAL;

SELECT ROUND(SYSDATE,'MON')
FROM DUAL;

SELECT ROUND(SYSDATE+18,'MON')
FROM DUAL;

--단일행함수의 변환함수
SELECT * FROM EMP;

SELECT EMPNO,ENAME,TO_CHAR(HIREDATE,'YYYY-MM-DD') 입사년월
FROM EMP;

--숫자자리수(9)
SELECT TO_CHAR(TO_NUMBER(1234.5678),'9999,99')
FROM DUAL;

SELECT TO_CHAR(TO_NUMBER(1234.5678),'999,99')
FROM DUAL;

SELECT * FROM EMP;

SELECT ENAME, TO_CHAR(SAL,'999') SALARY
FROM EMP
WHERE SAL<1000;

--일반함수
--NVL (EX: 아래의 STU_HEIGHT가 NULL 값이면 0, NULL값이 아니면 STU_HEIGHT 값이 반영됨.)
SELECT NVL(STU_HEIGHT,0)
FROM STUDENT;

SELECT * FROM EMP;

SELECT ENAME,NVL2(COMM,SAL+COMM,SAL) SALARY
FROM EMP;

SELECT NVL(NULLIF('A','A'),'널값')
FROM DUAL;

--CASE()
SELECT EMPNO,ENAME,SAL,
CASE JOB WHEN 'SALESMAN' THEN SAL*1.1
         WHEN 'CLERK' THEN SAL*1.15
         WHEN 'MANAGER' THEN SAL*1.2
         ELSE SAL
END AS 급여인상
FROM EMP;

--DECODE()
SELECT EMPNO,ENAME,JOB,SAL,
DECODE(JOB, 'SALESMAN',SAL*1.1,
            'CLERK',SAL*1.15,
            'MANAGER',SAL*1.2,
            SAL) AS 인상된급여
            FROM EMP;
            
            
--dual 은 기본적으로 들어간 테이블 함수