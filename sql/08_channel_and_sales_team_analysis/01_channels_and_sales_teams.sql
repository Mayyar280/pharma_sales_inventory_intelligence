-- Pharma Sales & Inventory Intelligence
-- 01 Channels And Sales Teams
-- Organized from the user's original SQL file.
-- Original query text is preserved; review notes are in README.md.

-- Original query #42 | source line 505
select
      country,
      city,
      count(*) as tot_record,
      count(distinct customer_name) as tot_customers,
      round(sum(sales) , 2) as tot_sales,
      round(100.0* sum(sales)/ (select sum(sales) from pharma_clean),2) as sales_pre
	from pharma_clean
    group by country,city
    order by tot_sales desc
    limit 15;

-- Original query #46 | source line 581
select 
name_of_manager,
sales_team,
count(*) as tot_record,
count(distinct name_of_sales_rep) as tot_rep,
count(distinct customer_name) as tot_customer,
round(sum(sales) ,2) as tot_sales,
round(avg(sales),2) as avg_sales,
round(sum(sales) / (select sum(sales) from pharma_clean) *100 ,2) as contribution_ptc
from pharma_clean
group by name_of_manager , sales_team
order by tot_sales desc;

-- Original query #47 | source line 594
select count(distinct customer_name)
from pharma_clean;

-- Original query #48 | source line 597
with sales_rep as (
  select  
      name_of_manager,
      sales_team,
      name_of_sales_rep,
      count(*) as tot_record,
      count(distinct customer_name) as tot_customer,
      round(sum(sales),2) as tot_sales,
      round(avg(sales),2) as avg_sales
      from pharma_clean 
      group by name_of_manager,sales_team,name_of_sales_rep),
	team_totals as( 
    select 
      * ,
      sum(tot_sales) over(partition by sales_team) as team_sales
      from sales_rep)
      
      select 
        name_of_manager,
        sales_team,
        name_of_sales_rep,
        tot_record,
        tot_customer,
        tot_sales,
        avg_sales,
        round(tot_sales / nullif(team_sales,0) *100 ,2) as team_cuntribution_sales
        from team_totals
        order by sales_team desc , tot_sales desc;
