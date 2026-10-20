-- ===============================================================
-- Model: FACT_ORDER_ITEMS
-- ===============================================================
--
-- Purpose
-- Creates the order item fact table by integrating order, customer,
-- product, seller, and calendar information at the individual item
-- level. This model supports product analytics, seller performance,
-- and customer-product insights.
--
-- Grain
-- One row per order_item_id within an order_id.
--
-- Sources
--  STG_ORDER_ITEMS
--  STG_ORDERS
--
-- References
--  DIM_CUSTOMERS
--  DIM_DATE
--
-- Measures
-- price
-- freight_value
--
-- Design Decisions
--   Maintains item-level granularity to enable product and seller
--    analysis without losing detail.
--   Uses DIM_CUSTOMERS via ref() to associate each order item with
--    the corresponding customer_unique_id.
--   Uses DIM_DATE via ref() to provide standardized calendar
--    attributes for time-based reporting.
--   Joins STG_ORDERS to bring in order status and purchase date,
--    which are not available in STG_ORDER_ITEMS.
-- ===============================================================

SELECT

    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,
    o.order_status,
    oi.price,
    oi.freight_value,
    dc.customer_unique_id,
    dd.full_date

FROM {{ ref('stg_order_items') }} oi

JOIN {{ ref('stg_orders') }} o
    ON o.order_id = oi.order_id

JOIN {{ ref('stg_customers') }} dc
    ON o.customer_id = dc.customer_id

JOIN {{ ref('dim_date') }} dd
    ON DATE(o.order_purchase_timestamp) = dd.full_date