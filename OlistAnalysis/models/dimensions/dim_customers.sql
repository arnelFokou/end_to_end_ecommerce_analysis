-- ------------------------------------------------------------------
-- Model: DIM_CUSTOMERS
--
-- Purpose:
-- Creates the customer dimension by exposing customer identifiers
-- and demographic attributes from the staging layer.
--
-- Grain:
-- One row per customer_id.
--
-- Source:
-- STG_CUSTOMERS
--
-- Note:
-- This dimension was used during the dbt transformation layer to
-- enrich fact tables with customer_unique_id. It was not included
-- in the final Power BI semantic model because the dashboards did
-- not require customer location attributes.
-- ------------------------------------------------------------------

SELECT
    customer_id,
    customer_unique_id,
    zip_code,
    city,
    state
FROM {{ref('stg_customers') }}