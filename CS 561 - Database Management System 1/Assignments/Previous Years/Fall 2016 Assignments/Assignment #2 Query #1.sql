with custprod_sales as 
(
	select cust, prod, sum(quant) as S1, count(quant) as C1, round(avg(quant), 0) as CUST_AVG
	from sales
	group by cust, prod

), other_prod_sales as
(
	select prod, sum(quant) as S3, count(quant) as C3
	from sales
	group by prod
	
), other_cust_sales as
(
	select cust, sum(quant) as S2, count(quant) as C2
	from sales
	group by cust

)
select cp.cust, cp.prod, CUST_AVG, round((S3-S1)/(C3-C1),0) as OTHER_PRODUCT_AVG, round((S2-S1)/(C2-C1),0) as OTHER_CUST_AVG
from custprod_sales cp, other_prod_sales op, other_cust_sales oc
where cp.prod = op.prod and cp.cust = oc.cust 