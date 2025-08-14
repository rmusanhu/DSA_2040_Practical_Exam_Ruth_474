**Name:** Ruth Musanhu  
**Student ID (last 3 digits):** 474



🎯 Exam Sections
Section 1: Data Warehousing (50 Marks)

    Task 1: Star Schema Design (15 marks)
    Task 2: ETL Process Implementation (20 marks)
    Task 3: OLAP Queries and Analysis (15 marks)

Section 2: Data Mining (50 Marks)

    Task 1: Data Preprocessing and Exploration (15 marks)
    Task 2: Clustering (15 marks)
    Task 3: Classification and Association Rule Mining (20 marks)

 ## 📂 Repository Structure  
DSA 2040_Practical Exam_Ruth_474/
│
├── README.md
│
├── Section1_DataWarehousing/
│   ├── run_olap.ipynb
│   ├── synthetic_retail_africa.csv
│   ├── synthetic_retail.ipynb
│   ├── schema_diagram.png   
│   ├── star_schema.sql
│   ├── etl_retail.ipynb
│   ├── retail_dw.db
│   ├── olap_queries.sql
│   ├── viewing the datbase.png
│   ├── starschema.drawio.png
│   ├── visualization_sales_by_country.png
│   └── analysis_report.md
│
├── Section2_DataMining/
│   ├── preprocessing_iris.ipynb
│   ├── clustering_iris.ipynb
│   ├── mining_iris_basket.ipynb
│   │
│   ├── visualizations/
│   │   ├── pairplot_iris.png
│   │   ├── correlation_heatmap.png
│   │   ├── boxplots_iris.png
│   │   ├── elbow_curve.png
│   │   ├── clusters_petal.png
│   │   └── decision_tree.png
│   │
│   └── reports/
│       ├── clustering_report.md
│       ├── top_association_rules.csv
│       └── association_rules_report.md
│
└── requirements.txt   

## 📥 Datasets Used  
### Section 1: Retail Data Warehouse  
- **Dataset**: Generated **synthetic retail data** (~1000 rows) mimicking UCI Online Retail  
- **Features**: `InvoiceNo`, `StockCode`, `Description`, `Quantity`, `InvoiceDate`, `UnitPrice`, `CustomerID`, `Country`  
- **Details**:  
  - Quantities: 1–50  
  - Unit prices: $1–$100  
  - Dates: Jan 2023 – Aug 2025  
  - 100 unique customers across 10 African countries (e.g., Nigeria, Kenya, South Africa)  
  - Generated using `pandas`, `numpy`, and `Faker` for realistic names and descriptions  
- **Reproducibility**: All random seeds set to `42`  

### Section 2: Data Mining  
- **Iris Dataset**: Used built-in `sklearn.datasets.load_iris()` (150 samples, 3 species)  
- **Market Basket Data**: Generated 40 synthetic transactions with embedded patterns (e.g., milk+bread+butter, diapers+beer)
## ⚙️ How to Run the Code  

###  Step 1: Clone or Download the Repository


### Step 2: Recommended File Execution Order 

To follow the project flow, open and run the files in this order: 
📂 Section 1: Data Warehousing 

    synthetic_retail.ipynb
    → Generates synthetic retail data from African countries (1000 rows).
    → Output: synthetic_retail_africa.csv 

    star_schema.sql
    → Review the star schema design (fact and dimension tables).
    → Use this as reference for ETL and queries. 

    etl_retail.ipynb
    → Runs the full ETL pipeline: extracts, transforms, and loads data into retail_dw.db.
    → Creates SalesFact, CustomerDim, ProductDim, and TimeDim. 

    olap_queries.sql
    → Contains three OLAP queries: roll-up, drill-down, slice.
    → Can be run in DB Browser for SQLite or via Python. 

    run_olap.ipynb 
    → Executes queries and generates visualizations (e.g., sales by country). 
     

 
