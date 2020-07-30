--�������̺��� �ְ������� ���������� �˻��϶�.
SELECT MAX(ENR_GRADE),MIN(ENR_GRADE)
FROM ENROL;

--�л����̺��� ������ ����ü�߰� �ְ�ü���� �˻��϶�.
SELECT MIN(STU_WEIGHT),MAX(STU_WEIGHT)
FROM STUDENT
WHERE STU_DEPT='���';

--�ȵȴ�. STUNAME�� ��� �л��� ��Ÿ���ߵǰ�, MIN(STU_WEIGHT)�� �ּҰ��� ���ؾ� �ϹǷ�. ��� �л��� ������1���� �ȵȴ�. ���� ��������Ѵ�.
SELECT STU_NAME, MIN(STU_WEIGHT)
FROM STUDENT;

--��Ī(ALIAS)�� ����Ͽ� �л� ���̺��� �л�, ������, �ش� �л���, ��� �������� �����͸� �˻��϶�
--�ڿ� �ٴ� �ѱ��� �� �̸��� �ٲ��ش�. AS�� �����Ȱ�.
SELECT COUNT(*) AS �л�, SUM(STU_HEIGHT) ������,
COUNT(STU_HEIGHT) �ش��л���, AVG(STU_HEIGHT) ��ս���
FROM STUDENT;

--GROUP BY��, �л� ���̺��� �а��� ��� ü���� ���϶�? ��ҹ��� ���� ���ص���
select STU_DEPT, AVG(STU_WEIGHT)
FROM STUDENT
GROUP BY STU_DEPT;
--�л� ���̺��� ü���� 50Ű�� �̻��� �л��鸸 �а����� �����Ͽ� �׷캰 �л����� �˻��϶�
select stu_dept, count(*)
from student
where stu_weight>=50
group by stu_dept;

--�л����̺��� �а���, �г⺰�� �׷�ȭ �Ͽ� �л����� �˻��϶�
select stu_dept, stu_grade, count(*)
from student
group by stu_dept, stu_grade;

--HAVING ��? ���� �л����߿��� �г⺰ ��ս����� 160�̻��� �г�� ��� ������ �˻��϶�.
select stu_grade, avg(stu_height)
from student
where stu_dept='���'
group by stu_grade having avg(stu_height)>=160 ;

--�ִ� ������ 175�̻��� �а��� �а��� �ִ� ������ ���϶�
select stu_dept, max(stu_height)
from student
group by stu_dept having max(stu_height)>=0; -- 0���� 175 �ϸ� ������ ���� ��.

--�а��� ��� ������ ���� ���� ��� ������ ���϶�?
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

select sub_no as �����ȣ, stu_no as �л���ȣ, enr_grade as ���� from enrol;

select sub_no as �����ȣ, sub_name �����̸�, sub_prof �����̸�, sub_grade ��������, sub_dept �����а� from subject;

select stu_dept|| stu_name as �а����̸���ħ from student;

SELECT STU_DEPT ||'��'||' ' || STU_NAME ||'�Դϴ�.' AS �а����� FROM STUDENT;

SELECT * FROM STUDENT WHERE stu_weight>=65;

select stu_no, stu_name from student where  stu_dept='��ǻ������';

select stu_name from student where stu_gender='M';

select stu_no from enrol where enr_grade >=80;

select * from student where stu_name='������';

select * from student where stu_dept='��ǻ������' and stu_grade = 1;
select * from student where stu_dept='���' and stu_grade = 2;
select * from student where stu_gender='F' and stu_weight<=60;

SELECT * FROM STUDENT WHERE STU_DEPT IN('���','��������') and stu_grade =1;

select * from student where stu_dept='��ǻ������' and stu_class='A' and stu_grade='2';
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

select stu_dept ||'�� ' ||stu_grade ||'�г� '||  stu_name||'�Դϴ�.' as ��ü�� from student;

SELECT stu_name, SUBSTR(stu_name,1,2) �̸� FROM student;

SELECT stu_name, stu_dept, SUBSTR(stu_dept,2,1) �̸� FROM student;

select stu_dept, length(stu_dept) from student;

select stu_name, instr(stu_name,'��') from student;

select stu_dept, instr(stu_dept,'��') from student;