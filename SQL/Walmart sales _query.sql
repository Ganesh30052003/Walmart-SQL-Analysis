create database walmart;
use walmart;


select * from walmart;
select product_line from walmart;


-- ================================== Generic Questions =============================================

-- How many distinct cities are present in the dataset?
select count(distinct city ) from walmart;

-- In which city is each branch situated?
select distinct branch , city from walmart;


-- ==================================== Product Analysis =============================================
-- How many distinct product lines are there in the dataset?
select count(distinct product_line) from walmart;

-- What is the most common payment method?
select payment, count(payment) as most_common_payment
from walmart 
group by payment 
order by most_common_payment desc limit 1;

-- What is the most selling product line?
select product_line, count(product_line)as most_selling_product from walmart group by product_line order by most_selling_product desc limit 1;

-- What is the total revenue by month?
select month(date)as month,sum(gross_income) as total_revenue from walmart group by month;

-- Which month recorded the highest Cost of Goods Sold (COGS)?
select month(date)as month , max(cogs) from walmart group by month;

-- Which product line generated the highest revenue?
select product_line , sum(gross_income)as highest_revenue from walmart group by product_line order by highest_revenue desc limit 1;

-- Which city has the highest revenue?
select city , sum(gross_income) as highest_revenue from walmart group by city order by highest_revenue desc limit 1;

-- Which product line incurred the highest VAT?

select product_line , max(VAT) as highest_VAT from walmart group by product_line order by highest_VAT desc limit 1;

-- Retrieve each product line and add a column product_category, indicating 'Good' or 'Bad,' based on whether its 
-- sales are above the average.
WITH sales_by_product AS (
    SELECT product_line, SUM(cogs) AS total_sales
    FROM walmart
    GROUP BY product_line
),
average_sales AS (
    SELECT AVG(total_sales) AS avg_sales FROM sales_by_product
)
SELECT 
    s.product_line,
    s.total_sales,
    CASE 
        WHEN s.total_sales > a.avg_sales THEN 'Good'
        ELSE 'Bad'
    END AS product_category
FROM sales_by_product s, average_sales a;


-- Which branch sold more products than average product sold?

select branch , sum(quantity)as total_sold
from walmart
group by branch
having sum(quantity)>(select avg(total_sold) 
from (select branch, sum(quantity)as total_sold 
	from walmart 
    group by branch)as sub);

-- What is the most common product line by gender?
select gender,product_line ,count(*) as cnt from walmart group by product_line, gender;

-- What is the average rating of each product line?
select Product_line,avg(rating) as avg_rating from walmart group by product_line;

-- ======================== Sales Analysis ======================================================

ALTER TABLE walmart
CHANGE COLUMN `Invoice ID` invoice_id text;

ALTER TABLE walmart
CHANGE COLUMN `Customer type` customer_type TEXT;


-- Number of sales made in each time of the day per weekday

select dayname(date) as day_name , time, count(invoice_id)as total_sales
from walmart
group by day_name , time
having day_name not in ('saturday', 'sunday')
order by day_name, time
;

-- Identify the customer type that generates the highest revenue.
select customer_type , sum(total)as highest_revenue 
from walmart 
group by customer_type order by highest_revenue desc limit 1;

-- Which city has the largest tax percent/ VAT (Value Added Tax)?
select city ,sum(VAT)as total_vat from walmart group by city order by  total_vat desc limit 1;

-- Which customer type pays the most VAT?
select customer_type , sum(vat) AS total_vat from walmart group by customer_type order by total_vat desc limit 1;

-- ============================= Customer Analysis =============================================

-- How many unique customer types does the data have?
select count(distinct customer_type ) from walmart ;

-- How many unique payment methods does the data have?
select count(distinct payment) from walmart ;

-- Which is the most common customer type?
select customer_type , count(customer_type) as total_occ from walmart group by customer_type order by total_occ desc limit 1;

-- Which customer type buys the most?
select customer_type , sum(quantity)as no_of_buys from walmart group by customer_type order by no_of_buys desc limit 1;

-- What is the gender of most of the customers?
select gender , count(*) as no_of_customers from walmart group by gender order by no_of_customers desc limit 1;

-- What is the gender distribution per branch?
select branch, gender , count(gender) as gender_distribution from walmart group by branch , gender order by branch, gender;

-- Which time of the day do customers give most ratings?
select time , count(rating) as rating  from walmart group by time order by rating desc limit 1;

-- Which time of the day do customers give most ratings per branch?
select time , branch , count(rating)as rating from walmart group by time , branch order by rating, branch desc limit 1;

-- Which day of the week has the best avg ratings?
select dayname(date)as day , avg(rating) as avg_rating from walmart group by day order by avg_rating limit 1;


-- Which day of the week has the best average ratings per branch?
select branch, day, avg_rating
from (
    select branch, DAYNAME(date) as day, AVG(rating) as avg_rating,
           rank() over (partition by branch order by avg(rating) desc) AS rnk
    from walmart
    group by branch, day
) as ranked
where rnk = 1;
