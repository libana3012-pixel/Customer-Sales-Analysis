# Customer behaviour: a small reproducible study

The dataset is **synthetic**, covers orders dated March–June 2026, and contains 8 registered customers, 12 orders and 19 order lines. This is an analytical exercise, not an account of employment or real customer performance.

## Results
| Segment | Customers | Definition |
| --- | ---: | --- |
| Repeat customers | 4 | Two or more observed orders |
| One-order customers | 3 | Exactly one observed order |
| Customers without orders | 1 | No observed order |
| Active customers | 7 | At least one observed order |

**Observed repeat share:** 4/7 = 57.14% of purchasing customers. This is *not* a normalized retention rate: the observation window is short and later cohorts have less time to return.

**Customer revenue:** C001 = 620 CU (30.69% of total 2,020 CU), C004 = 315 CU, C003 = 305 CU, C002 = 245 CU, C007 = 195 CU, C005 = 170 CU, C006 = 170 CU, C008 = 0 CU.

## Interpretation
- A `LEFT JOIN` preserves customers who have never ordered. Starting from the order table would silently exclude C008.
- Customer C001 accounts for the largest observed share of revenue; concentration deserves follow-up with a larger dataset.
- Cohort comparisons require caution: the June acquisition cohort has substantially less follow-up than the March cohort.
- This sample lacks marketing spend, profitability, refunds and consent data. It cannot establish acquisition effectiveness or causality.

## Reproduce
```bash
sqlite3 customers.db < case-study/customer-data.sql
sqlite3 -header -column customers.db < case-study/customer-analysis.sql
```

The synthetic data is deliberately small so every reported metric can be checked against the original rows.
