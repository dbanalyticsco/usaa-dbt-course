## Lab 3: Snapshots and Seeds

### Kick-off discussion

* Are there any tables at USAA that would benefit from being snapshotted?
* Are there any instances where having a snapshot table would have solved a problem at USAA?
* Share some of your best `case when` horror stories.
* Are there any at USAA that would benefit from a seed file?

### 1. Snapshot the customers table

Our application doesn't keep track of changes to any of the tables. When a record is updated, the prior state is lost as far as the application is concerned. From an analytics point of view, the full history would be really beneficial. 

Set up a snapshot model on the `customers` source table (not the model).

Things to think about:
* What type of snapshot strategy is best for this table?
* What database and schema should it get built in?

### 2. Snapshot the orders table

Similarly, we want a snapshot of the `orders` source table. Set another snapshot up for that table.

Things to think about:
* What type of snapshot strategy is best for this table?
* Should this snapshot get built in the same database and schema as the other snapshot?

### 3. Add the stores seed file to our project

There's a `store_id` column on the `orders` table that we haven't leveraged yet. It looks like it _should_ join to a stores table, but it doesn't seem to exist in our application database.

It turns out, the engineers haven't yet built that table. 

Create a seed file with the store IDs and names. Add a number column to our `orders` model called `store_name`.
