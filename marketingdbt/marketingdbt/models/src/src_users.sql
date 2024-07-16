{{
    config(
        materialized = 'incremental',
        unique_key = 'user_id',
        on_schema_change = 'fail'
    )
}}

WITH users AS (
    SELECT * FROM {{ source('marketing','raw_users') }}
)

SELECT
    LOGIN_UUID AS user_id,
    NAME_FIRST,
    NAME_LAST,
    GENDER,
    LOCATION_STREET_NUMBER as street_number,
    LOCATION_STREET_NAME as street_name,
    LOCATION_CITY as city,
    LOCATION_STATE,
    LOCATION_COUNTRY as country,
    LOCATION_POSTCODE as postcode,
    EMAIL,
    LOGIN_USERNAME,
    LOGIN_PASSWORD,
    YEAR(DOB_DATE) AS year_born,
    YEAR(REGISTERED_DATE) AS member_since,
    PHONE,
    NAT,
    CREATED_AT,
    UPDATED_AT
FROM
    users

{% if is_incremental() %}
where UPDATED_AT > (select max(UPDATED_AT) from {{ this }})
{% endif %}
