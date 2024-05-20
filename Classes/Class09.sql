#1
select co.country, count(*) as cantidad_ciudades from city ci
inner join country co on co.country_id = ci.country_id
group by co.country_id
order by co.country, co.country_id;

#2
select co.country, count(*) as cantidad_ciudades from city ci
inner join country co on co.country_id = ci.country_id
group by co.country_id
having 10<cantidad_ciudades
order by cantidad_ciudades desc;

#3
select first_name,last_name,a.*, 
(select count(*) from rental r where r.customer_id = c.customer_id) as total_películas_alquiladas, 
(select sum(amount) from payment p where p.customer_id = c.customer_id) as dinero_total_gastado 
from customer c
inner join address a on c.address_id = a.address_id
order by dinero_total_gastado desc; 

#4
select c.name,avg(length) as promedio  from category c
inner join film_category fc on fc.category_id = c.category_id
inner join film f on f.film_id = fc.film_id
group by c.name
order by promedio desc;

#5
select rating, concat(sum(p.amount), 'usd') as ventas from film f
inner join inventory i on i.film_id = f.film_id
inner join rental r on r.inventory_id = i.inventory_id
inner join payment p on r.rental_id = p.rental_id
group by rating
order by ventas desc;