/*
------------------------------------------------------------
Validation: Orders Table

Purpose:
Validate data quality before creating STG_ORDERS.

Validation Summary

✓ The expected grain of one row per order_id was confirmed.

✓ Multiple orders per customer are expected and align with the business process.

✓ NULL values in order lifecycle timestamps were validated as legitimate business scenarios for cancelled, unavailable, and in-progress orders.

✓ Order status values were reviewed and found to be consistent.

✓ No data cleansing was required. The staging layer preserves the original order lifecycle information.
------------------------------------------------------------
*/

-- Preview Data
SELECT *
FROM RAW.orders
LIMIT 10;

-- Row Count
SELECT COUNT(*)
FROM RAW.orders;

-- Grain Validation (Customer)
SELECT
    customer_id,
    COUNT(*)
FROM RAW.orders
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Grain Validation (Order)
SELECT
    order_id,
    COUNT(*)
FROM RAW.orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- NULL Validation
SELECT *
FROM RAW.orders
WHERE order_approved_at IS NULL;

SELECT *
FROM RAW.orders
WHERE order_delivered_carrier_date IS NULL;

SELECT *
FROM RAW.orders
WHERE order_delivered_customer_date IS NULL;

SELECT *
FROM RAW.orders
WHERE order_estimated_delivery_date IS NULL;

-- Business Value Validation
SELECT DISTINCT order_status
FROM RAW.orders;

-- Post-Transformation Validation
SELECT COUNT(*)
FROM STAGING.stg_orders;

SELECT *
FROM STAGING.stg_orders
LIMIT 10;

DESCRIBE TABLE STAGING.stg_orders;