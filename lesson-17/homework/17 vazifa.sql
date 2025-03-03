--Homework 17
go
Use Northwind
go

--32
select* from Customers c
select* from Orders o
select* from OrderDetails d


select  c.CustomerID,
c.CompanyName,o.OrderID,  totalamount=sum (Quantity* UnitPrice)
from Customers c
join Orders o on c.CustomerID=o.CustomerID
join OrderDetails d 
on d.OrderID=o.OrderID
where o.OrderDate >='2016-01-01' and OrderDate <'2017-01-01'
group by c.CustomerID,c.CompanyName,o.OrderID
 Having sum (Quantity* UnitPrice)> 10000
 order by totalamount desc

 --33
 select  c.CustomerID,
c.CompanyName, totalamount=sum (Quantity* UnitPrice)
from Customers c
join Orders o on c.CustomerID=o.CustomerID
join OrderDetails d 
on d.OrderID=o.OrderID
where o.OrderDate >='2016-01-01' and OrderDate <'2017-01-01'
group by c.CustomerID,c.CompanyName
 Having sum (Quantity* UnitPrice)> 15000
 order by totalamount desc
 --34
 select *,TotalWithDisccount = UnitPrice * Quantity *
(1- Discount) from OrderDetails

select  c.CustomerID,
c.CompanyName, TotalsWithoutDiscount= sum (Quantity* UnitPrice),
TotalWithDisccount = sum (UnitPrice * Quantity *
(1- Discount) )
from Customers c
join Orders o on c.CustomerID=o.CustomerID
join OrderDetails d 
on d.OrderID=o.OrderID
where o.OrderDate >='2016-01-01' and OrderDate <'2017-01-01'
group by c.CustomerID,c.CompanyName
having  sum (UnitPrice * Quantity *
(1- Discount) )>10000
order by TotalsWithoutDiscount desc

--35

select e.EmployeeID ,o.OrderID, o.OrderDate  from Employees e
join Orders o
on e.EmployeeID=o.EmployeeID
where o.OrderDate=(SELECT DATEADD(DAY, -1, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) + 1, 0)) )AS EndOfMonth;


select EmployeeID,OrderID,OrderDate  from Orders
where OrderDate=EOMONTH(OrderDate)
order  by  EmployeeID,OrderID

--36

select top 10 o.OrderId, TotalOrderDetails=count(*)
from Orders o
join OrderDetails d on
o.OrderID=d.OrderID
group by o.OrderID
order by count(*) desc

--37
Select top 2 percent 
OrderID
From Orders
order by newid ()

--38
Select
OrderID
 From OrderDetails Where Quantity >= 60
group by OrderID,Quantity
having count (*)>1

--39
with PotentialDuplicates as (
Select
OrderID
From OrderDetails
Where Quantity >= 60
Group By OrderID, Quantity
Having Count(*) > 1
)
Select
OrderID
,ProductID
,UnitPrice
,Quantity
,Discount
From OrderDetails
Where
OrderID in (Select OrderID from PotentialDuplicates)
Order by
OrderID
,Quantity

--40

Select distinct OrderDetails.OrderID
,ProductID
,UnitPrice ,Quantity ,Discount From OrderDetails Join (
Select OrderID
From OrderDetails Where Quantity >= 60
Group By OrderID, Quantity Having Count(*) > 1
) PotentialProblemOrders on PotentialProblemOrders.OrderID =
OrderDetails.OrderID

Order by OrderID, ProductID
--41
select OrderID, OrderDate, RequiredDate ,ShippedDate from Orders
where orderId in (select OrderID from Orders
where ShippedDate>= RequiredDate
)
--42

select e.EmployeeID, e.LastName, TotalLateOrders=count(*) from Orders o
join Employees e on e.EmployeeID=o.EmployeeID
where RequiredDate<= ShippedDate
group by e.EmployeeID, e.LastName
order by TotalLateOrders desc

--43
with cte1 as ( Select EmployeeID,
LateOrders = Count(*) From Orders Where RequiredDate <= ShippedDate
Group By EmployeeID
),
  cte2 as (
Select EmployeeID,
TotalOrders = Count(*) From Orders Group By EmployeeID
),
cte3 as (
select EmployeeID,LastName from Employees
)

