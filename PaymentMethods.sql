SELECT
	FORMAT(t.orderdate, 'yyyy-MM') AS orderdate,
    t.payment_method,
    COUNT(t.payment_method) / 4 AS payment_average,
	sum(t.total_amount) as total_amount 
FROM 
    (
	select 
		*, convert(date,order_date) as orderdate 
	from 
		[dbo].[Transactions] 
	) t
GROUP BY 
    FORMAT(t.orderdate, 'yyyy-MM'),
    t.payment_method
order by
	orderdate