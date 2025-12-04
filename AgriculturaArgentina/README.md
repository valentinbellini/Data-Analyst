# Agricultura Argentina (maiz, soja y trigo)

If prefer: [Link to english readme.md](README_EN.md)

Se presenta un análisis basado en los datos del portal del gobierno sobre la siembre, cosecha, producción y rendimientos de los principales granos en Argentina. La información proviene de 3 datasets distintos cuyas fuentes se mencionan a continuación:

- [Maiz](https://datos.gob.ar/dataset/agroindustria-maiz---siembra-cosecha-produccion-rendimiento/archivo/agroindustria_9a6a02f8-ef58-4250-87c2-f639fec502f1)
- [Soja](https://datos.gob.ar/dataset/agroindustria-soja---siembra-cosecha-produccion-rendimiento/archivo/agroindustria_ba694aa3-99d2-4d7d-9936-60f88e36ad9a)
- [Trigo](https://datos.gob.ar/dataset/agroindustria-trigo---siembra-cosecha-produccion-rendimiento/archivo/agroindustria_50f0edcc-4dfc-4afb-b78a-b164601d36ae)

Los tres conjuntos de datos tienen el mismo formato en sus columnas:

| Título de la columna          | Tipo de dato                | Descripción                                   |
|-------------------------------|-----------------------------|-----------------------------------------------|
| cultivo_nombre               | Texto (string)              | Nombre del cultivo.                           |
| anio                         | Número entero (integer)     | Año a que corresponden los datos.             |
| campania                    | Texto (string)              | Campaña en la que se desarrolló el cultivo.   |
| provincia_nombre             | Texto (string)              | Nombre de la provincia.                       |
| provincia_id                 | Texto (string)              | Código de la provincia.                       |
| departamento_nombre          | Texto (string)              | Nombre del departamento.                      |
| departamento_id              | Texto (string)              | Código del departamento.                      |
| superficie_sembrada_ha       | Número entero (integer)     | Superficie sembrada en hectáreas.             |
| superficie_cosechada_ha      | Número entero (integer)     | Superficie cosechada en hectáreas.            |
| produccion_tm                | Número entero (integer)     | Producción en toneladas.                      |
| rendimiento_kgxha            | Número entero (integer)     | Rendimiento en kilos por hectárea.            |

---

## Data Cleaning

Se realiza una limpieza de los datos previo a unificar los tres datasets en uno solo. Se buscan incosistencias, valores nulos que puedan afectar resultados y se ajustan las fechas de la serie de tiempo para evaluar los mismos períodos en todos los granos.

### Datatype
Debido a que los tipos de datos para algunas de las columnas son distintas, se unificarán los mismos para poder concatenar todos los datasets en uno mismo.

### Filter date
- Serie maiz: 1923-2023
- Serie soja: 1941-2023
- Serie trigo: 1927-2024

Se tomará la intersección entre ambos para hacer un análisis en la serie *(1941-2023)*.

### EDA

Las siguientes reglas se aplican a los datos:

* **Siembra nula:** Entradas donde la (`superficie_sembrada_ha`) es nula, son documentados y removidos, ya que una superficie sembrada de 0 ha es irrelevante para el análisis.
* **Cosecha perdida** Si la superficie sembrada es mayor a cero pero `superficie_cosechada_ha` es nulo (o cero), la entrada se mantiene y se interpreta como una pérdida en la cosecha (plaga, mal clima, etc) y esta es relevante para las estadísticas.
* **Valores negativos:** Entradas con valores numéricos negativos son eliminadas.
* **Inconsistencias:** Entradas donde la cosecha es mayor a la siembr (`superficie_cosechada_ha > superficie_sembrada_ha`) son corregidas o eliminadas.
* **Rendimiento Nulo:** Si la siembra $> 0$ y la cosecha $> 0$, pero el rendimiento (`rendimiento_kgxha`) es $0$, se elimina la entrada.
* **Outliers:** Entradas con rendimientos mayores a los máximos definidos en el programa (`MAX_YIELD_SOY`, `MAX_YIELD_CORN`) son tomados como outliers que afectan las estadísticas y son eliminados.
### Exportar a CSV

Se exportan los datos limpios a un nuevo [CSV](datasets/granos_argentina_1941_2023.csv)

## Data Analysis

* Se calcula el porcentaje de cosecha sobre la siembre de cada entrada para agregarlo en una nueva columna antes de exportar a la base de datos.
* Se guardan los resultados en una base de datos: Granos_Argentina.db
* Se definen funciones para leer query y tenerlas almacenadas en extensiones .sql *`('load_query' y 'run_query')`*

### Consultas realizadas.

1. Producción total y rendimiento promedio por año y grano: [produccion_anual.sql](queries/produccion_anual.sql)
2. Producción y siembra total por provincia y grano: para identificar las provincias más importantes para cada cultivo: [produccion_por_provincia.sql](queries/produccion_por_provincia.sql)
3. Rendimiento Promedio de los cultivos a lo largo del tiempo: [rendimiento_promedio_anual.sql](queries/rendimiento_promedio_anual.sql)

## Visualización

Se utiliza el CSV granos_argentina_1941_2023 para generar las visualizaciones en [Tableau](https://public.tableau.com/views/HistoriadegranosenArgentina/Produccionporprovincia?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link).

![Top provincias en produccion por grano](img/dashboard_provincias.jpg)

