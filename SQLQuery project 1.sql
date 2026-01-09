---SQL PROJECT RETAIL SALES ANALYSIS

CREATE DATABASE SQL_RETAIL_SALESP1

USE SQL_RETAIL_SALESP1;
GO

CREATE TABLE RETAIL_SALES(
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
total_sale FLOAT)

insert into  RETAIL_SALES(
Transaction_id,
Sale_date,
Sale_time,
Customer_id,
Gender,
Age ,
Category,
Quantity,
Price_per_unit,
cogs,
total_sale)


select  TOP 10 * from  RETAIL_SALES

SELECT * FROM  RETAIL_SALES
where Transaction_id = '679'


SELECT COUNT(*) FROM RETAIL_SALES

--data cleaning
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(Transaction_id) AS null_transaction_id,
    COUNT(*) - COUNT(Sale_time) AS null_sale_time,
    COUNT(*) - COUNT(Gender) AS null_gender,
    COUNT(*) - COUNT(Category) AS null_category,
    COUNT(*) - COUNT(Sale_date) AS null_transaction_id,
    COUNT(*) - COUNT(Customer_id) AS null_sale_time,
    COUNT(*) - COUNT(Age) AS null_gender,
    COUNT(*) - COUNT(Quantity) AS null_category,
    COUNT(*) - COUNT(Price_per_unit) AS null_sale_time,
    COUNT(*) - COUNT(cogs) AS null_gender,
    COUNT(*) - COUNT(total_sale) AS null_category
FROM RETAIL_SALES;


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
SELECT * FROM RETAIL_SALES
WHERE Sale_date = '2022-11-05'

-- Q.2 write a sql query to retrieve all
-- transactions where the category is 'clothing 
-- and the quantity sold is more than 3 in the month of Nov-2022
SELECT * FROM RETAIL_SALES
WHERE Category = 'Clothing'
and Quantity > 3 and Sale_date >= '2022-11-01'
and Sale_date < '2022-12-01'

--q3. write a sql query to calculate the total 
--sales for each category
SELECT Category,
SUM(total_sale) Total_Sale_category
from RETAIL_SALES
group by Category

--q4. find the average age of customers 
--who purchased items from the 'beauty' category
SELECT
AVG(Age) avg_age_beauty
FROM RETAIL_SALES
WHERE Category ='Beauty'

--q5. find all transactions where the 
--total_sale is greater than 100
SELECT * FROM RETAIL_SALES
WHERE total_sale > 1000

--q6 find the total number of transactions (transction_id)
--made by each gender in each category
SELECT Gender,
Category,
COUNT(Transaction_id) transact_count
from RETAIL_SALES
group by Gender, Category

--q7 calculate the average sale for each month.
-- find out best selling month in each year

SELECT sale_year,
sale_month,
Avg_monthly_sale
FROM 
(
SELECT 
AVG(total_sale) Avg_monthly_sale,
Year(Sale_date) sale_year,
month(Sale_date) sale_month,
rank() over(partition by Year(Sale_date) order by AVG(total_sale) desc) rankS
from RETAIL_SALES
group by year(sale_date),
month(Sale_date)
) AS T1
WHERE rankS = 1
--order by sale_year, sale_month desc


--Q8 write a sql query to find the 
--top 5 customers based on the highest total sale
SELECT TOP 5 Customer_id,
sum(total_sale) Total_sale
FROM RETAIL_SALES
group by  Customer_id
order by Total_sale desc


--Q9 write a sql query to 
--find the number of unique customers
-- who purchased items from each category
select   
Category,
count(Distinct Customer_id) as unique_cust
from RETAIL_SALES
group by Category

--q10 write a sql query to create each shift and number of orders 
--(example morning <=12 ,afternoon between 12 and 17,Evening >17)

WITH shifts AS (
    SELECT
        CASE
            WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM RETAIL_SALES
)
SELECT
    shift,
    COUNT(*) AS number_of_orders
FROM shifts
GROUP BY shift
ORDER BY shift;

--end of project
