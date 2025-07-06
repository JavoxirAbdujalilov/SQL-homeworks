--1. You must provide a report of all distributors and their sales by region. If a distributor did not have any sales for a region, Provide a zero-dollar value for that day. Assume there is at least one sale for each region
WITH REGIONS AS(
SELECT DISTINCT REGION FROM #REGIONSALES
)
,  DISTRIBUTORS AS(
SELECT dISTINCT DISTRIBUTOR FROM #REGIONSALES
)
SELECT	 R.REGION,
		D.DISTRIBUTOR,
		ISNULL(SALES, 0) AS SALES 
		FROM REGIONS R
		CROSS JOIN DISTRIBUTORS D
		LEFT JOIN 
		#REGIONSALES S
		ON S.REGION=R.REGION AND S.DISTRIBUTOR=D.DISTRIBUTOR
		ORDER BY 
		 D.DISTRIBUTOR, R.REGION

--2. Find managers with at least five direct reports
seleCT * FROM 
EMPLOYEE

SELECT E.NAME FROM EMPLOYEE E 
	JOIN (
		SELECT MANAGERID FROM EMPLOYEE WHERE MANAGERID IS NOT NULL 
		GROUP BY MANAGERID 
		HAVING COUNT(*)>=5 ) M ON E.ID=M.MANAGERID

--3. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
WITH CTE AS(
	SELECT PRODUCT_ID,  MONTH(ORDER_DATE) AS MONTHS, SUM(UNIT) TOTALUNIT FROM ORDERS 
	GROUP BY MONTH(ORDER_DATE), PRODUCT_ID)
SELECT PRODUCT_NAME, 
		TOTALUNIT 
	FROM PRODUCTS P
	JOIN CTE ON P.PRODUCT_ID=CTE.PRODUCT_ID
	WHERE tOTALUNIT>=100 AND MONTHS=2

-- 4. Write an SQL statement that returns the vendor from which each customer has placed the most orders
SELECT * FROM ORDERS
WITH CTE AS (
SELECT CUSTOMERID, VENDOR, COUNT(*) AS OrderCount, ROW_NUMBER() OVER (PARTITION BY CUSTOMERID ORDER BY COUNT(*) DESC) AS RN FROM ORDERS
GROUP BY CUSTOMERiD, VENDOR
)
SELECT CUSTOMERID, VENDOR FROM CTE
WHERE RN=1


--5. You will be given a number as a variable called @Check_Prime check if this number is prime then return 'This number is prime' else eturn 'This number is not prime'
DECLARE @Check_Prime INT = 91;
WITH CTE AS (
SELECT 1 AS NUMBER
UNION ALL
SELECT NUMBER+1 FROM CTE
WHERE NUMBER+1<=@Check_Prime
), DIVISORS AS(
SELECT NUMBER AS DIVISOR FROM CTE
WHERE @Check_Prime % NUMBER=0)
SELECT CASE WHEN  COUNT(*)>2 THEN 'This number is not prime'
ELSE 'This number is prime' END AS CHECKPRIME FROM DIVISORS

--6. Write an SQL query to return the number of locations,in which location most signals sent, and total number of signal for each device from the given table.
;WITH LOCATIONCOUNT AS (
SELECT DEVICE_ID,
		LOCATIONS,
		COUNT(*) AS SIGNALCOUNT FROM DEVICE
		GROUP BY  DEVICE_ID, LOCATIONS )
, MAXLOCATIONS  AS (
SELECT DEVICE_ID, LOCATIONS AS MAX_SIGNAL_LOCATION,SIGNALCOUNT, 
ROW_NUMBER() OVER (PARTITION BY DEVICE_ID ORDER BY SIGNALCOUNT DESC) AS RN FROM LOCATIONCOUNT )
, DEVICESUMMARY AS (
SELECT DEVICE_ID, COUNT(DISTINCT LOCATIONS) AS NO_OF_LOCATION, 
COUNT(*) AS NO_OF_SIGNALS FROM DEVICE
GROUP BY DEVICE_ID
)
SELECT MX.DEVICE_ID, NO_OF_LOCATION, MAX_SIGNAL_LOCATION, NO_OF_SIGNALS FROM MAXLOCATIONS MX JOIN DEVICESUMMARY DS ON MX.DEVICE_ID=DS.DEVICE_ID
WHERE RN=1
ORDER BY DEVICE_ID


