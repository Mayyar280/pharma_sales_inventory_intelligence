-- Pharma Sales & Inventory Intelligence
-- 01 Distributor Performance
-- Organized from the user's original SQL file.
-- Original query text is preserved; review notes are in README.md.

-- Original query #71 | source line 1003
select row_number()over(order by distributor) as row_num,
           distributor,
		   country,
           count(*) as tot_record,
           count(distinct customer_name) as tot_customers,
           count(distinct product_name) as tot_products,
           round(sum(sales),2) as tot_sales,
           round(avg(sales),2) as avg_sales,
           sum(quantity) as tot_quantity
	from pharma_clean
    group by distributor , country;

-- Original query #72 | source line 1014
with distributor_sales as(
                 select distributor,
                        country,
                        count(*) as tot_record,
                        round(sum(sales),2) as tot_sales
				from pharma_clean
                group by distributor , country),
		distributor_metrics  as (
                           select *,
                                   sum(tot_sales)over() as company_tot_sales,
                                   sum(tot_sales)over(order by tot_sales desc,distributor asc
                                   rows between unbounded preceding and current row) as cumulative_sales
							from distributor_sales)
				select row_number()over(),
                       distributor,
                       country,
                       tot_record,
                       tot_sales,
                       cumulative_sales,
                       round(tot_sales / company_tot_sales *100.0 ,2) as ptc_distributor,
                       round(cumulative_sales / company_tot_sales *100.0 ,2) as cumulative_ptc
				from distributor_metrics 
                order by tot_sales desc;

-- Original query #73 | source line 1038
with customer_distributor as (
              select customer_name,
                     country,
                     count(distinct distributor) as num_distributor,
                     round(sum(sales),2) as tot_sales,
                     count(*) as tot_record
			from pharma_clean
            group by customer_name , country)
		select country ,
               num_distributor,
              sum( tot_sales) as tot_sales,
               sum(tot_record) as tot_record,
               count(*) as tot_customers
               from customer_distributor
               group by country,num_distributor 
			 
             order by country , num_distributor;

-- Original query #74 | source line 1056
with dist_yearly as(
                      select
                      distributor,
                      country,
                      year_,
                      count(*) as tot_record,
                      round(sum(sales),2) as tot_sales,
                      sum(quantity) as tot_quantity
                      from pharma_clean 
                      group by distributor,
                      country,
                      year_),
		dist_rank as (
                      select
                           *,
                           dense_rank()over(partition by country,year_ order by tot_sales desc) as rank_sales
                           from dist_yearly
                           )
                           select 
                           country,
                           year_,
                           rank_sales,
                           distributor,
                           tot_record,
                           tot_sales,
                           tot_quantity
					from dist_rank
                    where rank_sales <=5
                   order by  country,
                           year_,
                           rank_sales;
