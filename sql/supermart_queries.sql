CREATE DATABASE supermart;
USE supermart;

CREATE TABLE sales (
    Order_ID VARCHAR(20) PRIMARY KEY,Customer_Name VARCHAR(100),Category VARCHAR(50),
    Sub_Category VARCHAR(50),City VARCHAR(50),Order_Date DATE,Region VARCHAR(20),
    Sales INT,Discount DECIMAL(4,2),Profit DECIMAL(10,2),State VARCHAR(50)
);

-- Overall KPIs
SELECT COUNT(*) AS total_orders,SUM(Sales) AS total_sales,SUM(Profit) AS total_profit ,ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct FROM sales;

-- Sales and profit by category
SELECT Category,SUM(Sales) AS total_sales,SUM(Profit) AS total_profit,ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS margin_pct
FROM sales GROUP BY Category ORDER BY total_sales DESC;

-- Top 5 sub categories by sales
SELECT Sub_Category,SUM(Sales) AS total_sales,SUM(Profit) AS total_profit
FROM sales GROUP BY Sub_Category ORDER BY total_sales DESC LIMIT 5;

-- Yearly sales and profit
SELECT YEAR(Order_Date) AS year,SUM(Sales) AS total_sales,SUM(Profit) AS total_profit
FROM sales GROUP BY YEAR(Order_Date) ORDER BY year;

-- Sales by calendar month (all years combined)
SELECT MONTHNAME(Order_Date) AS month_name,SUM(Sales) AS total_sales
FROM sales GROUP BY MONTH(Order_Date), MONTHNAME(Order_Date) ORDER BY total_sales DESC;

-- Sales and profit by region
SELECT Region,COUNT(*) AS orders,SUM(Sales) AS total_sales,SUM(Profit) AS total_profit,ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS margin_pct
FROM sales GROUP BY Region ORDER BY total_sales DESC;

-- Top 10 cities by sales
SELECT City,SUM(Sales) AS total_sales,SUM(Profit) AS total_profit
FROM sales GROUP BY City ORDER BY total_sales DESC LIMIT 10;

-- Does discount level affect profit
SELECT CASE 
WHEN Discount < 0.15 THEN '10-14%'
WHEN Discount < 0.20 THEN '15-19%'
WHEN Discount < 0.25 THEN '20-24%'
WHEN Discount < 0.30 THEN '25-29%'
ELSE '30-35%'

END AS discount_band,COUNT(*) AS orders,ROUND(AVG(Profit), 2) AS avg_profit,ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS margin_pct
FROM sales GROUP BY discount_band ORDER BY discount_band;