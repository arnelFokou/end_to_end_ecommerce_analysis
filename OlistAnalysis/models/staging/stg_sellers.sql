/*
------------------------------------------------------------
Table: STG_SELLERS

Purpose:
Prepare seller master data for downstream analytics while
preserving the original seller information.

Source:
RAW.sellers

Transformations:
- Preserve seller identifiers and location attributes
- No filtering or data cleansing applied
------------------------------------------------------------
*/


SELECT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
FROM {{source('olist', 'sellers')}}