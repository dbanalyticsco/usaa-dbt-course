with base as (

    select *
    from {{ source('ecomm','customers') }}

), fields as (

    select 
        id as customer_id,
        first_name,
        last_name,
        email,
        address,
        phone_number
    from base

)

select *
from fields