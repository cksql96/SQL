--신입사원을 채용하였다. 사원번호, 사원이름, 사원직무, 상급자사원번호, 급여, 부서번호를 
--입력받아 사원테이블에 삽입하는 프로시저를 작성하라.
CREATE OR REPLACE PROCEDURE PRO2(                                               --PRO2를 만들거나, 있다면 바꿔라.
    V_EMPNO IN EMP.EMPNO%TYPE,                                                  --사원번호
    V_ENAME IN EMP.ENAME%TYPE,                                                  --사원이름
    V_JOB IN EMP.JOB%TYPE,                                                      --사원직무
    V_MGR IN EMP.MGR%TYPE,                                                      --상급자사원번호
    V_SAL IN EMP.SAL%TYPE,                                                      --급여
    V_DEPTNO IN EMP.DEPTNO%TYPE)                                                --부서번호
    
    IS                                                                          --변수를 넣을게 없으므로 패스.
    BEGIN                                                                       --실행문
        INSERT INTO EMP                                                         --EMP에다가 넣을거야!
        VALUES(V_EMPNO, V_ENAME, V_JOB, V_MGR, NULL, V_SAL, NULL, V_DEPTNO);    --그 값은!! 사용자가 넣은, 6개랑, EMP행에 있지만 사용자가 지정안한것은, NULL로.
        COMMIT;                                                                 --커밋해라!! 적용해라!! 롤백해도 안돌아옴.
END PRO2;                                                                       --PRO2 끝!
/

EXECUTE PRO2(0703,'HCH','백수',1234,3000,10);
SELECT * FROM EMP;
--------------------------------------------------------------------------------
--부서번호를 변경하는 프로시저를 작성하라.
CREATE OR REPLACE PROCEDURE PRO3(                                               --PRO3을 만들자
    V_EMPNO IN EMP.EMPNO%TYPE,                                                  --사원번호
    V_DEPTNO IN EMP.DEPTNO%TYPE)                                                --부서번호
    
    IS                                                                          --변수넣을게 없으므로 패스
    BEGIN                                                                       --실행문
        UPDATE EMP                                                              --EMP를 바꾼다.(업뎃한다.)
        SET DEPTNO = V_DEPTNO                                                   --DEPTNO를 V_DEPTNO로 바꿔준다(업뎃시킨다.) V_DEPTNO랑 V_EMPNO는 사용자가 입력한수.
        WHERE EMPNO = V_EMPNO;                                                  --어쩔때? EMPNO가 V_EMPNO랑 같을때!
        COMMIT;                                                                 --적용한다.
        
END PRO3;                                                                       --PRO3 끝
/

EXECUTE PRO3(703,20);

--------------------------------------------------------------------------------
--최고급여를 받는 사원 이름을 출력하는 함수를 작성하시오?
CREATE OR REPLACE FUNCTION PRO4                                                 --PRO4 만들자(함수임) FUNCTION
    RETURN EMP.ENAME%TYPE                                                       --리턴을 할때, EMP에 있는 ENAME의 타입을 가져온다. 아니면 RETURN CHAR 해도 된다.
    IS                                                                          --변수설정하자.
        V_ENAME EMP.ENAME%TYPE;                                                 --V ENAME을 만들고 타입은 ENAME과 같게.
    BEGIN                                                                       --실행문
        SELECT ENAME INTO V_ENAME                                               --ENAME을 선택하는데, 이것은 V_NAME에 넣는다.
        FROM EMP                                                                --어디서? EMP 테이블에서
        WHERE SAL = (SELECT MAX(SAL) FROM EMP);                                 --어쩔때? SAL 이 (MAX(SAL)일때!, 어디서 SAL값을 구하나? EMP 테이블에서!
        RETURN V_ENAME;                                                         --V_ENAME을 결과로 리턴한다.
END PRO4;                                                                       --PRO 4 끝
/
SELECT DISTINCT PRO4 FROM EMP;                                                  --DISTINCT는 중복을 제거한다.
SELECT PRO4 FROM EMP;
--------------------------------------------------------------------------------
--학과를 입력받아서 과 점수의 표준편차를 출력하는 함수를 작성하라.
CREATE OR REPLACE FUNCTION PRO5(                                                --PRO5를 만든다.
    V_DEPT STUDENT.STU_DEPT%TYPE)                                               --V_DEPT 를 만드는데 타입은 STUDENT에 있는 STU_DEPT와 같다.   함수는 IN, OUT이 없다.
    RETURN NUMBER                                                               --리턴값은 NUMBER로 받는다.
        
    IS                                                                          --변수선언한다잉
    V_STDDEV NUMBER;                                                            --V_STDDEV를 NUMBER타입으로.
    
    BEGIN                                                                       --실행문 시작한다잉
    SELECT STDDEV(ENR_GRADE) INTO V_STDDEV                                      --STDDEV(ENR_GRADE)를 선택하는데, 그것을 V_STDDEV로 넣는다.
    FROM STUDENT NATURAL JOIN ENROL                                             --어디서? STUDENT 테이블에서, 그리고 ENROL도 자연스럽게 조인한다.
    WHERE STU_DEPT = V_DEPT;                                                    --어쩔때? STU_DEPT가 V_DEPT와 같을때!
    RETURN V_STDDEV;                                                            --V_DEPT를 결과값으로 리턴한다.
    
END PRO5;                                                                       --PRO5 끝
/

SELECT DISTINCT PRO5('전기전자') FROM STUDENT;

--------------------------------------------------------------------------------
--SQL
    --DQL  
        --SELECT(JOIN)
    --DML
        --INSERT() / UPDATE() / DELETE() / MODIFY()
    --DDL
        --CREATE() / DROP() / ALTER() / TRUNCATE()
    --DCL
        --GRANT() / REVOKE()                                                    --GRANT(권한주기), REVOKE(권한뺏기)
    --TML
        --COMMIT() / ROLLBACK()

SELECT TABLE_NAME FROM USER_TABLES;
SELECT * FROM TEST;                                                             
DELETE FROM TEST;
ROLLBACK;
TRUNCATE TABLE TEST;                                                            --DELETE + COMMIT
