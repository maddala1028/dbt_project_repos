{{ config(
    materialized ='dynamic_table'
    , snowflake_warehouse = 'compute_wh'
    , database = 'snowflake_dt'
    , schema = 'Transform_DT'
    , target_lag = 'downstream'

)}}

with Customer_DT as 
(
    SELECT 
    cust_id,cust_name, total_outstanding_amt,CRID,location,CUST_CREATED
    FROM  SNOWFLAKE_DT.public.customer 
    qualify row_number () over (partition by cust_id order by CUST_CREATED desc) = 1
    
)
select * from Customer_DT