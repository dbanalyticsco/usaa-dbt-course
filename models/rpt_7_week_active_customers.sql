with customers as (

    select *
    from {{ ref('customers') }}

), half_year as (

    select *
    from {{ ref('__7_week_order_metrics') }}

), seven_weeks as (

    select *
    from {{ ref('__7_week_customers') }}

), final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        half_year.avg_order_amount,
        half_year.order_count
    from customers
    left join half_year
        using (customer_id)
    inner join seven_weeks
        using (customer_id)

)

select *
from final