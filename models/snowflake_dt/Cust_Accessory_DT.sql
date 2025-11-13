{{config(
    materialized = 'dynamic_table',
    snowflake_warehouse = 'compute_wh',
    database = 'snowflake_dt',
    schema = 'Transform_DT',
    target_lag = '3 minutes'
)}}

WITH Cust_Accessory_DT AS (
    SELECT
        c.cust_id,
        c.cust_name,
        c.crid,
        c.location,
        c.cust_created,
        a.acc_id,
        a.acc_category,
        a.acc_status,
        a.acc_price,
        a.acc_count,
        ROUND(a.acc_price / NULLIF(a.acc_count, 0), 2) AS price_per_accessory
    FROM {{ ref('Customer_DT') }} c
    JOIN {{ ref('Accessory_DT') }} a
        ON c.cust_id = a.cust_id
)
SELECT * 
FROM Cust_Accessory_DT