--7. Write a SQL to find all Employees who earn more than the average salary in their corresponding department. Return EmpID, EmpName,Salary in your output
SELECT EMPID, EMPNAME, SALARY FROM EMPLOYEE E JOIN (SELECT DEPTID, AVG(SALARY)AS AVGSALARY FROM EMPLOYEE
GROUP BY DEPTID) D ON E.DEPTID=D.DEPTID
WHERE SALARY>=AVGSALARY

--8. You are part of an office lottery pool where you keep a table of the winning lottery numbers along with a table of each ticket’s chosen numbers. If a ticket has some but not all the winning numbers, you win $10. If a ticket has all the winning numbers, you win $100. Calculate the total winnings for today’s drawing.
WITH WINNINGNUMBERS AS (
SELECT 25 AS NUMBER 
UNION ALL 
SELECT 45 
UNION ALL
SELECT 78 
),
TICKETMATCHES AS (
SELECT T.TICKETID, COUNT(W.NUMBER) AS MATCHCOUNT FROM TICKETS T LEFT JOIN WINNINGNUMBERS W ON T.NUMBER=W.NUMBER GROUP BY T.TICKETID
),
TICKETPRIZE AS (
SELECT TICKETID,
	CASE
	WHEN MATCHCOUNT=3 THEN 100
	WHEN MATCHCOUNT IN(1,2) THEN 10
	ELSE 0
	END AS PRIZE FROM TICKETMATCHES
)
SELECT SUM(PRIZE) AS TOTALWINNING FROM TICKETPRIZE 



--9. The Spending table keeps the logs of the spendings history of users that make purchases from an online shopping website which has a desktop and a mobile devices.
--Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only and both mobile and desktop together for each date.

SELECT * FROM SPENDING
 WITH UserPlatform AS (
  SELECT
    User_id,
    Spend_date,
    MAX(CASE WHEN Platform = 'Mobile' THEN 1 ELSE 0 END) AS Used_Mobile,
    MAX(CASE WHEN Platform = 'Desktop' THEN 1 ELSE 0 END) AS Used_Desktop,
    SUM(Amount) AS Total_Amount
  FROM Spending
  GROUP BY User_id, Spend_date
),
UserType AS (
  SELECT
    Spend_date,
    CASE
      WHEN Used_Mobile = 1 AND Used_Desktop = 1 THEN 'Both'
      WHEN Used_Mobile = 1 THEN 'Mobile'
      WHEN Used_Desktop = 1 THEN 'Desktop'
    END AS Platform_Type,
    Total_Amount,
    User_id
  FROM UserPlatform
),
Aggregated AS (
  SELECT
    Spend_date,
    Platform_Type AS Platform,
    SUM(Total_Amount) AS Total_Amount,
    COUNT(DISTINCT User_id) AS Total_Users
  FROM UserType
  GROUP BY Spend_date, Platform_Type
),
AllDates AS (
  SELECT DISTINCT Spend_date FROM Spending
),
Final AS (
  SELECT Spend_date, 'Mobile' AS Platform FROM AllDates
  UNION ALL
  SELECT Spend_date, 'Desktop' FROM AllDates
  UNION ALL
  SELECT Spend_date, 'Both' FROM AllDates
)
SELECT
  ROW_NUMBER() OVER (ORDER BY F.Spend_date, 
    CASE F.Platform WHEN 'Mobile' THEN 1 WHEN 'Desktop' THEN 2 ELSE 3 END) AS Row,
  F.Spend_date,
  F.Platform,
  COALESCE(A.Total_Amount, 0) AS Total_Amount,
  COALESCE(A.Total_Users, 0) AS Total_Users
FROM Final F
LEFT JOIN Aggregated A
  ON F.Spend_date = A.Spend_date AND F.Platform = A.Platform
ORDER BY F.Spend_date, F.Platform;

--10. Write an SQL Statement to de-group the following data.
SELECT * FROM GROUPED
WITH CTE AS (
SELECT PRODUCT, 1 AS QUANTITY FROM GROUPED G
WHERE QUANTITY>=1
UNION ALL 
SELECT G.PRODUCT, CTE.QUANTITY +1 
FROM GROUPED G JOIN CTE ON G.PRODUCT=CTE.PRODUCT
WHERE CTE.QUANTITY+1<=G.QUANTITY
)
SELECT PRODUCT, 1 AS VALUE FROM CTE
ORDER BY PRODUCT, QUANTITY
