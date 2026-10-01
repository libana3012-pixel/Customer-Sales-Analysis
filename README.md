# Customer Sales Analysis
### Turning order history into a useful view of customer behaviour

**SQL / SQLite** · Customer segmentation · Cohort foundations · Data interpretation

> **The business question:** How many registered customers actually buy, how many return, and who is missing when we only look at transactions?

The `case-study/` directory is a standalone exercise using **fictional customers and purchases**. Its results are separate from the repository's earlier practice work.

## The answer at a glance

| Observed group | Customers | What it means |
|:--|--:|:--|
| Repeat purchasers | 4 | At least two observed orders |
| One-time purchasers | 3 | Exactly one observed order |
| No purchases | 1 | Customer exists but has no recorded order |
| Total | 8 | Registered customers in the sample |

Four of the seven customers who purchased placed another order during the observation window (**57.14%**). This is an *observed repeat-purchase share*, not a reliable long-term retention estimate. Customers arriving later had less time to return.

## Why the method matters

Two choices make a big difference to the answer:

1. **Start from the customer table.** A `LEFT JOIN` keeps the customer who has no order. Starting with sales transactions would silently hide that customer.
2. **Define your time window.** First-purchase month and follow-up period matter when comparing customer behaviour. A blank follow-up period is not the same as a 0% retention result.

## Explore the case

| Start with | What you will find |
|:--|:--|
| [Five-minute explanation](case-study/START-HERE.md) | The story without technical language |
| [Results and caveats](case-study/FINDINGS.md) | Customer groups and what the small sample cannot prove |
| [SQL analysis](case-study/customer-analysis.sql) | Order counts, customer value, first purchases, returners and product breadth |
| [Synthetic data](case-study/customer-data.sql) | Fully reproducible source tables |
| [Quality checks](case-study/quality-checks.sql) | Basic integrity and reconciliation |

```text
case-study/
  customer-data.sql       eight customers and twelve orders
  customer-analysis.sql   customer-level and cohort queries
  quality-checks.sql      source consistency checks
  FINDINGS.md             findings and limitations
  START-HERE.md           plain-English explanation
```

## Reproduce

```bash
sqlite3 customers.db < case-study/customer-data.sql
sqlite3 -header -column customers.db < case-study/quality-checks.sql
sqlite3 -header -column customers.db < case-study/customer-analysis.sql
```

**Skills demonstrated:** SQL joins, common table expressions (CTEs), `ROW_NUMBER()`, grouping, treatment of missing purchase activity, clear metric definitions and cautious interpretation.

**Next iteration:** a Python cohort analysis with consistent follow-up windows and simple, readable visualizations. The separate [portfolio hub](https://github.com/libana3012-pixel) will link the related projects when its public profile is set up.
