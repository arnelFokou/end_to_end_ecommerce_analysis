-- ------------------------------------------------------------------
-- Model: FACT_CUSTOMER_ORDERS
--
-- Purpose:
-- Creates the primary customer order fact table by integrating order,
-- customer, order item, and calendar data into a single analytical
-- model. This fact table serves as the foundation for customer
-- analytics, revenue analysis, retention, CLTV, repeat purchase, fulfillment analysis,
-- and executive reporting.
--
-- Grain:
-- One row per order_id.
--
-- Sources:
-- - STG_ORDERS
-- - STG_ORDER_ITEMS
--
-- References:
-- - DIM_CUSTOMERS
-- - DIM_DATE
--
-- Measures:
-- - order_value
-- - freight_value
--
-- Design Decisions:
-- - Uses DIM_CUSTOMERS via ref() to retrieve customer_unique_id,
--   ensuring each customer is consistently represented across
--   multiple orders.
--
-- - Uses DIM_DATE via ref() instead of deriving calendar attributes
--   repeatedly, providing a reusable and standardized calendar
--   dimension for downstream analysis.
--
-- - Aggregates item-level price and freight into order-level
--   measures to match the grain of one row per order.
-- ------------------------------------------------------------------



select
    o.order_id,
    dc.customer_unique_id,
    o.order_status,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    dd.full_date,

    SUM(oi.price) AS order_value,
    SUM(oi.freight_value) AS freight_value


from {{ref ('stg_orders') }} o

join {{ref ('dim_customers') }} dc
    on dc.customer_id = o.customer_id

join {{ref ('dim_date')}} dd
    on dd.full_date = date(o.order_purchase_timestamp)

join {{ref ('stg_order_items')}} oi
    on oi.order_id = o.order_id

group by 
    o.order_id,
    dc.customer_unique_id,
    o.order_status,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    dd.full_date