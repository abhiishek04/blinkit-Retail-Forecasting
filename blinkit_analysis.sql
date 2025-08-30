USE blinkit_analysis;
-- Total Number of Rows --
SELECT COUNT(*) 
FROM blinkit_data;

-- Check Duplicate Values in Primary Column--
SELECT COUNT(*) - COUNT(DISTINCT order_id) AS duplicates 
FROM blinkit_data;

-- Check Date & Time Consistency --
SELECT MIN(STR_TO_DATE(order_date, '%d-%m-%Y %H:%i')) AS start_date,
       MAX(STR_TO_DATE(order_date, '%d-%m-%Y %H:%i')) AS end_date
FROM blinkit_data;

-- Calculate total number of orders, revenue by total orders & average order value --
SELECT COUNT(order_id) as total_orders, 
ROUND(SUM(order_total),2) as total_revenue, 
ROUND(AVG(order_total),2) as avg_order_value
FROM blinkit_data; 

-- Monthly Sales Trend -- 
SELECT DATE_FORMAT(STR_TO_DATE(order_date, '%d-%m-%Y %H:%i'), '%Y-%m') AS month,
       ROUND(SUM(order_total),2) AS total_sales
FROM blinkit_data
GROUP BY month
ORDER BY month;

-- Total customers by customer segment --
SELECT COUNT(DISTINCT customer_id) as total_customers, customer_segment
FROM blinkit_data
GROUP BY customer_segment;

-- Total customers from different areas --
SELECT COUNT(DISTINCT customer_id) as total_customers, area
FROM blinkit_data
GROUP BY area;

-- Seasonal impact on Sales --
SELECT season, COUNT(order_id) as total_orders,
ROUND(SUM(order_total),2) as total_sales,
ROUND(AVG(order_total),2) as avg_sales
FROM blinkit_data
GROUP BY season
ORDER BY total_sales DESC;

-- Which segment drives revenue (Premium, Regular, New, etc)? --
SELECT customer_segment,
ROUND(SUM(order_total),2) as total_revenue, 
COUNT(order_id) as total_orders
FROM blinkit_data
GROUP BY customer_segment
ORDER BY total_revenue DESC;

-- Top 10 Customers by Spending --
SELECT customer_id, customer_name, 
ROUND(SUM(order_total),2) as total_amount
FROM blinkit_data
GROUP BY customer_name, customer_id
ORDER BY total_amount DESC
LIMIT 10;

-- Area-Wise Sales Distribution--
SELECT area, 
ROUND(SUM(order_total),2) as total_amount,
COUNT(order_id) as total_orders
FROM blinkit_data
GROUP BY area
ORDER BY total_amount DESC;

-- Order Frequency per Customer --
SELECT customer_id, 
COUNT(order_id) AS num_orders, 
ROUND(AVG(order_total),2) AS avg_order_value
FROM blinkit_data
GROUP BY customer_id
ORDER BY num_orders DESC;

-- Daily Sales Aggregation for Forecast Model Input-- 
SELECT DATE(STR_TO_DATE(order_date, '%d-%m-%Y %H:%i')) AS order_day,
ROUND(SUM(order_total),2) AS daily_sales,
COUNT(order_id) AS total_orders
FROM blinkit_data
GROUP BY order_day
ORDER BY order_day;




