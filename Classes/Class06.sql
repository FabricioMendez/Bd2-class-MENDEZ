use sakila;

#1
SELECT first_name,last_name FROM customer c1 
 WHERE EXISTS (
	SELECT * FROM customer c2 
		WHERE c1.last_name = c2.last_name AND c1.customer_id != c2.customer_id
			)ORDER BY c1.last_name;
            
#2
select ac1.first_name, ac1.last_name from film_actor fa
inner join actor ac1 on ac1.actor_id = fa.actor_id
where not exists(select * from actor ac2 where ac1.actor_id = ac2.actor_id);
		
#3
select c.first_name,c.last_name,count(r.customer_id) as cant_compras from rental r 
inner join customer c on c.customer_id = r.customer_id
group by r.customer_id having 1 = count(r.customer_id);

#4
select c.customer_id, c.first_name, c.last_name from customer c 
inner join rental r on r.customer_id = c.customer_id
group by c.customer_id having count(r.rental_id) > 1;

#5
SELECT ac.first_name, ac.last_name FROM film_actor fi_ac
inner join actor ac on ac.actor_id = fi_ac.actor_id
inner join film f on f.film_id = fi_ac.film_id
where f.title in ('BETRAYED REAR','CATCH AMISTAD')  group by ac.actor_id;

#6
SELECT ac.first_name, ac.last_name  from film_actor fi_ac
inner join actor ac on ac.actor_id = fi_ac.actor_id
inner join  film f on f.film_id = fi_ac.film_id
WHERE f.title = 'BETRAYED REAR'
and ac.actor_id not in (
    select actor_id from film_actor fa
    inner join film fi on fi.film_id = fa.film_id
    where fi.title='CATCH AMISTAD'
);

#7
select ac.first_name, ac.last_name from film_actor fi_ac
inner join actor ac on ac.actor_id = fi_ac.actor_id
inner join film f on f.film_id = fi_ac.film_id
where f.title = 'BETRAYED REAR' and ac.actor_id in (
    select actor_id from film_actor fa
    inner join film fi on fi.film_id = fa.film_id
    where fi.title='CATCH AMISTAD'
);

#8
select a.first_name, a.last_name from actor a
where a.actor_id not in (
  select f_a.actor_id from film_actor f_a
  inner join film f on f_a.film_id = f.film_id
  where f.title like '%BETRAYED REAR%'
) and a.actor_id not in (
  select f_a.actor_id from film_actor f_a
  inner join film f on f_a.film_id = f.film_id
  where f.title like '%CATCH AMISTAD%'
);