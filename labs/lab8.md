## Lab 8: Incremental Models

### 1. Make the orders model incremental

We've had a huge spike in order volumes because of Covid and as a result our `orders` model is taking longer and longer to build. 

Make the orders model incremental, without a primary key and without a lookback period, i.e. just insert new orders that were uploaded since the last run.

### 2. Check how late orders arrive in our system

Our engineers have just discovered a bug that causes some orders to arrive in the warehouse much later than they should. As a result, we're now worried about our incremental model missing data.

Write a query to check how many days back we need to look back in order to ensure our model catches 99% of new orders. You should compare the `created_at` and `_synced_at` columns.

### 3. Re-factor the incremental model to account for a lookback window

Based on your findings in step 2, re-factor the incremental model to ensure we always re-process 99% of orders. As we'll now be re-processing data, we'll need to add a unique key so that records do not get duplicated.

### 4. Add a column to our incremental model that stores when a record was last added or updated in the destination table

Now that our model is incremental, we need additional fields to facilitate auditing the data. 

Add a new column `dbt_uploaded_at`, which represents when a record was last processed. 

Things to think about:
* How do you ensure the new column gets added to the schema when you call `dbt run`?