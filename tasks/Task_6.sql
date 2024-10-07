--Task 6--
-- Output cities with the number of active and inactive customers (active - customer.active = 1).
-- Sort by the number of inactive customers in descending order.--


select  ci.city,
		sum(case when c.active = 1 then 1 else 0 end) over(partition by ci.city_id) as active_customers,
		sum(case when c.active = 0 then 1 else 0 end) over(partition by ci.city_id) as inactive_customers
from customer as c
inner join address a 
on c.address_id = a.address_id
inner join city as ci
on a.city_id  = ci.city_id 
order by inactive_customers desc