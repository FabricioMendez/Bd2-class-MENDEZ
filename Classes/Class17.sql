#1
select a.address, a.postal_code, c.city, co.country
from address a
inner join city c on (a.city_id = c.city_id)
inner join country co on (c.country_id = co.country_id)
where a.postal_code not in ('12345', '67890');

create index idx_postal_code on address(postal_code);

#Sin índice: La búsqueda en columnas no indexadas (como postal_code) es más lenta, ya que la base de datos tiene que buscar fila por fila para encontrar coincidencias.
#Con índice: Al tener un índice en postal_code, la base de datos puede buscar más rápidamente en esa columna porque el índice le proporciona un camino más eficiente para encontrar las filas relevantes, lo que generalmente reduce el tiempo de ejecución.

#2
select * from actor 
where first_name like "%A";

select * from actor 
where last_name like "%A";

#Si la columna first_name o last_name no están indexadas, la búsqueda será lenta porque la base de datos debe revisar todas las filas. Sin embargo, si hay un índice en alguna de estas columnas, la búsqueda será mucho más rápida, ya que el índice actúa como una guía para encontrar las filas coincidentes más rápido.

#3
select * from film
where description like '%adventure%';

select * from film_text
where match(description) against('adventure');

#MATCH () AGAINST () es más rápido y eficiente que LIKE, especialmente para grandes conjuntos de datos de texto.

