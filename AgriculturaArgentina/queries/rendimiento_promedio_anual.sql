SELECT
    anio,
    cultivo_nombre AS grano,
    AVG(rendimiento_kgxha) AS rendimiento_prom_anual_kgxha
FROM
    granos_argentina
GROUP BY
    anio,
    cultivo_nombre;
