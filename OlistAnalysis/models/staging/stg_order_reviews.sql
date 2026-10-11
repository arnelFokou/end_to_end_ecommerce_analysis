/*
------------------------------------------------------------
Table: STG_REVIEWS

Purpose:
Prepare customer review data for downstream analytics while
preserving the original review information.

Source:
RAW.reviews

Transformations:
- Preserve all review records
- Retain review scores, comments, and timestamps
- No filtering or data cleansing applied
------------------------------------------------------------
*/

SELECT
    order_id,
    review_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
FROM {{source('olist', 'order_reviews')}}