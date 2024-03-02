create table salesman
(
	salesman_id int unique not null,
	Name varchar(20) not null,
	City varchar(20) not null,
	Commision float
)

create table orders
(
	order_no int unique,
	purch_am int not null,
	order_date date not null,
	customer_id int unique not null,
	salesman_id int unique not null
)

create table customers
(
	customer_id int unique not null,
	customer_name varchar(20) not null,
	City varchar(20) not null,
	Grade int null,
	salesman_id int not null
)

Insert into salesman
Values
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5007, 'Paul Adam', 'San Jose', 0.13),
(5003, 'Lauson Hen', 'San Jose', 0.12)
Go

Insert into orders
Values
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2011-09-10', 3001, 5005),
(70002, 65.26, '2014-10-05', 3002, 5001),
(70004, 110.5, '2011-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2010-07-27', 3007, 5001),
(70008, 5760, '2013-09-10', 3002, 5001),
(70010, 1983.43, '2010-10-10', 3004, 5006),
(70003, 2480.4, '2013-10-10', 3009, 5003),
(70012, 250.45, '2010-06-27', 3008, 5002),
(70011, 75.29, '2014-08-17', 3003, 5007),
(70013, 3045.6, '2010-04-25', 3002, 5001)
Go

Insert into [customers] ([customer_id], [customer_name], [City], [Grade], [salesman_id])
Values
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3007, 'John Brad Davis', 'New York', 200, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3008, 'Julian Green', 'London', 300, 5002),
(3004, 'Fabian Johnson', 'Paris', 300, 5006),
(3009, 'Geoff Cameron', 'Berlin', 100, 5003),
(3003, 'Jozy Altidor', 'Moscow', 200, 5007),
(3001, 'John Brad Guzan', 'London', Null, 5005)
Go
-----------------------------------------------------------------------
select *
from customers as c
where c.City = 'New York'
order by c.customer_name asc;
-----------------------------------------------------------------------
select *
from customers as c
where c.customer_name like '%John%' AND (c.City = 'New York' OR c.city = 'London' OR c.city = 'Paris');	-- brackets are must for conditions including AND, OR etc.
-----------------------------------------------------------------------
select *
from customers as c
where  c.City = 'New York' OR c.city = 'London';
-----------------------------------------------------------------------
select * 
from orders as o
where o.purch_am > 500;

-----------------------------------------------------------------------
select *
from salesman s
where s.Name like '_a%';	--salesmen having 'a' in second postion

--Both commands are same

select * 
from salesman as s
where SUBSTRING(name,2,1)='a';
-----------------------------------------------------------------------
select s.salesman_id, s.Name, s.Commision*0.5 UpdatedCommision, s.City	-- can write with as or without it
from salesman s
where s.City = 'San Jose';
-----------------------------------------------------------------------
select *
from orders o
order by o.order_date asc;
-----------------------------------------------------------------------
select SUBSTRING(s.Name, 1, charindex(' ', s.name) - 1) FirstName
from salesman s
-----------------------------------------------------------------------
select DATEPART(YEAR, o.order_date) as Year_OrderDate,DATEPART(DAYOFYEAR, o.order_date) as DayofYear_OrderDate,DATEPART(WEEK, o.order_date) as Week_OrderDate,DATEPART(MONTH, o.order_date) as Month_OrderDate,DATEPART(DAY, o.order_date) as DAY_OrderDate,DATEPART(WEEKDAY, o.order_date) as Weekday_OrderDate
from orders as o
where month(o.order_date)='10';
-----------------------------------------------------------------------
select o.customer_id, o.order_date, o.order_no, o.purch_am * 3 updatedPurchaseAmount, o.salesman_id
from orders o
-----------------------------------------------------------------------
select c.customer_id, c.customer_name, c.City, c.salesman_id, o.order_date
from orders as o, customers as c
where o.customer_id=c.customer_id and year(o.order_date)='2012' 

intersect

select c.customer_id, c.customer_name, c.City, c.salesman_id, o.order_date
from orders as o, customers as c
where o.customer_id=c.customer_id and year(o.order_date)='2014'
-----------------------------------------------------------------------
select c.customer_id, c.customer_name, c.City, c.salesman_id, o.order_date
from orders as o, customers as c
where o.customer_id=c.customer_id and year(o.order_date)='2011'

union

select c.customer_id, c.customer_name, c.City, c.salesman_id, o.order_date
from orders as o, customers as c
where o.customer_id=c.customer_id and year(o.order_date)='2013';
-----------------------------------------------------------------------
select c.customer_id, c.customer_name, c.City, c.salesman_id, o.order_date
from orders as o, customers as c
where o.customer_id=c.customer_id and year(o.order_date)='2012'

except

select c.customer_id, c.customer_name, c.City, c.salesman_id, o.order_date
from orders as o, customers as c
where o.customer_id=c.customer_id and year(o.order_date)='2014';