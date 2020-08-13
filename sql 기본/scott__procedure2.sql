--���Ի���� ä���Ͽ���. �����ȣ, ����̸�, �������, ����ڻ����ȣ, �޿�, �μ���ȣ�� 
--�Է¹޾� ������̺� �����ϴ� ���ν����� �ۼ��϶�.
CREATE OR REPLACE PROCEDURE PRO2(                                               --PRO2�� ����ų�, �ִٸ� �ٲ��.
    V_EMPNO IN EMP.EMPNO%TYPE,                                                  --�����ȣ
    V_ENAME IN EMP.ENAME%TYPE,                                                  --����̸�
    V_JOB IN EMP.JOB%TYPE,                                                      --�������
    V_MGR IN EMP.MGR%TYPE,                                                      --����ڻ����ȣ
    V_SAL IN EMP.SAL%TYPE,                                                      --�޿�
    V_DEPTNO IN EMP.DEPTNO%TYPE)                                                --�μ���ȣ
    
    IS                                                                          --������ ������ �����Ƿ� �н�.
    BEGIN                                                                       --���๮
        INSERT INTO EMP                                                         --EMP���ٰ� �����ž�!
        VALUES(V_EMPNO, V_ENAME, V_JOB, V_MGR, NULL, V_SAL, NULL, V_DEPTNO);    --�� ����!! ����ڰ� ����, 6����, EMP�࿡ ������ ����ڰ� �������Ѱ���, NULL��.
        COMMIT;                                                                 --Ŀ���ض�!! �����ض�!! �ѹ��ص� �ȵ��ƿ�.
END PRO2;                                                                       --PRO2 ��!
/

EXECUTE PRO2(0703,'HCH','���',1234,3000,10);
SELECT * FROM EMP;
--------------------------------------------------------------------------------
--�μ���ȣ�� �����ϴ� ���ν����� �ۼ��϶�.
CREATE OR REPLACE PROCEDURE PRO3(                                               --PRO3�� ������
    V_EMPNO IN EMP.EMPNO%TYPE,                                                  --�����ȣ
    V_DEPTNO IN EMP.DEPTNO%TYPE)                                                --�μ���ȣ
    
    IS                                                                          --���������� �����Ƿ� �н�
    BEGIN                                                                       --���๮
        UPDATE EMP                                                              --EMP�� �ٲ۴�.(�����Ѵ�.)
        SET DEPTNO = V_DEPTNO                                                   --DEPTNO�� V_DEPTNO�� �ٲ��ش�(������Ų��.) V_DEPTNO�� V_EMPNO�� ����ڰ� �Է��Ѽ�.
        WHERE EMPNO = V_EMPNO;                                                  --��¿��? EMPNO�� V_EMPNO�� ������!
        COMMIT;                                                                 --�����Ѵ�.
        
END PRO3;                                                                       --PRO3 ��
/

EXECUTE PRO3(703,20);

--------------------------------------------------------------------------------
--�ְ�޿��� �޴� ��� �̸��� ����ϴ� �Լ��� �ۼ��Ͻÿ�?
CREATE OR REPLACE FUNCTION PRO4                                                 --PRO4 ������(�Լ���) FUNCTION
    RETURN EMP.ENAME%TYPE                                                       --������ �Ҷ�, EMP�� �ִ� ENAME�� Ÿ���� �����´�. �ƴϸ� RETURN CHAR �ص� �ȴ�.
    IS                                                                          --������������.
        V_ENAME EMP.ENAME%TYPE;                                                 --V ENAME�� ����� Ÿ���� ENAME�� ����.
    BEGIN                                                                       --���๮
        SELECT ENAME INTO V_ENAME                                               --ENAME�� �����ϴµ�, �̰��� V_NAME�� �ִ´�.
        FROM EMP                                                                --���? EMP ���̺���
        WHERE SAL = (SELECT MAX(SAL) FROM EMP);                                 --��¿��? SAL �� (MAX(SAL)�϶�!, ��� SAL���� ���ϳ�? EMP ���̺���!
        RETURN V_ENAME;                                                         --V_ENAME�� ����� �����Ѵ�.
END PRO4;                                                                       --PRO 4 ��
/
SELECT DISTINCT PRO4 FROM EMP;                                                  --DISTINCT�� �ߺ��� �����Ѵ�.
SELECT PRO4 FROM EMP;
--------------------------------------------------------------------------------
--�а��� �Է¹޾Ƽ� �� ������ ǥ�������� ����ϴ� �Լ��� �ۼ��϶�.
CREATE OR REPLACE FUNCTION PRO5(                                                --PRO5�� �����.
    V_DEPT STUDENT.STU_DEPT%TYPE)                                               --V_DEPT �� ����µ� Ÿ���� STUDENT�� �ִ� STU_DEPT�� ����.   �Լ��� IN, OUT�� ����.
    RETURN NUMBER                                                               --���ϰ��� NUMBER�� �޴´�.
        
    IS                                                                          --���������Ѵ���
    V_STDDEV NUMBER;                                                            --V_STDDEV�� NUMBERŸ������.
    
    BEGIN                                                                       --���๮ �����Ѵ���
    SELECT STDDEV(ENR_GRADE) INTO V_STDDEV                                      --STDDEV(ENR_GRADE)�� �����ϴµ�, �װ��� V_STDDEV�� �ִ´�.
    FROM STUDENT NATURAL JOIN ENROL                                             --���? STUDENT ���̺���, �׸��� ENROL�� �ڿ������� �����Ѵ�.
    WHERE STU_DEPT = V_DEPT;                                                    --��¿��? STU_DEPT�� V_DEPT�� ������!
    RETURN V_STDDEV;                                                            --V_DEPT�� ��������� �����Ѵ�.
    
END PRO5;                                                                       --PRO5 ��
/

SELECT DISTINCT PRO5('��������') FROM STUDENT;

--------------------------------------------------------------------------------
--SQL
    --DQL  
        --SELECT(JOIN)
    --DML
        --INSERT() / UPDATE() / DELETE() / MODIFY()
    --DDL
        --CREATE() / DROP() / ALTER() / TRUNCATE()
    --DCL
        --GRANT() / REVOKE()                                                    --GRANT(�����ֱ�), REVOKE(���ѻ���)
    --TML
        --COMMIT() / ROLLBACK()

SELECT TABLE_NAME FROM USER_TABLES;
SELECT * FROM TEST;                                                             
DELETE FROM TEST;
ROLLBACK;
TRUNCATE TABLE TEST;                                                            --DELETE + COMMIT
