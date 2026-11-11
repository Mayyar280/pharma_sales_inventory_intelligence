# Executive Summary

## Pharma Sales & Inventory Intelligence

This project analyzes 254,082 pharmaceutical sales records covering the period 2017–2020 across Germany and Poland. Using MySQL 8.0, the analysis explores sales performance, product trends, customer segmentation, distributor performance, sales channels, and data quality to identify meaningful business insights and support data-driven decision-making.

The analysis revealed that Germany accounts for approximately 94.23% of total reported sales, making it the company's primary market within the dataset. Sales are also highly concentrated among a small number of distributors, with the top three accounting for 68.75% of total sales. Customer segmentation showed that the High Value segment represents approximately 25% of customers while contributing 43.97% of total sales.

Product trend analysis identified Antimalarial as the strongest-growing product class in Germany, increasing by 28.48% between 2017 and 2020. Pharmacy/Retail remained the leading sales channel in Germany throughout the analyzed period. The investigation also identified 2,633 negative sales records, 36 sales-to-quantity-price discrepancies, and four groups of fully identical records. Additional investigations highlighted exceptional records with a significant impact on product-level sales performance.

The project demonstrates practical SQL skills through data cleaning, aggregations, Common Table Expressions (CTEs), Window Functions, and analytical queries. Its findings provide insights into market performance, distributor concentration, customer value, product trends, and data reliability.

**Project Scope & Limitations:** The dataset contains sales quantities and values but does not include actual inventory balances, manufacturing costs, or profit data. Therefore, the project focuses on sales and quantity movement rather than actual stock levels or profitability. Negative sales records are treated as investigation flags and are not automatically classified as confirmed returns.
