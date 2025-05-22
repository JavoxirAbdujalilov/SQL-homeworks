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
select  ProductID, SUM(Saleamount) as sumamount, AVG(Saleamount) as avgamount from Sales
GROUP by ProductID
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
SELECT * FROM TSQL2012.Sales.Orders
SELECT CUSTid, SUM(IIF(FREIGHT>50,FREIGHT,0)) AS OVER_50, MIN(FREIGHT) AS MINAMOUNT FROM TSQL2012.Sales.Orders
GROUP BY custid
 SELECT CustID,SUM( CASE 
 WHEN FREIGHT> 50 THEN FREIGHT ELSE 0 END) AS OVER_50, MIN(FREIGHT) AS MINFREIGHT FROM TSQL2012.SALES.ORDERS
 GROUP BY custid
 SELECT YEAR(ORDERDATE), MONTH(ORDERDATE),SUM(TOTALAMOUNT), COUNT(DISTINCT PRODUCTID) FROM Orders
 GROUP BY YEAR(ORDERDATE), MONTH(ORDERDATE)
 HAVING COUNT(ProductID)>=2
 SELECT YEAR(ORDERDATE), MIN(QUANTITY), MAX(QUANTITY) FROM Orders GROUP BY YEAR(ORDERDATE)


