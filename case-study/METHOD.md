# Method explained | Customer analysis

[← Case introduction](START-HERE.md) · [Findings](FINDINGS.md) · [Data setup](customer-data.sql) · [Analysis SQL](customer-analysis.sql) · [Source checks](quality-checks.sql) · [Repository home](../README.md)

## Why this question matters
A register can include customers who never made a purchase. If an analyst begins with the order table and counts customers there, the people without orders disappear. That produces an incomplete view of the population. The question is not simply “how many transactions?” but “what happened across *all registered customers*?”

## Data design and trade-offs
The fictional database separates customers, orders, products and order items. A customer can have many orders; an order can have multiple items. An item has a recorded unit price at the time of the transaction. This matters because multiplying order rows after a join can inflate transaction counts; prices should also reflect historical purchases instead of a later catalogue price.

## Why these SQL operations were chosen
1. **Build an order-value CTE.** Add item value at the order level first, so subsequent customer calculations start from one row per order.
2. **LEFT JOIN from customers.** Keep all eight registered customers, including C008, who has no orders. An inner join would omit that customer entirely.
3. **COUNT(order_id), not COUNT(*).** For the no-order customer, the left join contains a null order. COUNT of the actual order ID correctly produces zero.
4. **MIN and MAX dates.** Identify first and last *observed* purchase dates. These do not imply knowledge of orders outside the dataset.
5. **CASE to define purchase groups.** Zero orders, one order, and two or more orders become mutually exclusive segments.
6. **ROW_NUMBER in the cohort query.** Order rows by date to locate the first recorded purchase, then distinguish later observed orders.

## Work through the headline
Eight registered customers minus one with no orders = seven observed purchasers. Four made at least two purchases, so observed repeat-purchase share = 4 ÷ 7 × 100 = **57.14%**.

That does *not* mean 57.14% long-term retention. Someone buying for the first time in June has less follow-up time than somebody buying in March. A separate, equally timed cohort analysis is necessary to answer a retention question fairly.

## What I checked
The sample has eight customers, twelve orders and nineteen order items. The [validation script](../verify.py) independently checks the core figures with Python's SQLite interface; the [automated workflow](../.github/workflows/verify.yml) runs this script. The sample's reported gross line value is 2,020 fictional currency units.

## Limitations and a useful next iteration
The dataset is synthetic and small. No costs, refunds, customer acquisition spend or real customer history are available. In a larger project, I would agree on a customer identifier, choose a reporting cohort and observation window, treat refunds explicitly and join campaign cost only after confirming a consistent attribution model.

[← Results](FINDINGS.md) · [Return to repository](../README.md).
