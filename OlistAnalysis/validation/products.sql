/*
------------------------------------------------------------
Validation: Products Table

Purpose:
Validate data quality before creating STG_PRODUCTS.

Validation Summary

✓ The expected grain of one row per product_id was confirmed.

✓ Multiple products within the same product category were validated as expected business behavior.

✓ NULL values were identified in product_category_name and certain physical attributes (e.g., product_weight_g). These represent missing source information rather than data quality errors.

✓ Since the missing values could not be reliably inferred, they were preserved in the staging layer.

✓ Column names were standardized for consistency, with no additional data transformations applied.
------------------------------------------------------------
*/

-- Preview Data
SELECT *
FROM RAW.products
LIMIT 10;

-- Row Count
SELECT COUNT(*)
FROM RAW.products;

-- Grain Validation
SELECT
    product_id,
    COUNT(*)
FROM RAW.products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Business Value Validation
SELECT
    product_category_name,
    COUNT(*)
FROM RAW.products
GROUP BY product_category_name
HAVING COUNT(*) > 1;

-- NULL Validation
SELECT *
FROM RAW.products
WHERE product_category_name IS NULL;

SELECT *
FROM RAW.products
WHERE product_weight_g IS NULL;

SELECT *
FROM RAW.products
WHERE product_length_cm IS NULL;

SELECT *
FROM RAW.products
WHERE product_height_cm IS NULL;

SELECT *
FROM RAW.products
WHERE product_width_cm IS NULL;

-- Products with Valid Categories
SELECT *
FROM RAW.products
WHERE product_category_name IS NOT NULL;

-- Data Type Validation
DESCRIBE TABLE RAW.products;

-- Post-Transformation Validation
SELECT COUNT(*)
FROM STAGING.stg_products;

SELECT *
FROM STAGING.stg_products
LIMIT 10;

DESCRIBE TABLE STAGING.stg_products;