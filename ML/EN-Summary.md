# Course Summary

## Data Manipulation - Pandas

First of all, I'm leaving a brief review for working with the Pandas library.
Let's look at some library commands for working with DataFrames and manipulating data.

### Read and Write files

The `read_*` functions are used to read data from a file and load it into a pandas object, while the `to:*` functions are used to save a DataFrame to that file type. Example:

```python
    Autos = pd.read_csv('../Auto.csv') # Importar
    Autos.to_excel("autos.xlsx", sheet_name="Autos", index=False) # Exportar
```

### Specific Columns from a DatFrame

Select specific rows and/or columns using `loc` when using the name of rows and/or columns.

Select specific rows and/or columns using `iloc` when using their position in the table.


```python
    New_Cars = Autos.loc[Autos["year"] > 80]
    New_Cars.iloc[1:10, 2:9]
```

### Creating new columns

From a given DataFrame, we can create new columns based on calculations made with existing ones, such as if we want to convert from liters to gallons or from kilometers to miles. The following example shows how a new column is created to convert from MPG to KML:

```python
    df["KML.highway"] = df["MPG.highway"] * 0.43
```

### Sort() Function in Pandas:

The `sort()` function in Pandas is used to sort the data in a DataFrame or a Series. You can sort the data based on the values of one or more columns, in ascending or descending order. Let's look at the syntax and then explain each parameter:

```python
    DataFrame.sort_values(by='Price', axis=0, ascending=True, inplace=False, kind='quicksort', na_position='last')
```
- `by`: Specifies the column(s) by which the data will be sorted.
- `axis`:Specifies whether to sort by rows (axis=0) or columns (axis=1). Default is 0 (rows).
- `ascending`: Specifies whether the order is ascending (True) or descending (False). Default is True.
- `inplace`: If set to True, the modification will be made to the original DataFrame.
- `kind`: Sorting algorithm. Can be 'quicksort', 'mergesort', 'heapsort', or 'stable'.
- `na_position`: Specifies how to handle NA values. Can be 'last' (NA values are placed at the end) or 'first' (NA values are placed at the beginning).
### Groupby() function in Pandas:

The `groupby()` function in Pandas is used to split the data into groups based on some criteria. After splitting the data into groups, aggregate operations can be applied to each group, such as sum, average, count, etc.

```python
    # Sintaxis
    DataFrame.groupby(by=None, axis=0, level=None, as_index=True, sort=True, group_keys=True, squeeze=<object object>)
```

- `by`: Specifies the columns or functions by which the grouping will be performed.
- `axis`: Specifies whether to group by rows (axis=0) or columns (axis=1). Default is 0 (rows).
- `level`: If the axis is a MultiIndex, then the level or levels (key or keys) are used.
- `as_index`: If True, the groups will be returned with labels as indexes. If False, the groups will be returned as DataFrame objects.
- `sort`: Specifies whether the results are sorted.
- `group_keys`: If True, adds the group keys to the resulting index.

Let's look at an example:

```python
    import pandas as pd

    data = {'Name': ['Alice', 'Bob', 'Charlie', 'Alice', 'Bob'],
            'Age': [25, 30, 20, 25, 30],
            'Salary': [50000, 60000, 45000, 52000, 62000]}

    df = pd.DataFrame(data)

    # Group by the 'Name' column and calculate the average salary
    grouped_df = df.groupby('Name')['Salary'].mean()
    print(grouped_df)
```

### Useful Functions

I'm adding some useful functions/methods:

#### str.contains()

This method is used to check if each element of the Series (column) contains a specific string.

- `case=True` : Indicates that the search is case-sensitive.
- `regex=True` : Indicates that the provided string is a regular expression. This allows for more flexible and advanced matching.

Example:

```python
    pumpkins = pumpkins[pumpkins['Package'].str.contains('bushel', case=True, regex=True)]
```

#### DatetimeIndex()

This method is used to create a DatetimeIndex object from a column that contains dates and/or times. In the following example, we want to access the month of a particular column:

```python
    month = pd.DatetimeIndex(pumpkins['Date']).month
```

--- 

## Regression

Regression seeks to find the functional relationship between the independent variables (input) and the dependent variable (output). This relationship is typically represented as a mathematical function. In simple terms, regression tries to fit a line (or curve) that best fits the observed data.

Regression is used when we want to predict numerical values. Some application examples include predicting house prices based on features like size, number of rooms, etc.

### Tipos de regresiones:
- *Linear Regression*: Seeks to fit a straight line that best fits the data.
- *Polynomial Regression*: Uses a polynomial function to fit the data instead of a straight line.
- *Logistic Regression* : Used when the dependent variable is binary (0/1) and we want to predict the probability of an event occurring.
- *Ridge and Lasso Regression*: Regularized linear regression methods that help prevent overfitting by adding penalty terms to the loss function.
- *Time Series Regression*: Used when data has a time structure and the goal is to predict future values.
- *K-Nearest Neighbors Regression (KNN)*: Uses the values of the k nearest observations to predict the value of a new observation.

![Regression-Types](./images/RegressionTypes.png)

### How to use them in scikit-learn:

Here is a simple example of how to use linear regression in scikit-learn:

