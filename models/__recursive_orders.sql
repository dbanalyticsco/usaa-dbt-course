with recursive reorders as (

    select reordered_from_id as order_id, order_id as reorder_id
    from {{ ref('stg_ecomm__orders') }}
    where reordered_from_id is not null
    
    union all
  
    select reorders.order_id, orders.order_id as reorder_id
    from reorders
    left join {{ ref('stg_ecomm__orders') }} as orders
        on reorders.reorder_id = orders.reordered_from_id
    where orders.order_id is not null
    
)

select order_id, count(*) as count_reorders_generated
from reorders
group by 1

/* 

select 
    a.reordered_from_id as id, 
    a.id as a_reorder_id, 
    b.id as b_reorder_id, 
    c.id as c_reorder_id, 
    d.id as d_reorder_id, 
    e.id as e_reorder_id, 
    f.id as f_reorder_id, 
    g.id as g_reorder_id, 
    h.id as h_reorder_id, 
    i.id as i_reorder_id
from raw.ecomm.orders a
left join raw.ecomm.orders b on a.id = b.reordered_from_id
left join raw.ecomm.orders c on b.id = c.reordered_from_id
left join raw.ecomm.orders d on c.id = d.reordered_from_id
left join raw.ecomm.orders e on d.id = e.reordered_from_id
left join raw.ecomm.orders f on e.id = f.reordered_from_id
left join raw.ecomm.orders g on f.id = g.reordered_from_id
left join raw.ecomm.orders h on g.id = h.reordered_from_id
left join raw.ecomm.orders i on h.id = i.reordered_from_id
left join raw.ecomm.orders j on i.id = j.reordered_from_id
left join raw.ecomm.orders k on j.id = k.reordered_from_id
where a.reordered_from_id is not null
and k.id is not null

*/