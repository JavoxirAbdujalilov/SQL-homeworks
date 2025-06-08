--Using the Employees and Departments tables, write a query to return the names and salaries of employees whose salary is greater than 50000, along with their department names.
--🔁 Expected Columns: EmployeeName, Salary, DepartmentName
select Name, Salary, DepartmentName from Employees E
inner join Departments D on E.departmentID=D.departmentID
where salary>50000
--Using the Customers and Orders tables, write a query to display customer names and order dates for orders placed in the year 2023.
--🔁 Expected Columns: FirstName, LastName, OrderDate
Select FirstName, Lastname, orderdate from customers 
inner join orders on Customers.customerID= orders.customerID
where YEAR(orderdate)=2023
--Using the Employees and Departments tables, write a query to show all employees along with their department names. Include employees who do not belong to any department.
--🔁 Expected Columns: EmployeeName, DepartmentName
Select Name, DepartmentName from Employees 
left join Departments on Employees.departmentID=departments.departmentID
--Using the Products and Suppliers tables, write a query to list all suppliers and the products they supply. Show suppliers even if they don’t supply any product.
--🔁 Expected Columns: SupplierName, ProductName
select SupplierName, ProductName from Suppliers 
left join Products on Suppliers.supplierID=Products.SupplierID
--Using the Orders and Payments tables, write a query to return all orders and their corresponding payments. Include orders without payments and payments not linked to any order.
--🔁 Expected Columns: OrderID, OrderDate, PaymentDate, Amount
select * from Orders
select * from Payments
select O.Orderid, Orderdate, PaymentDate, Amount from Orders o
full join payments P on O.orderID=P.orderID
--Using the Employees table, write a query to show each employee's name along with the name of their manager.
--🔁 Expected Columns: EmployeeName, ManagerName
select * from employees
select E1.NAme as EmployeeNAme, E2.Name as ManagerName from employees as E1 
inner join Employees as E2 on E1.EMployeeID=E2.managerID
--Using the Students, Courses, and Enrollments tables, write a query to list the names of students who are enrolled in the course named 'Math 101'.
--🔁 Expected Columns: StudentName, CourseName
Select Name as StudentNAme, CourseName from Enrollments En1
inner join Students S1 on En1.StudentID=S1.StudentID
inner join Courses C1 on En1.CourseID=C1.CourseID
where CourseName='Math 101'
--Using the Customers and Orders tables, write a query to find customers who have placed an order with more than 3 items. Return their name and the quantity they ordered.
--🔁 Expected Columns: FirstName, LastName, Quantity
Select FirstName, LastName, Quantity from Customers 
inner join Orders on Customers.CustomerId=orders.customerID
where quantity>3
--Using the Employees and Departments tables, write a query to list employees working in the 'Human Resources' department.
--🔁 Expected Columns: EmployeeName, DepartmentName
Select Name, departmentName from employees 
inner join departments on employees.departmentID=Departments.departmentID
where departmentNAme='Human Resources'
--🟠 Medium-Level Tasks (9)
--Using the Employees and Departments tables, write a query to return department names that have more than 5 employees.
--🔁 Expected Columns: DepartmentName, EmployeeCount
Select DepartmentName, COUNT(EmployeeID) as EmployeeCount from Employees 
inner join departments on Employees.DepartmentID=departments.DepartmentID
Group by DepartmentName
Having COUNT(employeeID)>5
--Using the Products and Sales tables, write a query to find products that have never been sold.
--🔁 Expected Columns: ProductID, ProductName
select P.ProductID, ProductName from Products P
left join Sales on P.ProductID=sales.ProductID
where Sales.ProductID is null
--Using the Customers and Orders tables, write a query to return customer names who have placed at least one order.
--🔁 Expected Columns: FirstName, LastName, TotalOrders
select FirstNAme, LastNAMe, quantity as Totalorders from Customers 
right join Orders on Customers.CustomerId=orders.customerId
where quantity>=1
--Using the Employees and Departments tables, write a query to show only those records where both employee and department exist (no NULLs).
--🔁 Expected Columns: EmployeeName, DepartmentName
select Name, departmentName from employees 
inner join Departments on employees.DepartmentiD=departments.departmentID
--Using the Employees table, write a query to find pairs of employees who report to the same manager.
--🔁 Expected Columns: Employee1, Employee2, ManagerID
Select * from employees
SELECT E1.Name AS Employee1, E2.Name AS Employee2, E1.ManagerID
FROM Employees E1
JOIN Employees E2 ON E1.ManagerID = E2.ManagerID AND E1.EmployeeID <> E2.EmployeeID
ORDER BY E1.ManagerID;

