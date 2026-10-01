# Customer Sales Analysis
**SQL · SQLite · Customer Analytics**

## Overview
A SQL case study examining customer purchasing activity, order frequency and product demand. The purpose is to structure common commercial questions as repeatable database queries.

## Business questions
- Which customers have placed the most orders?
- Which products occur most frequently in the order records?
- Which customers have never placed an order?
- How many distinct products has each customer bought?

## Data overview
This project uses three related tables: `customers`, `products` and `orders`. Refer to the source files for the exact schema and sample data.

## Example query: product activity
```sql
SELECT
    product,
    COUNT(*) AS total_orders
FROM orders
GROUP BY product
ORDER BY total_orders DESC;
```

**Interpretation:** This query counts rows by product. Its result represents distinct orders only if each row is one order. The row-level structure should be checked before reporting it as an order count.

## Measures to validate
| Measure | Business purpose |
| --- | --- |
| Order frequency | Compare purchasing activity across customers |
| Customers with no orders | Identify customers without recorded transactions |
| Product frequency | Understand which products appear most often |
| Distinct products by customer | Examine variety of purchasing activity |

## Method and quality checks
- Confirm table keys and join relationships.
- Check whether counts represent records, items or distinct orders.
- Identify missing customer references and duplicate records.
- Record the reporting period and assumptions.

## Findings
Verified numerical findings will be added after the SQL outputs are executed and validated. This README does not present illustrative numbers as observed results.

## Next steps
1. Publish the source queries alongside the dataset.
2. Add actual result tables and concise conclusions.
3. Extend the analysis with customer segments and purchasing trends where the data supports them.

## Tools
SQL · SQLite · GitHub
