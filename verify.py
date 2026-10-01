"""Run the public synthetic customer case and check the main figures.

Usage: python3 verify.py
Uses only the Python standard library; no SQLite command-line installation needed.
"""
import sqlite3
from pathlib import Path

BASE = Path(__file__).parent / "case-study"
db = sqlite3.connect(":memory:")
db.execute("PRAGMA foreign_keys=ON")
db.executescript((BASE / "customer-data.sql").read_text(encoding="utf-8"))

def check(label, query, expected):
    value = db.execute(query).fetchone()[0]
    assert value == expected, f"{label}: expected {expected!r}, found {value!r}"
    print(f"PASS {label}: {value}")

check("Registered customers", "SELECT COUNT(*) FROM customers", 8)
check("Orders", "SELECT COUNT(*) FROM orders", 12)
check("Order lines", "SELECT COUNT(*) FROM order_items", 19)
check("Gross sales value", "SELECT SUM(quantity*unit_price) FROM order_items", 2020)
check("Active customers", "SELECT COUNT(DISTINCT customer_id) FROM orders", 7)
check("Repeat customers", """SELECT COUNT(*) FROM
    (SELECT customer_id FROM orders GROUP BY customer_id HAVING COUNT(*) >= 2)""", 4)
check("One-order customers", """SELECT COUNT(*) FROM
    (SELECT customer_id FROM orders GROUP BY customer_id HAVING COUNT(*) = 1)""", 3)
check("Customers without orders", """SELECT COUNT(*) FROM customers c
    WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id)""", 1)
check("Orphan orders", """SELECT COUNT(*) FROM orders o LEFT JOIN customers c
    ON c.customer_id=o.customer_id WHERE c.customer_id IS NULL""", 0)
check("Duplicate order/product lines", """SELECT COUNT(*) FROM
    (SELECT order_id,product_id FROM order_items
    GROUP BY order_id,product_id HAVING COUNT(*) > 1)""", 0)
print("Customer case checks passed.")
