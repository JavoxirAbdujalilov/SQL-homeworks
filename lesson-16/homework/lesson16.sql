--Create a numbers table using a recursive query from 1 to 1000.
WITH CTE AS (
SELECT 1 AS NUMBER 
UNION ALL
SELECT NUMBER+1 FROM CTE WHERE NUMBER<1000
)
SELECT * FROM CTE OPTION(MAXRECURSION 1000)
--Write a query to find the total sales per employee using a derived table.(Sales, Employees)
SELECT EMP.EMPLOYEEID, FIRSTNAME, LASTNAME, TOTALAMOUNT FROM EMPLOYEES EMP 
 JOIN (SELECT EMPLOYEEID, SUM(SALESAMOUNT) AS TOTALAMOUNT
 FROM SALES
GROUP BY EMPLOYEEID
) AS SALES ON EMP.EMPLOYEEID=SALES.EMPLOYEEID
--Create a CTE to find the average salary of employees.(Employees)
WITH CTE AS 
(SELECT DEPARTMENTID, AVG(SALARY) AS AVGSLARY FROM EMPLOYEES

GROUP BY DEPARTMENTID
) 
SELECT * FROM CTE
--Write a query using a derived table to find the highest sales for each product.(Sales, Products)
SELECT P.PRODUCTID, PRODUCTNAME, HIGHSALES FROM PRODUCTS P JOIN (SELECT PRODUCTID, MAX(SALESAMOUNT)
HIGHSALES FROM SALES
GROUP BY PRODUCTID) AS S ON P.PRODUCTID=S.PRODUCTID
--Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.
WITH CTE AS (
SELECT 1 AS NUMBER
UNION ALL
SELECT NUMBER*2 FROM CTE WHERE NUMBER<1000000)
SELECT * FROM CTE 
--Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
WITH CTE AS(
SELECT EMPLOYEEID, COUNT(SALESID) AS SALESOFEMP FROM SALES 
GROUP BY EMPLOYEEID
) 
SELECT FIRSTNAME,LASTNAME,SALESOFEMP FROM CTE
JOIN EMPLOYEES ON CTE.EMPLOYEEID=EMPLOYEES.EMPLOYEEID
WHERE SALESOFEMP>5
--Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
WITH CTE AS (
SELECT PRODUCTID, SALESAMOUNT FROM SALES WHERE SALESAMOUNT>500
)
SELECT P.PRODUCTID, PRODUCTNAAVGGME, SALESAMOUNT FROM PRODUCTS P JOIN CTE ON P.PRODUCTID=CTE.PRODUCTID
--Create a CTE to find employees with salaries above the average salary.(Employees)
WITH CTE AS (
SELECT  AVG(SALARY) AS AVGSALARY 
FROM EMPLOYEES
)
SELECT E.EMPLOYEEID, 
	E.FIRSTNAME, 
	E.LASTNAME, 
	E.SALARY, 
	C.AVGSALARY 
	FROM EMPLOYEES E
	CROSS JOIN CTE C
