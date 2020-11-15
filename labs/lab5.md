## Lab 5: Window Functions, Filtering and Calendar Spines

### 1. Add a `days_since_last_order` column to the `orders` model.

It's useful for analysis to know how many days had passed between an order and the prior order (for a given customer). 

Using a window function, add a column `days_since_last_order` to the `orders` model. To make sure you've done it correctly, add a test to ensure that the number, when not-null, is always positive.

### 2. Filter out employees from the orders and customers models

Employees get a discount from our ecommerce shop. While we're very happy for them to have that discount, we want to filter out all of their records from the warehouse.

If you haven't already, create a staging model for the customers data. In the staging model, filter out all emails for the domains `ecommerce.com`, `ecommerce.co.uk`, `ecommerce.ca`.

That filter should fix the customers data, but we still need to add a filter to the `orders` model. Filter out any employee orders.

### 3. Create a `customer__daily` model

Because customers regularly change their addresses, our support team want to know what address a customer had in a system on a given day.

First, create a calendar spine using the dbt-utils package.

Then, create a model called `customer__daily` that uses our snapshot data and the calendar spine to have a record of what a customer looked like on each day since they were created. We want to know their address at the _end_ of the day.

### 4. Write a query that shows rolling 7-day order volumes

You've had a request from the CEO to create a dashboard with the rolling 7-day order amounts. Because some days don't have orders, you think you'll need to use a calendar spine to create it.

Write a query that shows the number of orders on a rolling 7-day basis.

