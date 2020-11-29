with orders as (

    select *
    from {{ ref('orders') }}

), customers as (

    select *
    from {{ ref('customers') }}

), half_year as (

    select
        customer_id,
        round(avg(total_amount),2) as avg_order_amount,
        count(*) as order_count
    from orders
    where ordered_at > current_date - 180
    group by 1

), seven_weeks as (

    select distinct customer_id
    from orders
    where ordered_at > current_date - 42

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