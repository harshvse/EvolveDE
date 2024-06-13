SELECT
	FORMAT(t.orderdate, 'yyyy-MM') AS order_month,
	SUM(CAST(t.quantity AS bigint)) AS total_sales,
    SUM(CAST(t.total_amount AS bigint)) AS revenue,
	50000000 as threshold
FROM
    (
	select 
		* , CONVERT(DATE, order_date) AS orderdate 
	from
	 	[dbo].[Transactions] 
	) t
GROUP BY
    FORMAT(t.orderdate, 'yyyy-MM')
ORDER BY
    order_month;
