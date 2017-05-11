WITH sales_months AS
(
	SELECT cust, prod, generate_series(1, 12) as MONTH
	FROM sales
	GROUP BY cust, prod

), before_month AS 
(
	SELECT sm.cust, sm.prod, sm.month, round(avg(quant),0) as BEFORE_AVG
	FROM sales_months sm, sales s 
	WHERE sm.cust = s.cust AND sm.prod = s.prod AND sm.month = s.month+1
	GROUP BY sm.cust, sm.prod, sm.month

), after_month AS 
(
	SELECT sm.cust, sm.prod, sm.month, round(avg(quant),0) as AFTER_AVG
	FROM sales_months sm, sales s 
	WHERE sm.cust = s.cust AND sm.prod = s.prod AND sm.month = s.month-1
	GROUP BY sm.cust, sm.prod, sm.month

), before_result AS
(
	SELECT sm.cust, sm.prod, sm.month, BEFORE_AVG
	FROM sales_months sm LEFT JOIN before_month bm 
	ON sm.cust = bm.cust AND sm.prod = bm.prod AND sm.month = bm.month

), after_result AS
(
	SELECT sm.cust, sm.prod, sm.month, AFTER_AVG
	FROM sales_months sm LEFT JOIN after_month am 
	ON sm.cust = am.cust AND sm.prod = am.prod AND sm.month = am.month

)
SELECT B.cust AS "CUSTOMER", B.prod AS "PRODUCT", B.month AS "MONTH", BEFORE_AVG AS "BEFORE_AVG", AFTER_AVG AS "AFTER_AVG"
FROM before_result B, after_result A
WHERE B.cust = A.cust AND B.prod = A.prod AND B.month = A.month
