Use sakila;

#1
create user 'data_analyst'@'localhost' identified by 'Gloria123';

#2
grant select, update, delete on sakila.* to 'data_analyst'@'localhost';
show grants for data_analyst;

#3
create table test_table (
    id int primary key,
    name varchar(100)
);
#ERROR 1142 (42000): CREATE command denied to user 'data_analyst'@'localhost' for table 'test_table'

#4
update film
set title = 'Ascenso del IACC 2022'
where film_id = 20;

#5
revoke update on sakila.* from 'data_analyst'@'localhost';

#6
update film
set title = 'Argentina campeon mundial'
where film_id = 20;
#ERROR 1143 (42000): UPDATE command denied to user 'data_analyst'@'localhost' for table 'film'





