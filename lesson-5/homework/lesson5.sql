Select ProductName as Name from Products
Select * from Customers as Client
Select ProductName from Products
Union 
select ProductName from Products_Discounted 
Select ProductName from Products
INTERSECT
select ProductName from Products_Discounted
select distinct Firstname, lastname,Country from Customers
select *, case
when Price>1000 then 'High' else 'Low' end  from products
select*,  IIF(Stockquantity>100,'Yes','No') from Products_Discounted
select ProductName from Products
Union
Select ProductName from Products_Discounted
select * from Products 
except 
select * from Products_Discounted
select*, IIF(Price>1000,'Expensive', 'Affordable') from Products 
select * from employees 
Where Age>25 and salary>60000
Update employees
set salary=salary*1.10
where departmentName='HR' OR EMPLOYEEID=5
SELECT *, CASE
WHEN SALEAMOUNT>500 THEN 'TOP TIER'
WHEN SALEAMOUNT BETWEEN 200 AND 500 THEN 'MID TIER'
ELSE 'LOW TIER' END FROM SALES
SELECT CUSTOMERID FROM ORDERS
EXCEPT
SELECT CUSTOMERID FROM SALES
SELECT*, CASE 
WHEN QUANTITY>3 THEN  '7%'
WHEN QUANTITY BETWEEN 2 AND 3 THEN '5%'
ELSE '3%' end as Discount from orders
