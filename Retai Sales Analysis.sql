Create database if not exists Analysis;
Create schema if not exists Analysis;
Create table IF NOT exists retail_sales(
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(15),
age INT,
category VARCHAR(15),
quantity INT ,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);

select * from retail_sales
limit 10;

Select COUNT(*) 
from retail_sales;

select * from retail_sales
where transactions_id is null
or sale_date is null
or transactions_id is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantity is null
or price_per_unit is null
or cogs is null
or total_sale is null;

Delete from retail_sales
where transactions_id is null
or sale_date is null
or transactions_id is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantity is null
or price_per_unit is null
or cogs is null
or total_sale is null;

-- How many cusotmers with no null values
select count(*) as total_sale from 
retail_sales;

-- How many unique customers we have?
select count(distinct customer_id) as total_sales from retail_sales;

select distinct category as total_categories from retail_sales;

-- Data Analysis, Business key problems & Answers

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

Select * from retail_sales
where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions wher the category is clothing and the quantity sold is more than 4 in the month of Nov-2022.

Select * from retail_sales
where category = 'clothing' and quantity >= 4
and sale_date between '2022-11-01' and '2022-11-30';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each catrgory.

Select category, sum(total_sale) as net_sale from retail_sales
group by category;

-- Q.4 Write a SQL query to calculate the average age of customers who purchased items from the 'Beauty' category.

Select round(avg(age), 2) as Average_age from retail_sales
where category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions wheret total sales is more than 1000.

Select * from retail_sales
where total_sale >1000;

-- Q.6 Write a SQL query to find the total number of transactions(transaction_id) made by each gender in each category.

Select category, gender, count(*) as total_transactions from retail_sales
group by category, gender;

-- Q.7 Write a SQL query to calculate the average sale for each month each year. Find out best selling month in each year.

Select year(sale_date) as year, month(sale_date) as month, avg(total_sale) as Average_Sales from retail_sales
group by year, month
order by year, Average_Sales desc;


-- Q.8 Write a SQL query to calculate the top 5 customers based on the highest total sales.

Select customer_id, sum(total_sale) from retail_sales
group by customer_id, total_sale
order by total_sale desc
limit 5;

-- Q.9 Write a SQL query to find out the number of unique customers who purchased items from each category.

Select category, count(distinct(customer_id)) as Number_of_Customers from retail_sales
group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Aftrnoon between 12 and 17, Evening >17)

SELECT shift, COUNT(*) AS total_orders
FROM (
  SELECT *, 
    CASE
      WHEN HOUR(sale_time) < 12 THEN 'Morning'
      WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
      ELSE 'Evening'
    END AS shift
  FROM retail_sales
) AS hourly_sale
GROUP BY shift;





