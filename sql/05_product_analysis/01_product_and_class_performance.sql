-- Pharma Sales & Inventory Intelligence
-- 01 Product And Class Performance
-- Organized from the user's original SQL file.
-- Original query text is preserved; review notes are in README.md.

-- Original query #39 | source line 472
select 
  product_class,
  count(distinct product_name) as tot_product,
  round(sum(sales),2) as tot_sales,
  round(sum(quantity),2) as tot_quantity,
  round(avg(sales),2) as avg_sales,
  round(100.0 * sum(sales) / (select sum(sales) from pharma_clean) , 2) as prec_sales
  from pharma_analytics.pharma_clean
  group by product_class
  order by tot_sales desc;

-- Original query #40 | source line 483
select
    chanals,
    sub_channal,
    count(*) as tot_record,
    count(distinct Customer_Name) as tot_customer,
    round(sum(sales),2) as tot_sales,
    round(100.0*sum(sales) / (select sum(sales) from pharma_clean) ,2) as sales_precentage
    from pharma_analytics.pharma_clean
    group by chanals,Sub_Channal
    order by tot_sales desc;

-- Original query #55 | source line 752
SELECT
    Year_,
    Product_Name,
    COUNT(*) AS total_records,
    SUM(Quantity) AS total_quantity,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(AVG(Sales), 2) AS avg_sales
FROM pharma_clean
WHERE Month = 'August'
  AND Year_ IN (2018, 2019, 2020)
  AND Product_class = 'Analgesics'
GROUP BY
    Year_,
    Product_Name
ORDER BY
    Year_,
    total_sales DESC;
