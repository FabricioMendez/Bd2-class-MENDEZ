use sakila;

#1
insert into customer(store_id,address_id, first_name, last_name, email) 
values(1,(select max(address_id) 
from address a inner join city c on (c.city_id = a.city_id) 
inner join country co on (c.country_id = co.country_id) 
where co.country='United States'), 'fabri', 'mendez', 'fabrimendez@gmail.com');

#2
insert into rental (rental_date, inventory_id, customer_id, staff_id)
values (now(), 
    (select max(inventory_id) from inventory i inner join film f on (i.film_id = f.film_id) where f.title = 'ACADEMY DINOSAUR'), 
    (select customer_id from customer where first_name = 'MARY' and last_name = 'SMITH'),
    (select staff_id from staff where store_id = 2 limit 1));
    
#3
SET SQL_SAFE_UPDATES = 0;
Update film set release_year = 2001 where rating = 'G' ;
Update film set release_year = 2005 where rating = 'R' ;
Update film set release_year = 1918 where rating = 'G' ;
Update film set release_year = 2022 where rating = 'G' ;
Update film set release_year = 1973 where rating = 'PG-13' ;
Update film set release_year = 1999 where rating = 'PG' ;
Update film set release_year = 1986 where rating = 'R' ;
Update film set release_year = 1978 where rating = 'PG-13' ;  

#4
select rental_id from rental
where return_date is null
order by rental_date desc;
update rental
set return_date = now()
where rental_id = (select rental_id from rental where return_date is null 
order by rental_date desc);

#5
delete from rental where customer_id = 1;
delete from payment where customer_id = 2;
delete from customer where customer_id = 3;
delete from film_actor where actor_id = 4;
delete from actor where actor_id = 5;

#6

select inventory_id from inventory i left outer join rental r using(inventory_id) where r.rental_id is null limit 1;
insert into rental (rental_date,inventory_id,customer_id,staff_id) values (
	NOW(), 
	(1), 
    (select customer_id from customer limit 1), 
    (select staff_id from staff limit 1));
    
insert into payment (customer_id, staff_id, rental_id, amount, payment_date)
values (
    (select customer_id from rental where inventory_id = 1 limit 1),
    (select staff_id from rental where inventory_id = 1 limit 1),   
    (select max(rental_id) from rental where inventory_id = 1),  
    466.43, 
    NOW() 
);





 
