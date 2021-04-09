CREATE DATABASE pruebas;
GO
USE pruebas;
GO
CREATE TABLE people
(
    info_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50)
);
GO
INSERT INTO people (info_id, first_name, last_name) VALUES (1, 'nombre1', 'apellidos1');
GO
INSERT INTO people (info_id, first_name, last_name) VALUES (2, 'nombre2', 'apellidos2');
GO
INSERT INTO people (info_id, first_name, last_name) VALUES (3, 'nombre3', 'apellidos3');
GO