with orders as (

    select
        id as order_id,
        customer_id,
        created_at as ordered_at
    from raw.ecomm.orders
        
), customers as (

    select 
        id as customer_id,
        first_name,
        last_name,
        email,
        address,
        phone_number
    from raw.ecomm.customers

), customer_metrics as (

    select
        customer_id,
        count(*) as count_orders,
        min(ordered_at) as first_order_at,
        max(ordered_at) as most_recent_order_at
    from orders
    group by 1

), joined as (

    select 
        customers.*,
        coalesce(customer_metrics.count_orders,0) as count_orders,
        customer_metrics.first_order_at,
        customer_metrics.most_recent_order_at
    from customers
    left join customer_metrics
        using (customer_id)

)

select *
from joined