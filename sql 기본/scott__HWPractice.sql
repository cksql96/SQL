create table student1
as select * from student where stu_grade in (1,2);

create table subject1
as select * from subject;

create table enrol1
as select * from enrol;

select * from student1;

select * from subject1;

select * from enrol1;

INSERT INTO STUDENT1 VALUES (20101059,'조병준','컴퓨터정보',1,'B','M',164,70);

INSERT INTO STUDENT1 VALUES (20102038,'남지선','전기전자',1,'C','F',NULL,NULL);

insert into a_enrol
select * from enrol
where stu_no like '2015%';
select * from a_enrol;

DELETE FROM STUDENT1
WHERE STU_NAME ='박소신';

INSERT INTO STUDENT1 (STU_NO,STU_NAME,STU_DEPT,STU_GRADE,STU_CLASS,STU_GENDER)
VALUES(20103009,'박소신','기계', 
(SELECT STU_GRADE FROM STUDENT1 WHERE STU_NO='20153075'),
(SELECT STU_CLASS FROM STUDENT1 WHERE STU_NO='20153075'), 'M');

INSERT INTO STUDENT1
SELECT * FROM STUDENT
WHERE STU_GRADE = 3;

UPDATE STUDENT1
SET STU_CLASS ='B'
WHERE STU_NO = 20142021;

UPDATE STUDENT1
SET STU_HEIGHT = STU_HEIGHT + 2
WHERE STU_NO=20101059;

UPDATE STUDENT1
SET STU_GRADE = STU_GRADE + 1;

UPDATE ENROL1 
SET ENR_GRADE = ENR_GRADE - 10
WHERE SUB_NO = (SELECT SUB_NO FROM SUBJECT1 NATURAL JOIN ENROL1
WHERE SUB_NAME='전자회로실험');


UPDATE ENROL1
SET ENR_GRADE = 0
WHERE STU_NO = 20151062
AND SUB_NO = (SELECT SUB_NO FROM SUBJECT1 NATURAL JOIN ENROL1
WHERE SUB_NAME='소프트웨어공학');

DELETE STUDENT1
WHERE STU_NO = 20153088;

SELECT * FROM STUDENT1;
SELECT * FROM ENROL1;
SELECT * FROM SUBJECT1;

INSERT INTO SUBJECT1 VALUES(112,'자동화시스템','고종민',3,'기계');

UPDATE SUBJECT1
SET SUB_NO = 501
WHERE SUB_NO=110;

DELETE SUBJECT1
WHERE SUB_NO=101;

UPDATE ENROL1
SET SUB_NO = 999
WHERE SUB_NO NOT IN(SELECT SUB_NO FROM SUBJECT1);

UPDATE ENROL1
SET STU_NO = 99999999
WHERE STU_NO NOT IN(SELECT STU_NO FROM STUDENT1);

DELETE ENROL1
WHERE SUB_NO = 999;

DELETE ENROL1
WHERE STU_NO = 99999999;

DELETE SUBJECT1
WHERE SUB_NO NOT IN (SELECT SUB_NO FROM ENROL1);

DROP TABLE ENROL1;



