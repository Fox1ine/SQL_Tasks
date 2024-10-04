--Task 4-- 
--Print the titles of films that are not in the inventory. Write a query without using the IN operator.--

--first case with not exists --
select title
from film as f1
where not exists (
select * from film as f2
inner join inventory as i
on f2.film_id = i.film_id
where f1.film_id = f2.film_id
)


--second with left join--
SELECT f.title
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
WHERE i.film_id IS NULL;
