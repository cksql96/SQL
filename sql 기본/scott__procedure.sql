--���� ���ν���
--�й��� �г��� �Է��� �Ͽ� �ش��л��� �г��� �����ϴ� ���
--�Ű����� �ܺο��� �־����� ���� - INPUT ��




CREATE PROCEDURE TEST2(
    V_STU_NO IN STUDENT.STU_NO%TYPE,        --�Ǵ� V_STU_NO IN NUMBER. �̰Ŵ� V_STU_NO�� Ÿ���� STUDENT.STU_NO�� Ÿ�԰� ���� ��� ���̴�.
    V_STU_GRADE IN STUDENT.STU_GRADE%TYPE)
        IS                                      
            HCH VARCHAR2(30);
        BEGIN
            UPDATE STUDENT
            SET STU_GRADE = V_STU_GRADE
            WHERE STU_NO = V_STU_NO;
END TEST2;

SELECT * FROM STUDENT;

EXECUTE TEST2(20153075,2);              --20153075��� STU_NO�� ���� �л��� STU_GRADE�� 2�� �ٲ۴�.

DROP PROCEDURE TEST2;                   --���ν����� �����Ҷ�

--�й��� �Է����� �л��� �̸��� �˻��ϴ� ���ν�����?
CREATE PROCEDURE TEST3(
    V_STU_NO IN STUDENT.STU_NO%TYPE,
    V_STU_NAME OUT STUDENT.STU_NAME%TYPE)
        IS
        BEGIN
            SELECT STU_NAME
            INTO V_STU_NAME
            FROM STUDENT
            WHERE STU_NO = V_STU_NO;
END TEST3;
/

VARIABLE C_STU_NAME VARCHAR2(20);       --������ �������ֱ�
EXECUTE TEST3(20153075,:C_STU_NAME);
PRINT C_STU_NAME;

VARIABLE BBB VARCHAR2(20);              --��������� ����
EXECUTE TEST3(20153088,:BBB);           --PL/SQL ���ν����� ���������� �Ϸ�
PRINT BBB;                              --BBB -------- ���¿�

--�л��� �������̺��� ����������ŭ �÷��ְ� �� ����� ����ϴ� ���ν���?
CREATE PROCEDURE TEST4 (
    V_SUB_NO IN ENROL.SUB_NO%TYPE,
    V_STU_NO IN ENROL.STU_NO%TYPE,
    V_ENR_GRADE IN OUT ENROL.ENR_GRADE%TYPE)
        IS
        BEGIN
            UPDATE ENROL
            SET ENR_GRADE = ENR_GRADE + V_ENR_GRADE
            WHERE STU_NO = V_STU_NO AND SUB_NO = V_SUB_NO;
            SELECT ENR_GRADE
            INTO V_ENR_GRADE
            FROM ENROL
            WHERE STU_NO = V_STU_NO AND SUB_NO = V_SUB_NO;
END TEST4;
/

VARIABLE D_ENR_GRADE NUMBER
BEGIN :D_ENR_GRADE := 10; END;
/

SELECT * FROM ENROL;

EXECUTE TEST4(101,20131001,:D_ENR_GRADE);

PRINT D_ENR_GRADE;

--------------------------------------------------------------
--������
CREATE SEQUENCE SEQ2
INCREMENT BY 1
START WITH 201
MAXVALUE 999;

SELECT SEQ2.NEXTVAL FROM DUAL;

DROP SEQUENCE SEQ2;

CREATE PROCEDURE TEST5(
    V_SUB_NAME IN SUBJECT.SUB_NAME%TYPE,
    V_SUB_PROF IN SUBJECT.SUB_PROF%TYPE,
    V_SUB_GRADE IN SUBJECT.SUB_GRADE%TYPE,
    V_SUB_DEPT IN SUBJECT.SUB_DEPT%TYPE)
        IS
        BEGIN INSERT INTO SUBJECT
            VALUES(SEQ2.NEXTVAL, V_SUB_NAME,V_SUB_PROF,V_SUB_GRADE,V_SUB_DEPT);
            COMMIT;
END TEST5;
/

SELECT * FROM SUBJECT;

EXECUTE TEST5('�����α׷���','ȫ�浿',3,'��ǻ������');

