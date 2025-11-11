SELECT 
claim_id, 
employee_id,
claim_date,
UPPER(expense_type) AS expense_type,
claimed_amount,
LOWER(aaproval_status) AS aaproval_status,
approver_id
FROM RAW.PUBLIC.EXPENSE_CLAIMS

