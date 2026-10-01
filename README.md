# Customer Sales Analysis
**Who comes back, who buys once, and who has never ordered?**

This project looks at the *people behind the sales*, using a small imaginary shop dataset. The point is to understand customer behaviour rather than only add up revenue.

## The result in 30 seconds
The stand-alone case study follows eight fictional customers and twelve orders between March and June 2026.

| Customer group | People | Meaning |
| --- | ---: | --- |
| Bought more than once | 4 | Made at least two orders |
| Bought once | 3 | Made one order |
| Never ordered | 1 | Appears in the customer list but has no purchase |

**One finding:** 4 of the 7 people who ordered came back at least once (57.14%). That is an *observed repeat-purchase share*, not a long-term retention rate: later customers had less time to return.

All names and purchases are synthetic, not taken from an employer or real users.

## Explore the project
1. [Read the findings](case-study/FINDINGS.md) — results and the limits of this small sample.
2. [See the data](case-study/customer-data.sql) — the shop's customers, products and purchases.
3. [See the queries](case-study/customer-analysis.sql) — how the customer groups are calculated.
4. [Start with the simple guide](case-study/START-HERE.md) — explanations with no assumed SQL background.

## How to run it
With SQLite installed, from the repository root:
```bash
sqlite3 customers.db < case-study/customer-data.sql
sqlite3 -header -column customers.db < case-study/customer-analysis.sql
```

## Skills shown
Joining data (including people with no orders), building customer groups, using CTEs to make complex queries readable and applying ROW_NUMBER to identify first and later purchases.

## A note on scope
The `case-study/` folder is a new, self-contained exercise. Its data and results are separate from earlier practice files in this repository. This small dataset is for learning and query validation, not for forecasting customer behaviour.
