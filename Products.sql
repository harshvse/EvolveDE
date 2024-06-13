WITH typeconvertion AS (
    select 
		*,CONVERT(DATE, order_date) AS orderdate 
	from 
		[dbo].[Transactions]
), products as(
SELECT
	t.orderdate,
	t.product_id,
	p.product_name,
	t.quantity,
	t.total_amount,
	t.order_number,
	ROW_NUMBER() OVER (PARTITION BY t.order_number ORDER BY t.order_number) AS rn
FROM
  	(select *,ROW_NUMBER() OVER (ORDER BY orderdate) AS order_number from typeconvertion WHERE
    orderdate between '2024-03-03' and '2024-04-02') t
left JOIN
  	[dbo].[StoresWithProducts] p
ON
  	t.product_id = p.product_id
)
SELECT 
    orderdate,
    product_id,
    product_name,
    quantity,
    total_amount,
    order_number
FROM 
    products
WHERE 
    rn = 1 