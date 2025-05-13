select top 5 * from Employees;
select distinct category from Products;
select * from Products
where Price> 100;
select * from Customers
where FirstName like 'A%';
select * from Products
where Price> 100
order by Price asc;
select * from Employees
where Salary>=60000 and DepartmentName='HR'
update Employees
set Email=ISNULL(Email,'noemail@example.com');
select * from Products
where Price between 50 and 100;
select distinct category, productname from products;
select distinct category, productname from Products
order by ProductName desc;


select top 10 * from Products
order by Price desc;
select coalesce(Firstname, Lastname ) as Fullname from Employees;
select distinct category , price from products;
select * from Employees
where Age between 30 and 40 and Departmentname='marketing'
select * from Employees
order by Salary desc
offset 11 rows fetch next 20 rows only;
select * from Products
where Price<=1000 and StockQuantity>50 
order by StockQuantity desc;
select * from Products
where ProductName like '%e%';
SELECT * FROM Employees
WHERE DepartmentName IN('HR','IT', ' FINANCE');
SELECT * FROM Customers
ORDER BY City ASC , PostalCode DESC;

Select top(5) ProductID, SaleAmount from Sales
order by SaleAmount desc ;
select coalesce (firstname, lastname) as fullName from Employees
select distinct category, productname, price from Products
where Price>50;
select * from Products
where Price<(select AVG(Price)*0.1 from Products)
select * from Employees
where Age<30 and DepartmentName in('hr', 'IT')
select * from Customers
where Email like '%@gmail.com'
select * from Employees
where Salary>all(select Salary from Employees where DepartmentName='sales')
select*, dateadd(day,-180, getdate()) as date_180_days_ago from Orders
