#1
insert into employees (lastName, firstName, email) values ("Mendez","Fabricio", null);
#Error Code: 1048. Column 'email' cannot be null
#El error dice que email no puede ser null ya que esta declarado como not null

#2
UPDATE employees SET employeeNumber = employeeNumber - 20;
#Esta consulta restará 20 a todos los valores de employeeNumber. Si employeeNumber es la clave primaria, esto podría generar duplicados, lo que provocaría un error de Entrada duplicada porque las claves primarias deben ser únicas.
UPDATE employees SET employeeNumber = employeeNumber + 20;
#Si la primera consulta se ejecutó correctamente sin errores, esta consulta incrementará todos los valores de employeeNumber en 20, restaurando así los valores originales. Si hubo errores debido a duplicados en la primera actualización, esta consulta podría no ejecutarse correctamente.

#3
alter table employees 
add column age int default 16, 
add constraint check_age check (age between 16 and 70);

#4
/*En la base de datos Sakila:

film: Contiene detalles de las películas.
actor: Contiene detalles de los actores.
film_actor: Es una tabla de enlace que asocia actores con películas.
Integridad Referencial:

La tabla film_actor tiene claves foráneas que hacen referencia a las tablas film y actor.
La columna film_id en film_actor referencia a film_id en la tabla film.
La columna actor_id en film_actor referencia a actor_id en la tabla actor.
*/

#5
alter table employees 
add column lastUpdate datetime default current_timestamp, 
add column lastUpdateUser varchar(100);

create trigger before_insert_employees
before insert on employees
for each row
set new.lastUpdate = current_timestamp(),
    new.lastUpdateUser = user();

create trigger before_update_employees
before update on employees
for each row
set new.lastUpdate = current_timestamp(),
    new.lastUpdateUser = user();
    
#6
/*
CREATE TRIGGER before_insert_film_text
BEFORE INSERT ON film_text
FOR EACH ROW
BEGIN
    -- Lógica de ejemplo: Validar o modificar datos antes de la inserción
    IF NEW.title IS NULL OR NEW.description IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Title and description cannot be NULL';
    END IF;
END;

Explicación:

Evento: Este trigger se activa antes de insertar una nueva fila en la tabla film_text.
Propósito: El trigger verifica si los campos title o description son NULL. Si alguno de ellos es NULL, evita la inserción generando un error con SIGNAL.
Caso de Uso: Asegura la integridad de los datos al evitar que se agreguen registros incompletos a la tabla film_text.

CREATE TRIGGER after_update_film_text
AFTER UPDATE ON film_text
FOR EACH ROW
BEGIN
    -- Lógica de ejemplo: Registrar cambios o actualizar datos relacionados
    INSERT INTO film_text_log (film_id, old_title, new_title, updated_at)
    VALUES (NEW.film_id, OLD.title, NEW.title, NOW());
END;

Explicación:

Evento: Este trigger se activa después de una operación de actualización en la tabla film_text.
Propósito: Registra los cambios realizados en el campo title en una tabla de registro separada (film_text_log). El registro incluye el ID de la película, el título antiguo, el nuevo título, y una marca de tiempo.
Caso de Uso: Proporciona un historial de cambios, útil para propósitos de auditoría o para rastrear actualizaciones a lo largo del tiempo.

CREATE TRIGGER before_delete_film_text
BEFORE DELETE ON film_text
FOR EACH ROW
BEGIN
    -- Lógica de ejemplo: Prevenir la eliminación de ciertas filas
    IF OLD.film_id < 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete records with film_id less than 100';
    END IF;
END;

Explicación:

Evento: Este trigger se ejecuta antes de que se elimine una fila de la tabla film_text.
Propósito: Verifica el film_id del registro. Si film_id es menor que 100, genera un error, evitando la eliminación.
Caso de Uso: Protege los registros críticos de eliminaciones accidentales basadas en reglas de negocio específicas.