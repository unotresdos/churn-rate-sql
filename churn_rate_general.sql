 -- 1. First 100 subscription data
 SELECT * 
 FROM subscriptions
 LIMIT 100;
 -- 2. Min and Max months
 SELECT MIN(subscription_start),
        MAX(subscription_start)
 FROM subscriptions;
 -- 3. Temporary table for months
 WITH months AS (
  SELECT 
    '2017-01-01' AS first_day, 
    '2017-01-31' AS last_day 
  UNION 
  SELECT 
    '2017-02-01' AS first_day, 
    '2017-02-28' AS last_day
  UNION 
  SELECT 
    '2017-03-01' AS first_day, 
    '2017-03-30' AS last_day
 ),
 -- 4. Cross Join temporary table (subs+months)
 cross_join AS (
  SELECT *
  FROM subscriptions
  CROSS JOIN months
 ),
 -- 5. Status temporary table 
status AS (
  SELECT 
    id, 
    first_day AS month,
	  segment,
    CASE
      WHEN (subscription_start < first_day) 
        AND (
          subscription_end > first_day 
          OR subscription_end IS NULL
        )
      THEN 1
      ELSE 0
    END AS is_active,
-- 6. Canceled data for both segments
    CASE
      WHEN subscription_end BETWEEN first_day AND last_day 
      THEN 1
      ELSE 0
    END AS is_canceled
  FROM cross_join
),
-- 7. Status Aggregate temporary table
status_aggregate AS (
  SELECT 
    month, segment, 
    SUM(is_active) AS sum_active, 
    SUM(is_canceled) AS sum_canceled
  FROM status 
  GROUP BY month, segment
  ORDER BY 2 DESC
)
-- 8. Calculate churn rate
SELECT month, segment, 
       1.0 * sum_canceled / sum_active AS Churn_rate
FROM status_aggregate;
 
 