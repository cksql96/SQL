create table a_student
as select *
from student
WHERE STU_DEPT IN('기계','전기전자');

select * from a_student;

create table b_student
as select *
from student
where stu_dept in('전기전자','컴퓨터정보');

select * from b_student;

--중복된거 없앰
select * from a_student
union
select * from b_student;

--중복까지 포함
select * from a_student
union all
select * from b_student;

--교집합
select * from a_student
intersect
select * from b_student;

--같은걸 빼기
select * from a_student
minus
select * from b_student;

--DML...?
--insert()
create table a_enrol
as
select *
from enrol
where stu_no <20150000;

select * from a_enrol;

--20150062 김인중 학생이 108번 과목인 소프트웨어 공학 과목을 수강하여
--92점을 받았다.

--인위적
insert into a_enrol values(108,20150062,92);
select * from a_enrol;
--명시적
insert into a_enrol(sub_no, stu_no) values(110,20152008);
select * from a_enrol;

insert into a_enrol values(111,20152018,null);
select * from a_enrol;

--복수의 행을 집어넣는 방법
select * from enrol
where stu_no like '2015%';

insert into a_enrol
select * from enrol
where stu_no like '2015%';
select * from a_enrol;



UPDATE STUDENT1
SET STU_CLASS ='B'
WHERE STU_NO = 20142021;

--TCL
--Transaction control lang. 
--commit/rollback
select * from b_student;
delete from b_student;
select * from b_student; 
rollback;



--DDL(Data Definition Language)
--create가 DDL 명령어로, 자동으로 commit되므로, rollback을 해도 안돌아온다.
--DROP은 DDL명령어로, 자동으로 COMMIT 되고, 또한 테이블 자체를 삭제시킨다.
delete from b_student;
select * from b_student;
create table c_student (stu_ni number, stu_name char(10) );
rollback;
select * from b_student;
SELECT * FROM A_STUDENT;
DELETE A_STUDENT;
ROLLBACK;

SELECT * FROM A_STUDENT;
INSERT INTO A_STUDENT(STU_NO,STU_NAME)
VALUES(10,'홍');
COMMIT;
