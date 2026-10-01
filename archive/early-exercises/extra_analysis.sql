-- Customers who bought more than 1 product type
SELECT customers.name, COUNT(DISTINCT orders.product) AS unique_products
FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id
GROUP BY customers.name
HAVING COUNT(DISTINCT orders.product) > 1;

-- Total number of orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- Customers ordered by number of purchases
SELECT customers.name, COUNT(*) AS total_orders
FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id
GROUP BY customers.name
ORDER BY total_orders DESC;
