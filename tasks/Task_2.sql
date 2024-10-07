
--Task 2--
--Output the 10 actors whose films have rented the most, sorted in descending order.--


with rental_table as (

	select fa.actor_id as actorId, count(i.film_id) as rental_count
	from inventory i 
	inner join film_actor fa 
	on i.film_id = fa.film_id 
	group by fa.actor_id
	
)

select a.first_name, a.last_name ,rental_count
from rental_table as rt
inner join actor a 
on rt.actorId = a.actor_id 
order by rt.rental_count desc
limit 10
	
