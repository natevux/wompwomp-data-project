{{
    config(
        materialized = 'table',
        on_schema_change = 'fail'
    )
}}

with users as (
    SELECT * 
    FROM {{ ref('src_users') }}
)
SELECT
    name_first,
    name_last,
    gender,
    city,
    location_state,
    nat,
    YEAR(updated_at) - year_born as age,
    YEAR(updated_at) - member_since as member_time,
FROM 
    users