{{ config(
    materialized= 'dynamic_table',
    snowflake_warehouse = 'compute_wh',
    database = 'snowflake_dt',
    schema = 'Transform_DT',
    target_lag = 'downstream'
)}}


WITH accessory_dt AS (
  SELECT
    a.cust_id,
    a.acc_id,
    a.acc_category,
    a.acc_status,
    a.acc_price,
    a.acc_count
  FROM SNOWFLAKE_DT.PUBLIC.ACCESSORY_ITEM a
  JOIN (
    SELECT
      cust_id,
      acc_id,
      MAX(acc_price) AS max_price
    FROM SNOWFLAKE_DT.PUBLIC.ACCESSORY_ITEM
    GROUP BY cust_id, acc_id
  ) mp
    ON  a.cust_id  = mp.cust_id
    AND a.acc_id   = mp.acc_id
    AND a.acc_price = mp.max_price
)
SELECT *
FROM accessory_dt
