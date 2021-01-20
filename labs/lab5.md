## Lab 5: Window Functions, Filtering and Calendar Spines

### 1. Add a `days_since_last_order` column to the `orders` model.

It's useful for analysis to know how many days had passed between an order and the prior order (for a given customer). 

Using a window function, add a column `days_since_last_order` to the `orders` model.

### 2. Filter out employees from the orders and customers models

Employees get a discount from our ecommerce shop. While we're very happy for them to have that discount, we want to filter out all of their records from the warehouse.

If you haven't already, create a staging model for the customers data. In the staging model, filter out all emails for the domains `ecommerce.com`, `ecommerce.co.uk`, `ecommerce.ca`.

That filter should fix the customers data, but we still need to add a filter to the `orders` model. Filter out any employee orders.

### 3. Create a `customer__daily` model

Because customers regularly change their addresses, our support team want to know what address a customer had in a system on a given day.

First, create a calendar spine using the dbt-utils package.

Then, create a model called `customer__daily` that uses our snapshot data and the calendar spine to have a record of what a customer looked like on each day since they were created.

**N.B.**: For the purposes of this exercise, given we don't have our own snapshot data, please use the following table for the snapshot data: `analytics.snapshots_prod.customers_snapshot`.

### 4. Write a query that shows rolling 7-day order volumes

You've had a request from the CEO to create a dashboard with the rolling 7-day order amounts. Because some days don't have orders, you think you'll need to use a calendar spine to create it.

Write a query that shows the number of orders on a rolling 7-day basis.

## Links and Walkthrough Guides

The following links will be useful for these exercises:

* [Snowflake Docs: Functions](https://docs.snowflake.com/en/sql-reference/functions-all.html)
* [Snowflake Docs: Window Functions](https://docs.snowflake.com/en/sql-reference/functions-analytic.html)
* [dbt Docs: Packages](https://docs.getdbt.com/docs/building-a-dbt-project/package-management/)
* [Slides from presentation](https://docs.google.com/presentation/d/1CJCWaFTe0PHJ2K9ltryJdTmZB7k07cYTi4TJisu9LHw/edit?usp=sharing)

Click on the links below for step-by-step guides to each section above.

<details>
  <summary>👉 Section 1</summary>
  
  (1) To calculate `days_since_last_order` we need to add the following SQL (or similar depending on what you've named columns) to our `orders` model. It finds the prior order for a customer and calculates the difference in days between the two `ordered_at` values: 
  ```sql
    datediff('day', lag(ordered_at) over (partition by customer_id order by ordered_at), ordered_at) 
  ```
  (2) Execute `dbt run -m order` to make sure your model runs successfully.
</details>

<details>
  <summary>👉 Section 2</summary>
  
  (1) As discussed in the session, there are a number of different ways we could do this filter. In this instance we'll use an `ilike`. Add the following filter to your customers model:
  ```sql
    where email not ilike '%ecommerce.com'
      and email not ilike '%ecommerce.ca'
      and email not ilike '%ecommerce.co.uk'
  ```
  (2) Add the same filter to your `orders` model. Note that the `email` column isn't likely to already be there so you might need to join it in.
  (3) Execute `dbt run` to make sure your filters work.
</details>

<details>
  <summary>👉 Section 3</summary>
  
  (1) Create a `packages.yml` file in the root directory of your project. Add the following code to it to add the `dbt_utils` package:
  ```yaml
  packages:
    - package: fishtown-analytics/dbt_utils
      version: 0.6.4
  ```   
  (2) Create a new model called `calendar.sql`. Add the following code to it to generate a calendar spine:
  ```sql
  {{ dbt_utils.date_spine(
      datepart="day",
      start_date="to_date('01/01/2020', 'mm/dd/yyyy')",
      end_date="current_date"
    )
  }}
  ```
  (3) Create a new model called `customer__daily.sql`. Add the following SQL:
  ```sql
  with calendar as (

      select *
      from {{ ref('calendar') }}

  ), customers as (

      select *
      from analytics.snapshots_prod.customers_snapshot

  ), joined as (

      select 
          calendar.date_day,
          customers.*
      from calendar
      inner join customers
          on calendar.date_day < coalesce(customers._dbt_valid_to, '2099-01-01')
          and calendar.date_day >= customers._dbt_valid_from

  )

  select *
  from joined
  ```
  (4) Execute `dbt run -m +customer__daily` to make sure your models run successfully.
</details>

<details>
  <summary>👉 Section 4</summary>
  
  (1) Write a SQL query that joins our `orders` and `calendar` models. The join should work in a such a way that the prior 7 days of orders get joined to a given `date_day` in the `calendar` model. That way, you can then aggregate this joined query, grouping by the `date_day` column, in order to count how many orders there were on a rolling 7 day basis.
</details>

