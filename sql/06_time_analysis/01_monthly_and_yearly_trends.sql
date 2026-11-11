-- Pharma Sales & Inventory Intelligence
-- 01 Monthly And Yearly Trends
-- Organized from the user's original SQL file.
-- Original query text is preserved; review notes are in README.md.

-- Original query #49 | source line 626
select  distinct month
 from pharma_clean;

-- Original query #50 | source line 629
select 
   month,
   count(*) as total_record,
   round(sum(sales),2) as tot_sales,
   round(avg(sales),2) as avg_sales,
   round(sum(quantity),2) as tot_quantity
from pharma_clean
group by month
order by
case   
  month 
  when 'january' then 1
  when 'february' then 2
  when 'march' then 3
  when 'april' then 4
  when 'may' then 5
  when 'june' then 6
  when 'july' then 7
  when 'august' then 8
  when 'september' then 9
  when 'october' then 10
  when 'november' then 11
  when 'december' then 12
   end;

-- Original query #51 | source line 653
select 
   month,
   count(*) as total_record,
   round(sum(sales),2) as tot_sales,
   round(avg(sales),2) as avg_sales,
   round(sum(quantity),2) as tot_quantity
from pharma_clean
group by month
order by
case   
  month 
  when 'january' then 1
  when 'february' then 2
  when 'march' then 3
  when 'april' then 4
  when 'may' then 5
  when 'june' then 6
  when 'july' then 7
  when 'august' then 8
  when 'september' then 9
  when 'october' then 10
  when 'november' then 11
  when 'december' then 12
   end;

-- Original query #52 | source line 678
select year_,
   month,
   count(*) as total_record,
   round(sum(sales),2) as tot_sales,
   round(avg(sales),2) as avg_sales,
   round(sum(quantity),2) as tot_quantity
from pharma_clean
group by month , year_
order by
year_,
case   
  month 
  when 'january' then 1
  when 'february' then 2
  when 'march' then 3
  when 'april' then 4
  when 'may' then 5
  when 'june' then 6
  when 'july' then 7
  when 'august' then 8
  when 'september' then 9
  when 'october' then 10
  when 'november' then 11
  when 'december' then 12
   end;

-- Original query #53 | source line 704
with monthly_sales as(
select year_,
       month,
       round(sum(sales),2) as tot_sales
from pharma_clean
group by year_,month),
growth_monthly as (
     select year_,
     month,
     tot_sales,
     lag(tot_sales)over (partition by month order by year_) as previos_year_sales
     from monthly_sales)
     select year_,
            month,
            tot_sales,
            previos_year_sales,
            round((tot_sales-previos_year_sales) / nullif(previos_year_sales,0) ,2) as grothly_ptc
	 from growth_monthly 
     order by 
      case month 
          when 'january' then 1
  when 'february' then 2
  when 'march' then 3
  when 'april' then 4
  when 'may' then 5
  when 'june' then 6
  when 'july' then 7
  when 'august' then 8
  when 'september' then 9
  when 'october' then 10
  when 'november' then 11
  when 'december' then 12
   end,
   year_;

-- Original query #54 | source line 739
select 
year_,
product_class,
count(*) as tot_record,
round(sum(sales),2)  as tot_sales,
round(avg(sales),2) as avg_sales,
sum(quantity) as tot_quantity
from pharma_clean
where month = 'august'and
year_ in (2018,2019,2020)
group by year_,product_class
order by year_,tot_sales;
