use classicmodels;
show tables;

select * from customers;

create view customer_details
as
select customerName, phone, city
from customers;

select * from customer_details;



-- join two different tables and create view
create view show_product
as
select p.productName, p.msrp, o.priceEach
from products p
inner join orderdetails o
on p.productCode = o.productCode;

select * from show_product;


-- rename view name
rename table show_product to product_desc;

select * from product_desc;

show full tables where table_type = 'VIEW';


-- delete a view
drop view customer_details;

