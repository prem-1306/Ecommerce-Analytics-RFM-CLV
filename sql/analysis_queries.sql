-- Overall KPIs 
SELECT
SUM(oi.unit_price*oi.quantity) as total_revenue,
SUM(oi.profit)  as total_profit,
COUNT(DISTINCT oi.order_id) as total_orders,
COUNT(DISTINCT customer_id) as total_customers
FROM order_items as oi
JOIN orders as o
on o.order_id=oi.order_id;

-- Category-wise Revenue & Profit 
SELECT 
p.category,
SUM(oi.unit_price * oi.quantity) AS total_revenue,
SUM(oi.profit) AS total_profit,
ROUND(AVG((oi.profit / (oi.unit_price * oi.quantity)) * 100),2) AS avg_profit_margin_percent
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;


-- finding metrics just to match the powerbi numbers
SELECT
    DATE(o.order_date) AS order_date,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity) AS total_quantity,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE DATE(o.order_date) = '2022-04-03'
GROUP BY DATE(o.order_date);

-- Top 10 Revenue Generating Cities
SELECT c.city,
SUM(oi.quantity*oi.unit_price) as total_revenue,
SUM(oi.profit) as total_profit,
COUNT(DISTINCT o.order_id) as total_orders
FROM customers c 
JOIN orders o on c.customer_id=o.customer_id
JOIN order_items oi on o.order_id=oi.order_id
GROUP BY c.city
ORDER BY total_revenue DESC
LIMIT 10;


-- Monthly Revenue Trend
SELECT DATE_FORMAT(o.order_date,"%Y-%m") as year__month,
SUM(oi.unit_price*oi.quantity) as total_revenue,
SUM(oi.profit) as total_profit,
COUNT(DISTINCT o.order_id) as total_orders 
FROM orders o 
JOIN order_items oi
ON o.order_id=oi.order_id 
GROUP BY year__month 
ORDER BY year__month
;

-- Top 10 Highest Revenue Customers
SELECT c.customer_id ,
c.first_name as customer_name,
SUM(oi.unit_price*oi.quantity) as total_revenue,
COUNT(DISTINCT o.order_id) as total_orders
FROM customers c 
JOIN orders o 
ON c.customer_id=o.customer_id
JOIN order_items oi on o.order_id=oi.order_id
GROUP BY c.customer_id,customer_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Customer Segment-wise Revenue & Profit
SELECT c.segment ,
COUNT(DISTINCT c.customer_id) as total_customers,
COUNT(DISTINCT o.order_id) as total_orders,
SUM(oi.quantity*oi.unit_price) as total_revenue,
SUM(oi.profit) as total_profit 
FROM customers c 
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY c.segment
ORDER BY total_revenue DESC,total_profit DESC;

-- Discount vs Profit (Category-wise Impact)
SELECT 
p.category,
ROUND(AVG(discount_percent),2) as avg_discount_percent,
ROUND(AVG(profit/NULLIF(unit_price*quantity,0))*100,2)  as avg_profit_margin,
SUM(unit_price*quantity) as total_revenue,
SUM(profit) as total_profit
FROM  products p
JOIN order_items oi 
ON p.product_id=oi.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- Segment Wise Global Ranking And Segment Ranking
SELECT customer_id,customer_name,segment,city,total_revenue,total_orders,
RANK()OVER(ORDER BY total_revenue DESC) as global_rank,
RANK()OVER(PARTITION BY segment ORDER BY total_revenue DESC) as segment_rank
FROM (
SELECT 
c.customer_id,
c.first_name as customer_name,
c.segment,
c.city,
SUM(oi.unit_price*oi.quantity) as total_revenue,
COUNT(DISTINCT o.order_id) as total_orders
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_items oi
ON o.order_id =oi.order_id
GROUP BY c.customer_id,c.first_name,c.segment,c.city
)t
ORDER BY total_revenue DESC;

-- CLV Analysis
SELECT customer_id,customer_name,segment,city,total_revenue,total_profit as CLV,
ROUND((total_revenue / total_orders),2) as average_order_value,
ROUND((total_profit / total_revenue) * 100,2) as profit_margin_percent
FROM(
SELECT 
c.customer_id,
c.first_name as customer_name,
c.segment,
c.city,
COUNT(DISTINCT c.customer_id) as total_customers,
SUM(oi.unit_price*oi.quantity) as total_revenue,
COUNT(DISTINCT o.order_id) as total_orders,
SUM(oi.profit) as total_profit
FROM customers c JOIN orders o ON c.customer_id=o.customer_id
JOIN order_items oi ON oi.order_id=o.order_id
GROUP BY c.customer_id,customer_name,c.segment,c.city
)t
ORDER BY total_revenue DESC;

-- Bucket Rules
with clv_table as (
SELECT 
customer_id,
customer_name,
segment,
city,
total_revenue,
total_orders,
total_profit,
ROUND(total_profit,2) as CLV
FROM ( SELECT c.customer_id,c.first_name as customer_name,c.segment,c.city,
SUM(oi.unit_price*oi.quantity) as total_revenue,
COUNT(DISTINCT o.order_id) as total_orders,
SUM(oi.profit) as total_profit
FROM customers c JOIN orders o ON c.customer_id=o.customer_id 
JOIN order_items oi on o.order_id=oi.order_id
GROUP BY c.customer_id,c.first_name,c.segment,c.city
  )t
),
ranked as (SELECT *,
NTILE(5)OVER(ORDER BY CLV DESC) AS clv_bucket
FROM clv_table
)
SELECT *,
	CASE
		WHEN clv_bucket=1 THEN "VIP"
        WHEN clv_bucket=2 THEN "Loyal"
		WHEN clv_bucket = 3 THEN 'Growth'
        WHEN clv_bucket = 4 THEN 'At Risk'
        WHEN clv_bucket = 5 THEN 'Low Value'
    END AS customer_value_group
FROM ranked
ORDER BY CLV DESC;    