WHERE E.SALARY>C.AVGSALARY
--Medium Tasks
--Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
SELECT TOP 5 EMP.EMPLOYEEID, ORDR.ORDERS FROM EMPLOYEES EMP JOIN (SELECT EMPLOYEEID, COUNT(SALESID) AS ORDERS FROM SALES
GROUP BY EMPLOYEEID) AS  ORDR ON EMP.EMPLOYEEID=ORDR.EMPLOYEEID
ORDER BY ORDERS DESC
--Write a query using a derived table to find the sales per product category.(Sales, Products)
SELECT  CATEGORYID, SUM(SALESAMOUNT) FROM PRODUCTS P JOIN (SELECT PRODUCTID, SALESAMOUNT FROM SALES) AS SALES ON P.PRODUCTID=SALES.PRODUCTID
GROUP BY CATEGORYID
--Write a script to return the factorial of each value next to it.(Numbers1)
WITH CTE AS (
SELECT NUMBER, NUMBER AS MULTI, NUMBER AS FACT FROM NUMBERS1
UNION ALL
SELECT NUMBER, MULTI-1, FACT*(MULTI-1) FROM  CTE WHERE MULTI-1>0
)
SELECT NUMBER, MAX(FACT) FROM CTE 
GROUP BY NUMBER 
ORDER BY NUMBER
--This script uses recursion to split a string into rows of substrings for each character in the string.(Example)
WITH CTE AS (
SELECT ID, 1 AS POSITION, SUBSTRING(STRING,1,1) AS CHARACTER, STRING FROM EXAMPLE
UNION ALL
SELECT ID, POSITION+1, SUBSTRING(STRING,POSITION+1, 1), STRING FROM CTE
WHERE POSITION+1<=LEN(STRING)
)
SELECT ID, POSITION, CHARACTER FROM CTE
ORDER BY ID, POSITION OPTION(MAXRECURSION 0)
--Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
SELECT * FROM SALES 
-- Step 1: Build monthly totals
WITH MonthlySales AS (
  SELECT 
    FORMAT(SaleDate, 'yyyy-MM') AS SaleMonth,
    SUM(SalesAmount) AS TotalSales
  FROM Sales
  GROUP BY FORMAT(SaleDate, 'yyyy-MM')
)
SELECT 
  curr.SaleMonth,
  curr.TotalSales,
  prev.SaleMonth AS PrevMonth,
  prev.TotalSales AS PrevMonthSales,
  curr.TotalSales - prev.TotalSales AS SalesDiff
FROM MonthlySales curr
LEFT JOIN MonthlySales prev 
  ON FORMAT(DATEADD(MONTH, 1, CAST(prev.SaleMonth + '-01' AS DATE)), 'yyyy-MM') = curr.SaleMonth
ORDER BY curr.SaleMonth;

--Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)
SELECT E.EMPLOYEEID, FIRSTNAME, LASTNAME,  q.SaleYear,
  q.SaleQuarter,
  q.TotalSales FROM EMPLOYEES E JOIN (SELECT 
    EmployeeID,
    YEAR(SaleDate) AS SaleYear,
    DATEPART(QUARTER, SaleDate) AS SaleQuarter,
    SUM(SalesAmount) AS TotalSales
  FROM Sales
  GROUP BY EmployeeID, YEAR(SaleDate), DATEPART(QUARTER, SaleDate)
  HAVING SUM(SalesAmount) > 45000) AS Q ON E.EMPLOYEEID=Q.EMPLOYEEID
  ORDER BY Q.SaleYear, Q.SaleQuarter, Q.TotalSales DESC

--Difficult Tasks
--This script uses recursion to calculate Fibonacci numbers
WITH FibSequence AS (
    -- Base cases
    SELECT 
        0 as n, 
        CAST(0 as BIGINT) as curr_fib, 
        CAST(1 as BIGINT) as next_fib
    
    UNION ALL
    
    -- Recursive case
    SELECT 
        n + 1,
        next_fib,
        curr_fib + next_fib
    FROM FibSequence
    WHERE n < 20
)
SELECT n as Position, curr_fib as FibonacciNumber
FROM FibSequence
ORDER BY n
OPTION (MAXRECURSION 100);
--Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)

  WITH CharCheck AS (
    -- Base case: check first position
    SELECT 
        Id, 
        Vals,
        1 as Position,
        LEFT(Vals, 1) as FirstChar,
        CASE 
            WHEN LEN(Vals) = 1 THEN 1
            WHEN SUBSTRING(Vals, 1, 1) = LEFT(Vals, 1) THEN 1 
            ELSE 0 
        END as AllSame
    FROM FindSameCharacters
    WHERE Vals IS NOT NULL AND LEN(Vals) > 0
    
    UNION ALL
    
    -- Recursive case: check subsequent positions
    SELECT 
        c.Id,
        c.Vals,
        c.Position + 1,
        c.FirstChar,
        CASE 
            WHEN c.AllSame = 0 THEN 0
            WHEN SUBSTRING(c.Vals, c.Position + 1, 1) = c.FirstChar THEN 1
            ELSE 0
        END
    FROM CharCheck c
    WHERE c.Position < LEN(c.Vals)
)
SELECT DISTINCT Id, Vals
FROM CharCheck
WHERE LEN(Vals) > 1 
  AND Position = LEN(Vals) 
  AND AllSame = 1
