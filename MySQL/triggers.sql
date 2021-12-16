create database if not exists triggers;

use triggers;

show tables;

create table if not exists customers (
	cust_id int,
    age int,
    name varchar(30)
);

#####################################
# before insert trigger
#####################################
delimiter //
create trigger age_verify
before insert on customers 
for each row
begin
	if new.age < 0
		then set new.age = 0;
	end if;
end //
delimiter ;

insert into customers (cust_id, age, name) values (101, -20, 'bijoy');

select * from customers;

use triggers;
create table if not exists students(
	id int primary key auto_increment,
    name varchar(30),
    age int,
    mark float
);

select * from students;

delimiter //
create trigger check_marks
before insert on students
for each row
begin
	if new.mark <= 0
		then set new.mark = 33;
	elseif new.mark > 100
		then set new.mark = 100;
	end if;
end //
delimiter ;

delimiter //
create trigger check_id
before insert on students
for each row
begin
	if new.id < 10
		then set new.id = new.id + 100;
	end if;
end //
delimiter ;

insert into students (id, name, age, mark) values (6, 'bijoy', 23, 500);

select * from students;


use storedprocedure;
show tables;
select * from players;

create table if not exists message2 (
	player_id int,
    message varchar(30) default 'Name is missing!'
);
describe message2;

select * from students;

delimiter //
create trigger checkName
before insert on students
for each row
begin
	if new.name is null
		then insert into message2 values (new.id, default);
	end if;
end //
delimiter ;

use triggers;
insert into students values (108, null, -20, 200);
select * from students;


##################################
-- drop a trigger
drop trigger triggerName;