📂 Section 2: Data Mining 

    preprocessing_iris.ipynb
    → Loads the Iris dataset, scales features, checks for missing values, and generates EDA plots. 

    clustering_iris.ipynb
    → Applies K-Means clustering (k=3), plots the elbow curve, and evaluates clusters using ARI. 

    mining_iris_basket.ipynb
    → Part A: Trains Decision Tree and KNN, compares performance.
    → Part B: Generates synthetic market basket data and applies Apriori to find association rules. 
     

🏗️ Data Warehouse Design

### Task 1: Star Schema Design

I designed a **star schema** for the African retail data warehouse with one central fact table and three dimension tables:

- **`SalesFact` (Fact Table)**: Stores measurable sales data — `Quantity` and `TotalSales`. It links to dimensions using foreign keys: `CustomerKey`, `ProductKey`, and `TimeKey`.

- **`CustomerDim`**: Contains customer details such as `CustomerID`, `Name`, `Country`, and `Region` (e.g., West Africa). This supports demographic analysis.

- **`ProductDim`**: Stores product information like `StockCode`, `ProductName`, and `Category` (e.g., Electronics, Clothing), enabling category-based sales analysis.

- **`TimeDim`**: Tracks time attributes including `Date`, `Day`, `Month`, `Quarter`, and `Year`, allowing for time-series analysis (e.g., quarterly trends).

This schema supports key business queries like:
- Total sales by country and quarter (roll-up)
- Monthly sales drill-down in Nigeria
- Slice of sales for Electronics category

I chose a **star schema over snowflake** because it simplifies querying and improves performance for OLAP operations. Denormalized dimensions reduce JOIN complexity, making reporting faster — ideal for decision-making in retail analytics.

### Task 2: ETL Process Implementation

I implemented a complete ETL pipeline to populate a retail data warehouse using **synthetic African retail data** generated with realistic structure (1000 rows, 100 customers, 8 African countries, quantities 1–50, prices $1–$100). The data was generated using Python's `pandas`, `numpy`, and `Faker` for realistic customer names and product descriptions.

The ETL process followed three stages:
- **Extract**: Loaded data from `synthetic_retail_africa.csv` into a pandas DataFrame.
- **Transform**: 
  - Cleaned missing values and removed invalid entries (Quantity ≤ 0 or UnitPrice ≤ 0).
  - Calculated `TotalSales = Quantity × UnitPrice`.
  - Filtered records from the last year (Aug 2024 – Aug 2025).
  - Built dimension tables (`CustomerDim`, `ProductDim`, `TimeDim`) with surrogate keys.
- **Load**: Loaded all tables into an SQLite database (`retail_dw.db`) using `sqlite3`. The script includes logging at each stage (e.g., row counts) and error handling.

The pipeline is modular, reproducible (using `np.random.seed(42)`), and well-documented. It successfully created a star schema-ready database for OLAP analysis.


### Task 3: OLAP Queries and Analysis

Using the populated data warehouse, I executed three OLAP-style queries:
1. **Roll-up**: Total sales by country and quarter.
2. **Drill-down**: Monthly sales trends in Nigeria (top-performing country).
3. **Slice**: Total sales for the Electronics category.

I visualized the **roll-up result** (aggregated by country) using a bar chart (`visualization_sales_by_country.png`) created with `matplotlib`. The chart highlights Nigeria and South Africa as leading markets.

In the analysis report, I interpreted trends such as seasonal peaks in Q4 and the dominance of electronics. Despite synthetic data, patterns reflect real-world behavior due to weighted distributions (e.g., higher sales in populous countries). The star schema enabled fast, flexible analysis, supporting business decisions like inventory planning and regional targeting.

All queries are saved in `olap_queries.sql`, and the analysis is included in `analysis_report.md`.

🏗️  Data Mining
### Task 1: Data Preprocessing and Exploration

For this task, I used the **built-in Iris dataset** from `scikit-learn`, which contains 150 samples of iris flowers with four features: sepal length, sepal width, petal length, and petal width, labeled into three species: *setosa*, *versicolor*, and *virginica*. This dataset is ideal for data mining tasks due to its clear structure and well-separated classes.

