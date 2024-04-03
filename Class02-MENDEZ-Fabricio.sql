drop database if exists imdb;
CREATE DATABASE imdb;

USE imdb;

CREATE TABLE film (
    film_id INT AUTO_INCREMENT,
    title VARCHAR(255),
    descripcion VARCHAR(255),
    release_year INT,
    constraint Pk_film primary key (film_id)
);

CREATE TABLE actor (
    actor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

CREATE TABLE film_actor (
    actor_id INT,
    film_id INT,
    constraint Fk_actor FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
    constraint Fk_film FOREIGN KEY (film_id) REFERENCES film(film_id)
);


INSERT INTO actor (first_name, last_name) VALUES
('Tom', 'Hanks'),
('Leonardo', 'DiCaprio'),
('Meryl', 'Streep');

INSERT INTO film (title, descripcion, release_year) VALUES
('Forrest Gump', 'Una película sobre la vida de un hombre con un CI bajo que logra grandes cosas.', 1994),
('Titanic', 'Una joven aristócrata de diecisiete años se enamora de un artista pobre a bordo del Titanic.', 1997),
('The Devil Wears Prada', 'Una recién graduada inteligente pero sensata consigue un trabajo como asistente de Miranda Priestly', 2006);

INSERT INTO film_actor (actor_id, film_id) VALUES
(1, 1), 
(2, 2), 
(3, 3); 

ALTER TABLE film ADD column last_update DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE actor ADD column last_update DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE film_actor ADD FOREIGN KEY (actor_id) REFERENCES actor (actor_id);
ALTER TABLE film_actor ADD FOREIGN KEY (film_id) REFERENCES film (film_id);