create database if not exists storedprocedure;
use storedprocedure;

create table if not exists players(
	player_id int primary key auto_increment,
    name varchar(30) not null,
    country varchar(20),
    goals int default 0
);

insert into players (name, country, goals) values
('Bjioy', 'Bangladesh', 6),
('Messi', 'Argentina', 10),
('Ronaldo', 'Portugal', 7),
('Kohli', 'India', 2),
('Strac', 'Austrilia', default),
('Willimson', 'Bangladesh', default),
('Hinton', 'India', 3);

select * from players;

##########################################
-- stored procedure using select
##########################################
delimiter //
create procedure top_players()
begin
	select name, country
    from players
    where goals > 5;
end //
delimiter ;

call top_players();



##########################################
-- stored procedure using IN
##########################################
use sql_intro;
select * from employees;

delimiter //
create procedure sp_sortBySalary(in temp int)
begin
	select emp_name, age, salary
    from employees
    order by salary desc
    limit temp;
end //
delimiter ;

call sp_sortBySalary(5);



##########################################
-- stored procedure using UPDATE
##########################################
delimiter //
create procedure salary_update(in temp_name varchar(10), in temp_salary float)
begin
	update employees set salary = temp_salary
    where emp_name = temp_name;
end //
delimiter ;

call salary_update('bijoy', 12345);

select * from employees;




##########################################
-- stored procedure using out parameter
##########################################
delimiter //
create procedure totalEmp(out total_emps int, in temp_gender char(1))
begin
	select count(emp_name) into total_emps
    from employees
    where gender = temp_gender;
end //
delimiter ;

call totalEmp(@total_emp, 'M');
select @total_emp as total_male_emps;

