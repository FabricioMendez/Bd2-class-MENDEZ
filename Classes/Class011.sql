use sakila;

#4
select f.* from film f left join inventory i using (film_id) 
where i.inventory_id is null ;

#5
select f.title, i.inventory_id from film f
inner join inventory i using(film_id)
left join rental r using(inventory_id)
where r.rental_id is null;

#6
select c.first_name 'nombre', c.last_name 'apellido', s.store_id, f.title from rental r
inner join customer c using(customer_id)
inner join store s using(store_id)
inner join inventory i using(inventory_id)
inner join film f using(film_id)
where r.return_date is not null
ORDER BY s.store_id, c.last_name;

#7
select concat(c.city, ', ', co.country) as 'ubicacion', concat(st.first_name, ' ', st.last_name) as 'director', sum(p.amount) as 'total ventas'
from store s
inner join address a on s.address_id = a.address_id
inner join city c on a.city_id = c.city_id
inner join country co on c.country_id = co.country_id
inner join staff st on s.manager_staff_id = st.staff_id
inner join inventory i on s.store_id = i.store_id
inner join rental r on i.inventory_id = r.inventory_id
inner join payment p on r.rental_id = p.rental_id
group by s.store_id
order by 'Venta totales' asc;

#8
select a.first_name, a.last_name, COUNT(fa.film_id) as film_count
from actor a
inner join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name
order by film_count desc
limit 1;