select cte1.EmployeeID,cte3.LastName,cte2.TotalOrders,cte1.LateOrders  from cte1
join cte2 on cte1.EmployeeID=cte2.EmployeeID
join cte3 on  cte3.EmployeeId=cte2.EmployeeId


--44
with cte1 as ( Select EmployeeID,
LateOrders = Count(*) From Orders Where RequiredDate <= ShippedDate
Group By EmployeeID
),
  cte2 as (
Select EmployeeID,
TotalOrders = Count(*) From Orders Group By EmployeeID
),
cte3 as (
select EmployeeID,LastName from Employees
)

select cte2.EmployeeID,cte3.LastName,cte2.TotalOrders,cte1.LateOrders  from cte2
 left join cte1 on cte1.EmployeeID=cte2.EmployeeID
join cte3 on  cte3.EmployeeId=cte2.EmployeeId

--45
with cte1 as ( Select EmployeeID,
LateOrders = Count(*) From Orders Where RequiredDate <= ShippedDate
Group By EmployeeID
),
  cte2 as (
Select EmployeeID,
TotalOrders = Count(*) From Orders Group By EmployeeID
),
cte3 as (
select EmployeeID,LastName from Employees
)

select cte2.EmployeeID,
cte3.LastName,
cte2.TotalOrders,
 coalesce(cte1.LateOrders, 0) as LateOrders
from cte2
left join cte1 on cte1.EmployeeID=cte2.EmployeeID
join cte3 on  cte3.EmployeeId=cte2.EmployeeId

--46


with cte1 as ( Select EmployeeID,
LateOrders = Count(*) From Orders Where RequiredDate <= ShippedDate
Group By EmployeeID
),
  cte2 as (
Select EmployeeID,
TotalOrders = Count(*) From Orders Group By EmployeeID
),
cte3 as (
select EmployeeID,LastName from Employees
)

select cte2.EmployeeID,
cte3.LastName,
cte2.TotalOrders,
 coalesce(cte1.LateOrders, 0) as LateOrders,
  coalesce(cast (cte1.LateOrders as float )/cast (cte2.TotalOrders as float ),0
) as PercentOver
from cte2
left join cte1 on cte1.EmployeeID=cte2.EmployeeID
join cte3 on  cte3.EmployeeId=cte2.EmployeeId

--47
with cte1 as ( Select EmployeeID,
LateOrders = Count(*) From Orders Where RequiredDate <= ShippedDate
Group By EmployeeID
),
  cte2 as (
Select EmployeeID,
TotalOrders = Count(*) From Orders Group By EmployeeID
),
cte3 as (
select EmployeeID,LastName from Employees
)

select cte2.EmployeeID,
cte3.LastName,
cte2.TotalOrders,
 coalesce(cte1.LateOrders, 0) as LateOrders,
    coalesce( convert (decimal(10,2), 
        (convert(decimal(18,10), cte1.LateOrders) / 
         convert(decimal(18,10), cte2.TotalOrders))
    ), 0)  as PercentOver
from cte2
left join cte1 on cte1.EmployeeID=cte2.EmployeeID
join cte3 on  cte3.EmployeeId=cte2.EmployeeId

--48

WITH table1 AS (
    SELECT 
        Customers.CustomerID,
        Customers.CompanyName,
        SUM(Quantity * UnitPrice) AS TotalOrderAmount
    FROM Customers
    JOIN Orders ON Orders.CustomerID = Customers.CustomerID
    JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
    WHERE OrderDate >= '2016-01-01'
    AND OrderDate < '2017-01-01'
    GROUP BY Customers.CustomerID, Customers.CompanyName
)
SELECT * ,
case 
when TotalOrderAmount>10000 then 'very high'
when TotalOrderAmount between 5000 and 9999 then  'high'
when TotalOrderAmount between 1000 and 4999 then 'medium'
when TotalOrderAmount between 0 and 999  then 'low'
end as CustomerGroup
FROM table1

