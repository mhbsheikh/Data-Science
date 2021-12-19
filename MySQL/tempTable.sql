#########################################
# temp table
#########################################

use sql_intro;

select * from employees;

drop table if exists tempEmployees;
create temporary table if not exists tempEmployees (
	emp_id int,
	emp_name varchar(30),
	age int,
	gender char(1)
);

insert into tempEmployees
select emp_id, emp_name, age, gender from employees;

select * from tempEmployees;