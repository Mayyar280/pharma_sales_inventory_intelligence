# Pharma Sales & Inventory Intelligence

A MySQL portfolio project exploring pharmaceutical sales performance across Germany and Poland (2017–2020). The project uses SQL to examine market performance, products, customers, distributors, sales channels, and data quality, then translates the findings into business insights.

> **Scope note:** The dataset contains sales records and quantities, but no on-hand stock balances, manufacturing costs, or cost of goods sold. Therefore, this project analyzes sales and quantity movement; it does **not** calculate actual inventory levels, stock-outs, or profitability.

## Project at a Glance

| Item | Description |
|---|---|
| Domain | Pharmaceutical sales analytics |
| Database | MySQL 8.0 |
| Dataset | 254,082 records, 18 columns |
| Period | 2017–2020 |
| Markets | Germany and Poland |
| Main tools | MySQL Workbench, MySQL, SQL; Python was used for the initial CSV import |
| Main SQL methods | Data cleaning, aggregations, conditional logic, CTEs, Window Functions |

## Business Questions

- How are sales distributed between the countries and across time?
- Which product classes and individual products contribute most to sales?
- How concentrated are sales among customers and distributors?
- How do sales channels and sales teams perform?
- Which products, channels, and periods contain negative sales records?
- What data-quality issues could affect the reliability of the analysis?

## Key Findings

- **Geographic mix:** Germany contributes approximately **94.23%** of total reported sales; Poland contributes approximately **5.77%**. Poland is represented in the dataset in 2018 only, so multi-year country comparisons are not possible for Poland.
- **Distributor concentration:** The top three distributors account for approximately **68.75%** of total sales; the top five account for **82.97%**.
- **Customer value:** The High Value customer segment represents approximately one quarter of customers and contributes **43.97%** of sales. The top 20 customers contribute approximately **7.69%** of sales.
- **Product trends in Germany:** Antimalarial sales increased by approximately **28.48%** from 2017 to 2020, while Analgesics decreased by approximately **9.68%** over the same period.
- **Sales channels:** Pharmacy / Retail was the leading channel in Germany in each year from 2017 to 2020. In Poland in 2018, Hospital / Private was the largest channel, contributing **30.42%** of Polish sales.
- **Negative sales:** The dataset contains **2,633** records with negative sales, with a combined value of approximately **-146.48 million**. These are treated as investigation flags, not automatically classified as confirmed returns.
- **Data validation:** **36** records differ by more than 0.01 between recorded Sales and Quantity × Price. A separate full-row check identified **4 groups** of fully identical records (4 extra rows if one copy per group were retained).
- **High-volume records:** In 2019, records with Quantity of at least 10,000 represented approximately **0.13%** of records but contributed approximately **21.00%** of sales.
- **Exceptional record:** One August 2019 Ionclotide record has sales of **74,205,600**, materially influencing product-level sales analysis and requiring source validation.

## Analysis Workflow

1. **Data preparation and cleaning** — imported the source CSV, retained the raw table, and prepared `pharma_clean` for analysis.
2. **Data quality checks** — reviewed missing values, text whitespace, quantity-price-sales discrepancies, duplicate candidates, and unusual quantities.
3. **Sales performance** — analyzed sales by year, month, and country, including annual and monthly comparisons.
4. **Product analysis** — ranked products, compared product classes, and investigated product trends over time.
5. **Customer analysis** — measured customer contribution and concentration, activity across months/years, and relative value segments using `NTILE(4)`.
6. **Distributor analysis** — ranked distributors, calculated contribution and cumulative contribution, examined customer overlap, and compared yearly rankings.
7. **Channel and sales-team analysis** — compared channels over time and reviewed team and representative performance.
8. **Negative-sales investigation** — examined negative records by country, year, channel, product class, and selected high-impact products.
9. **Business insights** — translated the findings into practical recommendations while documenting dataset limitations.

## SQL Skills Demonstrated

- `GROUP BY`, aggregate functions, and conditional aggregation with `CASE WHEN`
- Common Table Expressions (CTEs)
- Window Functions: `LAG()`, `DENSE_RANK()`, `ROW_NUMBER()`, `NTILE()`, and cumulative `SUM() OVER()`
- Customer and distributor contribution analysis
- Year-over-year growth calculations
- Data-quality checks and anomaly investigation

## Business Recommendations

