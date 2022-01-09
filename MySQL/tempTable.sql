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





#########################################
# CTE - Common Table Expression
#########################################

with temp_emps (id, name, salary)
as(
	select 
		emp_id,
		concat(first_name, ' ', last_name) as emp_name,
		salary
	from employees
) select * from temp_emps;



with all_players (id, name)
as(
	select * from cricket c
	union all
	select * from football f
	union all
	select * from rugby r
) select * from all_players a, all_players b
where a.id = b.id and a.name <> b.name;

