CREATE DATABASE PCP;--CREATING AND THEN UPLOADING THE DATASET INTO THE DATABASE.
use PCP;

--SHOWING ALL THE DATABASES:-
SELECT * FROM fact;
SELECT * FROM Location;
SELECT * FROM Product;

--1. Display the number of states present in the LocationTable.
SELECT STATE
FROM Location;

--2. How many products are of regular type?
SELECT COUNT(DISTINCT Product_Type) AS COUNT_REGULAR
FROM PRODUCT
WHERE Type='REGULAR';

--3. How much spending has been done on marketing of product ID 1?
SELECT SUM(MARKETING) AS TOTAL_MARKETING_PID1
FROM fact
WHERE ProductId=1;

--4. What is the minimum sales of a product?
SELECT MIN(SALES) AS MIN_SALES
FROM 
fact;

--5. Display the max Cost of Good Sold (COGS)?
SELECT MAX(COGS) AS MAX_COGS
FROM fact;

--6. Display the details of the product where product type is coffee. 
SELECT * FROM PRODUCT 
WHERE Product_Type='COFFEE';

--7. Display the details where total expenses are greater than 40. 
SELECT * FROM fact
WHERE Total_Expenses>40;

--8. What is the average sales in area code 719?
SELECT AVG(SALES) AS AVG_SALES_AC791
FROM fact 
WHERE AREA_CODE=719;

--9. Find out the total profit generated by Colorado state.
SELECT SUM(PROFIT) AS TOTAL_PROFIT_COLORADO
FROM fact
WHERE AREA_CODE=303;

--10. Display the average inventory for each product ID.
SELECT PRODUCTID,AVG(INVENTORY) AS AVG_INVENTORY
FROM fact
GROUP BY ProductId
ORDER BY ProductId ;

--11. Display state in a sequential order in a Location Table.
SELECT * FROM Location
ORDER BY State;

--12. Display the average budget of the Product where the average budget
--margin should be greater than 100. 
SELECT PRODUCTID,AVG(BUDGET_MARGIN) AS AVG_BUDGETMARGIN
FROM fact
WHERE Budget_Margin>100
GROUP BY ProductId
ORDER BY ProductId;

--13. What is the total sales done on date 2010-01-01?
SELECT SUM(SALES) AS TOTAL_SALES
FROM fact
WHERE Date='2010-01-01';

--14. Display the average total expense of each product ID on an individual date.
SELECT DATE,AVG(TOTAL_EXPENSES) AS AVG_EXPENSES
FROM fact
GROUP BY DATE
ORDER BY DATE;

-- 15. Display the table with the following attributes such as date, productID, product_type, product, sales, profit, state, area_code.
SELECT DATE,F.PRODUCTID,PRODUCT_TYPE,PRODUCT,SALES,PROFIT,STATE,F.AREA_CODE
FROM fact AS F
INNER JOIN
LOCATION AS L
ON F.AREA_CODE=L.Area_Code
INNER JOIN
Product AS P
ON F.ProductId=P.ProductId;

--16. Display the rank without any gap to show the sales wise rank. 
SELECT *,
DENSE_RANK() OVER (ORDER BY SALES ASC) AS D_R
FROM fact;

--17. Find the state wise profit and sales.
SELECT STATE,PROFIT,SALES
FROM fact
INNER JOIN
Location
ON 
FACT.AREA_CODE=Location.Area_Code;

--18. Find the state wise profit and sales along with the productname. 
SELECT STATE,PROFIT,SALES,PRODUCT_TYPE
FROM fact
INNER JOIN
Location
ON 
FACT.AREA_CODE=Location.Area_Code
INNER JOIN
Product
ON fact.ProductId=PRODUCT.ProductId;

--19.If there is an increase in sales of 5%, calculate the increasedsales.
SELECT SALES,(SALES*1.07) AS INC_SALES
FROM FACT ;

--21. Create a stored procedure to fetch the result according to the product typefrom Product Table. 
CREATE OR ALTER PROCEDURE RESULT
(@INP VARCHAR(50))
AS
BEGIN
SELECT * FROM Product
WHERE Product_Type=@INP
END
EXECUTE RESULT 'COFFEE';

-- 22. Write a query by creating a condition in which if the total expenses is lessthan60 then it is a profit or else loss. 
SELECT PRODUCTID,TOTAL_EXPENSES,
CASE
WHEN TOTAL_EXPENSES>=60 THEN 'PROFIT'
WHEN TOTAL_EXPENSES<60 THEN 'LOSS'
ELSE 'NOTHING'
END AS ORDINAL_COL
FROM fact
ORDER BY ProductId;

--23. Change the product type from coffee to tea where product IDis 1 and undo it. 
BEGIN TRANSACTION
UPDATE Product
SET Product_Type='TEA'
WHERE ProductId=1;

ROLLBACK;

--24. Display the date, product ID and sales where total expenses are
--between 100 to 200.
SELECT DATE,PRODUCTID,SALES
FROM fact
WHERE Total_Expenses BETWEEN 100 AND 200;

--25. Delete the records in the Product Table for regular type.
BEGIN TRANSACTION
DELETE FROM Product
WHERE TYPE='REGULAR';

ROLLBACK;