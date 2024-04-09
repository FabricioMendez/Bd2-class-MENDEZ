USE sakila;

#1
select title, special_features from film
where rating = 'PG-13';

#2
select distinct length from film group by length;

#3
select title, rental_rate, replacement_cost 
from film 
where replacement_cost between 20.00 and 24.00;

#4
select f.title, f.description, f.rating from film f
where f.special_features like "%Behind the Scenes%";


#5
select a.first_name, a.last_name from film_actor fa
inner join actor a on a.actor_id =fa.actor_id
inner join film f on f.film_id = fa.film_id
where f.title='ZOOLANDER FICTION';

#6
select a.address, ci.city, c.country from store s 
inner join address a on a.address_id = s.address_id
inner join city ci on ci.city_id = a.city_id
inner join country c on c.country_id = ci.country_id
where s.store_id = 1; 

#7
select f1.title, f2.title, f1.rating 
from film f1, film f2 
where f1.rating = f2.rating;

#8
select distinct f.title, st.first_name, st.last_name from inventory i
inner join store s on s.store_id = i.store_id
inner join staff st on st.staff_id = s.manager_staff_id
inner join film f on f.film_id = i.film_id
where s.store_id = 2;