--Using the Orders and Customers tables, write a query to list all orders placed in 2022 along with the customer name.
--🔁 Expected Columns: OrderID, OrderDate, FirstName, LastName
select orderID, OrderDate, FirstName, LastName 
from Customers
 join Orders on Customers.CustomerID=Orders.CustomerID
where YEAR(orderDate)=2022
--Using the Employees and Departments tables, write a query to return employees from the 'Sales' department whose salary is above 60000.
--🔁 Expected Columns: EmployeeName, Salary, DepartmentName
Select Name, Salary, departmentName from Employees
inner join Departments on Employees.DepartmentID=Departments.DepartmentID
where DepartmentName='Sales' and Salary>60000

--Using the Orders and Payments tables, write a query to return only those orders that have a corresponding payment.
--🔁 Expected Columns: OrderID, OrderDate, PaymentDate, Amount
Select Payments.OrderID, Orderdate, PaymentDate, AMount from Orders
 join Payments on Orders.OrderID= Payments.OrderID
--Using the Products and Orders tables, write a query to find products that were never ordered.
--🔁 Expected Columns: ProductID, ProductName
Select Orders.ProductID, ProductName from products
left join Orders on Products.ProductID=Orders.ProductID
where Orders.ProductID is null
--🔴 Hard-Level Tasks (9)
--Using the Employees table, write a query to find employees whose salary is greater than the average salary in their own departments.
--🔁 Expected Columns: EmployeeName, Salary
select E.Name as EmployeeName, E.Salary from Employees E
inner join (
Select  departmentID, AVG(Salary) as Avgsalary from Employees
Group by DepartmentID) D on E.DepartmentID=D.DepartmentID
Where E.Salary>D.Avgsalary

--Using the Orders and Payments tables, write a query to list all orders placed before 2020 that have no corresponding payment.
--🔁 Expected Columns: OrderID, OrderDate
Select O.orderID, Orderdate From Orders O
left join Payments on O.OrderID=Payments.OrderID
Where YEAR(orderdate)<2020 and Payments.OrderID is null
--Using the Products and Categories tables, write a query to return products that do not have a matching category.
--🔁 Expected Columns: ProductID, ProductName
Select ProductID, ProductName from Products P
left join Categories C on P.Category=C.CategoryID
where C.CategoryID is null
--Using the Employees table, write a query to find employees who report to the same manager and earn more than 60000.
--🔁 Expected Columns: Employee1, Employee2, ManagerID, Salary
Select E1.name as Employee1, E2.Name as Employee2, E1.ManagerID, E1.Salary 
from Employees E1 
join Employees E2 on E1.ManagerID=E2.ManagerID and E1.EmployeeID<>E2.EmployeeID
where E1.Salary>60000 and E2.Salary>60000
order by E1.ManagerID
--Using the Employees and Departments tables, write a query to return employees who work in departments which name starts with the letter 'M'.
--🔁 Expected Columns: EmployeeName, DepartmentName
Select Name as EmployeeName, DepartmentName from EMployees
inner join Departments on Employees.DepartmentID=Departments.DepartmentID
where DepartmentName like 'M%'
--Using the Products and Sales tables, write a query to list sales where the amount is greater than 500, including product names.
--🔁 Expected Columns: SaleID, ProductName, SaleAmount
Select SaleID, ProductName, SaleAmount from Products 
join Sales on Products.ProductID=Sales.CustomerID
where SaleAmount> 500
--Using the Students, Courses, and Enrollments tables, write a query to find students who have not enrolled in the course 'Math 101'.
--🔁 Expected Columns: StudentID, StudentName
Select Enrollments.StudentID, Students.Name as StudentName from Enrollments
left join Students on Enrollments.StudentID=Students.StudentID
left join Courses on Enrollments.CourseID=Courses.CourseID
where Courses.CourseName is null or Courses.CourseName<>'Math 101'

--Using the Orders and Payments tables, write a query to return orders that are missing payment details.
--🔁 Expected Columns: OrderID, OrderDate, PaymentID
select Orders.OrderID, orderdate, PaymentID
from Orders
left join Payments on Orders.OrderID=Payments.OrderID
where PaymentID is Null
--Using the Products and Categories tables, write a query to list products that belong to either the 'Electronics' or 'Furniture' category.
--🔁 Expected Columns: ProductID, ProductName, CategoryName
Select ProductID, ProductName, CategoryName from Products 
left join Categories on Products.Category=Categories.CategoryID
where CategoryName in('Electronics','Furniture')

