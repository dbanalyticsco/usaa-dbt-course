## Lab 1: Runs, Sources and Docs

### 1. Re-factor your current model by creating two new staging models

So far, we've created one model. That model references two raw tables from our warehouse and 'cleans' up some of that data. Create two new models, `stg_ecomm__orders` and `stg_ecomm__customers`, that do that clean-up. Then, re-factor our existing model to reference those staging models.

<details>
  <summary>Click to see step-by-step guide.</summary>
  
  (a) This would be the first step.
</details>

### 2. Add sources to the project

Refactor your project from your pre-work by adding in sources wherever you had hard-coded references to the `ecomm` tables.

Things to think about:
* Do you want the source name to be the same as the schema name?
* Should you be applying a source freshness check to the data?

### 3. Add documentation to your models and sources

Now that we've removed all hard-coded references to our source data, we should document our models and sources.

Things to think about:
* Do I have any repeated definitions that I should use doc blocks for?
* What information is important in a column definition?

### 4. Add a new source table to the project

A new table has arrived in our warehouse, `deliveries`. The `deliveries` table looks like this:

| id | order_id | picked_up_at     | delivered_at     | status    | _synced_at       |
|----|----------|------------------|------------------|-----------|------------------|
| 1  | 1        | 2020-01-01 08:45 | 2020-01-01 09:12 | delivered | 2020-06-01 12:13 |
| 2  | 2        | 2020-01-01 08:57 | 2020-01-01 09:10 | delivered | 2020-06-01 12:13 |
| 3  | 3        | 2020-01-01 09:01 |                  | cancelled | 2020-06-01 12:13 |

We want to add this table as a source to our project.

### 5. Create an `orders` model that includes delivery time dimensions

Now that we have our new `deliveries` data, our partnerships team wants to know how long deliveries took for each order.

Create an `orders` model that `delivery_time_from_collection` and `delivery_time_from_order`. The column should contain the amount of time in minutes that it took to for the order to be delivered from collection and ordering respectively.

### 6. Add average delivery times to the customers model

We've got two new columns in our `orders` model. Our retention team wants to understand how the average delivery times affect customer churn.

Add `average_delivery_time_from_collection` and `average_delivery_time_from_order` to your `customers` model. This field will be used by the retention team to correlate delivery times and customer retention.

### 7. [Optional] Final Cleanup

Are there any final changes you want to make? Any models you want to refactor? Any documentation you want to add?