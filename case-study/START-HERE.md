# Start here: from orders to customer insight

[← Repository home](../README.md) · [Why the method was chosen](METHOD.md) · [Results](FINDINGS.md) · [Source data](customer-data.sql)

## The story
The first project asked how much the shop sold. This one asks a different question: **Who shops again?** A shop owner may have a customer register, but some of those people have never made a purchase.

## Four files
- `customer-data.sql` creates eight imaginary customers and their purchases.
- `customer-analysis.sql` counts how many times each person purchased and places them into groups.
- `FINDINGS.md` explains the real outputs of this synthetic exercise.
- `START-HERE.md` is this plain-language explanation.

## The three customer groups
| Group | Meaning | People |
| --- | --- | ---: |
| Never bought | Listed as a customer, but no order | 1 |
| Bought once | Exactly one observed order | 3 |
| Returned | Two or more observed orders | 4 |

**Why this matters:** Looking only at the order table would leave out the person who never bought anything. A `LEFT JOIN` lets us keep everyone from the customer table while connecting any orders they made.

## Five useful terms
| Term | Meaning |
| --- | --- |
| Customer segmentation | Dividing customers into useful groups |
| LEFT JOIN | Connecting two sheets while keeping every row from the first |
| CTE | A named intermediate step in an SQL query |
| Window function | A calculation across related rows without collapsing them into one |
| Retention | Customers who continue to return over a defined time window |

## Be careful with the headline
Four of seven purchasing customers ordered again: **57.14%**. That does not prove the shop has a 57.14% long-term retention rate. Someone who first purchased in June had less time to return than someone who purchased in March.

## Run it yourself
```bash
sqlite3 customers.db < case-study/customer-data.sql
sqlite3 -header -column customers.db < case-study/customer-analysis.sql
```
Use a **fresh database** for the first command; running the create script twice on the same database will try to create tables that already exist.

**Interview explanation:** “I joined customer and order records, included customers with no purchase, grouped customers by frequency and explained why observed repeat purchases are not the same as long-term retention.”

All data is fictional and used only for learning.
