--1. You need to write a query that outputs "100-Steven King", meaning emp_id + first_name + last_name in that format using employees table.
select CONCAT(employee_ID,'-',FIRST_NAME,' ', LAST_NAME) from employees
--2. Update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'
select REPLACE(Phone_Number, 124,999) from employees
--3. That displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the employees' first names.(Employees)
select FIrst_NAmE as Name, LEN(First_name) as LENGTH from employees
where First_NAME like '[A,J,M]%'
--4. Write an SQL query to find the total salary for each manager ID.(Employees table)
select E.MANAGER_ID, SUM(E.SAlary+(E.SAlary*E.commission_PCT)) as TotalSAlary from EMployees as E
group by E.Manager_id
--5. Write a query to retrieve the year and the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table
Select * from TestMAX
select Year1, GREATEST(MAX1,MAX2,MAX3) as HIghestValue from testMAX
--6. Find me odd numbered movies and description  is not boring.(cinema)
select * from cinema 
where Id %2<>0 and description not like 'boring'
--7. You have to sort data based on the Id but Id with 0 should always be the last row. Now the question is can you do that with a single order by column.(SingleOrder)
--option 1
select ID, Vals from SingleOrder
order by Id desc 
-- option 2
select MAX(ID) as ID, Vals from SingleOrder
group by vals
order by ID desc
--8. Write an SQL query to select the first non-null value from a set of columns. If the first column is null, move to the next, and so on. If all columns are null, return null.(person)
Select * from person
--option 1 
Select Coalesce(ssn,passportID,itin) as fistnotnullvalue
from person
-- option 2
select id, 
case 
when ssn is not null then ssn
when passportid is not null then passportid 
when itin is not null then itin
else null end
from person
--Medium Tasks
--1. Split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)
select 
StudentID,
SUBSTRING(fullNAme, 1, CHARINDEX(' ', fullName)-1)as FIrstName, 
SUBSTRING(FullNAme, CHARINDEX(' ', FullName)+1,CHARINDEX(' ',FullName,CHARINDEX(' ', FullNAme)+1)-CHARINDEX(' ', fullName)-1) as MiddleName,
substring(fullname,CHARINDEX(' ',FullName,CHARINDEX(' ', FullNAme)+1)+1, len(FullName)) as lastName
From students
--2. For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas. (Orders Table)

select * from orders
select * from Orders
where DeliveryState='TX' and customerID in(select distinct customerID from Orders
where deliveryState='CA')

--3. Write an SQL statement that can group concatenate the following values.(DMLTable)
SELECT STRING_AGG(String, ' ') AS FullSQL
FROM DMLTable
Group BY SequenceNumber;
--4. Find all employees whose names (concatenated first and last) contain the letter "a" at least 3 times.
select * from Employees
SELECT Employee_ID, 
       CONCAT_WS(' ', FIRST_NAME, LAST_NAME) AS FullName
FROM Employees
WHERE LEN(CONCAT_WS('', FIRST_NAME, LAST_NAME)) 
      - LEN(REPLACE(CONCAT_WS('', FIRST_NAME, LAST_NAME), 'a', '')) >= 3;


--5. The total number of employees in each department and the percentage of those employees who have been with the company for more than 3 years(Employees)
SELECT Department_ID, 
       COUNT(Employee_ID) AS TotalEmployees,
       SUM(CASE WHEN DATEDIFF(YEAR, Hire_Date, GETDATE()) > 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Percentage3year
FROM Employees
GROUP BY Department_ID;

--6. Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal)
select * from Personal
SELECT JobDescription, SpacemanID AS MostExperienced
FROM Personal
WHERE MissionCount = (
    SELECT MAX(MissionCount)
    FROM Personal P2
    WHERE P2.JobDescription = Personal.JobDescription
)
UNION
SELECT JobDescription, SpacemanID AS LeastExperienced
FROM Personal
WHERE MissionCount = (
    SELECT MIN(MissionCount)
    FROM Personal P2
    WHERE P2.JobDescription = Personal.JobDescription
);

--Difficult Tasks
--1. Write an SQL query that separates the uppercase letters, lowercase letters, numbers, and other characters from the given string 'tf56sd#%OqH' into separate columns.
WITH Numbers AS (
    SELECT TOP (LEN('tf56sd#%OqH'))
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects
),
Chars AS (
    SELECT 
        SUBSTRING('tf56sd#%OqH', n, 1) AS ch
    FROM Numbers
)
SELECT 
    STRING_AGG(CASE WHEN ch LIKE '[A-Z]' THEN ch END, '') AS UppercaseLetters,
    STRING_AGG(CASE WHEN ch LIKE '[a-z]' THEN ch END, '') AS LowercaseLetters,
    STRING_AGG(CASE WHEN ch LIKE '[0-9]' THEN ch END, '') AS Numbers,
    STRING_AGG(CASE WHEN ch NOT LIKE '[A-Za-z0-9]' THEN ch END, '') AS OtherCharacters
FROM Chars;
--2. Write an SQL query that replaces each row with the sum of its value and the previous rows' value. (Students table)
select * from Students
SELECT 
    StudentID,
    FullName,
    Grade,
    SUM(Grade) OVER (ORDER BY StudentID) AS CumulativeGrade
FROM Students;
--3. You are given the following table, which contains a VARCHAR column that contains mathematical equations. Sum the equations and provide the answers in the output.(Equations)
select *  from Equations
WITH Parsed AS (
    SELECT 
        Equation,
        value AS Token,
        ROW_NUMBER() OVER (PARTITION BY Equation ORDER BY (SELECT NULL)) AS rn
    FROM Equations
    CROSS APPLY STRING_SPLIT(REPLACE(REPLACE(Equation, '-', '+-'), ' ', ''), '+')
),
Evaluated AS (
    SELECT Equation, SUM(CAST(Token AS INT)) AS Total
    FROM Parsed
    GROUP BY Equation
)
SELECT Equation, Total AS TotalSum
FROM Evaluated;

--4. Given the following dataset, find the students that share the same birthday.(Student Table)
select * from Student
where Birthday in (
select Birthday from Student
group by Birthday
having COUNT(*)>1)
order by Birthday, StudentName
--5. You have a table with two players (Player A and Player B) and their scores. If a pair of players have multiple entries, aggregate their scores into a single row for each unique pair of players. Write an SQL query to calculate the total score for each unique player pair(PlayerScores)
select * from PlayerScores
SELECT 
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS Player2,
    SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY 
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END;

