--Find Employees with Minimum Salary
--Retrieve employees who earn the minimum salary in the company. Tables: employees (columns: id, name, salary)
SELECT iD, NAME, SALARY FROM employees
WHERE salary =(SELECT MIN(salary) FROM employees)

--Find Products Above Average Price
--Retrieve products priced above the average price. Tables: products (columns: id, product_name, price)

SELECT ID, PRODUCT_NAME, PRICE FROM products
WHERE price> (SELECT AVG(PRICE) FROM products)

--Nested Subqueries with Conditions
-- Find Employees in Sales Department Task: Retrieve employees who work in the "Sales" department. Tables: employees (columns: id, name, department_id), departments (columns: id, department_name)

SELECT name
FROM employees
WHERE department_id IN (
    SELECT id FROM departments WHERE department_name = 'Sales'
);

-- Find Customers with No Orders
--Retrieve customers who have not placed any orders. Tables: customers (columns: customer_id, name), orders (columns: order_id, customer_id)

SELECT cUSTOMER_ID, nAME FROM CUSTOMERS
WHERE CUSTOMER_ID NOT IN (SELECT CUSTOMER_ID FROM ORDERS)


--Find Products with Max Price in Each Category
--Retrieve products with the highest price in each category. Tables: products (columns: id, product_name, price, category_id)
SELECT  P.ID, PRODUCT_NAME, P.price 
	FROM PRODUCTS P
	JOIN (
		SELECT CATEGORY_ID, 
				MAX(price) AS MAXPRICE 
				FROM PRODUCTS
				GROUP BY CATEGORY_ID) AS F ON P.CATEGORY_ID=F.CATEGORY_ID AND P.price=F.MAXPRICE

-- Find Employees in Department with Highest Average Salary
--Retrieve employees working in the department with the highest average salary. Tables: employees (columns: id, name, salary, department_id), departments (columns: id, department_name)
SELECT e.id, e.name, e.salary, e.department_id
FROM employees e
WHERE e.department_id = (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);

-- Find Employees Earning Above Department Average
-- Retrieve employees earning more than the average salary in their department. Tables: employees (columns: id, name, salary, department_id)
SELECT name, SALARY  FROM employees E 
JOIN (SELECT DEPARTMENT_ID, AVG(SALARY) AS AVGSALARY FROM employees 
GROUP BY DEPARTMENT_ID) AS D ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
WHERE salary>AVGSALARY

--Find Students with Highest Grade per Course
--Retrieve students who received the highest grade in each course. Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade)
SELECT  S.NAME, G.COURSE_ID, G.GRADE FROM GRADES G JOIN (SELECT cOURSE_ID, MAX(GRADE)AS MAXGRADE FROM GRADES 
GROUP BY COURSE_ID
) AS MAX_GRADE ON G.COURSE_ID=MAX_GRADE.COURSE_ID AND G.GRADE=MAX_GRADE.MAXGRADE
JOIN STUDENTS S ON G.STUDENT_ID=S.STUDENT_ID


--Subqueries with Ranking and Complex Conditions
 --Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in each category. Tables: products (columns: id, product_name, price, category_id)
 SELECT id, product_name, price,CATEGORY_ID FROM (
  SELECT ID,  PRODUCT_NAME, PRICE, CATEGORY_ID, DENSE_RANK() OVER (PARTITION BY CATEGORY_ID ORDER BY PRICE DESC) AS RANK FROM PRODUCTS
 ) AS RANKED_PRODUCTS
 WHERE RANK=3
 --Find Employees whose Salary Between Company Average and Department Max Salary
 -- Retrieve employees with salaries above the company average but below the maximum in their department. Tables: employees (columns: id, name, salary, department_id)
SELECT 
    E.name, 
    E.salary, 
    MAX_S.MAXDEP
FROM employees E
JOIN (
    SELECT department_id, MAX(salary) AS MAXDEP
    FROM employees
    GROUP BY department_id
) AS MAX_S
    ON E.department_id = MAX_S.department_id
WHERE 
    E.salary > (SELECT AVG(salary) FROM employees)
    AND E.salary < MAX_S.MAXDEP;
