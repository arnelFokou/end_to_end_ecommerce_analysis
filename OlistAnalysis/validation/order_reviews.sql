/*
------------------------------------------------------------
Validation: Reviews Table

Purpose:
Validate data quality before creating STG_REVIEWS.

Validation Summary

✓ The expected grain of one row per order review was confirmed using order_id.

✓ review_id values are intentionally reused across multiple orders and therefore are not suitable as a unique identifier.

✓ The combination of (order_id, review_id) uniquely identifies each review record.

✓ NULL values in review_comment_title and review_comment_message represent customers submitting ratings without optional written feedback.

✓ Since the repeated review_id values reflect the business process rather than duplicate data, no records were removed during staging.

✓ No transformations were required beyond selecting the required columns for the staging layer.
------------------------------------------------------------
*/

-- Preview Data
SELECT *
FROM RAW.reviews
LIMIT 10;

-- Row Count
SELECT COUNT(*)
FROM RAW.reviews;

-- Grain Validation (Review ID)
SELECT
    review_id,
    COUNT(*)
FROM RAW.reviews
GROUP BY review_id
HAVING COUNT(*) > 1;

-- Grain Validation (Order ID)
SELECT
    order_id,
    COUNT(*)
FROM RAW.reviews
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Business Investigation
SELECT *
FROM RAW.reviews
WHERE order_id = '169d7e0fd71d624d306f132acd791cbe';

SELECT *
FROM RAW.reviews
WHERE order_id = 'c88b1d1b157a9999ce368f218a407141';

-- Composite Key Validation
SELECT
    order_id,
    review_id,
    COUNT(*)
FROM RAW.reviews
GROUP BY
    order_id,
    review_id
HAVING COUNT(*) > 1;

-- Review IDs Appearing More Than Twice
SELECT
    review_id,
    COUNT(*)
FROM RAW.reviews
GROUP BY review_id
HAVING COUNT(*) > 2;

-- Sample Investigation
SELECT *
FROM RAW.reviews
WHERE review_id = '2172867fd5b1a55f98fe4608e1547b4b';

SELECT *
FROM RAW.reviews
WHERE review_id = '0c76e7a547a531e7bf9f0b99cba071c1';

-- NULL Validation
SELECT *
FROM RAW.reviews
WHERE review_comment_title IS NULL
  AND review_comment_message IS NULL;

-- Data Type Validation
DESCRIBE TABLE RAW.reviews;

-- Post-Transformation Validation
SELECT COUNT(*)
FROM STAGING.stg_reviews;

SELECT *
FROM STAGING.stg_reviews
LIMIT 10;