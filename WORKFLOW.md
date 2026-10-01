# How the customer-analysis answer was reached

[Repository home](README.md) | [Plain-language introduction](case-study/START-HERE.md) | [Detailed SQL reasoning](case-study/METHOD.md) | [Findings](case-study/FINDINGS.md)

## Tools used
- **SQLite / SQL:** stores fictional customers, orders, products and order lines; joins tables and aggregates customer activity.
- **SQLite command-line tool:** runs the SQL setup, validation and analysis files.
- **Python 3 `sqlite3`:** runs a separate reproducible set of assertions via [verify.py](verify.py).
- **GitHub Actions:** runs the verification script automatically via [verify.yml](.github/workflows/verify.yml).

No paid service or external dataset is required.

## From the question to the answer

**1. Define the population.** The business question concerns registered customers, including those who never purchased. Starting from the order table would omit that person, so the analysis starts from the customer table and uses a LEFT JOIN. This keeps C008 in the result with zero orders.

**2. Make order value at the correct level.** An order may have several product lines. The SQL combines quantity × transaction-time unit price for the order before attributing that order's value to a customer. This avoids accidentally turning item rows into extra purchases.

**3. Segment observed behaviour.** The query counts actual order IDs, then separates customers into no orders, exactly one order, and two or more orders. That grouping is useful because the next step for somebody who never purchased differs from an established repeat purchaser.

**4. Check the arithmetic.** The [fictional source](case-study/customer-data.sql) contains eight registered customers, twelve orders and nineteen order lines. [Findings](case-study/FINDINGS.md): one customer has no order, three have one, four have at least two. Seven have purchased, so 4 / 7 × 100 = **57.14% observed repeat-purchase share**.

**5. Interpret without overclaiming.** This figure is not a proper long-term retention estimate. Customers who first appear near the June cutoff have less time to return than those recorded in March. See the separate [next-month cohort exercise](https://github.com/libana3012-pixel/data-analytics-portfolio-public/blob/main/projects/customer-cohorts/METHOD.md) for a fixed-window approach.

**6. Validate the output.** The [SQL checks](case-study/quality-checks.sql) inspect source consistency. [verify.py](verify.py) rebuilds the source in an in-memory SQLite database and asserts the published headline counts. An automated GitHub workflow executes those assertions.

## Run it from a fresh checkout
```bash
sqlite3 customers.db < case-study/customer-data.sql
sqlite3 -header -column customers.db < case-study/quality-checks.sql
sqlite3 -header -column customers.db < case-study/customer-analysis.sql
python3 verify.py
```
Create a new database for the setup command so old data does not interfere with the test. The input is synthetic; results describe the included example, not actual customer performance.
