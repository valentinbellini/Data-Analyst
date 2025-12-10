# SUBE

This project is a Data Analysis of the main transportation system in Argentina: SUBE. This system contain bus, metro and train transportation around all the country and the information is provide by the goverment thru their datasets website. We are doing two analysis here:

1. **Capacity and Efficiency Analysis**

This set of questions aims to identify whether the system is being used inefficiently or if there are demand peaks that could saturate it.

- *Demand Peaks:* What is the peak hour (time of day) with the highest average usage for each type of transport (Bus, Train, Subway)?Do the highest-usage days correlate with specific events or holidays?

- *Geographical Distribution:* Are there provinces or municipalities with disproportionately low or high usage relative to their population or the number of operating lines? Could this indicate lack of coverage or the need for more units?

- *Demand–Supply Relationship:* How is the maximum demand (highest QUANTITY) distributed across LINE? Are there lines that consistently exceed usage thresholds, suggesting a need to increase frequency or vehicle size?

2. **Seasonality and User Behavior Analysis**

These questions help us understand recurring usage patterns and user needs.

- *Day-of-Week Patterns:* What is the percentage drop in average usage on weekends (Saturday/Sunday) compared to the average for weekdays (Monday–Friday), and how does this drop vary between Buses, Trains, and Subways? (A very marked drop suggests the system is mainly used for commuting to work/school.)

- *Annual/Monthly Trends:* Does the total usage show a steady recovery over the 2021–2024 period, or has it stagnated? Are there consistent drops in specific months (e.g., January/February due to vacations)?

- *Secondary Trips:* When looking at the distribution of QUANTITY, can we identify many records with very low values (close to 1)?
This could indicate very short trips or transfers.

## Data Cleaning

You can access the data cleaning process in the [DataCleaning.ipynb](DataCleaning.ipynb) file.

### 1. Data Import

There are 5 datasets downloaded from the goverment website. Each csv contains the relevant information for all transactions in the SUBE System for an entire year so in order to have the information between 2021 to 2025, we import all the datasets and concatenate them.

*Source:* [Datasets Gob](https://datos.gob.ar/dataset/transporte-sube---cantidad-transacciones-usos-por-fecha)

### 2. Change DataType

With `df.info()` we found incorrect datatype for the DIA_TRANSPORTE (Transport_day) column. It's necessary to change this datatype to datetime because we are going to need this type for future analysis.

### 3. Check for nulls

Using the dataframe method `isnull()`, we count every null value in the csv (or the dataframe actually). There were near 13k null values in columns [JURISDICCION, PROVINCIA, MUNICIPIO], representengin about 0.56% of the total values. Just keep the number in mind because we are solving this "problem" later.

### 4. Negative Values.

The decision with negative value is to assign them to zero. It could be a wrong decision, but there were only 11 negative values in the dataset and there are more than 1.8 million rows, so it will not affect the statistics.

### 5. Add a column

For future analysis we think is necesary to add a new column now: the day of the week (Monday, Tuesday, ...) based on the datetime column DIA_TRANSPORTE transformed before. This is actually an easy task using pandas: `df['DIA_TRANSPORTE].dt.dat_name()`

### 6. Unique Values

It's time to check Categoric Data. This is the code we ran to found the errors:

``` Python
categoric_columns = [
    'DATO_PRELIMINAR', 
    'AMBA', 
    'JURISDICCION', 
    'TIPO_TRANSPORTE', 
    'DIA_SEMANA', 
    'PROVINCIA',
    'MUNICIPIO'
]

for column in categoric_columns:
    print(f"\nUnique values for column: **{column}**")
    print(df[column].value_counts(dropna=False))
    print("-" * 50)
```

**Results:**

* There are 13141 NaN values in JURISDICCION and 13141 NaN values when filtering the SUBTE (Metro) Transportation. So, for the TIPO_TRANSPORTE (Transport type) SUBTE, we assign the NaN values as follows:

``` Python
# MASK
mask_subte = df['TIPO_TRANSPORTE'] == 'SUBTE'

# 1. JURISDICCION to NACIONAL
df.loc[mask_subte, 'JURISDICCION'] = 'NACIONAL'

# 2. PROVINCIA to CABA
df.loc[mask_subte, 'PROVINCIA'] = 'CABA'

# 3. MUNICIPIO to 'SD'
df.loc[mask_subte, 'MUNICIPIO'] = 'SD'
```

* Few errors in "AMBA". If PROVINCIA = C.A.B.A -> AMBA should be YES.

### 7. Outliers

We check for outliers in the `CANTIDAD` (quantity of travels) column using `describe()` method for a quick analysis and Box Plot with Matplotlib.

The analysis of the CANTIDAD (Quantity of daily uses) column reveals a heavily skewed distribution, which is typical for count data like transportation usage.

**Key Findings**

* High Positive Skewness: The Mean ($\text{8,177}$) is significantly higher than the Median ($\text{2,191}$). This indicates that the vast majority of daily usages are low, but the average is drastically pulled up by a smaller number of days/lines with extremely high transaction volumes.

* Extensive Outlier Count: The standard Interquartile Range (IQR) rule ($1.5 \times \text{IQR}$) identifies $\text{288,848}$ records (12.4% of the data) as outliers (i.e., $\text{CANTIDAD} > \text{18,602}$).

**Conclusion on Outlier Treatment**

In the context of public transportation data, these high values are not errors, but rather a representation of real-world high demand.

* Entries classified as "outliers" likely correspond to major bus routes or highly transited lines during peak weekdays

* Recommendation: We will not remove these records, as they contain critical information regarding high-demand events.

* Strategy for Modeling: For any future statistical modeling or predictive analysis, the CANTIDAD column should be handled by using the Median as a measure of central tendency or by applying a logarithmic transformation to mitigate the skewness and stabilize the variance.