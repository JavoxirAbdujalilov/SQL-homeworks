--Easy Tasks
--Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)
select 
	LEFT(NAme, CHARINDEX(',',Name)-1) as FirstName,
	Right(Name, LEN(Name)-CHARINDEX(',', NAME)) AS SURNAME
	FROM TESTMULTIPLECOLUMNS
--Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)
SELECT * FROM TESTPERCENT
WHERE STRS LIKE '%[%]%'
--In this puzzle you will have to split a string based on dot(.).(Splitter)
SELECT ID, PARSENAME(VALS,2) AS VALUES1,
PARSENAME(VALS,1) AS VALUE2
FROM SPLITTER

--Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS)
SELECT 
REPLACE(
REPLACE(
REPLACE(
REPLACE(
REPLACE(
REPLACE(
REPLACE(
REPLACE(
REPLACE(
REPLACE('1234ABC123456XYZ1234567890ADS','1','X'), '2', 'X'), '3','X'),'4','X'),'5','X'),'6','X'),'7','X'),'8','X'),'9','X'),'0','X')

--Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots)
SELECT ID, LEN(VALS)-LEN(REPLACE(VALS,'.','')) AS MORETWODOT  FROM TESTDOTS
WHERE LEN(VALS)-LEN(REPLACE(VALS,'.',''))>2
--Write a SQL query to count the spaces present in the string.(CountSpaces)
SELECT * FROM COUNTSPACES
SELECT LEN(TEXTS)-LEN(REPLACE(TEXTS,' ','')) FROM COUNTSPACES
--write a SQL query that finds out employees who earn more than their managers.(Employee)
SELECT  E1.NAME AS EMPLOYEENAME, E2.NAME AS MANAGER, E1.SALARY AS EMPSALARY, E2.SALARY AS  MANAGERSALARY FROM EMPLOYEE AS E1
JOIN EMPLOYEE AS E2 ON E1.ID=E2.MANAGERID
WHERE E1.SALARY>E2.SALARY

--Find the employees who have been with the company for more than 10 years, but less than 15 years. Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service (calculated as the number of years between the current date and the hire date).(Employees)
SELECT EMPLOYEE_ID,FIRST_NAME, LAST_NAME, HIRE_DATE, DATEDIFF(YEAR,HIRE_DATE,GETDATE()) AS 'YEARS OF SERVICE'
FROM EMPLOYEES
 WHERE 
    DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 11 AND 14
    AND DATEADD(YEAR, DATEDIFF(YEAR, HIRE_DATE, GETDATE()), HIRE_DATE) <= GETDATE();
--Medium Tasks
--Write a SQL query to separate the integer values and the character values into two different columns.(rtcfvty34redt)
SELECT 
  REPLACE(TRANSLATE('rtcfvty34redt', '0123456789', REPLICATE(' ', 10)), ' ', '') AS Letters,
  REPLACE(TRANSLATE('rtcfvty34redt', 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', REPLICATE(' ', 52)), ' ', '') AS Digits;
--write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather)
select w1.id, W1.TEMPERATURE, W2.TEMPERATURE from weather w1
join weather w2 on w1.RECORDDATE=DATEADD(DAY,1, W2.RECORDDATE)
WHERE W1.TEMPERATURE>W2.TEMPERATURE

--Write an SQL query that reports the first login date for each player.(Activity)
SELECT PLAYER_ID,
MIN(EVENT_DATE) AS FIRSTLOGIN
FROM ACTIVITY
GROUP BY PLAYER_ID
--Your task is to return the third item from that list.(fruits)
SELECT * FROM FRUITS
SELECT SUBSTRING(
fRUIT_LIST,
CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1)+1,
CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) + 1)
-CHARINDEX(',', FRUIT_LIST, CHARINDEX(',', FRUIT_LIST)+1)-1)  FROM FRUITS

