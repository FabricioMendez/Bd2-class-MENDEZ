use sakila; 

#1
select title, rating from film 
where length =  (select min(`length`) from film);

#2
select title from film f1 
where length < ALL (select length from film f2 where f1.film_id != f2.film_id);

#3
select c.*,min(p.amount) as lowest_amount,a.* from payment p
inner join customer c on c.customer_id = p.customer_id
inner join address a on c.address_id = a.address_id 
group by p.customer_id;

select p.amount as lowest_amount,c.*,a.* from payment p
inner join customer c on c.customer_id = p.customer_id
inner join address a on c.address_id = a.address_id 
where p.amount <= all(select amount from payment p2 where p.customer_id = p2.customer_id)
group by p.customer_id, p.amount;

#4
select c.first_name as 'Nombre', c.last_name as 'Apellido', MAX(p.amount) as 'Cantidad Máxima', MIN(p.amount) as 'Cantidad Máxima'
from customer c
inner join payment p on c.customer_id = p.customer_id
group by c.first_name, c.last_name;
