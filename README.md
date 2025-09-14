# Walmart Sales Data Analysis (SQL Project)

## Project Overview
This is a self-driven SQL project analyzing Walmart sales transactions across branches in Mandalay, Yangon, and Naypyitaw.  
The goal is to uncover actionable insights on product performance, sales trends, and customer behavior.

## Dataset
The dataset contains real Walmart sales transactions and includes columns like:
- `invoice_id`, `branch`, `city`, `customer_type`, `gender`
- `product_line`, `unit_price`, `quantity`, `VAT`, `total`
- `date`, `time`, `payment`, `cogs`, `gross_margin_pct`, `gross_income`, `rating`

*Note: Dataset is not included due to size/privacy; it can be downloaded from Kaggle’s Walmart Sales dataset.*

## Features & Analysis
### Product Analysis
- Identified top-selling product lines
- Categorized product lines as Good/Bad based on sales
- Calculated revenue, COGS, VAT, and average ratings

### Sales Analysis
- Analyzed sales trends by time of day, day of the week, and month
- Identified branches selling more than average
- Evaluated customer types generating highest revenue

### Customer Analysis
- Determined gender distribution and most common customer types
- Identified busiest times for customer engagement
- Evaluated ratings trends per branch and day

## Skills Applied
- SQL: `GROUP BY`, `JOIN`, `CASE`, `RANK()`, `CTEs`
- Feature Engineering: `time_of_day`, `day_name`, `month_name`
- Exploratory Data Analysis (EDA)
- Business-focused insights

## Folder Structure
- `SQL/` – Contains all SQL scripts
- `Visualizations/` – Optional charts and output screenshots
- `Data/` – Optional dataset (or link to Kaggle)
- `Notes/` – Feature engineering and notes

## Key Insights
- Electronics is the top-selling product line
- Morning is the busiest time of day
- Majority of customers are female
- Branches with higher sales identified for inventory optimization
