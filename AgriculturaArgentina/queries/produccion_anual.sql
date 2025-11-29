SELECT 
    anio, 
    cultivo_nombre,
    SUM(produccion_tm) AS Produccion_Total_TM,
    ROUND(AVG(rendimiento_kgxha), 2) AS Rendimiento_Promedio_kgxha,
    ROUND(AVG(porcentaje_cosechado), 2) AS Porcentaje_Cosechado_Promedio
FROM 
    granos_argentina
GROUP BY 
    anio, 
    cultivo_nombre
ORDER BY 
    cultivo_nombre, 
    anio;