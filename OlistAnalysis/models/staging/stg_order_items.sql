/*
------------------------------------------------------------
Table: STG_ORDER_ITEMS

Purpose:
Prepare order line item data for downstream analytics while
preserving the original transactional information.

Source:
RAW.order_items

Transformations:
- Preserve the original order item records
- Retain product, seller, pricing, and freight information
- No filtering or data cleansing applied
------------------------------------------------------------
*/

SELECT
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value
FROM {{source('olist', 'order_items')}}