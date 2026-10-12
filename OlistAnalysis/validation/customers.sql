/*
------------------------------------------------------------
Validation: Customer Table

Purpose:
Validate data quality before creating STG_CUSTOMERS.

Validation Summary

✓ The expected grain of one row per customer_id was confirmed.

✓ No NULL values were found in the primary identifiers or customer attributes.

✓ Column data types were validated and required no changes.

✓ No leading or trailing whitespace was identified in customer_city.

✓ No data cleansing was required. The staging layer only standardizes column names for consistency.
------------------------------------------------------------
*/

-- Row Count - 99 441
SELECT COUNT(*)
FROM RAW.customers;

-- Grain Validation - 0 duplicate values
SELECT
    customer_id,
    COUNT(*)
FROM RAW.customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- NULL Checks - 0 null values for customer_id
SELECT *
FROM RAW.customers
WHERE customer_id IS NULL;

SELECT *
FROM RAW.customers
WHERE customer_unique_id IS NULL;

SELECT *
FROM RAW.customers
WHERE customer_zip_code_prefix IS NULL;

SELECT *
FROM RAW.customers
WHERE customer_city IS NULL;

SELECT *
FROM RAW.customers
WHERE customer_state IS NULL;



-- Whitespace Validation
SELECT DISTINCT customer_city
FROM RAW.customers;

SELECT
    LENGTH(customer_city) AS original_length,
    LENGTH(TRIM(customer_city)) AS trimmed_length
FROM RAW.customers;