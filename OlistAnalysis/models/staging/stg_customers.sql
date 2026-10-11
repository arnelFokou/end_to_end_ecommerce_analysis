/*
------------------------------------------------------------
Table: STG_CUSTOMERS

Purpose:
Prepare customer data for downstream analytics by
standardizing column names while preserving the original
business information.

Source:
RAW.customers

Transformations:
- Rename customer_zip_code_prefix → zip_code
- Rename customer_city → city
- Rename customer_state → state
- Preserve customer identifiers
------------------------------------------------------------
*/

SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix AS zip_code,
    customer_city AS city,
    customer_state AS state
FROM {{source ('olist','customers')}}