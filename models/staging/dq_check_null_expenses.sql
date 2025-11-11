{{config(materialized = 'table',
database = 'RAW',
alias = 'DQ_CHECK_NULL')}}

with dq_check as(
    {{check_null(ref('stg_expense_claims'),['claim_id','employee_id','claim_date']
    )}}
)

select *
from dq_check
where null_check_status = 'FAIL'