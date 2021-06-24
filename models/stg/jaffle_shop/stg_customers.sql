with customers as (
    Select id as customer_id,
        first_name,
        last_name
        from raw_jaffle_shop.customers
)

Select * from customers