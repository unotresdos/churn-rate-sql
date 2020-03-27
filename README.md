
#  Calculating Churn Rates Using SQL Queries

Four months into launching Codeflix, management asks you to look into subscription churn rates. It’s early on in the business and people are excited to know how the company is doing.

The marketing department is particularly interested in how the churn compares between two segments of users. Dataset containing subscription data for users who were acquired through two distinct channels.

## Project Data
The dataset provided to you contains one SQL table,  `subscriptions`. Within the table, there are 4 columns:

-   `id`  - the subscription id
-   `subscription_start`  - the start date of the subscription
-   `subscription_end`  - the end date of the subscription
-   `segment`  - this identifies which segment the subscription owner belongs to

## Project Execution

 1.   Determine the range of months of data provided. Which months will you be able to calculate churn for?
 2.   Create a temporary table, `cross_join`, from `subscriptions` and your `months`. Be sure to `SELECT` every column.
 3. Create a temporary table,  `status`, from the  `cross_join`  table you created. This table should contain:

-   `id`  selected from cross_join
-   `month`  as an alias of  `first_day`
-   `is_active_87`  created using a  `CASE WHEN`  to find any users from segment 87 who existed prior to the beginning of the month. This is  `1`  if true and  `0`  otherwise.
-   `is_active_30`  created using a  `CASE WHEN`  to find any users from segment 30 who existed prior to the beginning of the month. This is  `1`  if true and  `0`  otherwise.
 4. Add an `is_canceled_87` and an `is_canceled_30` column to the `status` temporary table. This should be `1` if the subscription is canceled during the month and `0` otherwise.
 5. Calculate the churn rates for the two segments over the three month period. Which segment has a lower churn rate?
 6. Modification of the code for large amount of the segments

## Project Files

- [churn_rate.sql](https://github.com/unotresdos/churn-rate-sql/blob/master/churn_rate.sql)  - SQL query to calculate churn rate 
- [churn_rate_general.sql](https://github.com/unotresdos/churn-rate-sql/blob/master/churn_rate_general.sql)- General SQL queries to calculate churn rate

