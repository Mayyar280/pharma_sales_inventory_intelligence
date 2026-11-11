-- Pharma Sales & Inventory Intelligence
-- 01 Country And City Analysis
-- Organized from the user's original SQL file.
-- Original query text is preserved; review notes are in README.md.

-- Original query #41 | source line 494
select 
      name_of_manager,
      sales_team,
      count(*) as tot_record,
      count(distinct customer_name) as tot_customer,
      round(sum(sales) , 2) as tot_sales,
      round(avg(sales) ,2) as av_sales_per_record
	from pharma_clean
    group by name_of_manager, sales_team
    order by tot_sales desc;

-- Original query #43 | source line 517
with
    cities_sales as (
       select
        country,
        city,
        count(*) as tot_record,
        count(distinct customer_name) as tot_customer,
        round(sum(sales) ,2) as tot_sales
	   from pharma_clean
       group by country,city),
ranked_cities as(
     select 
      country,
      city,
      tot_record,
      tot_customer,
      tot_sales,
      dense_rank() over( partition by country order by tot_sales desc) as city_rank
      from cities_sales)
      select * 
      from ranked_cities
      where city_rank <= 5
      order by country , city_rank;

-- Original query #44 | source line 541
with city_sales as ( 
      select 
			 country,
             city,
             sum(sales) as tot_sales
             from pharma_clean
             group by country,city),
	city_contribution as (
      select
             country,
             city,
             tot_sales,
             sum(tot_sales)over(partition by country ) as country_sales,
             dense_rank() over(partition by country order by tot_sales desc) as ranked_city
			from city_sales)
	 select 
             country,
             city,
             tot_sales,
             country_sales,
            round( tot_sales / nullif(country_sales , 0) *100 ,2) as ptc_contribution
            from city_contribution
            where ranked_city <= 5
            order by country,ranked_city;

-- Original query #45 | source line 566
SELECT
    Sales_team,
    COUNT(*) AS total_records,
    COUNT(DISTINCT Customer_Name) AS total_customers,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(AVG(Sales), 2) AS avg_sales,
    ROUND(
        SUM(Sales) /
        (SELECT SUM(Sales) FROM pharma_clean) * 100,
        2
    ) AS contribution_pct
FROM pharma_clean
GROUP BY Sales_team
ORDER BY total_sales DESC;
