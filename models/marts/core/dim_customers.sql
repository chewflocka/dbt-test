WITH 
customers as (
    Select * from {{ref('stg_customers')}}
),
orders as (
    Select * from {{ref('fct_orders')}}
),
customer_orders as (

	Select customer_id,
		min(order_date) as first_order_date,
		max(order_date) as last_order_date,
		count(order_id) as number_of_orders,
		sum(amount) as lifetime_value
	from orders
	group by customer_id
	),
final as (
	Select customers.customer_id,
		customers.first_name,
		customers.last_name,
		customer_orders.first_order_date,
		customer_orders.last_order_date,
		coalesce(customer_orders.number_of_orders,0) as number_of_orders,
		customer_orders.lifetime_value
	from customers
	left join customer_orders 
        on customers.customer_id = customer_orders.customer_id
	)

Select * from final
