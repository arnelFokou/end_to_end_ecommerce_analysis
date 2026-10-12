/*
------------------------------------------------------------
Validation: Geolocation Table

Purpose:
Validate data quality before creating STG_GEOLOCATION.

Validation Summary

✓ ZIP codes are not unique because a ZIP code can contain multiple geographic coordinates.

✓ Exact duplicate coordinate records were identified.

✓ Duplicate records were removed using SELECT DISTINCT.

✓ No trimming was required for city or state values.

------------------------------------------------------------
*/
-- Preview Data
SELECT *
FROM RAW.location
LIMIT 10;

-- Row Count
SELECT COUNT(*)
FROM RAW.location;

-- Grain Validation - a zip code can be associated to differents cities
SELECT
    geolocation_zip_code_prefix,
    COUNT(*)
FROM RAW.location
GROUP BY geolocation_zip_code_prefix
HAVING COUNT(*) > 1;

-- Duplicate Coordinate Validation - we have duplicate records in the table so we have to delete them
SELECT
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    COUNT(*)
FROM RAW.location
GROUP BY
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng
HAVING COUNT(*) > 1;

-- Validate Multiple Coordinates per ZIP Code
SELECT
    geolocation_zip_code_prefix,
    COUNT(DISTINCT geolocation_lat || ',' || geolocation_lng) AS coordinate_count
FROM RAW.location
GROUP BY geolocation_zip_code_prefix
ORDER BY coordinate_count DESC;

-- Sample Investigation
SELECT *
FROM RAW.location
WHERE geolocation_zip_code_prefix = '11542';

SELECT *
FROM RAW.location
WHERE geolocation_zip_code_prefix = '11542'
  AND geolocation_lat = -23.912500500000000
  AND geolocation_lng = -46.462945500000004;

SELECT *
FROM RAW.location
WHERE geolocation_zip_code_prefix = '11680'
  AND geolocation_lat = -23.442288300801300
  AND geolocation_lng = -45.085428940593870;

SELECT *
FROM RAW.location
WHERE geolocation_zip_code_prefix = '11610';

-- NULL Validation
SELECT *
FROM RAW.location
WHERE geolocation_state IS NULL;

-- Data Types
DESCRIBE TABLE RAW.location;

-- Whitespace Validation -- presence of whitespace so need to trim this column
SELECT
    LENGTH(geolocation_city) AS original_length,
    LENGTH(TRIM(geolocation_city)) AS trimmed_length
FROM RAW.location;

SELECT
    LENGTH(geolocation_state) AS original_length,
    LENGTH(TRIM(geolocation_state)) AS trimmed_length
FROM RAW.location;

-- Post-Transformation Validation
SELECT COUNT(*)
FROM STAGING.stg_location;

SELECT *
FROM STAGING.stg_location
LIMIT 10;

SELECT
    zip_code,
    latitude,
    longitude,
    COUNT(*)
FROM STAGING.stg_location
GROUP BY
    zip_code,
    latitude,
    longitude
HAVING COUNT(*) > 1;