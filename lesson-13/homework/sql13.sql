--HOMEWORK 13
GO
USE  W3Resource
GO

--1
select * from Inventory.Orders
select * from Inventory.Salesman

select * from Inventory.Orders
where salesman_id in (select salesman_id from Inventory.Salesman 
where name='Paul Adam')

--2

select * from Inventory.Orders
where salesman_id in (select salesman_id from Inventory.Salesman 
where city='London')

--3
select * from Inventory.Orders
where salesman_id=(select distinct salesman_id from Inventory.Orders where customer_id=3007);

--4
From the following tables write a SQL query to find the order values greater than the average order value of 10th October 2012.
Return ord_no, purch_amt, ord_date, customer_id, salesman_id.

--5
From the following tables, write a SQL query to find all the orders generated in New York city.
Return ord_no, purch_amt, ord_date, customer_id and salesman_id.

select * from Inventory.Orders
where salesman_id =( select salesman_id from Inventory.Salesman
where city ='New York')
--6

select commission from Inventory.Salesman
where city =(select city from Inventory.Customer
where city='Paris' )
--7
select * from Inventory.Customer
where customer_id in( select salesman_id-2001 from Inventory.Salesman
where name='Mc Lyon')
--8
select * from Inventory.Customer
select grade,count (customer_id) from Inventory.Customer
group by grade
having grade > (select avg(grade) from Inventory.Customer
where city='New York' )
--9

select ord_no, purch_amt, ord_date,  salesman_id from  Inventory.Orders	
where  salesman_id in (select salesman_id from Inventory.Salesman 
where commission=(select max (commission) from Inventory.Salesman)  );

--10

 select o.ord_no, o.purch_amt, o.ord_date, o.customer_id, o.salesman_id ,c.cust_name  from Inventory.Orders o
 join Inventory.Customer c on o.salesman_id=c.salesman_id
 where o.ord_date='2012-08-17'
 --11 

 select salesman_id ,name from Inventory.Salesman s
 where 1< (select count (*) from Inventory.Customer
 where salesman_id=s.salesman_id);

  --12 
 
select * from Inventory.Orders
where purch_amt >(
select avg (purch_amt)from Inventory.Orders)

--13
 

 select * from Inventory.Orders o
 where purch_amt >= ( select avg (purch_amt) from Inventory.Orders r
 where o.salesman_id=r.salesman_id)
 --14

 select ord_date,sum(purch_amt) as total_sum from Inventory.Orders
 group by ord_date
 having sum(purch_amt)> max(purch_amt)+1000;

 --15
 select * from Inventory.Customer
 where exists (select * from Inventory.Customer
 where city='London')
 --16
 select * from Inventory.Salesman
 where salesman_id in (
 select distinct salesman_id from Inventory.Customer a
 where exists (
 select * from Inventory.Customer b
 where b.salesman_id=a.salesman_id and
 b.cust_name<> a.cust_name)
 );


 --17
  select * from Inventory.Salesman
 where salesman_id in (
 select distinct salesman_id from Inventory.Customer a
 where not  exists (
 select * from Inventory.Customer b
 where b.salesman_id=a.salesman_id and
 b.cust_name<> a.cust_name)
 );
 --18
  select * from Inventory.Salesman a
  where exists (
  select *from Inventory.Customer b
  where  b.salesman_id=a.salesman_id 
  and 1<(
  select count (*) from Inventory.Orders o
  where o.customer_id=b.customer_id)
  );
  --19
  select * from Inventory.Salesman a
  where exists (
  select *from Inventory.Customer b
  where  b.salesman_id=a.salesman_id 
  and 1<(
  select count (*) from Inventory.Orders o
  where o.customer_id=b.customer_id)
  );
  --20
  select * from Inventory.Salesman 
  where city in  ( select city  from Inventory.Customer )
 --21
   select * from Inventory.Salesman a
   where exists (select * from Inventory.Customer b
where a.name < b.cust_name )
--22
select * from Inventory.Customer a
where grade > any  (select grade from  Inventory.Customer 
where  city<'New York')
--23
select * from Inventory.Orders
where purch_amt > any  (select purch_amt from Inventory.Orders
where ord_date='2012-09-10')
--24
select * from Inventory.Orders 
where purch_amt < any  (select purch_amt from Inventory.Orders a ,Inventory.Customer b
where a.customer_id=b.customer_id and b.city='London'  )

--25
select * from Inventory.Orders
where purch_amt < any (
select max(purch_amt) from Inventory.Orders a,Inventory.Customer b
where a.customer_id=b.customer_id and b.city='London' )
--26
select * from Inventory.Customer
 where grade > all (select grade from Inventory.Customer
 where city='New York')

 --27
 select name,city, subquery1.total_amt from Inventory.Salesman ,
 (select salesman_id,sum(Inventory.Orders.purch_amt) as total_amt from Inventory.Orders
 group by salesman_id) subquery1
 where subquery1.salesman_id=Inventory.Salesman.salesman_id and salesman.city in (select distinct city from Inventory.Customer);

 --28
 select * from Inventory.Customer
 where  grade <> all (select grade from Inventory.Customer
 where  city= 'London' and grade is not null)

 --29
 select *  from Inventory.Customer
 where grade <> all(
 select grade from Inventory.Customer 
 where city='Paris' )

 --30
 select * from Inventory.Customer
 where grade <>  any(select grade from Inventory.Customer
 where city='Dallas')



 --34
 SELECT * FROM emp_details
 where emp_lname in  ( 'Gabriel' , 'Dosio')
 --35
 SELECT * FROM emp_details
 where emp_dept in  ( 89,63)

 --36
 
 select  emp_fname , emp_lname from emp_details
 where emp_dept in (select dpt_code from emp_department
 where dpt_allotment>50000)

 