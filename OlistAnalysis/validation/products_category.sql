/*
------------------------------------------------------------
Validation: Product Category Translation Table

Purpose:
Validate data quality before creating
STG_PRODUCT_CATEGORY_TRANSLATION.

Validation Summary

✓ The expected grain of one row per product_category_name was confirmed.

✓ No duplicate category mappings were identified.

✓ No NULL values were found in product_category_name_english.

✓ The translation table serves as a reference lookup and required no data cleansing.

✓ No transformations were required beyond selecting the required columns for the staging layer.
------------------------------------------------------------
*/

-- Preview Data
SELECT *
FROM RAW.translation
LIMIT 10;

-- Row Count
SELECT COUNT(*)
FROM RAW.translation;

-- Grain Validation
SELECT
    product_category_name,
    COUNT(*)
FROM RAW.translation
GROUP BY product_category_name
HAVING COUNT(*) > 1;

-- NULL Validation
SELECT *
FROM RAW.translation
WHERE product_category_name_english IS NULL;

-- Data Type Validation
DESCRIBE TABLE RAW.translation;

-- Post-Transformation Validation
SELECT COUNT(*)
FROM STAGING.stg_category_name_translation;

SELECT *
FROM STAGING.stg_category_name_translation
LIMIT 10;

DESCRIBE TABLE STAGING.stg_category_name_translation;