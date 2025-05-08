create table  Employees ( EmpID int, Name varchar(50), Salary decimal(10,2)
insert into Employees ( EmpID, Name, Salary) values  (1,'Javoxir', 8000),(2, 'Shavkat', 10000), (3, ' Abbos', 4000);
insert into Employees  values (4, ' Aziz', 6000), (5, 'Bobur', 9000)
update employees 
set Salary=7000
where EmpID=1
delete from Employees
where EmpID=2
-- delete — removes specific rows form a table; can use where to target particular records;  can be rolled back if it is  inside  transaction; doesnot effect talbe structure 
-- truncate —-removes all rows from a table; faster than delete; cannot be rollled back; keeps the table structure but rsets indentity colummns
-- drop —- removes the entire table with all data and column and rows , including its structure; cannot be rolled back; we need to recreate table
alter table Employees 
Modify Name varchar(100)
alter  table Employees 
add column Department varchar(50)
alter table Employees
modify column  Salary Float
create table Departments (DepartmentID (int, primary key), DepartmentName varchar(50)
truncate table Employees
insert into departments  values (1,'marketing'), (2, ' sales'), (3, 'HR'), (4,'management'), (5, 'finance')
update table Employees 
set department='management'
where Salary>5000
truncate table employees
Alter table Employees 
drop column Department
Alter table Employees 
rename to StaffMembers 
drop table Departments 
create table Products (ProductID primary key, ProductName varchar(50), Category varchar(100), Price decimal(10,2))
alter table Products 
Add constraint chk_price Check(Price>0)
Alter table Products 
add column StockQuantity INT default 50
alter table Products 
rename column Category to  ProductCategory
insert into Products ( ProductID, ProductName, ProductCategory, Price, StockQuantity) values (1, 'phone', 1000, 10), (2, 'comp', 1500, 8), (3, ' earplug', 200, 100), (4, 'tv', 800, 1000), (5, 'radio', 50, 200)
Select * into Prooduct_backup from Products
alter table Products 
rename table Products to Inventory
alter table Inventory 
alter column Price type Float
alter table Inventory 
  add column ProductCode int Identity(1000,5)
