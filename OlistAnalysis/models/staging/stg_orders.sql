/*
------------------------------------------------------------
Table: STG_ORDERS

Purpose:
Prepare order-level data for downstream analytics while
preserving the original business information.

Source:
RAW.orders

Transformations:
- Preserve all order lifecycle timestamps
- Retain NULL values representing valid business scenarios
- No filtering or cleansing applied
------------------------------------------------------------
*/


SELECT
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
FROM {{source('olist', 'orders')}}