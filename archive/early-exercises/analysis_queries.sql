-- Show all customers and what they bought
SELECT customers.name, orders.product
FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id;

-- Count orders per customer
SELECT customers.name, COUNT(*) AS total_orders
FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id
GROUP BY customers.name
ORDER BY total_orders DESC;

-- Most popular products
SELECT product, COUNT(*) AS total_orders
FROM orders
GROUP BY product
ORDER BY total_orders DESC;

-- Customers with no orders
SELECT customers.name
FROM customers
LEFT JOIN orders
ON customers.id = orders.customer_id
WHERE orders.product IS NULL;

-- Unique products per customer
SELECT customers.name, COUNT(DISTINCT orders.product) AS unique_products
FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id
GROUP BY customers.name;
