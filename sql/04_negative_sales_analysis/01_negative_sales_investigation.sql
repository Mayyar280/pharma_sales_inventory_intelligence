-- Pharma Sales & Inventory Intelligence
-- 01 Negative Sales Investigation
-- Organized from the user's original SQL file.
-- Original query text is preserved; review notes are in README.md.

-- Original query #7 | source line 32
select count(*) as tot_record,
min(sales) as mi_sales,
max(sales) as mx_sales
from pharma_analytics.pharma_raw
where sales <0;

-- Original query #8 | source line 38
select count(*) as tot_record,
min(sales) as mi_sales,
max(sales) as mx_sales
from pharma_analytics.pharma_raw
where sales > 0;

-- Original query #9 | source line 44
select year_,
product_name,
country,
product_class,
quantity,
price,
sales,
month
from pharma_analytics.pharma_raw
where sales < 0
order by sales;

-- Original query #10 | source line 56
select
country,
count(*) as neg_record,
round(sum(sales) , 2) as neg_sum_sales,
round(avg(quantity),2) as neg_avg_quantity
from pharma_analytics.pharma_raw
where sales < 0
group by country
order by neg_record;

-- Original query #11 | source line 66
SELECT
    Country,
    COUNT(*) AS total_records,
    SUM(CASE WHEN Sales < 0 THEN 1 ELSE 0 END)
        AS negative_records,
    ROUND(
        100.0 * SUM(CASE WHEN Sales < 0 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS negative_percentage,
    ROUND(
        SUM(CASE WHEN Sales < 0 THEN Sales ELSE 0 END),
        2
    ) AS sum_negative_sales,
    ROUND(SUM(Sales), 2) AS net_total_sales
FROM pharma_analytics.pharma_raw
GROUP BY Country
ORDER BY negative_percentage DESC;

-- Original query #12 | source line 85
select 
 year_ , 
  count(*) as neg_record ,
  round(sum(sales) ,2) as total_neg_sales,
  round(avg(sales) ,2) as avg_neg_sales 
  from pharma_analytics.pharma_raw
  where sales < 0
  group by year_
  order by year_;

-- Original query #13 | source line 95
select 
   year_ ,
   count(*) as tot_record ,
   sum(case when sales < 0 then 1 else 0 end) as neg_record ,
   (100.0 * sum(case when sales < 0 then 1 else 0 end) / count(*) )as neg_percentage , 
   sum(sales) as tot_sales 
from pharma_analytics.pharma_raw
group by year_
order by year_;

-- Original query #14 | source line 106
select 
  product_class ,
  count(*) as tot_record ,
  round(sum(sales) , 2) as tot_neg_sales ,
  round(avg(sales) , 2) as avg_neg_sales 
from pharma_analytics.pharma_raw
where sales < 0
group by Product_class
order by tot_record desc ;

-- Original query #15 | source line 116
select 
 product_name,
 product_class,
 count(*) as neg_record,
 round(sum(sales) , 2) as tot_neg_sales,
 round(avg(sales) , 2) as avg_neg_sales
from pharma_analytics.pharma_raw
where sales < 0
group by Product_Name , Product_class
order by neg_record desc
limit 15;

-- Original query #16 | source line 128
select
 product_name ,
 product_class ,
 count(*) as total_record ,
 sum(case when sales < 0 then 1 else 0 end)  as negativ_record ,
 round (100.0 * sum(case when sales < 0 then 1 else 0 end) / count(*) , 2 ) as neg_precentage ,
 round (sum(case when sales < 0 then sales else 0 end) , 2) as neg_sales_total
from pharma_analytics.pharma_raw
group by Product_Name , Product_class
having sum(case when sales < 0 then 1 else 0 end) > 0
order by negativ_record desc , neg_precentage desc
limit 15;