-----------------------------------------------------------------------
--FUNCTION() ????
--������ �Է¹޾� ����� �������� ��½�Ű�� �Լ�??
CREATE FUNCTION TEST6(V_ENR_GRADE IN NUMBER) RETURN CHAR
    IS ENR_SCORE CHAR;
    BEGIN
        IF V_ENR_GRADE >= 90 THEN ENR_SCORE := 'A';
        ELSIF V_ENR_GRADE >=80 THEN ENR_SCORE := 'B';
        ELSIF V_ENR_GRADE >=70 THEN ENR_SCORE := 'C';
        ELSIF V_ENR_GRADE >=60 THEN ENR_SCORE := 'D';
        ELSE ENR_SCORE := 'F';
        END IF;
    RETURN (ENR_SCORE);
END TEST6;
/

VARIABLE D_SCORE CHAR;

EXECUTE :D_SCORE := TEST6(95);

PRINT D_SCORE;

SELECT ENR_GRADE,TEST6(ENR_GRADE) AS SCORE
FROM ENROL;

---------------------------------------------------------------------
--CURSOR & FETCH

CREATE PROCEDURE TEST7 IS
        V_STU_NO ENROL.STU_NO%TYPE;
        V_SUB_NO ENROL.SUB_NO%TYPE;
        V_ENR_GRADE ENROL.ENR_GRADE%TYPE;
    
    CURSOR T_CURSOR IS
    SELECT STU_NO, SUB_NO, ENR_GRADE
    FROM ENROL
    WHERE SUB_NO = '101';
    
    BEGIN    
        OPEN T_CURSOR;                                                          --OPEN / CLOSE
            LOOP                                                                    --LOOP / END LOOP
                FETCH T_CURSOR INTO V_STU_NO, V_SUB_NO, V_ENR_GRADE;
                EXIT WHEN T_CURSOR%NOTFOUND;          
                DBMS_OUTPUT.PUT_LINE(V_STU_NO||' '||V_SUB_NO||' '||V_ENR_GRADE);
            END LOOP;
        CLOSE T_CURSOR;
        
END TEST7;
/

DROP PROCEDURE TEST7;


EXECUTE TEST7;
SET SERVEROUTPUT ON;                --DBMS_OUTPUT.PUT_LINE�� ������ �̰��� �¾� ������ߵȴ�.

SELECT * FROM ENROL;
DESC ENROL;
DESC TEST7;

