-- Pharma Sales & Inventory Intelligence
-- 01 Completeness Duplicates And Validation
-- Organized from the user's original SQL file.
-- Original query text is preserved; review notes are in README.md.

-- Original query #17 | source line 141
select 
product_name,
quantity,
sales,
price,
round (quantity * price ,2) as calculat_sales,
round (sales - (quantity*price) , 2 ) as differince 
from pharma_analytics.pharma_raw
where abs(sales - (quantity * price))  > 0.01
limit 20;

-- Original query #18 | source line 152
select 
 count(*) as total_records,
 sum(case when abs(sales - (quantity * price)) > 0.01 then 1 else 0 end)  as mismatch_records,
 round(100.0 * sum(case when abs(sales-(quantity*price)) > 0.01 then 1 else 0 end) /count(*) , 2) as prec_mismatch_records,
 sum(case when quantity = 0 and sales <> 0 then 1 else 0 end) as dif_res
from pharma_analytics.pharma_raw;

-- Original query #19 | source line 160
select
product_name,
sales,
price,
quantity,
year_,
month,
country,
(quantity * price) as calculate_sales,
(sales - (quantity * price)) as difference
from pharma_analytics.pharma_raw
where abs(sales -(quantity * price)) > 0.01
order by abs(sales -(quantity * price)) desc;

-- Original query #20 | source line 174
select 
year_,
month,
count(*) as mismach_count,
round(sum(abs(sales-(quantity*price))) ,2) as tot_absulote_record
from pharma_analytics.pharma_raw
where abs(sales-(quantity*price)) > 0.01
group by year_,month
order by year_,mismach_count desc;

-- Original query #21 | source line 184
select 
 count(*) as total_record,
 sum(case when sales is null then 1 else 0 end) as mis_sales,
 sum(case when quantity is null then 1 else 0 end) as mis_quantity,
 sum(case when year_ is null then 1 else 0 end) as mis_year,
 sum(case when price is null then 1 else 0 end) as mis_price,
 sum(case when month is null or trim(month)='' then 1 else 0 end) as mis_month,
  sum(case when country is null or trim(country)='' then 1 else 0 end) as mis_country
  from pharma_analytics.pharma_raw;

-- Original query #22 | source line 194
SELECT
    Distributor,
    Customer_Name,
    City,
    Country,
    Product_name,
    Quantity,
    Price,
    Sales,
    Month,
    Year_,
    COUNT(*) AS duplicate_count
FROM pharma_analytics.pharma_raw
GROUP BY
    Distributor,
    Customer_Name,
    City,
    Country,
    Product_name,
    Quantity,
    Price,
    Sales,
    Month,
    Year_
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC
;

-- Original query #23 | source line 223
select 
count(*) as duplicate_groups,
sum(dup_count) as row_in_dup_group,
sum(dup_count - 1) as extra_duplicate_rows
from(
select count(*) as dup_count
from pharma_analytics.pharma_raw
group by Distributor,
        Customer_name,
        City,
        Country,
        Product_name,
        Quantity,
        Price,
        Sales,
        Month,
        Year_
    HAVING COUNT(*) > 1
) AS duplicates;

-- Original query #24 | source line 243
select 
year_,
country,
count(*) as row_in_dup_group,
sum(duplicate_count -1) as extra_dup_row_in_group
from(
select count(*) as duplicate_count,
 Year_,
        Country,
        Distributor,
        Customer_name,
        City,
        Product_name,
        Quantity,
        Price,
        Sales,
        Month
      from pharma_analytics.pharma_raw
      group by Year_,
        Country,
        Distributor,
        Customer_name,
        City,
        Product_name,
        Quantity,
        Price,
        Sales,
        Month
        having count(*) > 1
        ) as dup_detiels
        group by year_ , Country
        order by extra_dup_row_in_group;

-- Original query #25 | source line 276
select count(*) as tot_record,
sum(case when distributor <> trim(distributor) then 1 else 0 end) as dis_extra_space,
sum(case when customer_name <> trim(customer_name) then 1 else 0 end) cust_extra_space
from pharma_analytics.pharma_raw;

-- Original query #26 | source line 281
select 
concat('[' , distributor, ']') as original_dis,
concat('[' , trim(distributor) , ']') as  clean_dis,
count(*) as tot_record
from pharma_analytics.pharma_raw
where Distributor <> trim(Distributor)
group by original_dis , clean_dis
order by tot_record;

-- Original query #32 | source line 355
select 
count(*) as tot_record,
sum(case when distributor is null then 1 else 0 end )as dis_null,
sum(case when customer_name is null then 1 else 0 end ) as cu_null,
sum(case when city is null then 1 else 0 end ) as city_null,
sum(case when country is null then 1 else 0 end ) as count_null,
sum(case when product_class is null then 1 else 0 end ) as pro_null,
sum(case when quantity is null then 1 else 0 end )as quan_null,
sum(case when price is null then 1 else 0 end ) as price_null,
sum(case when sales is null then 1 else 0 end ) as sales_null,
sum(case when year_ is null then 1 else 0 end ) as year_null,
sum(case when month is null then 1 else 0 end ) as month_null
from pharma_analytics.pharma_clean;

-- Original query #33 | source line 370
select Distributor,
    Customer_Name,
    City,
    Country,
    Product_Name,
    Quantity,
    Price,
    Sales,
    Month,
    Year_ , 
    count(*) as dup_count
from pharma_analytics.pharma_clean
group by 
    Distributor,
    Customer_Name,
    City,
    Country,
    Product_Name,
    Quantity,
    Price,
    Sales,
    Month,
    Year_
HAVING COUNT(*) > 1
ORDER BY dup_count DESC
LIMIT 20;

-- Original query #34 | source line 397
SELECT
    COUNT(*) AS duplicate_groups,
    SUM(dup_count) AS rows_in_duplicate_groups,
    SUM(dup_count - 1) AS extra_duplicate_rows
FROM (
    SELECT COUNT(*) AS dup_count
    FROM pharma_clean
    GROUP BY
        Distributor,
        Customer_Name,
        City,
        Country,
        Product_Name,
        Quantity,
        Price,
        Sales,
        Month,
        Year_
    HAVING COUNT(*) > 1
) AS duplicates;

-- Original query #35 | source line 419
select 
year_,
country,
count(*) as total_orser,
sum(quantity) as total_cuantity,
round(sum(sales)) as total_sales,
round(avg(sales)) as avg_sales
from pharma_analytics.pharma_clean
group by 
year_,country
order by year_, total_sales desc
;