ORDER BY Id
--Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)
DECLARE @n2 INT = 5;

WITH Numbers AS (
    SELECT 1 as num
    UNION ALL
    SELECT num + 1
    FROM Numbers
    WHERE num < @n2
),
SequenceBuilder AS (
    SELECT 
        n1.num as N,
        n2.num as SeqNum
    FROM Numbers n1
    CROSS JOIN Numbers n2
    WHERE n2.num <= n1.num
)
SELECT 
    N,
    STRING_AGG(CAST(SeqNum as VARCHAR), '') WITHIN GROUP (ORDER BY SeqNum) as NumberSequence
FROM SequenceBuilder
GROUP BY N
ORDER BY N
OPTION (MAXRECURSION 100);
--Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)
SELECT 
  e.EmployeeID,
  e.FirstName,
  e.LastName,
  s.TotalSales
FROM Employees e
JOIN (
  SELECT 
    EmployeeID,
    SUM(SalesAmount) AS TotalSales
  FROM Sales
  WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
  GROUP BY EmployeeID
) AS s ON e.EmployeeID = s.EmployeeID
WHERE s.TotalSales = (
  SELECT MAX(TotalSales)
  FROM (
    SELECT 
      EmployeeID,
      SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY EmployeeID
  ) AS x
);

--Write a T-SQL query to remove the duplicate integer values present in the string column. Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)
SELECT * FROM RemoveDuplicateIntsFromNames
WITH Base AS (
    SELECT 
        PawanName,
        Pawan_slug_name,
        CHARINDEX('-', Pawan_slug_name) AS dash_pos
    FROM RemoveDuplicateIntsFromNames
),
SplitParts AS (
    SELECT
        PawanName,
        Pawan_slug_name,
        LEFT(Pawan_slug_name, CHARINDEX('-', Pawan_slug_name)) AS name_part,
        RIGHT(Pawan_slug_name, LEN(Pawan_slug_name) - CHARINDEX('-', Pawan_slug_name)) AS number_part
    FROM Base
),
Numbers AS (
    SELECT 
        sp.PawanName,
        sp.Pawan_slug_name,
        sp.name_part,
        sp.number_part,
        v.number AS position,
        SUBSTRING(sp.number_part, v.number, 1) AS digit
    FROM SplitParts sp
    CROSS APPLY (
        SELECT TOP (100) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS number
        FROM master.dbo.spt_values
    ) v
    WHERE v.number <= LEN(sp.number_part)
),
DigitCounts AS (
    SELECT 
        PawanName,
        Pawan_slug_name,
        name_part,
        digit,
        COUNT(*) OVER (PARTITION BY PawanName, digit) AS freq
    FROM Numbers
),
FilteredDigits AS (
    SELECT DISTINCT
        PawanName,
        Pawan_slug_name,
        name_part,
        digit
    FROM DigitCounts
    WHERE freq > 1
),
FinalAgg AS (
    SELECT 
        fd.PawanName,
        fd.Pawan_slug_name,
        fd.name_part,
        (
            SELECT STRING_AGG(fd2.digit, '') 
            FROM FilteredDigits fd2 
            WHERE fd2.PawanName = fd.PawanName
        ) AS cleaned_digits
    FROM FilteredDigits fd
    GROUP BY fd.PawanName, fd.Pawan_slug_name, fd.name_part
)
SELECT 
    r.PawanName,
    r.Pawan_slug_name,
    ISNULL(f.name_part + f.cleaned_digits, r.Pawan_slug_name) AS Cleaned_slug
FROM RemoveDuplicateIntsFromNames r
LEFT JOIN FinalAgg f ON r.PawanName = f.PawanName;


