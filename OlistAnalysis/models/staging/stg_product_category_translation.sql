/*
------------------------------------------------------------
Table: STG_PRODUCT_CATEGORY_TRANSLATION

Purpose:
Prepare the product category translation lookup table for
downstream analytics by preserving the mapping between
Portuguese and English category names.

Source:
RAW.translation

Transformations:
- Preserve the original category mapping
- No filtering or data cleansing applied
------------------------------------------------------------
*/


SELECT
    product_category_name,
    product_category_name_english
FROM {{source('olist', 'product_category_name_translation')}}