--49
WITH table2 AS (
    SELECT 
        Customers.CustomerID,
        Customers.CompanyName,
        SUM(Quantity * UnitPrice) AS TotalOrderAmount
    FROM Customers
    JOIN Orders ON Orders.CustomerID = Customers.CustomerID
    JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
    WHERE OrderDate >= '2016-01-01'
    AND OrderDate < '2017-01-01'
    GROUP BY Customers.CustomerID, Customers.CompanyName
)
SELECT * ,
case 
when TotalOrderAmount>10000 then 'very high'
when TotalOrderAmount between 5000 and 9999 then  'high'
when TotalOrderAmount between 1000 and 4999 then 'medium'
when TotalOrderAmount between 0 and 999  then 'low'
end as CustomerGroup
FROM table2

--50


WITH data1 AS (
    SELECT 
        Customers.CustomerID,
        Customers.CompanyName,
        SUM(Quantity * UnitPrice) AS TotalOrderAmount
    FROM Customers
    JOIN Orders ON Orders.CustomerID = Customers.CustomerID
    JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
    WHERE OrderDate >= '2016-01-01'
    AND OrderDate < '2017-01-01'
    GROUP BY Customers.CustomerID, Customers.CompanyName
)


SELECT * ,
case 
when TotalOrderAmount>10000 then 'very high'
when TotalOrderAmount between 5000 and 9999 then  'high'
when TotalOrderAmount between 1000 and 4999 then 'medium'
when TotalOrderAmount between 0 and 999  then 'low'
end as CustomerGroup
FROM data1


PercentageInGroup
with TotalInGroup as (
SELECT * ,
case 
when TotalOrderAmount>10000 then 'very high'
when TotalOrderAmount between 5000 and 9999 then  'high'
when TotalOrderAmount between 1000 and 4999 then 'medium'
when TotalOrderAmount between 0 and 999  then 'low'
end as CustomerGroup
FROM table1
)

--52
select country from Suppliers
union
select country from Customers
order by country 

--53

with SupplierCountry as(
select distinct country from Suppliers
),
CustomerCountry as (
select distinct country from Customers)
select 
SupplierCountry=SupplierCountry.Country ,
CustomerCountry=CustomerCountry.Country 
 from SupplierCountry
 full outer join 
 CustomerCountry on 
 SupplierCountry.Country =CustomerCountry.Country 

 --54
 
 with CustomerCountries as (
 select country,count(*) as total  from Customers
 group by country
 ),
 SupplierCountries as (
 select country,count(*) as total  from Suppliers
 group by country
)
Select Country = isnull(
SupplierCountries.Country, CustomerCountries.Country) ,
TotalSuppliers=
isnull(SupplierCountries.Total,0) ,
TotalCustomers=
isnull(CustomerCountries.Total,0)
From SupplierCountries 
Full Outer Join
CustomerCountries on 
CustomerCountries.Country = SupplierCountries.Country

 --55

with row1 as (
 Select ShipCountry
,CustomerID
,OrderID
,OrderDate = convert(date, OrderDate) ,
RowNumberPerCountry =
Row_Number() over (Partition by ShipCountry Order by ShipCountry,
OrderID)
From Orders
 )
  select ShipCountry
,CustomerID
,OrderID
,OrderDate from row1
where RowNumberPerCountry=1
group by ShipCountry
,CustomerID
,OrderID
,OrderDate

--56
select InitialOrder.CustomerID,
InitialOrderID=InitialOrder.OrderID,
InitialOrderDate=convert (date,InitialOrder.OrderDate),
 NextOrderID=NextOrder.OrderID,
NextOrderDate =convert (date,NextOrder.OrderDate),
datediff(dd,InitialOrder.OrderDate,NextOrder.OrderDate) as Daysbetween
from Orders InitialOrder 
join Orders NextOrder
on InitialOrder.CustomerID=NextOrder.CustomerID
and InitialOrder.OrderDate<NextOrder.OrderDate
where datediff(day,InitialOrder.OrderDate,NextOrder.OrderDate) <=5
order by InitialOrder.CustomerID,
InitialOrder.OrderID

--57
with cte as (
select 
CustomerID,
convert(date,OrderDate)as OrderDate,
convert (date,
Lead(OrderDate,1)over (Partition by CustomerId order by OrderDate)) as NextOrderDate
from Orders
)
 select *,
 datediff (day,OrderDate,NextOrderDate) as DaysBetweenOrders 
 from cte 
 where datediff (day,OrderDate,NextOrderDate)<=5
 order by CustomerID,OrderDate;

 