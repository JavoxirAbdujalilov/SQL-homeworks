SELECT * FROM SALES
SELECT * FROM PRODUCTS
-- Create a temporary table named MonthlySales to store the total quantity sold and total revenue for each product in the current month.
--Return: ProductID, TotalQuantity, TotalRevenue
SELECT P.PRODUCTID,  S.TOTALQUANTITY, P.PRICE*S.TOTALQUANTITY AS TOTALREVENUE INTO #MONTHLYSALES  FROM PRODUCTS P
		JOIN (SELECT PRODUCTID, 
					SUM(QUANTITY) AS TOTALQUANTITY	
				FROM SALES 
				WHERE MONTH(SALEDATE)=MONTH(GETDATE())
						AND YEAR(SALEDATE)=YEAR(GETDATE())
				GROUP BY PRODUCTID) S
		ON P.PRODUCTID=S.PRODUCTID

--Create a view named vw_ProductSalesSummary that returns product info along with total sales quantity across all time.	
--Return: ProductID, ProductName, Category, TotalQuantitySold
CREATE VIEW VW_ProductSalesSummary AS 
	SELECT  P.PRODUCTID,
			PRODUCTNAME, 
			CATEGORY,  
			TOTALQUANTITY 
		FROM PRODUCTS P
		JOIN (SELECT PRODUCTID, 
					SUM(QUANTITY) AS TOTALQUANTITY	
				FROM SALES 
				GROUP BY PRODUCTID) S
		ON P.PRODUCTID=S.PRODUCTID

--Create a function named fn_GetTotalRevenueForProduct(@ProductID INT)
--Return: total revenue for the given product ID
CREATE FUNCTION fn_GetTotalRevenueForProduct(@ProductID INT)
RETURNS DECIMAL(10,2)
		
AS
BEGIN
		DECLARE @TOTALREVENUE DECIMAL(10,2)

		SELECT @TOTALREVENUE=PRICE*SUM(QUANTITY) 
		  FROM Products P
    JOIN Sales S ON P.ProductID = S.ProductID
	WHERE P.PRODUCTID=@PRODUCTID
	  GROUP BY P.PRODUCTID, P.PRICE
    RETURN @TOTALREVENUE
END;
SELECT dbo.fn_GetTotalRevenueForProduct(2) AS Revenue;


--Create an function fn_GetSalesByCategory(@Category VARCHAR(50))
--Return: ProductName, TotalQuantity, TotalRevenue for all products in that category.

CREATE FUNCTION fn_GetSalesByCategory(@Category VARCHAR(50))

RETURNS TABLE 
	AS
RETURN(SELECT P.PRODUCTNAME,  S.TOTALQUANTITY, P.PRICE*S.TOTALQUANTITY AS TOTALREVENUE   FROM PRODUCTS P
		JOIN (SELECT PRODUCTID, 
					SUM(QUANTITY) AS TOTALQUANTITY	
				FROM SALES 
				GROUP BY PRODUCTID) S
		ON P.PRODUCTID=S.PRODUCTID
		WHERE P.CATEGORY=@Category
)



--You have to create a function that get one argument as input from user and the function should return 'Yes' if the input number is a prime number and 'No' otherwise. You can start it like this:

CREATE FUNCTION dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(50)
AS 
BEGIN 
    DECLARE @Result VARCHAR(50);

    IF @Number < 2 
    BEGIN
        SET @Result = 'NO';
        RETURN @Result;
    END;

    WITH CTE AS (
        SELECT 1 AS NUM
        UNION ALL
        SELECT NUM + 1 
        FROM CTE 
        WHERE NUM + 1 <= @Number
    )
    SELECT @Result = 
        CASE 
            WHEN COUNT(*) = 2 THEN 'YES'
            ELSE 'NO'
        END
    FROM CTE
    WHERE @Number % NUM = 0;

    RETURN @Result;
END;

-- Create a table-valued function named fn_GetNumbersBetween that accepts two integers as input:
--@Start INT
--@End INT
CREATE FUNCTION fn_GETNUMBERSBETWEEN (@START INT, @END INT)
	RETURNS @NUMBERS TABLE(NUMBER INT)
AS
BEGIN 
	IF @START>@END
	RETURN;

; WITH CTE AS (
 SELECT @START AS  NUMBER 
	UNION ALL 
 SELECT NUMBER+1 
	FROM CTE 
	WHERE NUMBER+1<=@END
)
	INSERT INTO @NUMBERS
	SELECT NUMBER FROM CTE
RETURN;
END 

--7. Write a SQL query to return the Nth highest distinct salary from the Employee table. If there are fewer than N distinct salaries, return NULL.

CREATE FUNCTION FN_getNthHighestSalary( @N INT )
RETURNS  TABLE 
AS 
RETURN (
SELECT TOP 1  SALARY AS HIGHESTNSALARY
	FROM (
	SELECT DISTINCT SALARY,
		DENSE_RANK() OVER (ORDER BY SALARY DESC) AS RNK FROM EMPLOYEE
	) AS RANKED 
	WHERE RNK=@N
)
--8. Write a SQL query to find the person who has the most friends.
--Return: Their id, The total number of friends they have

--Friendship is mutual. For example, if user A sends a request to user B and it's accepted, both A and B are considered friends with each other. The test case is guaranteed to have only one user with the most friends.


SELECT TOP 1 ID, COUNT(*) AS NUM 
FROM (
SELECT REQUESTER_ID AS ID FROM FRIENDS
	UNION ALL 
SELECT ACCEPTER_ID AS ID FROM FRIENDS 
) ALLFRIENDS 
GROUP BY ID 
ORDER BY NUM DESC

--9. Create a View for Customer Order Summary.
--Create a view called vw_CustomerOrderSummary that returns a summary of customer orders. The view must contain the following columns:
--Column Name | Description
--customer_id | Unique identifier of the customer
--name | Full name of the customer
--total_orders | Total number of orders placed by the customer
--total_amount | Cumulative amount spent across all orders
--last_order_date | Date of the most recent order placed by the customer

CREATE VIEW VW_CustomerOrderSummary
AS 
 SELECT 
		C.CUSTOMER_ID,
		C.NAME, 
		O.TOTAL_ORDERS, 
		O.TOTAL_AMOUNT, 
		O.LAST_VALUE_ORDER_DATE 
	FROM CUSTOMERS C 
	LEFT JOIN (
		SELECT CUSTOMER_ID, 
				COUNT(ORDER_ID) AS TOTAL_ORDERS,
				SUM(AMOUNT) AS TOTAL_AMOUNT,
				MAX(ORDER_DATE) AS LAST_VALUE_ORDER_DATE 
			FROM ORDERS
			 GROUP BY CUSTOMER_ID
 ) O ON C.CUSTOMER_ID=O.CUSTOMER_ID


  --Write an SQL statement to fill in the missing gaps. You have to write only select statement, no need to modify the table.

  SELECT 
	LAST_VALUE(TESTCASE) IGNORE NULLS OVER (ORDER BY ROWNUMBER) 
	FROM GAPS
