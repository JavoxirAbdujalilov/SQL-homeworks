--1. Using Products table, find the total number of products available in each category.
select category, SUM(stockquantity) as [total number of products] from products
group by Category
--2. Using Products table, get the average price of products in the 'Electronics' category.
SELECT CATEGORY, AVG(PRICE) AS AVERAGEPRICE FROM PRODUCTS
WHERE CATEGORY='ELECTRONICS'
GROUP BY CATEGORY
--3. Using Customers table, list all customers from cities that start with 'L'.
SELECT * FROM cUSTOMERS
WHERE CITY LIKE 'L%'
--4. Using Products table, get all product names that end with 'er'.
SELECT * FROM PRODUCTS
WHERE PRODUCTNAME LIKE '%ER'
--5. Using Customers table, list all customers from countries ending in 'A'.
SELECT * FROM CUSTOMERS
WHERE COUNTRY LIKE '%A'
--6. Using Products table, show the highest price among all products.
Select MAX(price) from products
--7. Using Products table, label stock as 'Low Stock' if quantity < 30, else 'Sufficient'.
select *, case 
when Stockquantity<30 then 'Low Stock' else 'Sufficient' end from products
--8. Using Customers table, find the total number of customers in each country.
select country, COUNT(customerId) from customers
group by country
--9. Using Orders table, find the minimum and maximum quantity ordered.
select MIN(QUANTITY) AS MINQUANTITY, MAX(QUANTITY)AS MAXQUANTITY FROM ORDERS
--10. Using Orders and Invoices tables, list customer IDs who placed orders in 2023 January to find those who did not have invoices.
SELECT CustomerID 
FROM Orders
WHERE YEAR(OrderDate) = 2023 AND MONTH(OrderDate) = 1
AND CustomerID NOT IN (SELECT CustomerID FROM Invoices);
--11. Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted including duplicates.
SELECT PRODUCTNAME FROM PRODUCTS
UNION ALL
SELECT PRODUCTNAME FROM PRODUCTS_DISCOUNTED
--12. Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted without duplicates.
SELECT PRODUCTNAME FROM PRODUCTS
UNION 
SELECT PRODUCTNAME FROM PRODUCTS_DISCOUNTED
--13. Using Orders table, find the average order amount by year.
SELECT YEAR(ORDERDATE),AVG(TOTALAMOUNT) FROM ORDERS
GROUP BY YEAR(ORDERDATE)
--14. Using Products table, group products based on price: 'Low' (<100), 'Mid' (100-500), 'High' (>500). Return productname and pricegroup.
SELECT PRODUCTNAME, CASE
WHEN PRICE>500 THEN 'HIGH' 
WHEN PRICE BETWEEN 100 AND 500 THEN 'MID' ELSE 'LOW' END AS PRICEGROUP
FROM PRODUCTS
--15. Using City_Population table, use Pivot to show values of Year column in seperate columns ([2012], [2013]) and copy results to a new Population_Each_Year table.
SELECT*FROM CITY_POPULATION
SELECT * FROM ( SELECT DISTRICT_ID, DISTRICT_NAME, POPULATION, YEAR FROM CITY_POPULATION) AS SOURCE_TABLE
PIVOT(
SUM(POPULATION)
FOR YEAR IN ([2012],[2013]))AS Population_Each_Year
--16. Using Sales table, find total sales per product Id.
SELECT  PRODUCTID, SUM(SALEAMOUNT) AS TOTALSALES FROM SALES
GROUP BY PRODUCTID
--17. Using Products table, use wildcard to find products that contain 'oo' in the name. Return productname.
SELECT PRODUCTNAME FROM PRODUCTS
WHERE PRODUCTNAME LIKE '%OO%'
--18. Using City_Population table, use Pivot to show values of City column in seperate columns (Bektemir, Chilonzor, Yakkasaroy) and copy results to a new Population_Each_City table.
SELECT * FROM (
SELECT DISTRICT_ID, DISTRICT_NAME, POPULATION, YEAR FROM CITY_POPULATION
) AS PREVIOUS_TABLE
PIVOT(
SUM(POPULATION)
FOR DISTRICT_NAME IN ([BEKTEMIR],[CHILONZOR],[YAKKASAROY])) AS POPULATION_EACH_CITY
--19. Using Invoices table, show top 3 customers with the highest total invoice amount. Return CustomerID and Totalspent.
SELECT TOP 3  TotalAmount AS TOTALSPENT, CUSTOMERID  FROM INVOICES
ORDER BY TOTALSPENT DESC
--20. Transform Population_Each_Year table to its original format (City_Population).

select district_name, 2012,2013 from population_each_year
 as Newtable
unpivot
( population for year in ([2012],[2013],[2014],[2015])) As unpivotdata

--21. Using Products and Sales tables, list product names and the number of times each has been sold. (Research for Joins)
SELECT P.ProductName, COUNT(S.SaleID) AS TimesSold
FROM Products P
JOIN Sales S ON P.ProductID = S.ProductID
GROUP BY P.ProductName;
--22. Transform Population_Each_City table to its original format (City_Population).
SELECT Year, City, Population
FROM Population_Each_City
UNPIVOT (Population FOR City IN ([Bektemir], [Chilonzor], [Yakkasaroy])) AS UnpivotedData;



