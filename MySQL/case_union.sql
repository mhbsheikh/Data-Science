-- union
use sql_joins;

select * from cricket;
select * from football;

select * from cricket
union
select * from football;

select * from cricket
union all
select * from football
order by cricket_id;

-- case statement
use sql_intro;
select * from employees;

select *,
case
	when salary < 10000 then 'Low'
    when salary > 50000 then 'high'
    else 'mid'
end salary_range
from employees;