SELECT color, 
               COUNT(*) AS count,
               ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM vineyards_2024), 2) AS percentage
FROM vineyards_2024
GROUP BY color