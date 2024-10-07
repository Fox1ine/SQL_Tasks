--Task 1 --
--Output the number of films in each category, sorted in descending order.--


select c.name, count(*)  as count_of_films 
from film_category as fc 
inner join category c 
on fc.category_id = c.category_id 
group by c.name
order by count_of_films desc