WITH tbl_original AS
(
	SELECT cust, prod, month, round(avg(quant),0) AS AVG
	FROM sales
	GROUP BY cust, prod, month

), tbl_before AS 
(
	SELECT t1.cust, t1.prod, t2.month, t1.AVG AS BEFORE_MONTH
	FROM tbl_original t1, tbl_original t2
	WHERE t1.cust = t2.cust AND t1.prod = t2.prod AND t1.month = t2.month-1
	
), tbl_after AS 
(
	SELECT t1.cust, t1.prod, t2.month, t1.AVG AS AFTER_MONTH
	FROM tbl_original t1, tbl_original t2
	WHERE t1.cust = t2.cust AND t1.prod = t2.prod AND t1.month = t2.month+1

), before_result AS 
(
	SELECT O.cust, O.prod, O.month, BEFORE_MONTH
	FROM tbl_original O LEFT JOIN tbl_before B
	ON O.cust = B.cust AND O.prod = B.prod AND O.month = B.month

), after_result AS 
(
	SELECT O.cust, O.prod, O.month, AFTER_MONTH
	FROM tbl_original O LEFT JOIN tbl_after A
	ON O.cust = A.cust AND O.prod = A.prod AND O.month = A.month

)
SELECT B.cust AS "CUSTOMER", B.prod AS "PRODUCT", B.month AS "MONTH", BEFORE_MONTH AS "BEFORE_AVG", AFTER_MONTH AS "AFTER_AVG"
FROM before_result B, after_result A
WHERE B.cust = A.cust AND B.prod = A.prod AND B.month = A.month