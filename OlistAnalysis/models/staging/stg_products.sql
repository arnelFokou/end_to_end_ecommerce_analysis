/*
------------------------------------------------------------
Table: STG_PRODUCTS

Purpose:
Prepare product master data for downstream analytics by
standardizing column names while preserving the original
product information.

Source:
RAW.products

Transformations:
- Standardize column names
- Preserve product attributes
- Retain NULL values representing missing source information
------------------------------------------------------------
*/

SELECT
    product_id,
    product_category_name,
    product_name_lenght AS product_name_length,
    product_description_lenght AS product_description_length,
    product_photos_qty,
    product_weight_g AS product_weight,
    product_length_cm AS product_length,
    product_height_cm AS product_height,
    product_width_cm AS product_width
FROM {{source ('olist','products')}}