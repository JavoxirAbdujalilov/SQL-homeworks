--Create a stored procedure that:

--Creates a temp table #EmployeeBonus
--Inserts EmployeeID, FullName (FirstName + LastName), Department, Salary, and BonusAmount into it
--(BonusAmount = Salary * BonusPercentage / 100)
--Then, selects all data from the temp table.
CREATE PROCEDURE USP_GETEMPBONUS
AS 
  BEGIN 
CREATE TABLE #EmployeeBonus (
    EmployeeID INT,
    FullName NVARCHAR(100),
    Department NVARCHAR(50),
    Salary DECIMAL(10, 2),
    BonusAmount DECIMAL(10, 2)
);
INSERT INTO #EmployeeBonus (EMPLOYEEID,
		FULLNAME, 
		E.DEPARTMENT, 
		SALARY, 
		 BONUSAMOUNT ) 
SELECT 
		EMPLOYEEID,
		CONCAT(FIRSTNAME,' ', LASTNAME) AS FULLNAME, 
		E.DEPARTMENT, 
		SALARY, 
		SALARY*BONUSPERCENTAGE/100 AS BONUSAMOUNT 
	FROM EMPLOYEES E 
	   JOIN DEPARTMENTBONUS D ON E.DEPARTMENT=D.DEPARTMENT;
  SELECT * FROM #EmployeeBonus;
  END;

  EXEC USP_GETEMPBONUS

--Create a stored procedure that:

--Accepts a department name and an increase percentage as parameters
--Update salary of all employees in the given department by the given percentage
--Returns updated employees from that department.
CREATE PROCEDURE usp_UpdateSalaryByDepartment
    @DeptName NVARCHAR(50),
    @PercentIncrease DECIMAL(5, 2)
AS
BEGIN
    -- Update salaries for the given department
    UPDATE Employees
    SET Salary = Salary + (Salary * @PercentIncrease / 100)
    WHERE Department = @DeptName;

    -- Return updated employees from that department
    SELECT 
        EmployeeID,
        FirstName,
        LastName,
        Department,
        Salary
    FROM Employees
    WHERE Department = @DeptName;
END;
	EXEC usp_UpdateSalaryByDepartment 
    @DeptName = 'Sales', 
    @PercentIncrease = 10;

--Perform a MERGE operation that:

--Updates ProductName and Price if ProductID matches
--Inserts new products if ProductID does not exist
--Deletes products from Products_Current if they are missing in Products_New
--Return the final state of Products_Current after the MERGE.

MERGE Products AS TARGET
USING ProductUpdates AS SOURCE
ON TARGET.ProductID = SOURCE.ProductID

WHEN MATCHED 
THEN 
    UPDATE
    SET TARGET.PRODUCTNAME = SOURCE.PRODUCTNAME,
        TARGET.PRICE = SOURCE.PRICE
WHEN NOT MATCHED BY TARGET
THEN 
    INSERT (PRODUCTID, PRODUCTNAME, PRICE)
    VALUES (SOURCE.PRODUCTID,SOURCE.PRODUCTNAME, SOURCE.PRICE)
WHEN NOT MATCHED BY SOURCE
THEN 
    DELETE;

--	Tree Node

--Each node in the tree can be one of three types:

--"Leaf": if the node is a leaf node.
--"Root": if the node is the root of the tree.
--"Inner": If the node is neither a leaf node nor a root node.
--Write a solution to report the type of each node in the tree.
SELECT 
    id,
    CASE 
        WHEN p_id IS NULL THEN 'Root'
        WHEN id IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Inner'
        ELSE 'Leaf'
    END AS type
FROM Tree 
ORDER BY id;

-- Find the confirmation rate for each user. If a user has no confirmation requests, the rate should be 0.
SELECT 
    s.user_id,
    ROUND(
        COALESCE(SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END), 0) * 1.0 /
        COALESCE(COUNT(c.action), 0),
    2) AS confirmation_rate
FROM 
    Signups s
LEFT JOIN 
    Confirmations c
ON 
    s.user_id = c.user_id
GROUP BY 
    s.user_id;

-- Find employees with the lowest salary
--Find all employees who have the lowest salary using subqueries.

SELECT *
FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
);


--Create a stored procedure called GetProductSalesSummary that:

--Accepts a @ProductID input
--Returns:
--ProductName
--Total Quantity Sold
--Total Sales Amount (Quantity × Price)
--First Sale Date
--Last Sale Date
--If the product has no sales, return NULL for quantity, total amount, first date, and last date, but still return the product name.

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Category NVARCHAR(50),
    Price DECIMAL(10,2)
);

-- Sales Table
CREATE PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantitySold,
        SUM(s.Quantity * p.Price) AS TotalSalesAmount,
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductName;
END;
