-- Customer behaviour case | SQLite 3.25+ | synthetic data
-- 01. Customer-level view. Aggregate orders first to prevent double-counting.
WITH order_value AS (
 SELECT o.order_id,o.customer_id,o.order_date,SUM(i.quantity*i.unit_price) AS revenue
 FROM orders o JOIN order_items i ON o.order_id=i.order_id
 GROUP BY o.order_id,o.customer_id,o.order_date
)
SELECT c.customer_id,c.market,COUNT(v.order_id) AS orders,
       COALESCE(SUM(v.revenue),0) AS customer_revenue,
       MIN(v.order_date) AS first_order_date,
       MAX(v.order_date) AS last_order_date,
       CASE WHEN COUNT(v.order_id)=0 THEN 'no orders'
            WHEN COUNT(v.order_id)=1 THEN 'one order'
            ELSE 'repeat customer' END AS purchase_segment
FROM customers c LEFT JOIN order_value v ON v.customer_id=c.customer_id
GROUP BY c.customer_id,c.market ORDER BY customer_revenue DESC,c.customer_id;

-- 02. Aggregate customer segmentation
WITH activity AS (
 SELECT c.customer_id,COUNT(o.order_id) AS order_count
 FROM customers c LEFT JOIN orders o ON o.customer_id=c.customer_id
 GROUP BY c.customer_id
)
SELECT CASE WHEN order_count=0 THEN 'no orders' WHEN order_count=1 THEN 'one order' ELSE 'repeat customer' END AS segment,
       COUNT(*) AS customers
FROM activity GROUP BY segment ORDER BY customers DESC;

-- 03. First-order month cohorts and return behaviour (any subsequent order within observation window)
WITH ranked AS (
 SELECT customer_id,order_id,order_date,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date,order_id) AS purchase_number
 FROM orders
), cohorts AS (
 SELECT customer_id,substr(order_date,1,7) AS first_month FROM ranked WHERE purchase_number=1
), repeaters AS (
 SELECT DISTINCT customer_id FROM ranked WHERE purchase_number>1
)
SELECT first_month,COUNT(*) AS acquired_customers,
       SUM(CASE WHEN r.customer_id IS NOT NULL THEN 1 ELSE 0 END) AS observed_repeaters
FROM cohorts c LEFT JOIN repeaters r ON c.customer_id=r.customer_id
GROUP BY first_month ORDER BY first_month;

-- 04. Distinct categories purchased; customers with no purchases remain visible.
SELECT c.customer_id,COUNT(DISTINCT p.category) AS distinct_categories
FROM customers c LEFT JOIN orders o ON c.customer_id=o.customer_id
LEFT JOIN order_items i ON i.order_id=o.order_id
LEFT JOIN products p ON p.product_id=i.product_id
GROUP BY c.customer_id ORDER BY distinct_categories DESC,c.customer_id;

-- 05. Integrity: should return zero rows
SELECT o.order_id FROM orders o LEFT JOIN customers c ON o.customer_id=c.customer_id WHERE c.customer_id IS NULL;
SELECT order_id,product_id,COUNT(*) FROM order_items GROUP BY 1,2 HAVING COUNT(*)>1;
