-- Alter is a DDL command
-- common use of alter:
#	add column
#	remove column
#	modify datatype
#	modify datatype length
#	rename column
#	rename table
#
#
#
#


create table if not exists alter_usecase(
	id int auto_increment primary key,
    name varchar(30)
);

insert into alter_usecase (name) values
('bijoy'), ('mehedi'), ('hasan'), ('sheikh'), ('mehedi'), ('yojib'), ('nasah');

select * from alter_usecase;

-- insert a new column to the table
alter table alter_usecase add (address varchar(30));

-- remove a column from the table
alter table alter_usecase drop column address;

-- modify datatype
alter table alter_usecase modify id varchar(10);

-- increase lenght of a datatype
alter table alter_usecase modify name varchar(100);

-- rename column name
alter table alter_usecase rename column id to roll_no;

-- rename table name
alter table alter_usecase rename to alter_usecase_renamed;
show tables;

-- add priary key
alter table alter_usecase_renamed add primary key (id);

-- set null to not-null
alter table alter_usecase_renamed modify id int not null;

select * from alter_usecase;
desc alter_usecase;



