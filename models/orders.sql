{{ 
    config(
        materialized='incremental',
        unique_key='order_id'
    )
}}

with orders as (

    select *
    from {{ ref('stg_ecomm__orders') }}
    {% if is_incremental() %}
    where _synced_at > (select dateadd('day', -3, max(a._synced_at)) from {{ this }} as a)
    {% endif %}    

), deliveries as (

    select *
    from {{ ref('stg_ecomm__deliveries') }}

), customers as (

    select *
    from {{ ref('stg_ecomm__customers') }}

), stores as (

    select *
    from {{ ref('stores_data') }}

), recursive_orders as (

    select *
    from {{ ref('__recursive_orders') }}

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
        orders._synced_at,
        datediff('minutes',orders.ordered_at,deliveries_filtered.delivered_at) as delivery_time_from_order,
        datediff('minutes',deliveries_filtered.picked_up_at,deliveries_filtered.delivered_at) as delivery_time_from_collection,
        stores.store_name,
        coalesce(recursive_orders.count_reorders_generated,0) as count_reorders_generated
    from orders
    left join deliveries_filtered
        using (order_id)
    left join stores 
        using (store_id)
    left join customers
        using (customer_id)
    left join recursive_orders
        using (order_id)
    where customers.email not ilike '%ecommerce.com'
      and customers.email not ilike '%ecommerce.ca'
      and customers.email not ilike '%ecommerce.co.uk'

{% if is_incremental() %}

), old_data as (

    select
        customer_id,
        max(ordered_at) as ordered_at
    from {{ this }}
    group by 1

), windows as (

    select
        joined.*,
        datediff(
            'day', 
            coalesce(lag(joined.ordered_at) over (partition by joined.customer_id order by joined.ordered_at), old_data.ordered_at),
            joined.ordered_at
        ) as days_since_last_order
    from joined
    left join old_data
        using (customer_id)

{% else %}

), windows as (

    select
        joined.*,
        datediff(
            'day', 
            lag(joined.ordered_at) over (partition by joined.customer_id order by joined.ordered_at),
            joined.ordered_at
        ) as days_since_last_order
    from joined

{% endif %}

), audit_field as (

    select 
        *,
        current_timestamp as dbt_uploaded_at,
        '{{ invocation_id }}' as run_id
    from windows

)

select *
from audit_field