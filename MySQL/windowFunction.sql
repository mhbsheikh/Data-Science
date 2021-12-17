use sql_intro;

select * from employees;

select dept, max(salary) as max_salary
from employees 
group by dept
order by max_salary desc;

select e.*,
	max(salary) over() as max_salary
from employees e;

select e.*,
	max(salary) over(partition by dept) as max_salary,
    min(salary) over(partition by dept) as min_salary,
    avg(salary) over(partition by dept) as avg_salary
from employees e
order by e.dept desc;


-- add an unique row number to each instances
select e.*,
	row_number() over() as rn
from employees e;

select e.*,
	row_number() over(partition by dept) as rn_to_eachDept
from employees e
order by dept desc;

-- fetch the first employee joined in each department
select *
from(
	select e.*,
		row_number() over(partition by dept order by emp_id) as rn
	from employees e
) as subquery
where subquery.rn < 2;

-- rank window function
select e.*,
	rank() over(partition by dept order by salary desc) as ranking
from employees e;

-- rank top-N instances based on condition
select *
from(
	select e.*, rank() over(partition by dept order by salary desc) as ranking
    from employees e
) as subquery
where subquery.ranking <= 2;


-- difference between danse and dense rank window function
-- when multiple same values encountred:
-- 		dense: 1, 2, 2, 4 || dense-rank: 1, 2, 2, 3

select e.*,
	rank() over(partition by dept order by salary desc) as ranking,
    dense_rank() over(partition by dept order by salary desc) as dense_ranking
from employees e;


-- lag window function
-- fetch previous value of a value
select e.*,
	lag(salary) over(partition by dept order by emp_id desc) as prev_emp_salary
from employees e;

select e.*,
	lag(salary, 2, 'No Record') over(partition by dept order by emp_id desc) as prev_emp_salary
from employees e;

-- lead window function
-- fetch the next record of an instance
select e.*,
	lead(salary, 1, "No Next Record Found") over(partition by dept order by emp_id desc) as next_emp_salary
from employees e;


select e.*,
	lag(salary, 1, "No Previous Record Found") over(partition by dept order by emp_id desc) as next_emp_salary,
	lead(salary, 1, "No Next Record Found") over(partition by dept order by emp_id desc) as next_emp_salary
from employees e;


select e.*,
	lag(salary) over(partition by dept order by emp_id desc) as prev_emp_salary,
    case
		when e.salary > lag(salary) over(partition by dept order by emp_id desc)
			then 'Higher'
		when e.salary < lag(salary) over(partition by dept order by emp_id desc)
			then 'Lower'
		when e.salary = lag(salary) over(partition by dept order by emp_id desc)
			then 'equal'
	end sal_range
from employees e;










