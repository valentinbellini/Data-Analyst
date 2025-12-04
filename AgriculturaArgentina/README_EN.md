# 🇦🇷 Argentine Agriculture Analysis (Corn, Soy, and Wheat)

This project presents an analysis based on public government data regarding the planting, harvesting, production, and yields of the main grains in Argentina (Corn, Soy, and Wheat). The information is sourced from three distinct datasets provided by the official Argentine data portal.

## Data Sources

| Grain | URL |
| :--- | :--- |
| **Corn (Maíz)** | https://datos.gob.ar/dataset/agroindustria-maiz---siembra-cosecha-produccion-rendimiento/archivo/agroindustria_9a6a02f8-ef58-4250-87c2-f639fec502f1 |
| **Soy (Soja)** | https://datos.gob.ar/dataset/agroindustria-soja---siembra-cosecha-produccion-rendimiento/archivo/agroindustria_ba694aa3-99d2-4d7d-9936-60f88e36ad9a |
| **Wheat (Trigo)** | https://datos.gob.ar/dataset/agroindustria-trigo---siembra-cosecha-produccion-rendimiento/archivo/agroindustria_50f0edcc-4dfc-4afb-b78a-b164601d36ae |

The three datasets share an identical column structure:

| Column Title | Data Type | Description |
|---|---|---|
| `cultivo_nombre` | Text (string) | Name of the crop (Corn, Soy, or Wheat). |
| `anio` | Integer | Year corresponding to the data. |
| `campania` | Text (string) | Crop season during which the planting took place. |
| `provincia_nombre` | Text (string) | Name of the province. |
| `provincia_id` | Text (string) | Province code. |
| `departamento_nombre` | Text (string) | Name of the department (county). |
| `departamento_id` | Text (string) | Department code. |
| `superficie_sembrada_ha` | Integer | Planted surface area in hectares (ha). |
| `superficie_cosechada_ha` | Integer | Harvested surface area in hectares (ha). |
| `produccion_tm` | Integer | Production in metric tons (TM). |
| `rendimiento_kgxha` | Integer | Yield in kilograms per hectare (kg/ha). |

---

## Data Cleaning (ETL Process)

Data cleaning is performed before merging the three datasets into a single file. The process focuses on identifying inconsistencies, handling null values that could affect results, and adjusting the time series to ensure all grains are evaluated over the same period.

### Data Type Standardization
Due to observed inconsistencies in the data types across the individual datasets, types for key numerical columns are standardized to ensure proper concatenation.

### Time Series Filtering
The raw data cover different periods:
* Corn Series: 1923-2023
* Soy Series: 1941-2023
* Wheat Series: 1927-2024

The analysis will focus on the **intersection of these series** to ensure comparable timeframes, resulting in the period: **(1941-2023)**.

### Cleaning Logic
The following rules were applied to the data:
* **Null Planting:** Entries where planting (`superficie_sembrada_ha`) is null are documented and removed, as a zero value makes subsequent harvest analysis irrelevant.
* **Lost Harvest:** If planting is greater than zero, but the harvest (`superficie_cosechada_ha`) is null (or zero), the entry is kept and interpreted as a lost harvest, which is relevant for statistical loss calculations.
* **Negative Values:** Entries with any negative numerical values are eliminated.
* **Inconsistencies:** Entries where harvested surface area is logically impossible (i.e., `superficie_cosechada_ha > superficie_sembrada_ha`) are corrected or removed.
* **Zero Yield:** If planting $> 0$ and harvest $> 0$, but yield (`rendimiento_kgxha`) is $0$, the entry is removed.
* **Outliers:** Entries where the yield is greater than a defined maximum yield (e.g., `MAX_YIELD_SOY`, `MAX_YIELD_CORN`) are removed.

#### Export to CSV

The cleaned and unified data are exported to a new CSV file: **`granos_argentina_1941_2023.csv`**

---

## Data Analysis & Modeling

### Feature Engineering
The percentage of harvested area relative to planted area is calculated for each entry and added as a new column *before* exporting the data to the database.

### Database Storage
The cleaned results are stored in an **SQLite** database: **`Granos_Argentina.db`**.

### Query Management
Utility functions are defined (`load_query` and `run_query`) to read SQL queries from external `.sql` files, facilitating cleaner Python code and easier query maintenance.

### Key Analytical Queries

The following aggregated queries were run against the database:

1.  **Total Production and Average Yield by Year and Crop:** ([`produccion_anual.sql`](queries/produccion_anual.sql))
2.  **Total Production and Planting by Province and Crop:** Used to identify the most important provinces for each grain. ([`produccion_por_provincia.sql`](queries/produccion_por_provincia.sql))
3.  **Average Yield of Crops Over Time:** ([`rendimiento_promedio_anual.sql`](queries/rendimiento_promedio_anual.sql))

---

## Visualization

The final cleaned CSV file, `granos_argentina_1941_2023.csv`, is used as the data source to generate the visualizations in **Tableau**.

The resulting dashboard explores trends in production, yield, and provincial importance.

**Tableau Public Link:**
https://public.tableau.com/views/HistoriadegranosenArgentina/ProdProvincia?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

**Top Producing Provinces Dashboard Snapshot:**
![Top provincias en produccion por grano](img/dashboard_provincias.jpg)

