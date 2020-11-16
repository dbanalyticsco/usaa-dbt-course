## Lab 9: Snowflake Specifics in dbt

### Kick-Off Discussion
* How much of what we just discussed is already in place at USAA?
* How much of what we just discussed would be useful to implement at USAA?
* What would be the right fields to cluster by in the `customers` model?
* What would be the right fields to cluster by in the `orders` model?

### 1. Run the orders model with a larger warehouse.

Despite making the `orders` model, it's still taking too long to build. Add a configuration to the orders model that has it run with the larger `compute_wh_xl` warehouse.

Things to think about:
* How do you verify that it's actually building with the new warehouse setting?

### 2. Write a macro to clone your production environment

This step assumes you ran a successful production run in lab 7. If you did not, go and do so now.

As a result of increasing run times in development, we want to set up a way for developers to clone the production schema into their own schema when they start developing.

Write a macro to clone your production environment into your target environment.

### 3. Add query tags to all dbt models

Because dbt queries can come from a long-list of users (all of you), we want to add a query tag 'dbt_run' to all queries executed by dbt.

Add the query tag to your project and then verify that it's working.

### 4. Add a `cluster_by` config to the orders model

While our orders model now builds quickly, it's still very slow to query.

Add a `cluster_by` config to the `orders` model, based on what you think the most common query pattern will be.