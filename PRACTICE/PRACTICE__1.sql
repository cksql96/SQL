--SQL �� ���� �����
--
--CMD ������ ���� ����
--
--SQLPLUS
--
--SYSTEM    123456
--
--CREATE USER HCH IDENTIFIED BY 123456;
--
--GRANT CONNECT,RESOURCE,DBA TO HCH

--1������
CREATE TABLE PRODUCT(
P_CODE  CHAR(3),
P_NAME  VARCHAR2(30),
P_COST  NUMBER,
P_GROUP VARCHAR2(30),
CONSTRAINT PK_P_CODE PRIMARY KEY(P_CODE));

--2������
DESC PRODUCT;

--3������
INSERT INTO PRODUCT VALUES ('101','19��ġ �����',150000,'�����');
INSERT INTO PRODUCT VALUES ('102','22��ġ �����',200000,'�����');
INSERT INTO PRODUCT VALUES ('103','25��ġ �����',260000,'�����');
INSERT INTO PRODUCT VALUES ('201','�������콺',7000,'���콺');
INSERT INTO PRODUCT VALUES ('202','�������콺',18000,'���콺');
INSERT INTO PRODUCT VALUES ('301','����Ű����',8000,'Ű����');
INSERT INTO PRODUCT VALUES ('302','����Ű����',22000,'Ű����');
INSERT INTO PRODUCT VALUES ('401','2ä�� ����Ŀ',10000,'����Ŀ');
INSERT INTO PRODUCT VALUES ('402','5.1ä�� ����Ŀ',120000,'����Ŀ');

--4������
SELECT * FROM PRODUCT;

--5������
CREATE TABLE TRADE(
T_SEQ   NUMBER,
P_CODE  CHAR(3),
C_CODE  VARCHAR2(4),
T_DATE  DATE,
T_QTY   NUMBER,
T_COST  NUMBER,
T_TAX   NUMBER,
CONSTRAINT PK_T_SEQ PRIMARY KEY(T_SEQ));

--6������
DESC TRADE;

--7������
INSERT INTO TRADE VALUES(61,'131','101',TO_DATE('2016-04-01','YYYY-MM-DD'),10,150000,150000);
INSERT INTO TRADE VALUES(5,'102','102',TO_DATE('2016-04-26','YYYY-MM-DD'),8,200000,150000);
INSERT INTO TRADE VALUES(8,'103','101',TO_DATE('2016-05-20','YYYY-MM-DD'),2,260000,150000);
INSERT INTO TRADE VALUES(3,'201','103',TO_DATE('2016-04-13','YYYY-MM-DD'),7,7000,150000);
INSERT INTO TRADE VALUES(2,'201','201',TO_DATE('2016-04-12','YYYY-MM-DD'),5,7000,150000);
INSERT INTO TRADE VALUES(9,'202','104',TO_DATE('2016-06-02','YYYY-MM-DD'),8,18000,150000);
INSERT INTO TRADE VALUES(6,'301','103',TO_DATE('2016-05-02','YYYY-MM-DD'),12,8000,150000);
INSERT INTO TRADE VALUES(10,'302','103',TO_DATE('2016-06-09','YYYY-MM-DD'),9,22000,150000);
INSERT INTO TRADE VALUES(4,'401','104',TO_DATE('2016-04-20','YYYY-MM-DD'),15,10000,150000);
INSERT INTO TRADE VALUES(11,'401','105',TO_DATE('2016-06-15','YYYY-MM-DD'),20,10000,150000);
INSERT INTO TRADE VALUES(7,'402','102',TO_DATE('2016-05-08','YYYY-MM-DD'),5,120000,150000);

--8������
SELECT * FROM TRADE;

--9������
CREATE TABLE CUSTOMER(
C_CODE  VARCHAR2(4),
C_NAME  VARCHAR2(30),
C_CEO   VARCHAR2(12),
C_ADDR  VARCHAR2(100),
C_PHONE VARCHAR2(13),
CONSTRAINT PK_C_CODE PRIMARY KEY (C_CODE));

--10������
DESC CUSTOMER;

--11������
INSERT INTO CUSTOMER VALUES('101','��Ǫ��ȸ��','�����','��⵵ �Ȼ��','010-1234-5678');
INSERT INTO CUSTOMER VALUES('102','������ٴ�','�ڳ���','��⵵ ���ý�','010-1122-3344');
INSERT INTO CUSTOMER VALUES('103','����ȸ��','�̹μ�','����� ���α�','010-3785-8809');
INSERT INTO CUSTOMER VALUES('104','�Ͼ����','������','���ϵ� ���׽�','010-8569-3468');
INSERT INTO CUSTOMER VALUES('105','�Ѹ����Ѷ�','�Ϲο�','��õ�� ������','010-9455-6033');

--12������
SELECT * FROM CUSTOMER;

--13������
CREATE TABLE STOCK(
P_CODE      CHAR(3),
S_QTY       NUMBER,
S_LASTDATE  DATE,
CONSTRAINT PK_P_CODE_S_QTY PRIMARY KEY(P_CODE,S_QTY));

--14������
DESC STOCK;

--15������
INSERT INTO STOCK VALUES('101',50,TO_DATE('2016-04-01','YYYY-MM-DD'));
INSERT INTO STOCK VALUES('102',20,TO_DATE('2016-04-26','YYYY-MM-DD'));
INSERT INTO STOCK VALUES('103',5,TO_DATE('2016-05-20','YYYY-MM-DD'));
INSERT INTO STOCK VALUES('201',2,TO_DATE('2016-04-13','YYYY-MM-DD'));
INSERT INTO STOCK VALUES('202',15,TO_DATE('2016-06-02','YYYY-MM-DD'));
INSERT INTO STOCK VALUES('301',0,TO_DATE('2016-05-02','YYYY-MM-DD'));
INSERT INTO STOCK VALUES('302',20,TO_DATE('2016-06-09','YYYY-MM-DD'));
INSERT INTO STOCK VALUES('401',10,TO_DATE('2016-06-15','YYYY-MM-DD'));
INSERT INTO STOCK VALUES('402',7,TO_DATE('2016-05-08','YYYY-MM-DD'));

--16������
SELECT * FROM STOCK;

--17������
ALTER TABLE PRODUCT
ADD(��� VARCHAR2(20));

--18������
SELECT * FROM PRODUCT;

--19������
ALTER TABLE PRODUCT
MODIFY(��� NUMBER);

--20������
DESC PRODUCT;

--21������
ALTER TABLE PRODUCT
DROP(���);

--22������
DESC PRODUCT;

--23������
RENAME PRODUCT TO PRODUCT1;

--24������
SELECT TABLE_NAME FROM USER_TABLES;

--25������
DELETE PRODUCT1;

--26������
SELECT * FROM PRODUCT1;

--27������
DROP TABLE PRODUCT1;

--28������
SELECT TABLE_NAME FROM USER_TABLES;

--29������
--PASS!!

--30������
CREATE VIEW V_TRADE
AS
SELECT * FROM TRADE
WHERE P_CODE=401;

--31������
SELECT * FROM V_TRADE;

--32������
SELECT C_CODE FROM TRADE
WHERE T_DATE = (SELECT MAX(T_DATE) FROM TRADE);