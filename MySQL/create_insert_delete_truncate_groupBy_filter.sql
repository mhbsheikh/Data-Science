# keywords order
# SELECT -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY -> LIMIT

########################################################################
-- create a database
create database if not exists sql_intro;
show databases; 
use sql_intro; 


-- delete a databse
drop database if exists temp_db;



########################################################################
-- select a db
use sql_intro;


-- create a table
create table if not exists emp_details(
	id int auto_increment primary key,
	name varchar(30),
    age int,
    sex char(1),
    doj date,
    city varchar(15),
    salary float
);


-- show all tables names
show tables;


-- show a table
select * from emp_details;


-- insert values into a table
insert into emp_details (name, age, sex, doj, city, salary) values
("Jimmy", 35, "M", "2005-05-30", "Chicago", 70000),
("Shane", 30, "M", "1999-05-30", "Seattle", 55000),
("Marry", 28, "F", "2009-05-30", "Boston", 62000),
("Dwane", 37, "M", "2011-05-30", "Austin", 57000),
("Sara", 32, "F", "2017-05-30", "New York", 72000),
("Ammy", 35, "F", "2014-05-30", "Seattle", 80000);


-- describe a table
describe emp_details;


-- remove all values from the table
truncate table emp_details;


-- drop a table
drop table if exists emp_details;


-- duplicate a table
create table if not exists emp_details_copy like emp_details;
insert into emp_details_copy select * from emp_details;
select * from emp_details_copy;


-- rename a table 
# rename is unable rename a temporary table
# alter table is able to rename a temporary table
rename table emp_details_copy to emp_details_duplicate;
alter table emp_details_duplicate rename to emp_details_copy;
show tables;


-- temporary table
create temporary table if not exists temp_table(
	name varchar(20),
    id int primary key auto_increment,
    height float
);


insert into temp_table (name) select name from emp_details;

select * from temp_table;

drop temporary table emp_details;

alter table old_table_name rename to new_table_name;

show tables;



###########################################################
select * from emp_details;
select distinct(city) from emp_details;


-- aggregate functions
# count, sum, avg, min, max
select 
	count(salary) as salary_count,
    sum(salary) as total_salary,
    avg(salary) as average_salary,
    min(salary) as minimum_salary,
    max(salary) as maximum_salary
from emp_details;

select *
from emp_details
where age > 30;

select 
	name as emp_name, 
	sex, 
    salary
from emp_details
where sex = 'f'
order by salary desc;

select *
from emp_details
-- where city in ('chicago', 'austin');
where salary between 50000 and 60000;

-- multiple condition
select *
from emp_details
where age > 30 and salary < 60000;



########################################
-- group by
select sex, count(sex) as gender_count, round(avg(salary), 1) as average_salary
from emp_details
group by sex;


-- default functions
select (10+20) as addition;
select (50*50) as multiplication;

-- string functions
select length('Mehedi Hasan Bijoy') as len_of_string;
select char_length('Mehedi Hasan Bijoy') as len_of_string;
select character_length('Mehedi Hasan Bijoy') as len_of_string;
select repeat('Bijoy', 10) as repeatNtimes;
select upper('BiJoy') as to_upper;
select lower('BiJoy') as to_lower;
select lcase('BiJoY') as to_lower;
select reverse('Bijoy') as reversed; # string and number both
select replace('This is the string to replace', 'to', 'xx') as replace_pattern;
select ltrim('     Bijoy         ') as left_trimed; -- removes leading spaces
select rtrim('                Bijoy     sdfg ') as right_trimed; -- removes tailing spaces
select ascii('b') ascii_value_of_character;
select position('or' in 'orange is a fruit') as found_at; -- if found returns the index where it found, else 0
select concat('Mehedi', ' hasan', ' bijoy') as merged_name;

-- date functions
select curdate() as currentDate;
select year(curdate()) as current_year, month(curdate()) as current_month, day(curdate()) as current_day;
select now() as current_date_n_time;



select 
	Name, Age, Sex, concat(name, ' ', age, ' ', sex) as name_age_sex_merged
from emp_details;