```python
    from sklearn.model_selection import train_test_split
    from sklearn.linear_model import LinearRegression

    # Assuming we have X as our features and y as our targets
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # Create a linear regression model
    model = LinearRegression()

    # Train the model
    model.fit(X_train, y_train)

    # Make predictions
    predictions = model.predict(X_test)
```

---

## Classification

Classification is a supervised machine learning method in which the model attempts to predict the correct label for a given input data. In classification, the model is fully trained on the training data, and then evaluated on the test data before being used to make predictions on new, unseen data.

### Machine Learning Classification Vs. Regression

There are four main categories of machine learning algorithms: supervised, unsupervised, semi-supervised, and reinforcement learning.

Although classification and regression both belong to the supervised learning category, they are not the same.

- The prediction task is a *classification* when the target variable is *discrete*. An application is identifying the underlying sentiment of a text.
- The prediction task is a *regression* when the target variable is *continuous*. An example could be predicting a person's salary given their level of education, previous work experience, geographic location, and seniority level.

### Different Types of Machine Learning Classification Tasks

There are four main classification tasks in machine learning: binary, multiclass, multilabel, and imbalanced classifications.

#### Binary Classification

In a binary classification task, the goal is to classify the input data into two mutually exclusive categories. In such a situation, the training data is labeled in binary format: true and false; positive and negative; 0 and 1; spam and non-spam, etc., depending on the problem being addressed.

#### Multiclass Classification

Multiclass classification, on the other hand, has at least two mutually exclusive class labels, where the goal is to predict which class a given input example belongs to. For example, a machine learning model that predicts whether an image contains a truck, a boat, or an airplane.

#### Multilabel Classification

In multilabel classification tasks, we try to predict 0 or more classes for each input example. In this case, there is no mutual exclusion because the input example can have more than one label.

This scenario can be observed in different fields, such as auto-tagging in Natural Language Processing, where a given text can contain multiple topics. Similarly, in computer vision, an image can contain multiple objects.

#### Imbalanced Classification

In imbalanced classification, the number of examples is unevenly distributed across each class, meaning we may have more of one class than the others in the training data. Consider the following 3-class classification scenario where the training data contains: 60% trucks, 25% airplanes, and 15% boats.

We can use multiple approaches to address the imbalance problem in a dataset. The most commonly used approaches include sampling techniques or leveraging the power of cost-sensitive algorithms.

### Metrics for Evaluating Machine Learning Classification Algorithms

Now that we have an idea of the different types of classification models, it is crucial to choose the appropriate evaluation metrics for those models. In this section, we will cover the most commonly used metrics: Accuracy, Precision, Recall, F1-Score, and ROC (Receiver Operating Characteristic) AUC (Area Under the Curve).

Example of using `logistic regression` for multiclass classification:

```python
    X_train, X_test, y_train, y_test = train_test_split(cuisines_feature_df, cuisines_label_df, test_size=0.3)

    # Create a logistic regression with multi_class set to ovr and the solver set to liblinear:
    lr = LogisticRegression(multi_class="ovr", solver="liblinear")
    model = lr.fit(X_train, y_train) # np.ravel(y_train)

    accuracy = model.score(X_test, y_test)
    print ("Accuracy is {}".format(accuracy))
```

---

## Clustering

Clustering is an unsupervised machine learning task where the goal is to find objects that are similar to each other and group them into sets called clusters such that elements within the same group are more similar to each other than to elements of other groups.

In a professional setting, clustering can be used to determine things like market segmentation or to determine which age group buys which items, for example.

Once the data is organized into clusters, a cluster ID is assigned to them, and this technique can be useful for preserving the privacy of a dataset; you can refer to a data point by its cluster ID, instead of more revealing identifiable data.

### Scikit-Learn Clustering

[Scikit-learn](https://scikit-learn.org/stable/modules/clustering.html) offers a long list of methods for clustering. The type you choose will depend on each particular case.

### K-Means clustering

K-Means clustering is a method derived from the field of signal processing. It is used to divide and partition groups of data into 'k' groups using a series of observations. Each observation works to group a data point closer to its nearest 'mean', or the center point of a group.

The groups can be visualized as [diagramas Voronoi](https://en.wikipedia.org/wiki/Voronoi_diagram), which include a point (or 'seed') and its corresponding region.

An example using K-means is provided below:

```python
    from sklearn.preprocessing import LabelEncoder
    le = LabelEncoder()

    X = df.loc[:, ('artist_top_genre','popularity','danceability','energy')]

    y = df['artist_top_genre']

    # This assigns a unique number to each unique value present in the 'artist_top_genre' column
    X['artist_top_genre'] = le.fit_transform(X['artist_top_genre'])

    # We encode the values of the target variable
    y = le.transform(y)

    # CLUSTERING: 
    from sklearn.cluster import KMeans

    nclusters = 3 
    seed = 0

    km = KMeans(n_clusters=nclusters, random_state=seed)
    km.fit(X)

    # Predict the cluster for each data point

    y_cluster_kmeans = km.predict(X)
    y_cluster_kmeans # Arreglo impreso con los grupos predichos (0, 1, 0 2) para cada fila del dataframe.
```

In addition, techniques like the `Elbow Method` are explained and practically used in [K-means.ipynb](./Clustering/2.K-means.ipynb).


## Real World Applications

![Real World](./images/ml-realworld.png)