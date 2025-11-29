SELECT
    anio,
    cultivo_nombre,
    SUM(superficie_sembrada_ha) AS Superficie_Sembrada_Total_HA
FROM
    granos_argentina
GROUP BY
    anio,
    cultivo_nombre
ORDER BY
    cultivo_nombre,
    anio;