# Retail Data Quality & Reporting Analysis

This repository demonstrates an end-to-end analytics process starting from raw datasets and ending with validated insights presented in a Power BI dashboard.

---

## Purpose of project
This repository serves as a portfolio example demonstrating a full analytics lifecycle - starting from raw datasets, ensuring their quality, and ultimately producing business-ready reporting in Power BI.

---

## SQL-based Data Quality Analysis
Located here: [README.md](sql/README.md)

Includes:
- profiling of raw datasets
- error classification
- reconciliation checks between two sources
- creation of final reporting-ready output tables
- screenshots illustrating execution results

---

## Power BI Dashboard
Located here: [README.md](dashboard/README.md)

You can open the interactive report directly via the PBIX file:  
[dashboard.pbix](dashboard/dashboard.pbix)

Includes:
- KPI visualization
- customer and product metrics
- trend analysis
- interactive slicing by date/product/customer
- technical documentation

---

## Repository Structure

```
Retail_Data_Quality_Project/
│
├── sql/                       # SQL scripts for data validation and analytical logic
│   ├── data_quality.db
│   ├── data_quality_project.sql
│   └── README.md
│
├── dashboard/                 # Power BI dashboard + documentation
│   ├── dashboard.db
│   ├── retail_sales_dataset.xlsx
│   └── README.md
│   
├── data/                      # Source CSV files + intermediate Excel used for modeling
│   ├── checks.csv
│   ├── cleaned_data.csv
│   └── data_preparation_analysis.xlsx
│
├── images/                    # Screenshots showing SQL outputs & dashboard results
│   ├── dashboard
│   │   └── dashboard_view.png
│   └── sql
│       ├── error_distribution.png
│       ├── error_types.png
│       ├── monthly_trend.png
│       ├── record_match_summary.png
│       └── source_system_errors.png
│
├── README.md                  # Project documentation
└── LICENSE                    # MIT license
```

Supporting analysis file located in `/data`:
- **data_preparation_analysis.xlsx** — contains intermediate validation logic used prior to dashboard modelling.

---

## Skills Demonstrated

- SQL data validation & reconciliation
- Identifying quality issues in structured datasets
- Designing reporting-ready data outputs
- Power Query transformations
- Data modeling (star schema)
- Designing KPIs and interactive BI views
- Analytical thinking and results interpretation
- Business-oriented narrative in documentation

---

## How to Explore the Project
1. Start with the SQL documentation here: [README.md](sql/README.md)
2. Examine generated outputs & screenshots
3. Open PBIX file for finalized analytics: [dashboard.pbix](dashboard/dashboard.pbix)
4. Inspect dashboard documentation for logic and interpretation: [README.md](dashboard/README.md)

5. Explore /data if you want to inspect raw input datasets and supporting analysis file
