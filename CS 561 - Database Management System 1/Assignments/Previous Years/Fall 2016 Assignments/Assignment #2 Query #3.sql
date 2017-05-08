with original_sales as 
(
	select cust, prod, month, round(avg(quant),0) as avg_sale, max(quant) as max_sale
	from sales
	group by cust, prod, month

), before_sales as
(
	select t1.cust, t1.prod, t1.month, count(t2.quant) as before_tot
	from original_sales t1, sales t2
	where t1.cust = t2.cust and t1.prod = t2.prod and t1.month = t2.month+1 and
		t2.quant between t1.avg_sale and t1.max_sale
	group by t1.cust, t1.prod, t1.month

), after_sales as
(
	select t1.cust, t1.prod, t1.month, count(t2.quant) as after_tot
	from original_sales t1, sales t2
	where t1.cust = t2.cust and t1.prod = t2.prod and t1.month = t2.month-1 and
		t2.quant between t1.avg_sale and t1.max_sale
	group by t1.cust, t1.prod, t1.month

), before_result as
(
	select t1.cust, t1.prod, t1.month, t2.before_tot
	from original_sales t1 left join before_sales t2
	on t1.cust = t2.cust and t1.prod = t2.prod and t1.month = t2.month
	
), after_result as
(
	select t1.cust, t1.prod, t1.month, t2.after_tot
	from original_sales t1 left join after_sales t2
	on t1.cust = t2.cust and t1.prod = t2.prod and t1.month = t2.month	
)
select b.cust, b.prod, b.month, before_tot, after_tot
from before_result b, after_result a
where b.cust = a.cust and b.prod = a.prod and b.month = a.month
order by b.cust, b.prod, b.month