--Easy (10 puzzles)
--1. Using Products, Suppliers table List all combinations of product names and supplier names.
select ProductName, SupplierName from products, suppliers
--2. Using Departments, Employees table Get all combinations of departments and employees.
select  Name, DepartmentName
from Employees
cross join Departments
--3. Using Products, Suppliers table List only the combinations where the supplier actually supplies the product. Return supplier name and product name
Select PRODUCTName, SupplierName
from Products inner join Suppliers on Products.SupplierID=suppliers.SupplierID 
--4. Using Orders, Customers table List customer names and their orders ID.
Select firstname as Name, orderID
from customers inner join orders on customers.customerID=orders.customerID
--5. Using Courses, Students table Get all combinations of students and courses.
select Name, CourseName from students
cross join courses
--6. Using Products, Orders table Get product names and orders where product IDs match.
select ProductName, OrderID from products inner join orders on Products.ProductID=orders.productid
--7. Using Departments, Employees table List employees whose DepartmentID matches the department.
select Name, DepartmentName from Employees 
inner join departments on Employees.departmentid=Departments.Departmentid
--8. Using Students, Enrollments table List student names and their enrolled course IDs.
select Name, enrollmentID from students inner join Enrollments on students.studentID=enrollments.studentID
--9. Using Payments, Orders table List all orders that have matching payments.
select Orders.OrderID, paymentID from Orders inner join Payments on orders.orderid=payments.orderiD
--10. Using Orders, Products table Show orders where product price is more than 100.
Select orderID, Productname, price from Orders inner join Products on orders.ProductId=products.productID 
  where Price>100
--🟡 Medium (10 puzzles)
--11. Using Employees, Departments table List employee names and department names where department IDs are not equal. It means: Show all mismatched employee-department combinations.
select name, DepartmentName from Employees 
Cross join  Departments 
where Employees.DepartmentID<>departments.DepartmentID
--12. Using Orders, Products table Show orders where ordered quantity is greater than stock quantity.
SELECT P.ProductName, O.OrderID, P.StockQuantity, O.Quantity
FROM Products P
LEFT JOIN Orders O ON P.ProductID = O.ProductID 
where O.Quantity > P.StockQuantity;
--13. Using Customers, Sales table List customer names and product IDs where sale amount is 500 or more.
select Firstname, PRODUCTID, Saleamount from Customers inner join Sales on Customers.CustomerID=Sales.CustomerID
where SAles.saleamount>500
--14. Using Courses, Enrollments, Students table List student names and course names they’re enrolled in.
Select S.Name,C.CourseName from Enrollments E
inner join students S on E.StudentID=S.StudentID
inner join Courses C on E.CourseID=C.CourseID
--15. Using Products, Suppliers table List product and supplier names where supplier name contains “Tech”.
select PRODUCTNAme, supplierNAme from products inner join Suppliers on Products.supplierID=Suppliers.supplierID
where Suppliers.SupplierName like '%Tech%'
--16. Using Orders, Payments table Show orders where payment amount is less than total amount.
Select PaymentID, O.OrderID, TotalAmount, AMount from Orders O inner join Payments P on O.orderID=P.OrderID
where Amount<TotalAmount
--17. Using Employees and Departments tables, get the Department Name for each employee.
Select Name, departmentName from employees E inner join Departments D on E.departmentID=D.departmentID
--18. Using Products, Categories table Show products where category is either 'Electronics' or 'Furniture'.
Select ProductNAme,categoryname from Products P inner join Categories C on P.Category=C.CategoryID
where categoryNAMe in('Electronics', 'Furniture')
--19. Using Sales, Customers table Show all sales from customers who are from 'USA'.
select SaleID, firstname, country from Sales inner join Customers on sales.customerID=customers.customerID
where country='USA'
--20. Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100.
select Firstname, country, totalamount from Orders O inner join Customers C on O.CustomerID=C.CustomerID
where country='Germany' and Totalamount>100
--🔴 Hard (5 puzzles)(Do some research for the tasks below)
--21. Using Employees table List all pairs of employees from different departments.
SELECT E1.Name AS Employee1, E2.Name AS Employee2, E1.DepartmentID AS Dept1, E2.DepartmentID AS Dept2
FROM Employees E1
JOIN Employees E2 ON E1.DepartmentID <> E2.DepartmentID AND E1.EmployeeID < E2.EmployeeID;
--22. Using Payments, Orders, Products table List payment details where the paid amount is not equal to (Quantity × Product Price).
select price, quantity, Amount from Orders 
inner join Products on Orders.ProductID=Products.ProductID
inner join Payments on orders.OrderID=payments.OrderID
where price*quantity<> Amount
--23. Using Students, Enrollments, Courses table Find students who are not enrolled in any course.
select S.Studentid from Students S
left join  enrollments EN on S.studentID=En.StudentID
where En.EnrollmentID is null
--24. Using Employees table List employees who are managers of someone, but their salary is less than or equal to the person they manage.
select E1.Name as employees, E2.Name as Manager, E1.salary as EmployeeSalary, E2.Salary as ManagerSalary from Employees as E1 inner join employees as E2 on E1.employeeID=E2.ManagerID
where E1.Salary>=E2.SAlary
--25. Using Orders, Payments, Customers table List customers who have made an order, but no payment has been recorded for it.
select Customers.customerID, orders.OrderID, paymentID from Orders 
inner join customers on orders.customerID=customers.customerID
left join payments on Orders.orderID=payments.orderID
where paymentID is null
