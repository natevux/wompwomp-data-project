WITH year as (
    SELECT 
        name_first,
        name_last,
        nat,
        YEAR(updated_at) - year_born as age,
        YEAR(updated_at) - member_since as member_time
    FROM {{ ref('src_users') }}
)
SELECT 
    nat as Nationality,
    AVG(age) as average_age_users,
    AVG(member_time) as average_user_history
FROM
    year
GROUP BY nat
ORDER BY average_age_users DESC