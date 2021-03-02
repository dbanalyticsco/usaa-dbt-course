with base as (

    select *
    from {{ source('stripe','payments') }}

), fields as (

    select 
        json_data:order_id::varchar as order_id,
        json_data:id as payment_id,
        json_data:method::varchar as payment_type,
        json_data:amount::int / 100.0 as payment_amount,
        json_data:created_at::timestamp as created_at
    from base

)

select *
from fields