📊 Ecommerce Analytics – RFM & CLV

End-to-end Ecommerce Analytics project designed to simulate a real-world business scenario, covering the complete analytics workflow from data generation → analysis → SQL → Power BI dashboards.
This project demonstrates hands-on experience in Python, SQL, and Power BI, with a strong focus on customer behavior analysis, revenue insights, RFM segmentation, and Customer Lifetime Value (CLV).

🧠 Business Problem Statement
An e-commerce business wants to:
Understand overall sales and order performance
Identify high-value, loyal, and at-risk customers
Analyze customer engagement patterns using RFM
Estimate Customer Lifetime Value (CLV) for long-term growth
Build interactive dashboards for management decision-making

🛠️ Tech Stack & Tools Used:---
🐍 Python (Jupyter Lab)
    numpy, pandas
    matplotlib, seaborn
    Data generation, cleaning, EDA, RFM & CLV calculations

🗄️ SQL (MySQL)
    Schema design
    Joins & aggregations
    Window functions
    Business-oriented analytical queries

📊 Power BI
    Multi-page interactive dashboards
    KPI cards, slicers, heatmaps, calendar visuals
    RFM & CLV business insights

🔄 End-to-End Project Workflow
1️⃣ Data Generation (Python)
    Synthetic ecommerce data generated using numpy & pandas
    Tables created:
    customers
    products
    orders
    order_items
    payments
    📁 Notebook
    notebooks/01_data_generation.ipynb

2️⃣ Data Cleaning, EDA & Feature Engineering (Python)
    Data cleaning & validation
    Revenue and profit calculations
    Exploratory Data Analysis (EDA)
    RFM table generation
    CLV (realized & projected) calculations
    Charts using matplotlib & seaborn
    📁 Notebook
    notebooks/02_data_cleaning_eda_rfm_clv.ipynb

3️⃣ Data Storage & SQL Integration
    Core transaction tables loaded into MySQL:
    customers
    products
    orders
    order_items
    payments
    Loading approach (realistic & honest):
    order_items & rfm loaded using Python (pandas.to_sql)
    Remaining tables imported using MySQL Import Wizard
    CLV tables consumed directly in Power BI via CSV
    📁 SQL Files
    sql/table_creation.sql – Database schema
    sql/data_import.sql – Import documentation
    sql/analysis_queries.sql – Business analysis queries

4️⃣ SQL Analytics & Business Queries
    Overall KPIs (Revenue, Profit, Orders, Customers)
    Category-wise revenue & profit
    Monthly & quarterly trends
    Top customers & cities
    Customer segmentation analysis
    CLV ranking & customer value buckets

5️⃣ Power BI Dashboarding
    Professional multi-page Power BI dashboard covering:
    E-Commerce Business Overview
    Sales & Orders Analysis
    Customer Analytics & RFM Insights
    Customer Lifetime Value (CLV) Insights

Key features:
    Dynamic slicers (Year, Month, City)
    KPIs with MoM comparison
    Calendar heatmaps (day & hour analysis)
    RFM scatter analysis
    CLV contribution & projected value insights
    📁 Power BI file (local)
    powerbi/ecommerce_dashboard.pbix

📸 Dashboard Screenshots
🔹 E-Commerce Business Overview
    [View] (screenshots/powerbi/overview_page.png)

🔹 Sales & Orders Analysis
   [View] (screenshots/powerbi/sales_orders_page.png)
    
🔹 Customer Analytics & RFM
    [View] (screenshots/powerbi/customers_rfm_page.png)
    
🔹 Customer Lifetime Value (CLV)
    [View] (screenshots/powerbi/clv_insights_page.png)
    
📈 Python EDA & Visualization (Matplotlib / Seaborn)
  * Segment-wise Revenue, Customers & AOV
    [View] (screenshots/python/rfm_segment_analysis.png)
    
  * Monthly Revenue Trend
    [View] (screenshots/python/monthly_revenue_trend.png)
    
  * Distribution of Customer Order Counts
    [View] (screenshots/python/distribution_of_customers.png)
```
📂 Project Structure
Ecommerce-Analytics-RFM-CLV/
│
├── notebooks/
│   ├── 01_data_generation.ipynb
│   └── 02_data_cleaning_eda_rfm_clv.ipynb
│
├── data/
│   ├── customers.csv
│   ├── products.csv
│   ├── orders.csv
│   ├── order_items.csv
│   ├── payments.csv
│   ├── rfm.csv
│   └── clv_by_customer_cleaned.csv
│
├── sql/
│   ├── table_creation.sql
│   ├── data_import.sql
│   └── analysis_queries.sql
│
├── screenshots/
│   ├── powerbi/
│   └── python/
│
└── README.md

🚀 Author

Prem Gupta
Aspiring Data Analyst

Skills
Python | SQL | Power BI | Data Analytics
