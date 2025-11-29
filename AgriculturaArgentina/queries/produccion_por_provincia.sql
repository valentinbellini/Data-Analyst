SELECT 
    provincia_nombre, 
    cultivo_nombre,
    SUM(superficie_sembrada_ha) AS Superficie_Sembrada_Total,
    SUM(produccion_tm) AS Produccion_Total_TM
FROM 
    granos_argentina
GROUP BY 
    provincia_nombre, 
    cultivo_nombre
ORDER BY 
    cultivo_nombre, 
    Produccion_Total_TM DESC;