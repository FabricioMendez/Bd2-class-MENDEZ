use sakila;

#1
DELIMITER //
CREATE FUNCTION CopiasFilm(film VARCHAR(50), storeId INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE copies INT;
    
    SELECT COUNT(*) INTO copies FROM inventory i
    INNER JOIN film f ON i.film_id = f.film_id
    WHERE (f.film_id = film OR f.title = film) AND i.store_id = storeId;
    
    RETURN copies;
END //
DELIMITER ;

#2
DELIMITER //
Create procedure list_customer (in p_country varchar(50), out p_customer varchar (100)) 
begin 
	DECLARE v_first_name VARCHAR(45);
    DECLARE v_last_name VARCHAR(45);
    DECLARE done INT DEFAULT 0;
    
	DECLARE curClientes CURSOR FOR
    select c.first_name, c.last_name
    from customer c 
    inner join address a on (a.address_id = c.address_id)
    inner join city ci on (ci.city_id = a.city_id)
    inner join country co on (co.country_id = ci.country_id)
    where co.country_id = p_country;
    
    -- Controlar cuando el cursor llega al final
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Abrir el cursor
    OPEN curClientes;
    
    leer_clientes: LOOP
        -- Obtener los valores actuales del cursor
        FETCH curClientes INTO v_first_name, v_last_name;
        
        -- Si no hay más filas, terminar el loop
        IF done THEN
            LEAVE leer_clientes;
        END IF;

        -- Concatenar el nombre y apellido al parámetro de salida
        SET p_clientes = CONCAT(p_clientes, v_first_name, ' ', v_last_name, ';');
    END LOOP leer_clientes;

    -- Cerrar el cursor
    CLOSE curClientes;
END //

CALL list_customer('Argentina', @p_customer);
SELECT @p_customer;

#3
/*
inventory_in_stock(p_inventory_id):
Verifica si un inventario específico está disponible (retorna 1 si está en stock o 0 si no lo está).

film_in_stock(p_film_id, p_store_id, OUT p_count):
Cuenta cuántas copias de una película están disponibles en una tienda específica
*/