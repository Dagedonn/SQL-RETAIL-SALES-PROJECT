---SQL PROJECT RETAIL SALES ANALYSIS

CREATE DATABASE SQL_RETAIL_SALESP1;

USE SQL_RETAIL_SALESP1;
GO


CREATE TABLE RETAIL_SALES
(
Transaction_id INT NOT NULL primary key,
Sale_date DATE,
Sale_time TIME,
Customer_id INT ,
Gender VARCHAR(20),
Age INT,
Category VARCHAR(20),
Quantity INT,
Price_per_unit FLOAT,
cogs  FLOAT,
total_sale FLOAT
);





--data cleaning
SELECT COUNT(*) FROM RETAIL_SALES;
SELECT COUNT(DISTINCT Customer_id) FROM RETAIL_SALES;
SELECT DISTINCT Category FROM RETAIL_SALES;

SELECT * FROM RETAIL_SALES
WHERE 
    Sale_date IS NULL OR Sale_time IS NULL OR Customer_id IS NULL OR 
    Gender IS NULL OR Age IS NULL OR Category IS NULL OR 
    Quantity IS NULL OR Price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM RETAIL_SALES
WHERE 
    Sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;


--data exploration

--total sales
select count(*)
from RETAIL_SALES

--total customers
select count(Customer_id)
from RETAIL_SALES

--total of unique customers
select count(distinct Customer_id) distinct_customers
from RETAIL_SALES

select * from RETAIL_SALES

--different category types
select distinct Category from RETAIL_SALES

-- Data analysis and Business Key problems & answers
-- Q.1 Write a sql query to retrieve all columns for sales made on '2022-11-05
SELECT * RETAIL_SALES
WHERE Sale_date = '2022-11-05';

-- Q.2 write a sql query to retrieve all
-- transactions where the category is 'clothing 
-- and the quantity sold is more than 3 in the month of Nov-2022
SELECT 
  *
FROM RETAIL_SALES
WHERE Category = 'Clothing'
  AND Sale_date >= '2022-11-01'
  AND Sale_date < '2022-12-01'
  AND Quantity > 3


--q3. write a sql query to calculate the total 
--sales for each category
SELECT 
    Category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM RETAIL_SALES
GROUP BY Category

--q4. find the average age of customers 
--who purchased items from the 'beauty' category
SELECT
    AVG(age) as avg_age
FROM RETAIL_SALES
WHERE Category = 'Beauty'

--q5. find all transactions where the 
--total_sale is greater than 100
SELECT * FROM RETAIL_SALES
WHERE total_sale > 1000

--q6 find the total number of transactions (transction_id)
--made by each gender in each category
SELECT
    Gender,
    Category,
COUNT(Transaction_id) transact_count
FROM RETAIL_SALES
GROUP BY
    Gender,
    Category

--q7 calculate the average sale for each month.
-- find out best selling month in each year

SELECT
    sale_year,
    sale_month,
    Avg_monthly_sale
FROM 
(
SELECT 
    AVG(total_sale) Avg_monthly_sale,
    YEAR(Sale_date) sale_year,
    MONTH(Sale_date) sale_month,
    RANK() over(partition by Year(Sale_date) order by AVG(total_sale) desc) rankS
from RETAIL_SALES
GROUP BY  year(sale_date),
MONTH(Sale_date)
) AS T1
WHERE rankS = 1

--order by sale_year, sale_month desc


--Q8 write a sql query to find the 
--top 5 customers based on the highest total sale
SELECT TOP 5 Customer_id,
    SUM(total_sale) Total_sale
FROM RETAIL_SALES
GROUP BY  Customer_id
ORDER BY Total_sale DESC


--Q9 write a sql query to 
--find the number of unique customers
-- who purchased items from each category
SELECT 
    Category,    
    COUNT(DISTINCT Customer_id) as cnt_unique_Cus
FROM RETAIL_SALES
GROUP BY Category

--q10 write a sql query to create each shift and number of orders 
--(example morning <=12 ,afternoon between 12 and 17,Evening >17)
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN DATEPART(HOUR FROM Sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR FROM Sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM RETAIL_SALES
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

--end of project

