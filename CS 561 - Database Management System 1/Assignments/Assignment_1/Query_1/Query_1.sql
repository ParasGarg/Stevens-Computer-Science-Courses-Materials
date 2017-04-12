WITH actual_sales AS
(
	SELECT cust, min(quant) AS min_q, max(quant) AS max_q, avg(quant) AS avg_q
	FROM sales
	GROUP BY cust 
),
min_sales AS
(
	SELECT A1.cust, min_q, S.prod, S.day, S.month, S.year, S.state
	FROM actual_sales A1, sales S
	WHERE A1.cust = S.cust AND min_q = S.quant
),
max_sales AS
(
	SELECT A2.cust, max_q, S.prod, S.day, S.month, S.year, S.state
	FROM actual_sales A2, sales S
	WHERE A2.cust = S.cust AND max_q = S.quant
)
SELECT A.cust, A.min_q, MIN.prod, MIN.day, MIN.month, MIN.year, MIN.state, A.max_q, MAX.prod, MAX.day, MAX.month, MAX.year, MAX.state, ROUND(A.avg_q)
FROM min_sales AS MIN, max_sales AS MAX, actual_sales AS A
WHERE MIN.cust = MAX.cust AND MIN.cust = A.cust AND MAX.cust = A.cust