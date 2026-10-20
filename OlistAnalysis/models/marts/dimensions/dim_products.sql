
-- ------------------------------------------------------------------
-- Model: DIM_PRODUCTS
--
-- Purpose:
-- Creates the product dimension by combining product attributes
-- with their English category names for business-friendly reporting.
--
-- Grain:
-- One row per product_id.
--
-- Sources:
-- - STG_PRODUCTS
-- - STG_CATEGORY_NAME_TRANSLATION
--
-- Notes:
-- - Preserves all products using a LEFT JOIN.
-- - Adds English category names to improve readability in
--   downstream SQL analysis and Power BI dashboards.
-- ------------------------------------------------------------------

SELECT
    p.product_id,
    t.product_category_name_english
FROM {{ ref('stg_products') }} p

LEFT JOIN {{ ref('stg_product_category_translation') }} t
    ON p.product_category_name = t.product_category_name