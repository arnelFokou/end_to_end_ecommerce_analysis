
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
    p.product_category_name,
    t.product_category_name_english,
    p.product_name_length,
    p.product_description_length,
    p.product_photos_qty,
    p.product_weight,
    p.product_length,
    p.product_height,
    p.product_width

FROM {{ ref('stg_products') }} p

LEFT JOIN {{ ref('stg_product_category_translation') }} t
    ON p.product_category_name = t.product_category_name