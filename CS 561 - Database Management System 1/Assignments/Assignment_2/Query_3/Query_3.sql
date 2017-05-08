WITH original_sales AS 
(
	SELECT cust, prod, month, sum(quant) AS MONTH_SALES
	FROM sales
	GROUP BY cust, prod, month

), total_sales AS
(
	SELECT t1.cust, t1.prod, t1.month, sum(t2.MONTH_SALES) AS COMBINED_SALES
	FROM original_sales t1, original_sales t2
	WHERE t1.cust = t2.cust AND t1.prod = t2.prod AND t1.month >= t2.month
	GROUP BY t1.cust, t1.prod, t1.month

), target_sales AS
(
	SELECT cust, prod, round(sum(MONTH_SALES)/3,0) AS TARGETED_SALES
	FROM original_sales
	GROUP BY cust, prod
)

SELECT t1.cust AS "CUSTOMER", t1.prod AS "PRODUCT", min(t1.month) AS "1/3 PURCHASED BY MONTH"
FROM total_sales t1, target_sales t2
WHERE t1.cust = t2.cust AND t1.prod = t2.prod AND combined_sales >= targeted_sales
GROUP BY t1.cust, t1.prod