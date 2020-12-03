with base as (

    select *
    from {{ source('ecomm','orders') }}
    {% if target.name == 'dev' %}
    where created_at > current_date - 30
    {% endif %}

), fields as (

    select
        id as order_id,
        customer_id,
        created_at as ordered_at,
        status as order_status,
        store_id,
        total_amount,
        reordered_from_id
    from base

)

select *
from fields