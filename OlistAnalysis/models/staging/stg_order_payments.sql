/*
------------------------------------------------------------
Table: STG_PAYMENTS

Purpose:
Prepare payment transaction data for downstream analytics
while preserving the original payment information.

Source:
RAW.payments

Transformations:
- Preserve all payment transaction records
- Retain payment method, installments, and payment value
- No filtering or data cleansing applied
------------------------------------------------------------
*/

SELECT
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
FROM {{source('olist', 'order_payments')}}