1. **Monitor distributor dependency:** Review the concentration of sales among the largest distributors and assess options to strengthen distribution resilience.
2. **Prioritize high-value customers:** Develop appropriate account-management and retention approaches for the High Value segment, while exploring opportunities to grow other segments.
3. **Review product portfolio trends:** Investigate the growth of Antimalarial and the decline of Analgesics in Germany before making product, promotion, or supply decisions.
4. **Align channel strategy with market evidence:** Maintain visibility into Pharmacy / Retail performance in Germany and assess the role of Hospital / Private in Poland, noting the limited Polish time coverage.
5. **Strengthen negative-sales review:** Establish a process to investigate large and recurring negative sales records and confirm whether they represent returns, adjustments, or accounting corrections.
6. **Improve data traceability:** Introduce a unique transaction identifier and documented sales-representative assignment rules; automate validation of Quantity × Price against recorded Sales.

## Repository Structure

```text
pharma-sales-intelligence/
├── data/
│   └── raw/                 # Source CSV (include only if redistribution is permitted)
├── sql/
│   ├── 00_setup/             # MySQL import/environment configuration
│   ├── 01_data_model/        # Schema and table creation (source file pending)
│   ├── 02_data_cleaning/     # Cleaning transformations (source file pending)
│   ├── 03_data_quality/     # Validation and duplicate checks (source file pending)
│   ├── 04_sales_analysis/   # Overall, annual, and monthly sales (pending)
│   ├── 05_product_analysis/ # Product and product-class trends (pending)
│   ├── 06_customer_analysis/ # Customer performance and segmentation (pending)
│   ├── 07_distributor_analysis/ # Distributor performance (pending)
│   ├── 08_geographical_analysis/ # Country and city analysis (pending)
│   ├── 09_channel_analysis/ # Sales channel analysis (pending)
│   ├── 10_sales_team_analysis/ # Team and representative analysis (pending)
│   ├── 11_negative_sales_analysis/ # Negative sales investigation (pending)
│   ├── 12_high_volume_anomalies/ # High-volume and anomaly investigation (pending)
│   └── README.md            # SQL run order and file inventory
├── reports/                 # Business insights and supporting write-ups
├── dashboard/               # Power BI / Excel dashboard files and screenshots
├── README.md
└── .gitignore
```

The detailed file naming and migration plan is documented in [`sql/README.md`](sql/README.md). The data folder guidance is in [`data/raw/README.md`](data/raw/README.md).

## Data Source

The dataset was obtained from the following public GitHub repository:

[Pharma Sales Insights and Reporting](https://github.com/dyavadi8769/Pharma-Sales-Insights-and-Reporting)

Please retain the source attribution and check the source repository's license and terms before redistributing the CSV in this portfolio repository.

## How to Reproduce

1. Install MySQL 8.0 and MySQL Workbench (or another MySQL client).
2. Create a database named `pharma_analytics`.
3. Obtain the source CSV from the dataset repository linked above.
4. Import the CSV into a raw table named `pharma_raw`, preserving the original source fields.
5. Run the SQL scripts in the order documented in [`sql/README.md`](sql/README.md).
6. Review the result sets and compare them with the documented findings. Paths and import settings may need to be adjusted for the local environment.

## Limitations and Interpretation Notes

- No transaction/order identifier is available. Counts are described as **records**, not confirmed distinct orders.
- No actual inventory balances are provided; quantity is treated as recorded sales quantity, not stock on hand.
- No manufacturing costs or cost of goods sold are provided; profit and margin are not calculated.
- Negative Sales values may represent returns, adjustments, or corrections. Their precise business meaning cannot be confirmed from the available fields alone.
- Poland appears only in 2018 in this dataset. Do not interpret the absence of other Polish years as evidence of market exit or business closure.
- Duplicate candidates sharing sales details may differ in sales-representative, manager, or team assignment. Only fully identical rows were counted as exact duplicates; no rows were automatically deleted.
- The exceptional Ionclotide record is retained as an investigation flag. Its validity should be confirmed with the data owner before operational decisions are made.
- Customer segments are relative quartiles created with `NTILE(4)`, not fixed monetary customer tiers.

## Project Status

Core analyses and initial business recommendations are complete. The current SQL upload contained only `pharma.analytics.sql`, which was classified as MySQL import/environment setup and placed in `sql/00_setup/`. The other Workbench analysis files were not included in that ZIP, so the analysis folders are prepared but remain unpopulated until the original scripts are supplied. The remaining portfolio work is to import and review those scripts, validate the final run order, and build a dashboard.
