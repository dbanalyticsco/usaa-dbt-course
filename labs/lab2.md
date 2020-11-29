## Lab 2: Jinja and Testing

## Kick-off Discussion Questions

1. What are instances where more testing would have been useful at USAA? What was the issue? What test would you have added?
2. What are some examples of SQL that you've written recently that might benefit from using Jinja?

### 1. Make sure our models have primary keys

We've got two models, `orders` and `customers`. Each should have a primary key. We want to make sure that the primary keys are unique and not null.

Things to think about:
* If the tests fail, is there a problem with our query?

### 2. Add columns to your customers table that contain how many orders the customer had in the last 30, 90 and 360 days.

More work for our retention team. They want to easily be able to see how order patterns affect customer behaviour. They want to be able to easily write a query that would tell them how many customers have more than 5 orders in the last 30 days.

Things to think about:
* Are there ways that Jinja could be helpful here?

### 3. Add a test to ensure all the delivery time columns are greater than zero (if not null)

In the last lab, we added two columns to each of the `orders` and `customers` tables. In theory, when populated, they should always be greater than zero. We'll need to write a custom schema test that ensures that's always the case.

### 4. Add a test to ensure that the number of orders in the last 90 days from our `customers` table doesn't exceed the total number of orders in our `orders` table.

Having added the new columns in step 2, we want to double-check that the sum of the column on the `customers` model doesn't exceed the total number of orders in our `orders` model.

Given the specificity of this test, we likely don't want to write a custom schema test. Could we use a data test to do it?