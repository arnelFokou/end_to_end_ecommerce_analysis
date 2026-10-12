/*
------------------------------------------------------------
Validation: Sellers Table

Purpose:
Validate data quality before creating STG_SELLERS.

Validation Summary

✓ The expected grain of one row per seller_id was confirmed.

✓ No NULL values were identified in seller_state.

✓ Seller location information was complete and required no data cleansing.

✓ No transformations were required beyond selecting the required columns for the staging layer.
------------------------------------------------------------
*/

-- Preview Data
SELECT *
FROM RAW.sellers
LIMIT 10;

-- Row Count
SELECT COUNT(*)
FROM RAW.sellers;

-- Grain Validation
SELECT
    seller_id,
    COUNT(*)
FROM RAW.sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;

-- NULL Validation
SELECT *
FROM RAW.sellers
WHERE seller_state IS NULL;

-- Data Type Validation
DESCRIBE TABLE RAW.sellers;

-- Post-Transformation Validation
SELECT COUNT(*)
FROM STAGING.stg_sellers;

SELECT *
FROM STAGING.stg_sellers
LIMIT 10;

DESCRIBE TABLE STAGING.stg_sellers;