The preprocessing pipeline included:
- **Loading and inspection**: The data was loaded into a pandas DataFrame for easy manipulation. I checked the first few rows and overall shape (150 × 5).
- **Missing value check**: `.isnull().sum()` confirmed no missing values.
- **Feature scaling**: Applied **Min-Max normalization** to scale all features to [0, 1], ensuring equal weight in downstream models.
- **Label encoding**: Species were kept as numeric labels (0, 1, 2) for modeling and mapped to names for visualization.

For exploration:
- **Summary statistics** (`df.describe()`) showed mean, std, and quartiles per feature.
- **Pairplot**: Revealed strong separation between *setosa* and the other two species, especially in petal dimensions.
- **Correlation heatmap**: Showed high positive correlation between petal length and petal width (≈0.96), suggesting redundancy.
- **Boxplots**: Identified minor outliers in versicolor and virginica but no major data issues.

Finally, I implemented a reusable `split_data()` function using `train_test_split` (80/20 split, stratified) to maintain class balance. All visualizations were saved in the `visualizations/` folder.

This preprocessing ensures clean, normalized data ready for clustering and classification.

### Task 2: Clustering (K-Means)

In this task, I applied **K-Means clustering** to the preprocessed Iris dataset to discover natural groupings without using species labels. I used the scaled features (Min-Max normalized) and set `k=3` to match the known number of species.

The model achieved an **Adjusted Rand Index (ARI) of 0.716**, indicating moderate to strong agreement between predicted clusters and true species. The high ARI suggests that the algorithm successfully captured the underlying structure, particularly isolating *setosa* as a distinct cluster. Misclassifications occurred mainly between *versicolor* and *virginica*, which overlap in petal dimensions — a known challenge due to their biological similarity.

To justify the choice of `k=3`, I plotted the **elbow curve** for `k=1` to `10`. The curve shows a clear bend (elbow) at `k=3`, confirming it as the optimal number of clusters based on inertia (within-cluster sum of squares).

I visualized the clusters using a scatter plot of **petal length vs. petal width**, the most discriminative features. The plot shows well-separated clusters with centroids (red X) positioned at their centers. Minor misclassifications arise because K-Means assumes spherical clusters, while real classes have slightly elliptical shapes.

This task demonstrates how unsupervised learning can uncover hidden patterns in data. In real-world applications, such as customer segmentation or image compression, K-Means is valuable when true labels are unavailable. Even with synthetic data, similar results would be expected if the cluster structure is preserved. Overall, the model performed well, and the analysis supports `k=3` as the optimal choice.


### Task 3: Classification & Association Rules

For classification, I trained a **Decision Tree** and **KNN (k=5)** on the preprocessed Iris dataset. Both models achieved **identical accuracy of 96.7%** on the test set, indicating comparable performance.

The Decision Tree showed perfect precision and recall for *setosa* and *virginica*, but slightly lower recall for *versicolor* (90%), meaning one sample was misclassified. KNN performed similarly, with balanced precision and recall across classes. The tie in accuracy suggests that both models handle the Iris dataset well — Decision Tree due to clear decision boundaries, and KNN due to local pattern sensitivity.

The Decision Tree was visualized using `plot_tree`, revealing that splits on **petal length** and **petal width** are the most discriminative features, aligning with domain knowledge.

For association rule mining, I generated 40 synthetic transactions with embedded patterns (e.g., milk+bread+butter, diapers+beer). Using the Apriori algorithm, I discovered strong rules with high lift. The top rule `{milk, diapers} → {butter, beer}` (lift ≈ 1.97) suggests a recurring "family essentials + beer" shopping pattern, possibly reflecting real-world consumer behavior.

These results demonstrate how supervised models can achieve high performance on structured data, while unsupervised rule mining uncovers actionable patterns in transactional data — both essential in business intelligence and retail analytics.


### 🏁 Conclusion 

This project demonstrates comprehensive skills in:   

    Data Warehousing: Star schema design, ETL implementation, OLAP analysis  
    Data Mining: Preprocessing, clustering, classification, and association rule mining
     

The synthetic African retail data enabled realistic business insights, while the Iris dataset provided a solid foundation for machine learning tasks. Association rule mining uncovered meaningful patterns like {milk, diapers} → {butter, beer}, demonstrating real-world applicability.  





