create database if not exists subquaries;

use subquaries;

create table if not exists products (
	prod_id int auto_increment,
    item varchar(20),
    sell_price float,
    product_type varchar(20),
    primary key(prod_id)
);

insert into products (item, sell_price, product_type) values
('Laptop', 10000, 'Luxury'),
('T-shirt', 150, 'Non-Luxury'),
('Sharee', 2800, 'Non-Luxury'),
('Iphone X', 80000, 'Luxury'),
('GPU', 150000, 'Luxury'),
('Bed sheet', 800, 'Non-Luxury'),
('T-shirt', 450, 'Non-Luxury');

select * from products;

create table if not exists orders(
	order_id int,
    product_sold varchar(30),
    selling_price float
);

describe orders;

select * 
from products
where sell_price <= 10000;

select prod_id, item, sell_price
from products
where product_type in (select product_type from products where product_type = 'Luxury')
order by sell_price desc
limit 3;

select prod_id, item, sell_price
from products
where prod_id in (select prod_id from products where sell_price > 5000);

use sql_joins;
select * from employees;

create table if not exists employees_clone like employees;
insert into employees_clone select * from employees;
select * from employees_clone;

update employees_clone 
set salary = salary * 2
where salary in (select reports_to from employee where reports_to = 1);

select * from employees_clone;

update employees_clone
set reports_to = 5
where salary in (select min(salary) from employees);

select * from employees_clone;


use classicmodels;

select productName, MSRP
from products
where productCode in (select productCode from orderdetails where priceEach > 100);

