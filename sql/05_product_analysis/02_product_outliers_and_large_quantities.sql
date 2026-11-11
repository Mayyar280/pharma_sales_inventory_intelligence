-- Pharma Sales & Inventory Intelligence
-- 02 Product Outliers And Large Quantities
-- Organized from the user's original SQL file.
-- Original query text is preserved; review notes are in README.md.

-- Original query #56 | source line 770
select  *
    from pharma_clean
    where product_name = 'Ionclotide' and year_ in (2019) and month = 'august'
    order by quantity desc;

-- Original query #57 | source line 775
select 
       count(*) as tot_record,
       sum(quantity) as tot_quantity,
       sum(sales) as tot_sales,
       avg(sales) as avg_sales,
       sum(case when quantity = 117600 then sales else 0 end) as exceptional_sales,
       sum(sales) - sum(case when quantity = 117600 then sales else 0 end) as sales_without_exceptional
       from pharma_clean
       where product_name = 'ionclotide' and month = 'august' and year_ in (2019)
	;

-- Original query #58 | source line 787
select *
    from pharma_clean
    where product_name = 'ionclotide' and year_ in (2019)
    and quantity > 1000;

-- Original query #59 | source line 792
select *
    from pharma_clean
    where  Distributor = 'Bashirian-Kassulke'
    order by quantity desc
    limit 20;

-- Original query #60 | source line 798
select *
    from pharma_clean
    where quantity > 10000
   order by quantity desc
    limit 20;

-- Original query #61 | source line 804
select 
       distributor,
       count(*) as tot_record,
       count(distinct product_name) as tot_product,
       count(distinct customer_name) as tot_customer,
       sum(quantity) as tot_quantity,
       round(sum(sales),2) as tot_sales,
       max(quantity) as max_quantity
       from pharma_clean
       where quantity >= 10000
       group by distributor;

-- Original query #62 | source line 816
SELECT
    Year_,
    COUNT(*) AS large_records,
    COUNT(DISTINCT Distributor) AS distributors,
    COUNT(DISTINCT Product_Name) AS products,
    SUM(Quantity) AS total_quantity,
    ROUND(SUM(Sales), 2) AS total_sales,
    MAX(Quantity) AS max_quantity

FROM pharma_clean

WHERE Quantity >= 10000

GROUP BY Year_

ORDER BY Year_;

-- Original query #63 | source line 833
with yearly_analysis as (
    select 
     year_,
     count(*) as tot_record,
     sum(quantity) as tot_quantity,
     round(sum(sales),2) as tot_sales,
     sum(case when quantity >= 10000 then 1 else 0 end) as larg_record,
	 sum(case when quantity >= 10000 then quantity else 0 end) as larg_quantity,
	 sum(case when quantity >= 10000 then sales else 0 end) as larg_sales
     from pharma_clean
     group by year_)
     select 
       year_,
       tot_record,
       tot_quantity,
       tot_sales,
       round(larg_record *100.0 / tot_record ,2) as larg_record_ptc,
       round(larg_quantity *100.0 / tot_quantity ,2) as larg_quantity_ptc,
       round(larg_sales *100.0 / tot_sales ,2) as larg_sales_ptc
	from yearly_analysis
    order by year_;

-- Original query #64 | source line 855
select 
      customer_name,
      country,
      city,
      count(*) as tot_record,
      round(sum(sales),2) as tot_sales,
      round(avg(sales),2) as avg_sales,
      sum(quantity) as tot_quantity
	from pharma_clean
    group by customer_name,      country ,city
    order  by tot_sales desc
    limit 20;
