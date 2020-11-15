## Lab 1: Runs, Sources and Docs

### 1. Add sources to the project

Refactor your project from your pre-work by adding in sources wherever you had hard-coded references to the `ecomm` tables.

Things to think about:
* Do you want the source name to be the same as the schema name?
* Should you be applying a source freshness check to the data?

### 2. Add documentation to your models and sources

Now that we've removed all hard-coded references to our source data, we should document our models and sources.

Things to think about:
* Do I have any repeated definitions that I should use doc blocks for?
* What information is important in a column definition?

### 3. Add a new source table to the project

A new table has arrived in our warehouse, `deliveries`. The `deliveries` table looks like this:

| id | order_id | picked_up_at     | delivered_at     | status    | _synced_at       |
|----|----------|------------------|------------------|-----------|------------------|
| 1  | 1        | 2020-01-01 08:45 | 2020-01-01 09:12 | delivered | 2020-06-01 12:13 |
| 2  | 2        | 2020-01-01 08:57 | 2020-01-01 09:10 | delivered | 2020-06-01 12:13 |
| 3  | 3        | 2020-01-01 09:01 |                  | cancelled | 2020-06-01 12:13 |

We want to add this table as a source to our project.

### 4. Add delivery time to the orders model

Now that we have our new `deliveries` data, our partnerships team wants to know how long deliveries took for each order.

Add `delivery_time_from_collection` and `delivery_time_from_order` to your `orders` model. The column should contain the amount of time in minutes that it took to for the order to be delivered from collection and ordering respectively.

### 5. Add average delivery times to the customers model

We've got two new columns in our `orders` model. Our retention team wants to understand how the average delivery times affect customer churn.

Add `average_delivery_time_from_collection` and `average_delivery_time_from_order` to your `customers` model. This field will be used by the retention team to correlate delivery times and customer retention.

### 6. [Optional] Final Cleanup

Are there any final changes you want to make? Any models you want to refactor? Any documentation you want to add?