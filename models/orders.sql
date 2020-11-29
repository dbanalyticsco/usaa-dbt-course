with orders as (

    select *
    from {{ ref('stg_ecomm__orders') }}

), deliveries as (

    select *
    from {{ ref('stg_ecomm__deliveries') }}

), customers as (

    select *
    from {{ ref('stg_ecomm__customers') }}

), stores as (

    select *
    from {{ ref('stores_data') }}

), deliveries_filtered as (

    select *
    from deliveries
    where delivery_status = 'delivered'

), joined as (

    select
        orders.order_id,
        orders.customer_id,
        orders.ordered_at,
        orders.order_status,
        orders.total_amount,
        orders.store_id,
        datediff('minutes',orders.ordered_at,deliveries_filtered.delivered_at) as delivery_time_from_order,
        datediff('minutes',deliveries_filtered.picked_up_at,deliveries_filtered.delivered_at) as delivery_time_from_collection,
        stores.store_name
    from orders
    left join deliveries_filtered
        using (order_id)
    left join stores 
        using (store_id)
    left join customers
        using (customer_id)
    where customers.email not ilike '%ecommerce.com'
      and customers.email not ilike '%ecommerce.ca'
      and customers.email not ilike '%ecommerce.co.uk'

), windows as (

    select
        *,
        datediff(
            'day', 
            lag(ordered_at) over (partition by customer_id order by ordered_at),
            ordered_at
        ) as days_since_last_order
    from joined

)

select *
from windows