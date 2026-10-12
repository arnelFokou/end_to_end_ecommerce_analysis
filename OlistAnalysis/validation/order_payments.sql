/*
------------------------------------------------------------
Validation: Payments Table

Purpose:
Validate data quality before creating STG_PAYMENTS.

Validation Summary

✓ The expected grain of one row per payment transaction was confirmed using the composite key (order_id, payment_sequential).

✓ Multiple payment records per order were validated as expected business behavior, as orders can be paid using multiple transactions or payment methods.

✓ payment_sequential values repeat across different orders and therefore are not unique on their own.

✓ No NULL values were identified in payment_value.

✓ No transformations were required beyond selecting the required columns for the staging layer.
------------------------------------------------------------
*/

-- Preview Data
SELECT *
FROM RAW.payments
LIMIT 10;

-- Row Count
SELECT COUNT(*)
FROM RAW.payments;

-- Grain Validation (Order)
SELECT
    order_id,
    COUNT(*)
FROM RAW.payments
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Grain Validation (Payment Sequence)
SELECT
    payment_sequential,
    COUNT(*)
FROM RAW.payments
GROUP BY payment_sequential
HAVING COUNT(*) > 1;

-- Composite Key Validation
SELECT
    order_id,
    payment_sequential,
    COUNT(*)
FROM RAW.payments
GROUP BY
    order_id,
    payment_sequential
HAVING COUNT(*) > 1;

-- NULL Validation
SELECT *
FROM RAW.payments
WHERE payment_value IS NULL;

-- Data Type Validation
DESCRIBE TABLE RAW.payments;

-- Post-Transformation Validation
SELECT COUNT(*)
FROM STAGING.stg_payments;

SELECT *
FROM STAGING.stg_payments
LIMIT 5;

DESCRIBE TABLE STAGING.stg_payments;