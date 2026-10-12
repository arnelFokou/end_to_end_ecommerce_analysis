-- ------------------------------------------------------------------
-- Model: DIM_DATE
--
-- Purpose:
-- Creates a reusable calendar dimension to support time-based
-- analysis across the analytics models and Power BI dashboards.
--
-- Grain:
-- One row per calendar date.
--
-- Source:
-- Generated using Snowflake's GENERATOR function.
--
-- Notes:
-- - Covers the date range from 2015-01-01.
-- - Includes commonly used calendar attributes such as year,
--   quarter, month, week, day, and weekend flag.
-- ------------------------------------------------------------------


-- Dimension calendrier
-- Grain : une ligne par date

WITH RECURSIVE calendar(full_date) AS (

    SELECT CAST('2015-01-01' AS DATE)

    UNION ALL

    SELECT CAST(DATEADD(day, 1, full_date) AS DATE)
    FROM calendar
    WHERE full_date < CAST('2026-01-02' AS DATE)

)

SELECT
    full_date,
    EXTRACT(YEAR FROM full_date) AS year,
    EXTRACT(QUARTER FROM full_date) AS quarter,
    EXTRACT(MONTH FROM full_date) AS month,
    TO_CHAR(full_date, 'Month') AS month_name,
    EXTRACT(WEEK FROM full_date) AS week_of_year,
    EXTRACT(DAY FROM full_date) AS day,
    TO_CHAR(full_date, 'Day') AS day_name,
    CASE
        WHEN EXTRACT(DOW FROM full_date) IN (0, 6) /*0 match to sunday and 6 for saturday */
        THEN TRUE
        ELSE FALSE
    END AS is_weekend
FROM calendar