--Write a SQL query to create a table where each character from the string will be converted into a row.(sdgfhsdgfhs@121313131)
WITH Numbers AS (
    SELECT TOP (LEN('sdgfhsdgfhs@121313131'))
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects
),
SplitChars AS (
    SELECT 
        n,
        SUBSTRING('sdgfhsdgfhs@121313131', n, 1) AS character
    FROM Numbers
)
SELECT character
FROM SplitChars;

--You are given two tables: p1 and p2. Join these tables on the id column. The catch is: when the value of p1.code is 0, replace it with the value of p2.code.(p1,p2)
SELECT P1.ID,
CASE 
WHEN P1.CODE=0 THEN P2.CODE
ELSE P1.CODE
END AS CODE
FROM P1 
JOIN P2 ON P1.ID=P2.ID
--Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:
--If the employee has worked for less than 1 year → 'New Hire'
--If the employee has worked for 1 to 5 years → 'Junior'
--If the employee has worked for 5 to 10 years → 'Mid-Level'
--If the employee has worked for 10 to 20 years → 'Senior'
--If the employee has worked for more than 20 years → 'Veteran'(Employees)
SELECT EMPLOYEE_ID, fIRST_NAME, DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS STAJ,
CASE 
WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) <1 THEN 'NEW HIRE'
WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE())  BETWEEN 1 AND 5 THEN 'JUNIOR'
WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE())<10 THEN 'MID-LEVEL'
WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE())<20 THEN 'SENIOR' ELSE 'VETERAN' END AS STATUS FROM EMPLOYEES
--Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.(GetIntegers)
SELECT 
ID, VALS,
LEFT(VALS, PATINDEX('%[^0-9]%', VALS+'j')-1) AS LEADINGINTEGER
FROM GETINTEGERS
WHERE PATINDEX('%[0-9]%',VALS)=1

--Difficult Tasks
--In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals)
SELECT 
  Id,
  Vals,
  STUFF(
    STUFF(Vals, 1, CHARINDEX(',', Vals), 
          SUBSTRING(Vals, CHARINDEX(',', Vals) + 1, 
                    CHARINDEX(',', Vals, CHARINDEX(',', Vals) + 1) - CHARINDEX(',', Vals) - 1) + ','),
    CHARINDEX(',', Vals) + 2,
    CHARINDEX(',', Vals, CHARINDEX(',', Vals) + 1) - CHARINDEX(',', Vals) - 1,
    LEFT(Vals, CHARINDEX(',', Vals) - 1)
  ) AS SwappedVals
FROM MultipleVals;

--Write a SQL query that reports the device that is first logged in for each player.(Activity)
SELECT 
  a.player_id,
  a.device_id
FROM Activity a
JOIN (
  SELECT player_id, MIN(event_date) AS first_login
  FROM Activity
  GROUP BY player_id
) firsts
  ON a.player_id = firsts.player_id AND a.event_date = firsts.first_login;

   --You are given a sales table. Calculate the week-on-week percentage of sales per area for each financial week. For each week, the total sales will be considered 100%, and the percentage sales for each day of the week should be calculated based on the area sales for that week.(WeekPercentagePuzzle)
   WITH WeeklyTotals AS (
  SELECT 
    Area,
    FinancialWeek,
    SUM(ISNULL(SalesLocal, 0) + ISNULL(SalesRemote, 0)) AS TotalWeeklySales
  FROM WeekPercentagePuzzle
  GROUP BY Area, FinancialWeek
)
SELECT 
  wpp.Area,
  wpp.[Date],
  wpp.FinancialWeek,
  wpp.DayName,
  wpp.MonthName,
  CAST(100.0 * (ISNULL(wpp.SalesLocal, 0) + ISNULL(wpp.SalesRemote, 0)) 
       / NULLIF(wt.TotalWeeklySales, 0) AS DECIMAL(5,2)) AS DailySalesPercentage
FROM WeekPercentagePuzzle wpp
JOIN WeeklyTotals wt 
  ON wpp.Area = wt.Area AND wpp.FinancialWeek = wt.FinancialWeek
ORDER BY wpp.Area, wpp.FinancialWeek, wpp.[Date];
