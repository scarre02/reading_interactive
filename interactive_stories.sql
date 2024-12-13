CREATE DATABASE interactive_stories;

USE interactive_stories;

CREATE TABLE stories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    contenido TEXT NOT NULL
);stories

INSERT INTO stories (titulo, contenido) VALUES
('El Conejo y el Bosque', 'Había una vez un conejo que vivía en el bosque.'),
('El León Valiente', 'El león era valiente y cuidaba de los animales.'),
('La Tortuga y la Liebre', 'La tortuga ganó la carrera con paciencia y determinación.');
SELECT * FROM stories;

