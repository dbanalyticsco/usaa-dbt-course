## Lab 4. CTEs, Subqueries, and Query Optimization

### 1. Re-write the query using CTEs

You received a query from a collague in the marketing department who was trying to pull some information from your warehouse. Unfortunately, they exclusively used subqueries and you want to clean it up before providing your feedback because you think it will be easier to read.

Re-write the following query using CTEs instead of subqueries.

TODO: Dylan, add the query here.
```sql
select
    customer_id,
    first_name,
    last_name,
    (select round(avg(total_amount),2) from {{ ref('orders') }} where orders.customer_id = customers.customer_id and ordered_at > current_date 180) as avg_order_amount,
    (select count(*) from {{ ref('orders') }} where orders.customer_id = customers.customer_id and ordered_at > current_date - 180) as order_count
from {{ ref('customers') }}
where customer_id in (
  select distinct customer_id
  from {{ ref('orders') }}
  where ordered_at > current_date - 42
)
```

### 2. Break out the query into ephemeral models.

After reviewing the query, you think it would be useful to add it to your dbt project. However, you think part of the query is going to be re-usable elsewhere and want to break it up.

Move part of the query into another model. You won't want the new model to appear in the warehouse, so set it to be materialized as ephemeral.

Things to think about: 
* What section of the query is most suitable to be split out?
* Are there any tests you should apply to the new ephemeral model?

### 3. Optimize the new query from marketing

You've received another query from marketing. While they've used CTEs this time, the query seems to take a long time to run. 

Investigate why the query is taking so long and try to re-write it to speed it up.

TODO: Dylan, add the query here.
```sql
select *
from {{ ref('orders') }}
```

