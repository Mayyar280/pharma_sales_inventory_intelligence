-- Pharma Sales & Inventory Intelligence
-- 01 Customer Value And Concentration
-- Organized from the user's original SQL file.
-- Original query text is preserved; review notes are in README.md.

-- Original query #65 | source line 868
with customer_sales as (
       select customer_name,
              country,
              city,
              count(*) as tot_record,
              sum(quantity) as tot_quantity,
              round(sum(sales),2) as tot_sales
              from pharma_clean
              group by customer_name, country, city),
		customer_contribution as (
              select * , sum(tot_sales) over() as company_customer_sales
              from customer_sales)
		select
           customer_name,
           country,
           city,
           tot_quantity,
           tot_record,
           round(tot_sales,2) as tot_sales,
           round(tot_sales / nullif(company_customer_sales,0) *100.0 ,3) as ptc_sales_customer
           from
           customer_contribution
           order by tot_sales desc
           limit 20;

-- Original query #66 | source line 893
with customer_sales as (
               select customer_name,
					  country,
                      city,
                      round(sum(sales),2) as tot_sales
			   from pharma_clean
               group by customer_name , country , city
               ),
	customer_ranking as( 
               select *,
                      sum(tot_sales)over() as  company_total_sales,
                      row_number() over(order by tot_sales desc) as customer_rank
			   from customer_sales),
	cumulative_sales as (
			   select * ,
					sum(tot_sales)over(order by tot_sales desc rows between unbounded preceding and current row) as cumulative_sales
			   from customer_ranking)
			select customer_name,
            country,
            customer_rank,
             ROUND(tot_sales, 2) AS total_sales,
    ROUND(
        tot_sales / NULLIF(company_total_sales, 0) * 100,
        3
    ) AS customer_contribution_pct,
    ROUND(
        cumulative_sales / NULLIF(company_total_sales, 0) * 100,
        3
    ) AS cumulative_contribution_pct
FROM cumulative_sales
WHERE customer_rank <= 20
ORDER BY customer_rank;

-- Original query #67 | source line 926
with customer_sales as (
		select customer_name,
               country,
               sum(sales) as tot_sales
        from pharma_clean
        group by customer_name , country),
	customer_rank as (
        select * ,
           sum(tot_sales)over()as company_sales,
           row_number()over(order by tot_sales desc) as rank_number
		from customer_sales),
	customer_summury as (
        select count(*) as tot_customers,
			   max(company_sales) as company_sales
		from customer_rank),
	concentration as (
        select 
               sum(case when rank_number <= 5 then tot_sales end) as top_5_sales,
               sum(case when rank_number <= 10 then tot_sales end) as top_10_sales,
               sum(case when rank_number <= 20 then tot_sales end) as top_20_sales,
               sum(case when rank_number <= 50 then tot_sales end) as top_50_sales
			from customer_rank)
	   select 
         s.tot_customers,
         s.company_sales,
         round(c.top_5_sales / s.company_sales * 100.0 , 2) as ptc_5_customer,
         round(c.top_10_sales / s.company_sales * 100.0 , 2) as ptc_10_customer,
         round(c.top_20_sales / s.company_sales * 100.0 , 2) as ptc_20_customer,
         round(c.top_50_sales / s.company_sales  * 100.0 , 2)as ptc_50_customer
		from customer_summury s cross join concentration c;

-- Original query #68 | source line 957
select  country,
                count(distinct customer_name) as tot_customers,
		        count(*) as tot_record,
                round(sum(sales),2) as tot_sales,
                round(avg(sales),2) as avg_sales,
                round(sum(sales) / count(distinct customer_name),2) as avg_sales_per_customer
			from pharma_clean
            group by country
            order by tot_sales desc;

-- Original query #69 | source line 967
select customer_name,
			   country,
               round(sum(sales),2) as tot_sales,
               round(avg(sales),2) as avg_sales,
               count(*) tot_record,
               count(distinct year_) as active_year,
               count(distinct concat(year_,'-',month) )as active_month
			from pharma_clean
            group by customer_name , country
            order by active_month desc , tot_sales desc
            limit 20;

-- Original query #70 | source line 979
with customer_sales as (
             select customer_name,
                    country,
                    round(sum(sales),2) as tot_sales
				from pharma_clean
                group by customer_name , country),
		customer_segments as ( 
                select customer_name,
                country,
                tot_sales,
                ntile(4)over(order by tot_sales desc) as segment_num
			from customer_sales)
		select case 
                 when segment_num = 1 then 'high value'
                 when segment_num = 2 then 'medium value'
                 when segment_num = 3 then 'low value'
                 else 'very low value' end as segment_customers,
                count(*) as tot_record,
                round(sum(tot_sales),2) as tot_sales,
                round(avg(tot_sales),2) as avg_sales_per_customer
                from customer_segments
                group by segment_num
                order by segment_num;
