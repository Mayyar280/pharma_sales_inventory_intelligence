# Business Insights & Recommendations

## Key Business Insights

### Geographic Performance
Germany accounts for approximately 94.23% of total reported sales, highlighting a significant concentration of sales activity in the German market. Poland is represented in the dataset in 2018 only, so multi-year country comparisons are not available for Poland.

### Distributor Concentration
The top three distributors contribute approximately 68.75% of total sales. This indicates a high level of distributor concentration and highlights the importance of monitoring distributor dependency and distribution network resilience.

### Customer Value
The High Value customer segment represents approximately 25% of customers but contributes 43.97% of total sales. This demonstrates the importance of identifying and retaining high-value customers while exploring opportunities to develop lower-value segments.

### Product Portfolio Performance
Antimalarial recorded the strongest cumulative sales growth among the six product classes in Germany, increasing by approximately 28.48% between 2017 and 2020. In contrast, Analgesics declined by approximately 9.68% over the same period.

### Sales Channel Performance
Pharmacy/Retail remained the leading sales channel in Germany throughout the analyzed period. In Poland, Hospital/Private was the leading channel in 2018, contributing 30.42% of total Polish sales.

### Negative Sales and Data Quality
The dataset contains 2,633 negative sales records with a combined value of approximately -146.48 million. The data-quality investigation also identified 36 discrepancies between recorded sales and calculated quantity-price values, as well as four groups of fully identical records.

### High-Volume Sales Records
In 2019, records with quantities of 10,000 units or more represented approximately 0.13% of total records but contributed approximately 21.00% of total sales.

## Business Recommendations

1. **Geographic diversification:** Evaluate opportunities to reduce geographic dependency on Germany and investigate the potential for expanding activity in other markets.
2. **Distributor risk management:** Monitor the performance and dependency associated with the largest distributors and assess opportunities to strengthen the distribution network.
3. **Customer retention:** Prioritize relationship management and retention strategies for high-value customers while identifying opportunities to increase the value of other customer segments.
4. **Product portfolio review:** Investigate the growth of Antimalarial and the decline of Analgesics, and review products with unusually high sales fluctuations before making product or marketing decisions.
5. **Sales channel optimization:** Maintain focus on the strong Pharmacy/Retail channel in Germany while evaluating the role of Hospital/Private in Poland.
6. **Data quality controls:** Introduce automated validation checks, investigate negative sales records, review duplicate candidates, and implement unique transaction identifiers to improve data traceability.

## Limitations

The dataset does not include manufacturing costs, profit margins, or actual inventory balances. Consequently, the analysis focuses on reported sales performance and quantity movement rather than profitability or physical stock levels.

Negative sales records cannot be conclusively classified as product returns without additional transaction or accounting information. Furthermore, the absence of a unique transaction identifier limits the ability to distinguish genuine duplicate transactions from records with shared sales details but different sales-representative assignments.

Poland appears only in 2018 in this dataset. Customer segments are relative quartiles created with `NTILE(4)`, not fixed monetary customer tiers.
