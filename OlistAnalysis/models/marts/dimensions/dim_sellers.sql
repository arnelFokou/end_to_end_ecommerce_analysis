-- ------------------------------------------------------------------
-- Model: DIM_SELLERS
--
-- Purpose:
-- Creates a seller dimension containing the seller identifier
-- and derived geographic region for seller performance analysis.
--
-- Grain:
-- One row per seller_id.
--
-- Source:
-- STG_SELLERS
--
-- Transformations:
-- - Retain seller_id as the seller's identifier.
-- - Derive seller_region from seller_state using the
--   region_from_state macro.
--
-- Output:
-- A simplified seller dimension designed to support geographic
-- comparisons and seller performance analysis in Power BI.
--
-- Notes:
-- - Unnecessary location attributes have been excluded to keep
--   the model focused on the project's analytical requirements.
-- - Used to enrich FACT_ORDER_ITEMS through seller_id.
-- ------------------------------------------------------------------


SELECT
    seller_id,
    {{ region_from_state('seller_state') }} as seller_region


FROM {{ ref('stg_sellers') }}