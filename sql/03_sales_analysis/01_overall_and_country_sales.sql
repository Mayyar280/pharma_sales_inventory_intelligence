-- Pharma Sales & Inventory Intelligence
-- 01 Overall And Country Sales
-- Organized from the user's original SQL file.
-- Original query text is preserved; review notes are in README.md.

-- Original query #3 | source line 3
select 
 count(*) as total_record,
 sum(sales) as sum_sales,
 max(sales) as max_sales,
 min(sales) as min_sales,
 avg(sales) as avg_sales
from pharma_analytics.pharma_raw;

-- Original query #4 | source line 11
select year_,
sum(sales) as annual_sales,
sum(quantity) as total_quantity
from pharma_analytics.pharma_raw
group by year_
order by year_;

-- Original query #5 | source line 18
select Product_name , sum(sales) as total_sales , sum(quantity) as total_quantity
from pharma_analytics.pharma_raw
group by Product_Name
order by  total_sales desc
limit 10;

-- Original query #6 | source line 24
select
 count(*) as total_records,
 round(sum(sales) , 2) as sums_sales,
 round(avg(sales) , 2) as avgs_sales,
 round(max(sales) , 2) as maxs_sales,
 round(min(sales) , 2) as mins_sales
from pharma_analytics.pharma_raw;

-- Original query #36 | source line 432
select country
from pharma_analytics.pharma_clean
group by Country;

-- Original query #37 | source line 436
with yearly_sales as(
 select
  year_,
  country,
  sum(sales) as total_sales
  from pharma_clean
  group by year_,country),
  sales_growth as(
 select 
  year_,
  country,
  total_sales,
  lag(total_sales) over( partition by country order by year_) as previous_year_sales
  from yearly_sales)
 select 
  year_,
  country,
  total_sales,
  previous_year_sales,
  round(total_sales - previous_year_sales  ,2) as sales_change,
  round(100.0*(total_sales - previous_year_sales)/nullif(previous_year_sales,0),2) as growth_precentage
  from sales_growth
  order by year_,country;

-- Original query #38 | source line 460
select
 product_name,
 product_class,
 sum(quantity) as tot_quantity,
 sum(sales) as tot_sales,
 avg(price) as avg_price,
 count(*) as tot_record
 from pharma_clean
 group by product_name,product_class
 order by tot_sales desc
 limit 10;
