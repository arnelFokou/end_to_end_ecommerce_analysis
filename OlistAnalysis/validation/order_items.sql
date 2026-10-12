/*
------------------------------------------------------------
Validation: Order Items Table

Purpose:
Validate data quality before creating STG_ORDER_ITEMS.

Validation Summary

✓ The expected grain of one row per order item was confirmed using the composite key (order_id, order_item_id).

✓ Multiple line items within the same order were validated as expected business behavior.

✓ order_item_id is only unique within an order and therefore must be combined with order_id to uniquely identify each record.

✓ No NULL values were identified in freight_value.

✓ No transformations were required beyond selecting the required columns for the staging layer.
------------------------------------------------------------
*/

-- Preview Data
SELECT *
FROM RAW.order_items
LIMIT 10;

-- Row Count
SELECT COUNT(*)
FROM RAW.order_items;

-- Grain Validation (Order)
SELECT
    order_id,
    COUNT(*)
FROM RAW.order_items
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Grain Validation (Order Item)
SELECT
    order_item_id,
    COUNT(*)
FROM RAW.order_items
GROUP BY order_item_id
HAVING COUNT(*) > 1;

-- Composite Key Validation
SELECT
    order_id,
    order_item_id,
    COUNT(*)
FROM RAW.order_items
GROUP BY
    order_id,
    order_item_id
HAVING COUNT(*) > 1;

-- NULL Validation
SELECT *
FROM RAW.order_items
WHERE freight_value IS NULL;

-- Data Type Validation
DESCRIBE TABLE RAW.order_items;

-- Post-Transformation Validation
SELECT COUNT(*)
FROM STAGING.stg_order_items;

SELECT *
FROM STAGING.stg_order_items
LIMIT 10;