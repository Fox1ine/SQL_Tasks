--Task 5--
--Output the top 3 actors who have appeared in the most films in the ‘Children’ category.--
-- If several actors have the same number of films, output all of them.--


with res_table as ( 

	select a.actor_id,
		a.first_name as name_of_actor ,
		a.last_name as surname,
		c.name as name_of_category, 
		count(*) as count_films,
		rank() over (order by count(*) desc ) as runk_num
	from actor a 
	inner join film_actor fa 
	on a.actor_id = fa.actor_id 
	inner join  film_category fc
	on fa.film_id  = fc.film_id 
	inner join category c 
	on fc.category_id = c.category_id 
	group by a.actor_id,name_of_category
	order by runk_num asc 
)

select name_of_actor, surname, count_films
from res_table as rt
where rt.name_of_category = 'Children' 
limit 3



