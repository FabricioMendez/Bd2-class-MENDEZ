#1
select concat(c.first_name, ' ', c.last_name) as full_name, address, city
from customer c
inner join address a on (c.address_id = a.address_id)
inner join city ci on (a.city_id = ci.city_id)
inner join  country co on (ci.country_id = co.country_id)
where co.country = 'Argentina';

#2
select f.title, l.name as language, case f.rating
           when 'G' then 'G (General Audiences) – All ages admitted.'
           when 'PG' then 'PG (Parental Guidance Suggested) – Some material may not be suitable for children.'
           when 'PG-13' then 'PG-13 (Parents Strongly Cautioned) – Some material may be inappropriate for children under 13.'
           when 'R' then 'R (Restricted) – Under 17 requires accompanying parent or adult guardian.'
           when 'NC-17' then 'NC-17 (Adults Only) – No one 17 and under admitted.'
           else 'Not Rated'
       end as full_rating
from film f
inner join language l using (language_id);

#3
select f.title, f.release_year, concat(a.first_name, ' ',a.last_name) as full_namme 
from film_actor fa 
inner join film f using(film_id) 
inner join actor a using(actor_id) 
where lower(concat(a.first_name, ' ',a.last_name)) = lower('NICK WAHLBERG');

#4
select f.title, concat(c.first_name, ' ', c.last_name) as customer_full_name, 
       case 
           when r.return_date is not null then 'Yes'
           else 'No'
       end as returned
from rental r
inner join inventory i using (inventory_id)
inner join film f using (film_id)
inner join customer c using (customer_id)
where month(r.rental_date) in (4, 8);

#5
#La función CAST convierte un valor de un tipo de dato a otro. Es una función estándar de SQL.
# select cast(rental_rate as signed) from film;
#La función CONVERT también convierte un valor de un tipo de dato a otro, similar a CAST, pero es más específica de ciertos sistemas de bases de datos, como SQL Server.
# select convert(rental_rate, signed) from film;

#6
#NVL reemplaza un valor NULL por un valor especificado. Es común en Oracle.
#Ejemplo (no en MySQL):
# SELECT NVL(NULL, 'valor_por_defecto') FROM dual;

#ISNULL reemplaza un valor NULL por un valor especificado. Es utilizado en SQL Server y MySQL.
#Ejemplo en MySQL:
# SELECT ISNULL(NULL, 'valor_por_defecto');

#IFNULL es la versión de MySQL de ISNULL. Funciona de manera idéntica.
#Ejemplo en MySQL:
# SELECT IFNULL(NULL, 'valor_por_defecto');

#COALESCE devuelve el primer valor no NULL de una lista de valores. Es más flexible que NVL y ISNULL porque puede tomar más de dos argumentos.
#Ejemplo en MySQL:
# SELECT COALESCE(NULL, NULL, 'valor_por_defecto');
