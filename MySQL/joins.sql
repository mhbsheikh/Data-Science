create database if not exists sql_joins;

use sql_joins;

create table if not exists cricket (
	cricket_id int auto_increment,
    name varchar(30),
    primary key(cricket_id)
);

create table if not exists football (
	football_id int auto_increment,
    name varchar(30),
    primary key(football_id)
);

create table if not exists rugby (
	rugby_id int auto_increment,
    name varchar(30),
    primary key(rugby_id)
);

insert into cricket (name) values
('Mehedi'), ('Hasan'), ('Bijoy'), ('Idehem'), ('Nasah'), ('Yojib'), ('Sheikh'), ('Khiesh');

insert into football (name) values
('Mehedi'), ('Messi'), ('Bijoy'), ('Ronaldo'), ('Kaka'), ('Maradona'), ('Sheikh'), ('Neymar');

insert into rugby (name) values
('Virat'), ('Kohli'), ('Smith'), ('Joe'), ('Root'), ('Willimson'), ('Rahul'), ('Stokes'), ('Ronaldo'), ('Bijoy'), ('Mehedi');

select * from cricket;
select * from football;
select * from rugby;






#################################################
# inner join
#################################################
select c.name as Cricketer, f.name as Footballer, c.cricket_id as common_id
from cricket as c
inner join football as f
where c.cricket_id = f.football_id;

select *
from cricket as c
inner join rugby as r
where c.cricket_id = r.rugby_id
order by r.name desc;

use sql_joins;
select *
from cricket as c
inner join football as f
using (name);


select *
from cricket as c
inner join football as f
using (name)
inner join rugby as r
on f.football_id = r.rugby_id
order by r.rugby_id desc;

select *
from cricket as c
left join rugby as r
	on c.name = r.name
left join football as f
	on r.name = f.name
where r.rugby_id is not null;

select *
from cricket as c
right join rugby as r
	on c.name = r.name
right join football as f
	on r.name = f.name
where r.name is not null
order by c.name;


create table if not exists employees (
	emp_id int auto_increment,
    first_name varchar(30),
    last_name varchar(30),
    reports_to int,
    salary float,
    primary key(emp_id)
);

describe employees;

insert into employees (first_name, last_name, reports_to, salary) values
('Mehedi', 'Hasan', Null, 50000),
('Leonel', 'Messi', 1, 20000),
('Sheikh', 'Hasina', 1, 30000),
('Ronaldo', 'Neymar', 2, 20000),
('Obaidul', 'Kader', 3, 40000);

select * from employees;




#################################################
# self join
#################################################
-- emp and manager
select 
	a.emp_id, a.first_name as employee, a.reports_to, b.first_name as manager
from employees a, employees b
where a.reports_to = b.emp_id;

-- emp and manager
select 
	e.emp_id,
    	e.first_name,
    	s.reports_to,
    	concat(s.first_name, ' reports to ', e.first_name) as manager
from employees e
inner join employees s
on e.emp_id = s.reports_to;


-- create a new table
create table if not exists students(
	student_id int,
	course_id int,
    course_name varchar(10)
);

alter table students modify student_id varchar(10);
alter table students modify course_id varchar(10);

insert into students (student_id, course_id, course_name) values
('student1', 'course1', 'cse115'),
('student1', 'course2', 'mat116'),
('student2', 'course3', 'cse498R'),
('student3', 'course4', 'bus498R');


-- students who are enrolled in more than one course
select 
	-- *,
    a.student_id, a.course_id
from students a, students b
where a.student_id = b.student_id and a.course_id <> b.course_id;




#################################################
# left join
#################################################
select * 
from cricket c
left join football f
on c.name = f.name;

select *
from cricket c
left join football f
on c.name = f.name
left join rugby r
on c.cricket_id = r.rugby_id;

select *
from cricket c
left join football f
on c.name = f.name
left join rugby r
on c.cricket_id = r.rugby_id
where r.rugby_id between 2 and 5 and f.name is not null;


select *
from cricket c
left join football f
on c.name = f.name
left join rugby r
on c.cricket_id = r.rugby_id
group by f.football_id
order by c.cricket_id desc;


#################################################
# right join
#################################################

select *
from football f
right join rugby r 
using (name)
right join cricket c
on r.rugby_id = c.cricket_id;





#################################################
# full join
#################################################

select *
from cricket
full join football
using(name)









































































