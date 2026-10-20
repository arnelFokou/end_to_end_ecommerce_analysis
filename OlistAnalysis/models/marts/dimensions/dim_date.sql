-- ------------------------------------------------------------------
-- Model: DIM_DATE
--
-- Purpose:
-- Creates a reusable calendar dimension to support time-based
-- analysis across the data warehouse and Power BI dashboards.
--
-- Grain:
-- One row per calendar date.
--
-- Source:
-- Calendar dates are generated using a recursive CTE in SQL.
--
-- Transformations:
-- - Generate consecutive dates from 2015-01-01 to 2026-01-03.
-- - Extract calendar attributes: year, quarter, month, week, and day.
-- - Add the month name and day name for reporting purposes.
-- - Identify weekends using the day of the week.
--
-- Output:
-- One row per date with calendar attributes for filtering,
-- grouping, and analyzing business metrics over time.
--
-- Notes:
-- - Weekend identification assumes Sunday = 0 and Saturday = 6
--   for EXTRACT(DOW FROM full_date).
-- ------------------------------------------------------------------

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
