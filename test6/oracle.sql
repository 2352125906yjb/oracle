
CREATE TABLE ticket(
  ticket_id number NOT NULL,
  username varchar(20) NOT NULL,
  passwd varchar(20) NOT NULL,
  uname varchar(20) NOT NULL,
  sex varchar(5) NOT NULL,
  ticket_quota number NOT NULL,
  overdue_num number NOT NULL,
  PRIMARY KEY (ticket_id)
);

CREATE TABLE yonghu  (
  yonghu_id number NOT NULL,
  username varchar(16) NOT NULL,
  passwd varchar(16) NOT NULL,
  uname varchar(16) NOT NULL,
  sex varchar(5) NOT NULL,
  ticket_quota number NOT NULL,
  overdue_num number NOT NULL,
  PRIMARY KEY (yonghu_id)
);

CREATE TABLE admina (
  ticket_id number NOT NULL,
  ISBN varchar(20) UNIQUE NOT NULL,
  ticket_name varchar(50) NOT NULL,
  publishing_house varchar(50) NOT NULL,
  surplus number NOT NULL,
  PRIMARY KEY (admina_id)
);

CREATE TABLE buytickets_record(
  buytickets_ticket_record_id number NOT NULL,
  yonghu_id number NOT NULL,
  ISBN varchar(50) NOT NULL,
  lend_time date NOT NULL,
  lend_days number NOT NULL,
  PRIMARY KEY (buytickets_ticket_record_id),
  CONSTRAINT ticket_id FOREIGN KEY (ticket_id) REFERENCES users (yonghu_id),
  CONSTRAINT ISBN FOREIGN KEY (ISBN) REFERENCES ticket (ISBN)
);

CREATE TABLE returntickets_record(
  id number NOT NULL,
  buytickets_ticket_record_id number NOT NULL,
  return_time date NOT NULL,
  is_overdue varchar(5) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT buytickets_ticket_record_id FOREIGN KEY (buytickets_ticket_record_id) REFERENCES buytickets_record (buytickets_ticket_record_id)
)


-- 创建普通用户id序列
create sequence seq_newUserids increment by 1 start with 1 maxvalue 999999999;
-- 创建售票员id序列
create sequence seq_newAdminids increment by 1 start with 1 maxvalue 999999999;
-- 创建车票id序列
create sequence seq_newBookids increment by 1 start with 1 maxvalue 999999999;
-- 创建车票ISBN序列
create sequence seq_newISBNs increment by 1 start with 10000000 maxvalue 999999999;
 
-- 创建购票记录id序列
create sequence seq_newBorrow_books_recordids increment by 1 start with 1 maxvalue 999999999;
-- 创建退票记录id序列
create sequence seq_newids increment by 1 start with 1 maxvalue 999999999;

create or replace
PROCEDURE insertdata as
flag number;
begin
    flag:=0;
    for i in 1..10000
        loop
            insert into users(yonghu_id,username,passwd,uname,sex,ticket_quota,overdue_num)
            values(seq_newUserids.nextval,'testuser','000','张剑波','男',4,0);
            flag:=flag+1;
            if flag=10001 then 
                commit;
            end if;
        end loop;
end;

call insertdata();

create or replace
PROCEDURE insertadminadata as
flag number;
begin
    flag:=0;
    for i in 1..10000
        loop
            insert into admin(admina_id,username,passwd,uname,sex,ticket_quota,overdue_num)
            values(seq_newAdminaids.nextval,'hualahuala','111','张三','女',10,0);
            flag:=flag+1;
            commit;
        end loop;
end;

call insertadminadata();

create or replace
PROCEDURE insertbookdata as
flag number;
begin
    flag:=0;
    for i in 1..10000
        loop
            insert into ticket(ticket_id,isbn,ticket_name,publishing_house,surplus)
            values(SEQ_NEWBOOKIDS.nextval,to_char(SEQ_NEWISBNS.nextval),'川渝线','余剑波手写打印','5');
            flag:=flag+1;
            commit;
        end loop;
end;

call insertbookdata();




create or replace function getUserid
return number
is
yonghu_id number;
begin
    select yonghu_id into User_id from (select * from users order by dbms_random.value) where rownum< 2;
    return yonghu_id;
end;

create or replace function getIsbn
return varchar2
as
isbn varchar2(20 byte);
begin
    select isbn into isbn from (select * from book order by dbms_random.value) where rownum <2;
    return isbn;
end;


create or replace
PROCEDURE insertlendbookdata as
flag number;
begin
    flag:=0;
    for i in 1..10000
        loop
            insert into borrow_record(borrow_books_record_id,user_id,isbn,lend_time,LEND_DAYS)
            values(SEQ_NEWBORROW_BOOKS_RECORDIDS.nextval,getuserid(),getisbn(),SYSDATE(),5);
            flag:=flag+1;
            commit;
        end loop;
end;

call insertlendbookdata();

create or replace function getborrowid
return number
as
borrowid number;
begin
    select buytickets_ticket_record_id into borrowid from (select * from buytickets_record order by dbms_random.value) where rownum <2;
    return borrowid;
end;


create or replace
PROCEDURE insertreturnbookdata as
flag number;
begin
    flag:=0;
    for i in 1..10000
        loop
            insert into return_record(id,buytickets_ticket_record_id,return_time,is_overdue)
            values(SEQ_NEWIDS.nextval,getborrowid(),SYSDATE(),'否');
            flag:=flag+1;
            if flag=10001 then 
                commit;
            end if;
        end loop;
end;

call insertreturnbookdata();







