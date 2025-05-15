-- The purpose of bulk insert is that importing data from a file into a database table or view. This is particularly useful for loading large volumes of data efficiently.
-- four file formats can be imported are csv, txt, xml, json.
create table Products (ProductID INT primary key, ProductName Varchar(50), Price decimal(10,2));
insert into Products values  (1, 'Laptop', 1200.00), (2, 'Smartphone', 800.00), (3, 'Tablet', 400.00);
-- NULL Represents missing or unknown data in a column. NOT NULL Ensures a column must have a value (cannot be empty).
Alter table Products add constraint UQ_ProductName Unique(ProductName);
-- comments help the purpose of a SQL query, making it eagier to undersand for others or for the future references. Types of comments: single-line comments using --( 2 line); multi-line comments /*...*/. And we can also make a comment using CTRL+K,CTRL+C
Alter table Products add CategoryID INT;
Create table Categories (CategoryID INT Primary key, CategoryName Varchar(50) Unique);
-- The purpose of IDENTITY is that automatically generate unique values for a column, typically serving as a primary key. It eliminates the need for manual entry of sequential numbers. so it can Auto-Incrementing Values; Primary Key Support; Simplifies Data Entry
bulk insert Products from 'C:\Users\Lenovo\Desktop\product1.txt' with (firstrow=1, rowterminator='\n', fieldterminator=',')
Alter table Products add constraint FK_Category Foreign Key (CategoryID)references Categories(CategoryID)
--Primary Key (PK) ensures each row is uniquely identified, does not allow NULL values, and a table can have only one PK. It automatically creates a clustered index. Unique Key (UK) ensures uniqueness but allows NULL values. A table can have multiple UKs, and it creates a non-clustered index by default.
Alter table Products Add constraint Price check(price>0);
Alter table Products add Stock int not null default 0;
Select ProductName, ISNULL(Price,0) as AdjestedPrice from Products 
-- A FOREIGN KEY constraint establishes a relationship between two tables, ensuring referential integrity by linking a column in one table to the PRIMARY KEY of another table. it Prevents invalid data; Maintains consistency; Enforces relationships
Create table Customers (CustomerID INT primary key, CustomerName varchar(50), Age int check(age>=18));
Create table Orders (OrderId int identity(100,10));
Create table OrderDetails (OrdersID int, ProductID int, Quantity int Primary key( OrdersID,ProductID,Quantity)); 
--Isnull replaces null with a single specific value, accepts only 2 arguments uses the data type of the first argument. SELECT ProductName, ISNULL(Price, 0) AS AdjustedPrice FROM Products;    Coalesce returns the first non-NULL value from multiple arguments, accepts multiple parameters, follows CASE expression rules for data type precedence. SELECT ProductName, COALESCE(DiscountPrice, Price, 0) AS FinalPrice FROM Products;
Create table Employees (EmpID int Primary key, Email varchar(50) unique); 
ALTER TABLE Products 
ADD CONSTRAINT FK_Category FOREIGN KEY (CategoryID) 
REFERENCES Categories(CategoryID)
ON DELETE CASCADE
ON UPDATE CASCADE;
