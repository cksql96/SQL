--저장 프로시저
--학번과 학년을 입력을 하여 해당학생의 학년을 수정하는 방법
--매개변수 외부에서 주어지는 변수 - INPUT 값




CREATE PROCEDURE TEST2(
    V_STU_NO IN STUDENT.STU_NO%TYPE,        --또는 V_STU_NO IN NUMBER. 이거는 V_STU_NO의 타입은 STUDENT.STU_NO의 타입과 같다 라는 뜻이다.
    V_STU_GRADE IN STUDENT.STU_GRADE%TYPE)
        IS                                      
            HCH VARCHAR2(30);
        BEGIN
            UPDATE STUDENT
            SET STU_GRADE = V_STU_GRADE
            WHERE STU_NO = V_STU_NO;
END TEST2;

SELECT * FROM STUDENT;

EXECUTE TEST2(20153075,2);              --20153075라는 STU_NO를 가진 학생의 STU_GRADE를 2로 바꾼다.

DROP PROCEDURE TEST2;                   --프로시저를 삭제할때

--학번을 입력으로 학생의 이름을 검색하는 프로시저는?
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

VARIABLE C_STU_NAME VARCHAR2(20);       --변수명 설정해주기
EXECUTE TEST3(20153075,:C_STU_NAME);
PRINT C_STU_NAME;

VARIABLE BBB VARCHAR2(20);              --빈공간으로 나옴
EXECUTE TEST3(20153088,:BBB);           --PL/SQL 프로시저가 성공적으로 완료
PRINT BBB;                              --BBB -------- 이태연

--학생의 수강테이블에서 임의점수만큼 올려주고 그 결과를 출력하는 프로시져?
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
--시퀀스
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

EXECUTE TEST5('앱프로그래밍','홍길동',3,'컴퓨터정보');

-----------------------------------------------------------------------
--FUNCTION() ????
--점수를 입력받아 결과를 학점으로 출력시키는 함수??
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
SET SERVEROUTPUT ON;                --DBMS_OUTPUT.PUT_LINE을 쓰려면 이것을 셋업 시켜줘야된다.

SELECT * FROM ENROL;
DESC ENROL;
DESC TEST7;

