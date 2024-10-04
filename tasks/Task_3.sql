--Task 3--
-- Output the category of films on which the most money was spent --


with films as (
	select c.name as filmCategoryName, fc.film_id
	from category c 
	inner join film_category fc
	on c.category_id = fc.category_id
),

rental_stuff as (
	select r.rental_id, i.inventory_id, i.film_id
	from rental r 
	inner join inventory as i
	on r.inventory_id = i.inventory_id
),

payments as (
 	select p.rental_id, sum(p.amount) as total_amount
	from payment p 
	group by p.rental_id
)


select f.filmCategoryName, sum(ps.total_amount) AS spent
from films as f
inner join rental_stuff rs on f.film_id = rs.film_id
inner join payments ps on rs.rental_id = ps.rental_id
group by f.filmCategoryName
order by spent desc
limit 1
