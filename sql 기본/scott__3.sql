create table a_student
as select *
from student
WHERE STU_DEPT IN('���','��������');

select * from a_student;

create table b_student
as select *
from student
where stu_dept in('��������','��ǻ������');

select * from b_student;

--�ߺ��Ȱ� ����
select * from a_student
union
select * from b_student;

--�ߺ����� ����
select * from a_student
union all
select * from b_student;

--������
select * from a_student
intersect
select * from b_student;

--������ ����
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

--20150062 ������ �л��� 108�� ������ ����Ʈ���� ���� ������ �����Ͽ�
--92���� �޾Ҵ�.

--������
insert into a_enrol values(108,20150062,92);
select * from a_enrol;
--�����
insert into a_enrol(sub_no, stu_no) values(110,20152008);
select * from a_enrol;

insert into a_enrol values(111,20152018,null);
select * from a_enrol;

--������ ���� ����ִ� ���
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
--create�� DDL ��ɾ��, �ڵ����� commit�ǹǷ�, rollback�� �ص� �ȵ��ƿ´�.
--DROP�� DDL��ɾ��, �ڵ����� COMMIT �ǰ�, ���� ���̺� ��ü�� ������Ų��.
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
VALUES(10,'ȫ');
COMMIT;
