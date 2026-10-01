-- Source checks for the standalone synthetic customer case.
-- Expected: 8 registered customers, 12 orders, 19 item lines.
SELECT 'customers' AS check_name,COUNT(*) AS actual,8 AS expected,
 CASE WHEN COUNT(*)=8 THEN 'PASS' ELSE 'FAIL' END AS status FROM customers
UNION ALL SELECT 'orders',COUNT(*),12,CASE WHEN COUNT(*)=12 THEN 'PASS' ELSE 'FAIL' END FROM orders
UNION ALL SELECT 'order_lines',COUNT(*),19,CASE WHEN COUNT(*)=19 THEN 'PASS' ELSE 'FAIL' END FROM order_items;
-- Preserve customers with zero orders when checking customer groups.
WITH activity AS (
 SELECT c.customer_id,COUNT(o.order_id) AS n FROM customers c
 LEFT JOIN orders o ON c.customer_id=o.customer_id GROUP BY c.customer_id
)
SELECT SUM(CASE WHEN n=0 THEN 1 ELSE 0 END) AS no_orders,
       SUM(CASE WHEN n=1 THEN 1 ELSE 0 END) AS one_order,
       SUM(CASE WHEN n>1 THEN 1 ELSE 0 END) AS repeat_customers
FROM activity;
-- Expected: 1, 3, 4, respectively.
SELECT 'orders_without_line_items' AS check_name,COUNT(*) AS issues FROM orders o
WHERE NOT EXISTS (SELECT 1 FROM order_items oi WHERE oi.order_id=o.order_id);
