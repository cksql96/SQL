--성적테이블에서 최고점수와 최저점수를 검색하라.
SELECT MAX(ENR_GRADE),MIN(ENR_GRADE)
FROM ENROL;

--학생테이블에서 기계과의 최저체중과 최고체중을 검색하라.
SELECT MIN(STU_WEIGHT),MAX(STU_WEIGHT)
FROM STUDENT
WHERE STU_DEPT='기계';

--안된다. STUNAME은 모든 학생을 나타내야되고, MIN(STU_WEIGHT)는 최소값을 구해야 하므로. 모든 학생과 몸무게1개는 안된다. 둘이 맞춰줘야한다.
SELECT STU_NAME, MIN(STU_WEIGHT)
FROM STUDENT;

--별칭(ALIAS)을 사용하여 학생 테이블에서 학생, 신장합, 해당 학생수, 평균 신장으로 데이터를 검색하라
--뒤에 붙는 한글은 행 이름을 바꿔준다. AS가 생략된것.
SELECT COUNT(*) AS 학생, SUM(STU_HEIGHT) 신장합,
COUNT(STU_HEIGHT) 해당학생수, AVG(STU_HEIGHT) 평균신장
FROM STUDENT;

--GROUP BY절, 학생 테이블에서 학과별 평균 체중을 구하라? 대소문자 구분 안해도댐
select STU_DEPT, AVG(STU_WEIGHT)
FROM STUDENT
GROUP BY STU_DEPT;
--학생 테이블에서 체중이 50키로 이상인 학생들만 학과별로 선택하여 그룹별 학생수를 검색하라
select stu_dept, count(*)
from student
where stu_weight>=50
group by stu_dept;

--학생테이블에서 학과별, 학년별로 그룹화 하여 학생수를 검색하라
select stu_dept, stu_grade, count(*)
from student
group by stu_dept, stu_grade;

--HAVING 절? 기계과 학생들중에서 학년별 평균신장이 160이상인 학년과 평균 신장을 검색하라.
select stu_grade, avg(stu_height)
from student
where stu_dept='기계'
group by stu_grade having avg(stu_height)>=160 ;

--최대 신장이 175이상인 학과와 학과별 최대 신장을 구하라
select stu_dept, max(stu_height)
from student
group by stu_dept having max(stu_height)>=0; -- 0말고 175 하면 문제의 답이 됨.

--학과별 평균 신장이 가장 높은 평균 신장을 구하라?
select max(avg(stu_height))
from student
group by stu_dept;

desc subject;

select * from subject;
select * from enrol;

select sub_no, sub_name
from subject;

select * from student;

select stu_no, stu_name, stu_gender from student;

select stu_no, stu_name, stu_grade, stu_class from student;

SELECT DISTINCT stu_dept, stu_grade FROM STUDENT;

select distinct stu_dept, stu_class from student;

SELECT stu_height+5 FROM STUDENT;

SELECT NVL2(STU_HEIGHT,stu_height+5,0) FROM STUDENT;

select sub_no as 과목번호, stu_no as 학생번호, enr_grade as 점수 from enrol;

select sub_no as 과목번호, sub_name 과목이름, sub_prof 교수이름, sub_grade 과목점수, sub_dept 과목학과 from subject;

select stu_dept|| stu_name as 학과명이름합침 from student;

SELECT STU_DEPT ||'과'||' ' || STU_NAME ||'입니다.' AS 학과성명 FROM STUDENT;

SELECT * FROM STUDENT WHERE stu_weight>=65;

select stu_no, stu_name from student where  stu_dept='컴퓨터정보';

select stu_name from student where stu_gender='M';

select stu_no from enrol where enr_grade >=80;

select * from student where stu_name='김인중';

select * from student where stu_dept='컴퓨터정보' and stu_grade = 1;
select * from student where stu_dept='기계' and stu_grade = 2;
select * from student where stu_gender='F' and stu_weight<=60;

SELECT * FROM STUDENT WHERE STU_DEPT IN('기계','전기전자') and stu_grade =1;

select * from student where stu_dept='컴퓨터정보' and stu_class='A' and stu_grade='2';
select stu_no, stu_name from student where stu_height between 160 and 170;

SELECT stu_no, stu_name, stu_dept FROM STUDENT WHERE STU_NO LIKE '2013%';

select * from student where stu_grade in(1,3);

SELECT * FROM STUDENT WHERE STU_no LIKE '____20%';

select stu_name from student where stu_no like '2014%';

SELECT stu_no, stu_name FROM STUDENT WHERE STU_HEIGHT IS not null;

select stu_no, stu_name from student order by stu_no asc;

select stu_no, stu_name from student order by stu_name asc;

select * from student order by stu_dept asc,stu_grade desc;

select * from student order by stu_dept asc, stu_class asc;

select stu_no, stu_name from student order by stu_dept, stu_gender, stu_grade asc;

SELECT upper(stu_gender) FROM student;

select stu_dept ||'과 ' ||stu_grade ||'학년 '||  stu_name||'입니다.' as 전체합 from student;

SELECT stu_name, SUBSTR(stu_name,1,2) 이름 FROM student;

SELECT stu_name, stu_dept, SUBSTR(stu_dept,2,1) 이름 FROM student;

select stu_dept, length(stu_dept) from student;

select stu_name, instr(stu_name,'김') from student;

select stu_dept, instr(stu_dept,'기') from student;