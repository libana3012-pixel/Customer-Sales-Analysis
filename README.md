Customer Sales Analysis (SQL Project)
## About
I created this project to practice SQL and get more comfortable working with data.
The dataset includes customers, products, and orders. The goal was to use SQL to answer simple business questions and understand how data can be analyzed in practice.
---
## What I worked on
In this project, I explored questions like:
- Which customers have placed the most orders?
- What products are most popular?
- Are there customers who haven’t ordered anything?
- How many different products has each customer bought?
---
## Tools used
- SQL (SQLite)
- GitHub
---
## Data structure
The project uses three tables:
customers  
products  
orders  
---
## Example query
```sql
SELECT product, COUNT(*) AS total_orders
FROM orders
GROUP BY product
ORDER BY total_orders DESC;
