
-- ------------------------------------------------------------------
-- Model: DIM_SELLERS
--
-- Purpose:
-- Creates the seller dimension by exposing seller identifiers and
-- location attributes for seller performance analysis.
--
-- Grain:
-- One row per seller_id.
--
-- Source:
-- STG_SELLERS
--
-- Notes:
-- - Provides seller location attributes that can support future
--   geographic and operational analysis.
-- - Used to enrich FACT_ORDER_ITEMS in the Power BI semantic model.
-- ------------------------------------------------------------------

SELECT
    seller_id,
    seller_city,
    seller_state,
    seller_zip_code_prefix

FROM {{ ref('stg_sellers') }}