------------------------------------------------------------------------------------------------------
--FOR문을 사용하여 진행되는 프로시저             --INPUT이 없다. 따라서 CURSOR를 OPEN할 이유가 없다. 자동으로 문서안에 있는 모든 내용을 훑으므로
CREATE PROCEDURE TEST8                                                          --TEST 8 을 만든다.(INPUT이 없기때문에, ()를 안해도 된다.
    IS                                                                          --변수 선언!!
        V_ENROL ENROL%ROWTYPE;                                                  --V_ENROL 이라는것을, 타입은? ENROL에 있는 모든 하위 타입들을 다 가져온다.    
    CURSOR T_CURSOR                                                             --커서를 만든다. 이도 마찬가지로 (INPUT이 없다) 모든 정보를 훑는다.
    IS                                                                          --그럼 BASED ON WHAT? 멀라 그건 이따가
    SELECT STU_NO, SUB_NO, ENR_GRADE                                            --STU_NO, SUB_NO, ENR_GRADE의 정보를 가져와
    FROM ENROL                                                                  --어디서? ENROL테이블에서
    WHERE SUB_NO = '101';                                                       --어쩔때? SUB_NO가 101일때. 커서가 BASED ON SUB_NO='101'에 따라 움직이고 찾는다.
    
    BEGIN                                                                       --실행문
        FOR V_ENROL IN T_CURSOR                                                 --V_ENROL이라는 변수는 T_CURSOR에 따라서 간다.조건도.
        LOOP                                                                    --루프문 시작
            EXIT WHEN T_CURSOR%NOTFOUND;                                        --루프 끝낸다 언제? 커서가 암것도 못찾을때
            DBMS_OUTPUT.PUT_LINE(V_ENROL.STU_NO||' '||V_ENROL.SUB_NO||' '||V_ENROL.ENR_GRADE);      --출력한다잉
        END LOOP;                                                               --루프문 끝
END TEST8;                                                                      --TEST8 끝
/

DROP PROCEDURE TEST8;

EXECUTE TEST8;
--------------------------------------------------------------------------------------------------------
--커서를 이용하여, 과목번호 변경에 따라 OUTPUT이 다르게 만들어라
CREATE PROCEDURE TEST9(                                                         --TEST9을 만든다.
    V_SUB_NO IN ENROL.SUB_NO%TYPE)                                              --INPUT은 V_SUB_NO로 넣는데, 타입은 ENROL에 SUB_NO와 같다.
    IS                                                                          --변수선언간다
        V_STU_NO ENROL.STU_NO%TYPE;                                             --V_STU_NO 타입은 ENROL에 STU_NO와 같다.
        V_ENR_GRADE ENROL.ENR_GRADE%TYPE;                                       --V_ENR_GRADE 타입은 ENROL에 ENR_GRADE와 같다.
    CURSOR T_CURSOR(                                                            --커서를 하나 만든다. 이름은 T_CURSOR. 
        V_SUB_NO NUMBER)                                                        --인풋은 V_SUB_NO, 사용자가 입력했던 그 정보를 그대로. SUB_NO에 따라 커서의 위치가 바뀐다.
        IS                                                                      --커서가 존재하는 그 위치에서 어떠한 정보를 가져올것인가??(변수선언과는 조금 다른듯)
            SELECT STUDENT.STU_NO, ENR_GRADE                                    --ENR_GRADE와 STUDENT에 있는 STU_NO의 정보를 가져온다.
            FROM STUDENT,ENROL                                                  --어디서? STUDENT와 ENROL에서
            WHERE STUDENT.STU_NO = ENROL.STU_NO AND ENROL.SUB_NO = V_SUB_NO;    --어쩔때? STUDENT에 있는 STU_NO와 ENROL에 있는 STU_NO가 같을때(조인문) 그리고!! SUB_NO가 V_SUB_NO와 같을때!(INPUT값이 존재할때!)
            
    BEGIN                                                                       --실행문을 시작한다.
        OPEN T_CURSOR(V_SUB_NO);                                                --T_CURSOR를 실행한다.               CURSOR는 커서 위치를 두고, 그 곳에 있는 정보를 다 가져오는거와 같다고 생각한다.
            LOOP                                                                --루프문 시작                    루프와 CURSOR는 붙어다니는게 낫고, 루프가 한번 끝날때, 커서는 자동으로 다음줄로 이동한다.!
                FETCH T_CURSOR INTO V_STU_NO,V_ENR_GRADE;                       --T_CURSOR의 정보를 가져온다. 가져온것을, V_STU_NO, V_ENR_GRADE에 넣는다.
                EXIT WHEN T_CURSOR%NOTFOUND;                                    --루프를 빠져나온다. 언제? T_CURSOR가 아무것도 못찾을때, NULL일때!
                DBMS_OUTPUT.PUT_LINE(V_STU_NO||' '||V_ENR_GRADE);               --아니면, 그 커서에 있는 V_STU_NO와 V_ENR_GRADE를 출력한다.
            END LOOP;                                                           --루프문 끝
        CLOSE T_CURSOR;                                                         --커서도실행 끝
END TEST9;                                                                      --TEST9 끝
/

EXECUTE TEST9(101);

-----------------------------------------------------------------------------------
--예외처리문
CREATE OR REPLACE PROCEDURE TEST10(                 --OR REPLACE를 쓰는것은, 만약에 저 테이블 네임이 있을경우 덮어쓰기한다.
    V_STU_NO IN STUDENT.STU_NO%TYPE)                --밖에서 들어오는 INPUT을 저기에 대입한다.
    IS
        V_STU_NAME STUDENT.STU_NAME%TYPE;           --변수선언. BEGIN에서 쓰기위해서. 선언해주는것.
    BEGIN                                           --실행문
        SELECT STU_NAME INTO V_STU_NAME             --STU_NAME을 V_STU_NAME에 넣는다.
        FROM STUDENT                                --어디서? STUDENT 테이블에서
        WHERE STU_NO = V_STU_NO;                    --STU_NO와 V_STU_NO가 같을때!! (위에 첫줄에 설명대로 밖에서 들어온 INPUT값이 STU_NO라면..->(있다면))
        DBMS_OUTPUT.PUT_LINE(V_STU_NAME);           --그러면 V_STU_NAME을 출력한다.
        
        EXCEPTION                                   --예외(없을때)
        WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('해당 데이터가 없습니다.');      --데이터 없다는 출력문 보낸다.
END TEST10;
/

EXECUTE TEST10(20153088);

--------------------------------------------------------------------------------
--프로그래머가 예외처리 이름을 지정하는 경우?
CREATE OR REPLACE PROCEDURE TEST11(                                             --test11만든다~안에 내용들은? 아래에
    V_SUB_NO IN ENROL.SUB_NO%TYPE)                                              --INPUT값은 V_SUB_NO로 들간다.
    IS                                                                          --변수 선언 간다잉
        V_CNT NUMBER;                                                           --V_CNT는 NUMBER타입이고
        CNT_ERROR EXCEPTION;                                                    --CNT_ERROR는 예외타입이다.
    BEGIN                                                                       --실행문
        SELECT COUNT(STU_NO) INTO V_CNT                                         --COUNT(STU_NO)를 V_CNT로 집어넣어
        FROM ENROL                                                              --어디서? ENROL테이블에서
        WHERE SUB_NO = V_SUB_NO;                                                --어쩔때? SUB_NO가 V_SUB_NO(INPUT값)과 같을때! (있을때!)
        
        IF V_CNT = 0 THEN RAISE CNT_ERROR;                                      --만약 COUNT가 0이면?(없다면?) CNT_ERROR변수를 실행하라.
        END IF;                                                                 --IF문 끝. (더이상 적을 조건이 없다)
        
        DBMS_OUTPUT.PUT_LINE(V_SUB_NO||'과목수강자는 '||V_CNT||'명 입니다.');      --IF문에 안걸린다면? 이거 출력해
        
        EXCEPTION                                                               --예외로,
        WHEN CNT_ERROR THEN DBMS_OUTPUT.PUT_LINE('아무도 없다잉');                --CNT_ERROR변수가 실행되면, 저것을 출력하라.
        
END TEST11;                                                                     --TEST11끝~
/

EXECUTE TEST11(109);

--------------------------------------------------------------------------------
--급여가 2000이상이 사원의 사원번호, 사원이름, 부서이름을 부서 이름순으로 검색하는 프로시저를 작성하시오
CREATE OR REPLACE PROCEDURE PRO1
    IS                                                                          --변수선언
        V_EMPNO NUMBER;                                                         --사원번호
        V_ENAME EMP.ENAME%TYPE;                                                 --사원이름
        V_DNAME DEPT.DNAME%TYPE;                                                --부서이름
        
    CURSOR RESULT IS                                                            --선언부
        SELECT EMPNO, ENAME, DNAME
        FROM EMP NATURAL JOIN DEPT
        WHERE SAL >= 2000                                                       --SAL이 2000이상인것들만 커서를 둔다.
        ORDER BY DNAME;
    
    BEGIN                                                                       --실행문
    OPEN RESULT;
        LOOP
            FETCH RESULT INTO V_EMPNO, V_ENAME, V_DNAME;                            
            EXIT WHEN RESULT%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('사원번호: '||V_EMPNO||'     사원이름: '||V_ENAME||'     부서이름: '||V_DNAME);
        END LOOP;
    CLOSE RESULT;
END PRO1;
/

EXECUTE PRO1;


SET SERVEROUTPUT ON;
