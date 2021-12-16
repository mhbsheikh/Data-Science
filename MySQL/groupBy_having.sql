#################################################################
-- group by
#################################################################
show databases;
use sql_intro;
show tables;

create table if not exists employees (
	Emp_id int primary key, 
    Emp_name varchar(25), 
    Age int, 
    Gender char(1), 
    Doj date, 
    Dept varchar(20), 
    City varchar(20), 
    Salary float
);

describe employees;

insert into employees values
(110, 'bijoy', 23, 'M', '1998-07-26', 'Sales', 'Dhaka', 30000),
(111, 'mehedi', 25, 'M', '1997-07-26', 'Products', 'Ctg', 4000),
(112, 'Hasan', 30, 'M', '1992-07-26', 'HR', 'NY', 20000),
(113, 'Dani', 23, 'F', '1999-07-26', 'Marketing', 'Ctg', 50000),
(114, 'Sokina', 20, 'F', '1990-07-26', 'Marketing', 'Dhaka', 30000),
(115, 'Banu', 21, 'F', '1991-07-26', 'Finance', 'Dhaka', 32000),
(116, 'Bijoya', 23, 'F', '1998-07-26', 'Tech', 'NY', 35000),
(117, 'Kim', 30, 'M', '1988-07-26', 'Sales', 'Chandpur', 54000),
(118, 'John', 32, 'M', '1978-07-26', 'HR', 'Chandpur', 28000),
(119, 'Geoffrey', 35, 'M', '1988-07-26', 'IT', 'Gazipur', 62000),
(120, 'Hasina', 22, 'F', '1998-07-26', 'Finance', 'Dhaka', 39000),
(121, 'Khaleda', 31, 'F', '1989-07-26', 'Marketing', 'Dhaka', 23000),
(122, 'Murad', 35, 'M', '1996-07-26', 'Sales', 'Rongpur', 32000),
(123, 'Obaidul', 40, 'M', '1998-07-26', 'Tech', 'Kalkata', 33000),
(124, 'Kader', 26, 'M', '1996-07-26', 'HR', 'unknown', 31000),
(128, 'Sheikh', 27, 'F', '1995-07-26', 'Product', 'idk', 63000);

select * from employees;

select distinct city from employees;

select distinct dept from employees;

select avg(age) as average_age from employees;


-- average age in each department
select
	dept, round(avg(age), 1) as average_age
from employees
group by dept
order by avg(salary);


select dept, sum(salary) as total_salary
from employees
group by dept
order by total_salary desc;

select dept, count(emp_name) as total_emp
from employees
group by dept;

select year(doj) as joining_year, count(emp_id) as total_employee
from employees
group by joining_year
order by total_employee desc;

select year(doj) as joining_year, count(emp_id) as total_emp
from employees
group by joining_year
order by joining_year desc;



###################################
# having
###################################
# Select Columns
# From Table
# Where Condition
# Group By Column
# Having Group Condition

select * from employees;

select dept, count(emp_id) as total_emp, 'Checked' as Status
from employees
where salary < 50000
group by dept
having total_emp > 1
order by total_emp desc;

