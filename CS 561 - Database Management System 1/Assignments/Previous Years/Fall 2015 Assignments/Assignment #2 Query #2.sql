with original_sales as 
(
	select cust, prod,  
		(case when month < 4 then 'Q1'
			when month < 7 then 'Q2'
			when month < 10 then 'Q3'
			when month < 13 then 'Q4'
		end) as Quater, quant
	from sales

), quater_info as 
(
	select cust, prod, quater, round(avg(quant),0) as quater_avg
	from original_sales
	group by cust, prod, quater

), before_quater as
(
	select t1.cust, t1.prod, t2.quater, t1.quater_avg
	from quater_info t1,  quater_info t2
	where t1.cust = t2.cust and t1.prod = t2.prod and 
		case when t1.quater = 'Q1' then t2.quater = 'Q2'
			when t1.quater = 'Q2' then t2.quater = 'Q3'
			when t1.quater = 'Q3' then t2.quater = 'Q4'
		end

), after_quater as
(
	select t1.cust, t1.prod, t2.quater, t1.quater_avg
	from quater_info t1, quater_info t2
	where t1.cust = t2.cust and t1.prod = t2.prod and 
		case when t1.quater = 'Q2' then t2.quater = 'Q1'
			when t1.quater = 'Q3' then t2.quater = 'Q2'
			when t1.quater = 'Q4' then t2.quater = 'Q3'
		end

), before_result as
(
	select t1.cust, t1.prod, t1.quater, t2.quater_avg
	from quater_info t1 left join before_quater t2
	on t1.cust = t2.cust and t1.prod = t2.prod and t1.quater = t2.quater

), after_result as
(
	select t1.cust, t1.prod, t1.quater, t2.quater_avg
	from quater_info t1 left join after_quater t2
	on t1.cust = t2.cust and t1.prod = t2.prod and t1.quater = t2.quater
)
select t1.cust, t1.prod, t1.quater, t1.quater_avg, t2.quater_avg
from before_result t1, after_result t2
where t1.cust = t2.cust and t1.prod = t2.prod and t1.quater = t2.quater
order by cust, prod, quater