select
    vc.customer_id,
    vc.name,
    SUM(voi.quantity) as total_purchased
from virtusa.Customers vc
join virtusa.orders vo on vc.customer_id = vo.customer_id
join virtusa.Order_Items voi on vo.order_id = voi.order_id
group by vc.customer_id,vc.name
having sum(voi.quantity) = (select max(total_qty)
                            from (select sum(voi2.quantity) as total_qty
                                  from virtusa.Customers vc2
                                           join virtusa.orders vo2 on vc2.customer_id = vo2.customer_id
                                           join virtusa.Order_Items voi2 on vo2.order_id = voi2.order_id
                                  group by vc2.customer_id) t);