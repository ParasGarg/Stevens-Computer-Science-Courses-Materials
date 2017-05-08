WITH nj_sales AS
(
	SELECT cust, prod, quant AS nj_min, day AS nj_day, month AS nj_month, year AS nj_year
	FROM sales S1
	WHERE quant = ( SELECT MIN(quant)
			FROM sales
			WHERE (cust, prod) = (S1.cust, S1.prod) AND state = 'NJ')
), ny_sales AS
(
	SELECT cust, prod, quant AS ny_min, day AS ny_day, month AS ny_month, year AS ny_year
	FROM sales S1
	WHERE quant = ( SELECT MIN(quant)
			FROM sales
			WHERE (cust, prod) = (S1.cust, S1.prod) AND state = 'NY')
), ct_sales AS
(
	SELECT cust, prod, quant AS ct_max, day AS ct_day, month AS ct_month, year AS ct_year
	FROM sales S1
	WHERE quant = ( SELECT MAX(quant)
			FROM sales
			WHERE (cust, prod) = (S1.cust, S1.prod) AND state = 'CT' AND 
				year BETWEEN 2000 AND 2005)
)	
SELECT *
FROM nj_sales NATURAL FULL JOIN ny_sales NATURAL FULL JOIN ct_sales
ORDER BY CUST, PROD