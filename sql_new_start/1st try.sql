
--SEQUENCE 객체 생성
--시퀀스 객체: 고유한 일련번호(1부터 시작, long) 생성하는 DB객체
create sequence seq_board;

--시퀀스 테스트
SELECT seq_board.NEXTVAL, seq_board.CURRVAL
FROM dual;

DROP SEQUENCE seq_board;

commit;

------------------------------------------------------------------------
-- DDL : Data Definition Language
------------------------------------------------------------------------
CREATE TABLE tbl_board (
    bno         NUMBER(10,0)      PRIMARY KEY,                  --board number
    title       VARCHAR2(200)     NOT NULL,                     --200bytes  까지 얻는다.
    content     VARCHAR2(2000)    NOT NULL,                     --2000bytes 까지 얻는다.
    writer      VARCHAR2(50)      NOT NULL,                     --50bytes   까지 얻는다.
    insert_ts   TIMESTAMP  DEFAULT sysdate  NOT NULL,           --registration date.
    update_ts   TIMESTAMP                                       --요즘은, DATE말고, TIMESTAMP를 쓴다.
);

--테이블을 완전히 drop 시켜버린다.
DROP TABLE tbl_board purge;

DESCRIBE tbl_board;
DESC tbl_board;

--Dummy(더미) 데이터 추가
INSERT INTO tbl_board(bno,title,content,writer)     --tbl_board에 bno,title,content,writer를 넣는다.
VALUES (seq_board.NEXTVAL, '제목 테스트', '내용 테스트', 'user00'); --그 Value(값)은 저러하다.

commit;

SELECT * FROM tbl_board;

--이미 입력된 테이블의 레코드를 가지고, '더미' 데이터를 빠르게 증가 시키는 방법
INSERT INTO tbl_board(bno, title, content, writer)
SELECT seq_board.NEXTVAL, title, content, writer 
FROM tbl_board;

SELECT count(*) FROM tbl_board;


SELECT bno
FROM tbl_board
WHERE bno < 300;

SELECT *
FROM tbl_board
where writer = 'newbie10';

UPDATE tbl_board
SET
    title =  'AAA' || title,
    content = 'CCCCCC',
    update_ts = sysdate
WHERE
    bno = '53';


SELECT *
FROM 
    tbl_board
WHERE bno = 247031;


DELETE FROM 
    tbl_board
WHERE 
    bno >1000;