------------------------------------------------------------------------------------------------------
--FOR���� ����Ͽ� ����Ǵ� ���ν���             --INPUT�� ����. ���� CURSOR�� OPEN�� ������ ����. �ڵ����� �����ȿ� �ִ� ��� ������ �����Ƿ�
CREATE PROCEDURE TEST8                                                          --TEST 8 �� �����.(INPUT�� ���⶧����, ()�� ���ص� �ȴ�.
    IS                                                                          --���� ����!!
        V_ENROL ENROL%ROWTYPE;                                                  --V_ENROL �̶�°���, Ÿ����? ENROL�� �ִ� ��� ���� Ÿ�Ե��� �� �����´�.    
    CURSOR T_CURSOR                                                             --Ŀ���� �����. �̵� ���������� (INPUT�� ����) ��� ������ �ȴ´�.
    IS                                                                          --�׷� BASED ON WHAT? �ֶ� �װ� �̵���
    SELECT STU_NO, SUB_NO, ENR_GRADE                                            --STU_NO, SUB_NO, ENR_GRADE�� ������ ������
    FROM ENROL                                                                  --���? ENROL���̺���
    WHERE SUB_NO = '101';                                                       --��¿��? SUB_NO�� 101�϶�. Ŀ���� BASED ON SUB_NO='101'�� ���� �����̰� ã�´�.
    
    BEGIN                                                                       --���๮
        FOR V_ENROL IN T_CURSOR                                                 --V_ENROL�̶�� ������ T_CURSOR�� ���� ����.���ǵ�.
        LOOP                                                                    --������ ����
            EXIT WHEN T_CURSOR%NOTFOUND;                                        --���� ������ ����? Ŀ���� �ϰ͵� ��ã����
            DBMS_OUTPUT.PUT_LINE(V_ENROL.STU_NO||' '||V_ENROL.SUB_NO||' '||V_ENROL.ENR_GRADE);      --����Ѵ���
        END LOOP;                                                               --������ ��
END TEST8;                                                                      --TEST8 ��
/

DROP PROCEDURE TEST8;

EXECUTE TEST8;
--------------------------------------------------------------------------------------------------------
--Ŀ���� �̿��Ͽ�, �����ȣ ���濡 ���� OUTPUT�� �ٸ��� ������
CREATE PROCEDURE TEST9(                                                         --TEST9�� �����.
    V_SUB_NO IN ENROL.SUB_NO%TYPE)                                              --INPUT�� V_SUB_NO�� �ִµ�, Ÿ���� ENROL�� SUB_NO�� ����.
    IS                                                                          --�������𰣴�
        V_STU_NO ENROL.STU_NO%TYPE;                                             --V_STU_NO Ÿ���� ENROL�� STU_NO�� ����.
        V_ENR_GRADE ENROL.ENR_GRADE%TYPE;                                       --V_ENR_GRADE Ÿ���� ENROL�� ENR_GRADE�� ����.
    CURSOR T_CURSOR(                                                            --Ŀ���� �ϳ� �����. �̸��� T_CURSOR. 
        V_SUB_NO NUMBER)                                                        --��ǲ�� V_SUB_NO, ����ڰ� �Է��ߴ� �� ������ �״��. SUB_NO�� ���� Ŀ���� ��ġ�� �ٲ��.
        IS                                                                      --Ŀ���� �����ϴ� �� ��ġ���� ��� ������ �����ð��ΰ�??(����������� ���� �ٸ���)
            SELECT STUDENT.STU_NO, ENR_GRADE                                    --ENR_GRADE�� STUDENT�� �ִ� STU_NO�� ������ �����´�.
            FROM STUDENT,ENROL                                                  --���? STUDENT�� ENROL����
            WHERE STUDENT.STU_NO = ENROL.STU_NO AND ENROL.SUB_NO = V_SUB_NO;    --��¿��? STUDENT�� �ִ� STU_NO�� ENROL�� �ִ� STU_NO�� ������(���ι�) �׸���!! SUB_NO�� V_SUB_NO�� ������!(INPUT���� �����Ҷ�!)
            
    BEGIN                                                                       --���๮�� �����Ѵ�.
        OPEN T_CURSOR(V_SUB_NO);                                                --T_CURSOR�� �����Ѵ�.               CURSOR�� Ŀ�� ��ġ�� �ΰ�, �� ���� �ִ� ������ �� �������°ſ� ���ٰ� �����Ѵ�.
            LOOP                                                                --������ ����                    ������ CURSOR�� �پ�ٴϴ°� ����, ������ �ѹ� ������, Ŀ���� �ڵ����� �����ٷ� �̵��Ѵ�.!
                FETCH T_CURSOR INTO V_STU_NO,V_ENR_GRADE;                       --T_CURSOR�� ������ �����´�. �����°���, V_STU_NO, V_ENR_GRADE�� �ִ´�.
                EXIT WHEN T_CURSOR%NOTFOUND;                                    --������ �������´�. ����? T_CURSOR�� �ƹ��͵� ��ã����, NULL�϶�!
                DBMS_OUTPUT.PUT_LINE(V_STU_NO||' '||V_ENR_GRADE);               --�ƴϸ�, �� Ŀ���� �ִ� V_STU_NO�� V_ENR_GRADE�� ����Ѵ�.
            END LOOP;                                                           --������ ��
        CLOSE T_CURSOR;                                                         --Ŀ�������� ��
END TEST9;                                                                      --TEST9 ��
/

EXECUTE TEST9(101);

-----------------------------------------------------------------------------------
--����ó����
CREATE OR REPLACE PROCEDURE TEST10(                 --OR REPLACE�� ���°���, ���࿡ �� ���̺� ������ ������� ������Ѵ�.
    V_STU_NO IN STUDENT.STU_NO%TYPE)                --�ۿ��� ������ INPUT�� ���⿡ �����Ѵ�.
    IS
        V_STU_NAME STUDENT.STU_NAME%TYPE;           --��������. BEGIN���� �������ؼ�. �������ִ°�.
    BEGIN                                           --���๮
        SELECT STU_NAME INTO V_STU_NAME             --STU_NAME�� V_STU_NAME�� �ִ´�.
        FROM STUDENT                                --���? STUDENT ���̺���
        WHERE STU_NO = V_STU_NO;                    --STU_NO�� V_STU_NO�� ������!! (���� ù�ٿ� ������ �ۿ��� ���� INPUT���� STU_NO���..->(�ִٸ�))
        DBMS_OUTPUT.PUT_LINE(V_STU_NAME);           --�׷��� V_STU_NAME�� ����Ѵ�.
        
        EXCEPTION                                   --����(������)
        WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('�ش� �����Ͱ� �����ϴ�.');      --������ ���ٴ� ��¹� ������.
END TEST10;
/

EXECUTE TEST10(20153088);

--------------------------------------------------------------------------------
--���α׷��Ӱ� ����ó�� �̸��� �����ϴ� ���?
CREATE OR REPLACE PROCEDURE TEST11(                                             --test11�����~�ȿ� �������? �Ʒ���
    V_SUB_NO IN ENROL.SUB_NO%TYPE)                                              --INPUT���� V_SUB_NO�� �鰣��.
    IS                                                                          --���� ���� ������
        V_CNT NUMBER;                                                           --V_CNT�� NUMBERŸ���̰�
        CNT_ERROR EXCEPTION;                                                    --CNT_ERROR�� ����Ÿ���̴�.
    BEGIN                                                                       --���๮
        SELECT COUNT(STU_NO) INTO V_CNT                                         --COUNT(STU_NO)�� V_CNT�� ����־�
        FROM ENROL                                                              --���? ENROL���̺���
        WHERE SUB_NO = V_SUB_NO;                                                --��¿��? SUB_NO�� V_SUB_NO(INPUT��)�� ������! (������!)
        
        IF V_CNT = 0 THEN RAISE CNT_ERROR;                                      --���� COUNT�� 0�̸�?(���ٸ�?) CNT_ERROR������ �����϶�.
        END IF;                                                                 --IF�� ��. (���̻� ���� ������ ����)
        
        DBMS_OUTPUT.PUT_LINE(V_SUB_NO||'��������ڴ� '||V_CNT||'�� �Դϴ�.');      --IF���� �Ȱɸ��ٸ�? �̰� �����
        
        EXCEPTION                                                               --���ܷ�,
        WHEN CNT_ERROR THEN DBMS_OUTPUT.PUT_LINE('�ƹ��� ������');                --CNT_ERROR������ ����Ǹ�, ������ ����϶�.
        
END TEST11;                                                                     --TEST11��~
/

EXECUTE TEST11(109);

--------------------------------------------------------------------------------
--�޿��� 2000�̻��� ����� �����ȣ, ����̸�, �μ��̸��� �μ� �̸������� �˻��ϴ� ���ν����� �ۼ��Ͻÿ�
CREATE OR REPLACE PROCEDURE PRO1
    IS                                                                          --��������
        V_EMPNO NUMBER;                                                         --�����ȣ
        V_ENAME EMP.ENAME%TYPE;                                                 --����̸�
        V_DNAME DEPT.DNAME%TYPE;                                                --�μ��̸�
        
    CURSOR RESULT IS                                                            --�����
        SELECT EMPNO, ENAME, DNAME
        FROM EMP NATURAL JOIN DEPT
        WHERE SAL >= 2000                                                       --SAL�� 2000�̻��ΰ͵鸸 Ŀ���� �д�.
        ORDER BY DNAME;
    
    BEGIN                                                                       --���๮
    OPEN RESULT;
        LOOP
            FETCH RESULT INTO V_EMPNO, V_ENAME, V_DNAME;                            
            EXIT WHEN RESULT%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('�����ȣ: '||V_EMPNO||'     ����̸�: '||V_ENAME||'     �μ��̸�: '||V_DNAME);
        END LOOP;
    CLOSE RESULT;
END PRO1;
/

EXECUTE PRO1;


SET SERVEROUTPUT ON;
