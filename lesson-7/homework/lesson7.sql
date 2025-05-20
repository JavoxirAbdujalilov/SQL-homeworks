select  MIN(price) from Products
select MAX(salary) from employees
select COUNT(*) from Customers
Select COUNT(distinct category) from products
select SUM (saleamount) from Sales
where productID=7
select AVG(age) from employees
select departmentName, COUNT(*) from employees
group by departmentName
select Category, MIN(price) as minprice, MAX(price) as maxprice from Products
Group by category
select * from products
select customerID, SUM(saleamount) from sales
group by customerID

select departmentName, COUNT(*) from employees
group by departmentName 
having COUNT(employeeID)>5
--- 11 savol join qo`shilgan select SUM(saleamount) as totalsales, AVG(saleamount) as avaragesales from sales
--- group by ProductID
select COUNT(*) from employees 
where departmentName='HR'
select departmentname, MIN(salary) minsalary, MAX(salary) maxsalary from employees
group by departmentname
select departmentname, AVG(salary) as avaragesalary from employees
group by departmentname;
select departmentName, COUNT(*) as 'number of employyees', AVG(salary) avaragesalary from employees
group by departmentName 
select category, AVG(price)  from products
group by Category
having AVG(price)> 400
select year(saledate), SUM(saleamount) from sales
group by year(saledate)
SELECT CustomerID FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) >= 3;
select DepartmentName, avg(salary) as avgsalary from Employees
group by DepartmentName
Having AVG(salary)> 60000
select CAtegory, AVG(price) as avgprice from Products
group by category
having AVG(price)>150
select customerID, SUM(saleamount) totalamount from sales
group by customerID
having SUM(saleamount)> 1500 
 select departmentName, SUM(salary) totalsalary, AVG(salary) avvgsalary from employees
 group by departmentName
 having AVG(salary)> 65000
 select * from TSQL2012.Sales.Orders
-- 11.23.24.25 qoldi


