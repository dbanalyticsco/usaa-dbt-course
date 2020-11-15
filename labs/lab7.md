## Lab 7: Environments, Deployment, and the SDLC

### 1. Set up a new deployment environment

You don't have a deployment environment set up in dbt Cloud for your project yet. 

Set up a new deployment environment, using dbt 0.18.1 and have the models build into a schema called production_[first initial + last name]. (This is so your production models don't conflict with each other.)

It's hard to test this without a 'job', so...

### 2. Set up a production job 

Set up a job that runs every day at 6am (in your timezone) that does the following:
* Checks your sources aren't stale.
* Tests all your source data
* Uploads seed data
* Runs all your models
* Tests all your models, but not sources

Once you've got the job set up, kick it off manually to make sure everything runs/passes. If it doesn't, push the necessary changes.

### 3. Open a pull request

Turn on 'run on pull request' on your production job. Then make a small change to your project on a new branch, commit the change, and then open a pull request.

If everything is working correctly, there should be a new run in your dbt project testing your new changes.