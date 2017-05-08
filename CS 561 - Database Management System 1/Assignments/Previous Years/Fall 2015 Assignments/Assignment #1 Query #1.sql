with cust_sales as 
(
	select cust, prod, min(quant) as MIN_Q, max(quant) as MAX_Q, round(avg(quant), 0) as AVG_Q
	from sales
	group by cust, prod
	
), min_sales as
(
	select c.cust, c.prod, min_q, s.day, s.month, s.year
	from cust_sales c, sales s
	where c.cust = s.cust and c.prod = s.prod and c.min_q = s.quant

), max_sales as 
(
	select c.cust, c.prod, max_q, s.day, s.month, s.year
	from cust_sales c, sales s
	where c.cust = s.cust and c.prod = s.prod and c.max_q = s.quant
)
select mi.cust, mi.prod, min_q, mi.day, mi.month, mi.year, max_q, ma.day, ma.month, ma.year
from min_sales mi, max_sales ma
where mi.cust = ma.cust and mi.prod = ma.prod