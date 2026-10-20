/*
    Model: dim_customers

    Purpose:
    Build a customer dimension with one record per unique customer.

    Transformations:
    - Extract customer attributes from stg_customers.
    - Derive the customer's region using the region_from_state macro.
    - Use ROW_NUMBER() to identify duplicate records for each customer_unique_id.
    - Retain only the first record per customer, ordered by customer_id.
    - Rename customer_unique_id to customer_id in the final output.

    Output:
    One row per customer_unique_id, with the customer's ZIP code,
    city, and derived region.

    Note:
    If multiple records exist for the same customer_unique_id,
    the record with the lowest customer_id according to the ordering
    is retained.
*/


with custs as(
select 
    customer_unique_id,
    zip_code,
    city,
    {{ region_from_state('state') }} as  customer_region,
    row_number() over(partition by customer_unique_id order by customer_id) rn
FROM {{ref('stg_customers') }})


select customer_unique_id as customer_id,
    zip_code,
    city,
    customer_region
from custs
where rn = 1