## 📝 Self-Assessment

Overall, the project meets the exam requirements across both sections: star schema design and ETL are fully implemented with OLAP analysis; data mining covers preprocessing, clustering, classification, and association rules with documentation and artifacts.

### ✅ Completed Tasks

#### Setup & Infrastructure
- [✅] Project structure adheres to best practices.
- [✅] Environment configuration (Python 3.x, required libraries).
- [✅] `requirements.txt` file included for reproducibility.
- [✅] GitHub repository named `DSA_2040_Practical_Exam[YourNameXXX]`.
- [✅] `.gitignore` updated to allow committing images and database files.

#### Data Generation & Warehousing
- [✅] Synthetic datasets generated:
  - Retail data (`synthetic_retail_africa.csv`) mimicking African markets.
  - Iris dataset (preprocessed using scikit-learn).
  - Transactional data for market basket analysis.
- [✅] Star schema design:
  - Fact table: `SalesFact` with measures like `TotalSales` and foreign keys.
  - Dimension tables: `CustomerDim`, `ProductDim`, `TimeDim`.
  - Diagram created using Draw.io and saved as `schema_diagram.png`.
- [✅] Database creation:
  - SQLite database (`retail_dw.db`) populated with transformed data.
  - Tables include `SalesFact`, `CustomerDim`, `ProductDim`, `TimeDim`.

#### ETL Pipeline
- [✅] ETL process implemented in `etl_retail.ipynb`:
  - Extraction: Read synthetic retail data or UCI Online Retail CSV.
  - Transformation:
    - Cleaned missing values.
    - Filtered data for last year (Aug 2024 – Aug 2025).
    - Created dimension tables (`CustomerDim`, `ProductDim`, `TimeDim`).
    - Handled outliers (removed invalid rows).
  - Loading: Successfully loaded into `retail_dw.db`.

#### OLAP Queries & Analysis
- [✅] OLAP queries written in `olap_queries.sql`:
  - Roll-up: Total sales by country and quarter.
  - Drill-down: Monthly sales for Nigeria.
  - Slice: Total sales for Electronics category.
- [✅] Visualization of sales by country (`visualization_sales_by_country.png`).
- [✅] Analysis report (`analysis_report.md`) summarizing insights:
  - Top-performing countries: Nigeria and South Africa.
  - Seasonal trends: Higher sales in Q4 due to holidays.
  - Dominant category: Electronics (~30% of total sales).

#### Data Mining
- [✅] Preprocessing & Exploration (`preprocessing_iris.ipynb`):
  - Loaded Iris dataset from scikit-learn.
  - Normalized features using Min-Max scaling.
  - Generated visualizations: Pairplot, correlation heatmap, boxplots.
  - Split data into train/test sets (80/20 stratified split).
- [✅] Clustering (`clustering_iris.ipynb`):
  - Applied K-Means with k=3.
  - Adjusted Rand Index (ARI): ~0.716 (moderate alignment with true species).
  - Elbow curve plotted to justify k=3.
  - Visualized clusters using petal length vs. width.
- [✅] Classification (`mining_iris_basket.ipynb`):
  - Trained Decision Tree and KNN classifiers.
  - Both achieved identical accuracy (~96.7%).
  - Decision Tree visualization (`decision_tree.png`).
- [✅] Association Rule Mining (`mining_iris_basket.ipynb`):
  - Generated synthetic market basket data with realistic patterns.
  - Applied Apriori algorithm using `mlxtend`.
  - Top 5 association rules saved as `top_association_rules.csv`.
  - Analysis report (`association_rules_report.md`) discussing implications.


### ⚠️ Challenges Faced
- Initial difficulty in aligning `InvoiceDate` and `TimeKey` during ETL.
- Ensuring reproducibility of synthetic data generation.
- Fine-tuning visualization aesthetics for clarity.

### 🛠️ Tools Used
- Python libraries: pandas, numpy, matplotlib, seaborn, scikit-learn, mlxtend.
- SQLite for data warehousing.
- DB Browser for SQLite for database exploration.
- Draw.io for star schema diagramming.

