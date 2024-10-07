--Task 7--
--Output the category of films that have the highest number of total rental hours in cities (customer.address_id in this city),
-- and that start with the letter ‘a’. Do the same for cities with a ‘-’ in them. Write everything in one query.--


with highest_rental_time as (
		select c.name as category_name, city.city as name_of_city,
			round(sum(extract(epoch from (r.return_date - r.rental_date)) / 3600)) AS total_rental_hours
		from rental r 
		inner join inventory i 
		on r.inventory_id = i.inventory_id 
		inner join film_category fc 
		on i.film_id = fc.film_id 
		inner join category c 
		on fc.category_id = c.category_id 
		inner join customer cust
		on r.customer_id = cust.customer_id 
		inner join address a 
		on cust.address_id = a.address_id 
		inner join city
		on city.city_id = a.city_id 
		group by c.name,city.city	
),
ranked_rental_time as (
	select category_name,name_of_city,total_rental_hours,
	rank() over (partition by name_of_city order by total_rental_hours desc ) as rank_of_sum_rental
	from highest_rental_time
)

select  name_of_city, category_name, total_rental_hours, rank_of_sum_rental
from ranked_rental_time 
where (lower(name_of_city) like 'a%' or lower(name_of_city) like '%-%')
and rank_of_sum_rental = 1
order by total_rental_hours desc
	 
	
		