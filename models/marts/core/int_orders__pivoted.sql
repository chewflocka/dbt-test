{%- set payment_methods = ['bank_transfer','coupon','credit_card','gift_card'] -%}


with payments as (
    Select * from {{ref('stg_payments')}}

),
pivoted as (
    Select order_id,
    {% for p in payment_methods -%}
        sum(case when payment_method = '{{p}}' then amount else 0 end) as {{p}}_amount {%- if not(loop.last) -%}, {%- endif %}
    {% endfor -%}

     from payments
     where status = 'success'
     group by order_id
)

Select * from pivoted