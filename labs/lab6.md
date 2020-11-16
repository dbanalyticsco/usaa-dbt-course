## Lab 6: Semi-Structured Data and Recursive CTEs

### Kick-off questions

* What semi-structured data exists within USAA?
* How is that data being transformed currently?

### 1. Create a staging model for the payments data

We've recently integrated our payments data into Snowflake. The data comes as a JSON API response from the source system and we decided it would be easier to just put it in Snowflake in the same format.

Create a staging model for the new payments data that includes the following fields:
* order_id
* id
* payment_type
* payment_amount
* created_at

Things to think about: 
* Does our new model need tests?
* Does every column have the correct datatype?

### 2. Write a query that provides a record for each zipcode

As part of the payments data work, we also received a dataset with information about US zipcodes. Again, this data has been provided to us as a single JSON object and we want to unnest it so that each record contains a zipcode and relevant information about that zipcode.

Write a query, using a `lateral flatten`, that contains a record for each zipcode in our new dataset.

### 3. Add a new column to our `orders` model that represents how many times an order has been re-ordered

A few months ago, our engineers added the ability in our application to simply 're-order' a prior order. The ID of the order that was 're-ordered' exists on our source orders data.

Write a query, using a recursive CTE, that shows how many times a given order was 're-ordered'. For the following 'chain' of orders, we would expect the following output:

| order_id | reordered_from_id | reordered_count |
|----------|-------------------|-----------------|
| 1        |                   | 4               |
| 2        | 1                 | 3               |
| 3        | 2                 | 0               |
| 4        | 2                 | 1               |
| 5        | 4                 | 0               |

Order 1 generated 4 downstream orders. It generated order 2, which in turn generated orders 3 and 4, the latter of which generated order 5, for a total of 5 (2,3,4,5)
Order 2 generated 3 downstream orders. It generated order 3 and 4, the latter of which generated order 5, for a total of 3 (3,4,5).
Order 3 had no downstream orders.
Order 4 generated 1 downstream order. It generated order 5, for a total of 1 (5).
Order 5 had no downstream orders.