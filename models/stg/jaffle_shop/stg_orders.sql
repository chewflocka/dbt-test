with orders as (
	Select id as order_id,
		user_id as customer_id,
		order_date,
		status
	from {{source('raw_jaffle_shop','orders')}}
	)

Select * from orders