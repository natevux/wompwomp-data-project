SELECT NAT, COUNT(*) as users_count
FROM {{ ref('demograph_info') }}
GROUP BY NAT
ORDER BY users_count desc