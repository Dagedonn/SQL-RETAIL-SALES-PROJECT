# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `SQL_RETAIL_SALESP1` 

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `SQL_RETAIL_SALESP1`.
- **Table Creation**: A table named `RETAIL_SALES` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE SQL_RETAIL_SALESP1;

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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT * RETAIL_SALES
WHERE Sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022**:
```sql
SELECT 
  *
FROM RETAIL_SALES
WHERE Category = 'Clothing'
  AND Sale_date >= '2022-11-01'
  AND Sale_date < '2022-12-01'
  AND Quantity > 3

```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
    Category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM RETAIL_SALES
GROUP BY Category
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT
    AVG(age) as avg_age
FROM RETAIL_SALES
WHERE Category = 'Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM RETAIL_SALES
WHERE total_sale > 1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT
    Gender,
    Category,
COUNT(Transaction_id) transact_count
FROM RETAIL_SALES
GROUP BY
    Gender,
    Category
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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

```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT TOP 5 Customer_id,
    SUM(total_sale) Total_sale
FROM RETAIL_SALES
GROUP BY  Customer_id
ORDER BY Total_sale DESC
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
    Category,    
    COUNT(DISTINCT Customer_id) as cnt_unique_Cus
FROM RETAIL_SALES
GROUP BY Category
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Dage the analyst

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!


Thank you for your support, and I look forward to connecting with you!


