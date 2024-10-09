use sakila;

#1
create view list_of_customers as
select c.customer_id, CONCAT(c.first_name, ' ', c.last_name) as customer_full_name, a.address, a.phone, a.postal_code AS zip_code, ci.city, co.country, c.store_id,  
case
        when c.active = 1 then 'active'
        else 'inactive'
    end as status
from customer c
inner join address a on (a.address_id = c.address_id)
inner join city ci on (ci.city_id = a.city_id)
inner join country co on (co.country_id = ci.country_id);

SELECT * FROM list_of_customers;

#2
create view film_details as 
select f.film_id, f.title, f.description, f.length, f.rating, c.name as category, f.rental_rate AS price,  GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name) SEPARATOR ', ') AS actors 
from film f 
inner join film_category fc on (fc.film_id = f.film_id)
inner join category c on (c.category_id = fc.category_id)
inner join film_actor fa on (fa.film_id = f.film_id)
inner join actor a on (a.actor_id = fa.actor_id)
group by f.film_id, f.title, f.description, c.name, f.rental_rate, f.length, f.rating;

Select * from film_details;

#3
create view sales_by_film_category as
select c.name as category, sum(rental_rate) as total_ventas, f.title
from film f 
inner join film_category fc on (fc.film_id = f.film_id)
inner join category c on (c.category_id = fc.category_id)
group by c.name;

select * from sales_by_film_category;

#4
create view actor_information as 
select count(fa.film_id) as film_count, a.actor_id, a.first_name, a.last_name 
from actor a 
inner join film_actor fa on (fa.actor_id = a.actor_id)
group by a.actor_id, a.first_name, a.last_name
order by actor_id;

select * from actor_information

#5
# GROUP_CONCAT: Junta los títulos de películas y sus categorías en una sola cadena para cada actor.
# Uniones (inner joins): Se conectan las tablas de actores, películas, y categorías para obtener los títulos y categorías de las películas en las que ha actuado cada actor.
# GROUP BY: Agrupa por actor para que cada actor aparezca en una fila única con todas sus películas listadas.

#6
#Una materialized view (vista materializada) es una vista especial en una base de datos que almacena físicamente los datos resultantes de una consulta. A diferencia de las vistas tradicionales (que son consultas virtuales ejecutadas cada vez que se acceden) 
#las materialized views guardan una copia de los datos para evitar recalcular los resultados cada vez, lo que mejora significativamente el rendimiento en consultas complejas o sobre grandes volúmenes de datos.

#Alternativas a las Materialized Views:
#Vistas normales (standard views), Índices, Tablas temporales y Tablas desnormalizadas.

#DBMS donde soportan las Materialized Views:
# Oracle,PostgreSQL y SQL Server