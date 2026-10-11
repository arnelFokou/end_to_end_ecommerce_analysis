/*
------------------------------------------------------------
Table: STG_GEOLOCATION

Purpose:
Prepare geolocation reference data for downstream analytics by
removing exact duplicate records and standardizing column names.

Source:
RAW.location

Transformations:
- Remove duplicate geolocation records
- Rename geolocation_zip_code_prefix → zip_code
- Rename geolocation_lat → latitude
- Rename geolocation_lng → longitude
- Rename geolocation_city → city
- Rename geolocation_state → state
------------------------------------------------------------
*/

SELECT DISTINCT
    geolocation_zip_code_prefix AS zip_code,
    geolocation_lat AS latitude,
    geolocation_lng AS longitude,
    geolocation_city AS city,
    geolocation_state AS state
FROM {{source('olist', 'geolocation')}}