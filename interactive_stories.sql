CREATE DATABASE interactive_stories;

USE interactive_stories;

CREATE TABLE stories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    contenido TEXT NOT NULL
);

INSERT INTO stories (titulo, contenido) VALUES
('El Conejo y el Bosque', 'Había una vez un conejo que vivía en el bosque.'),
('El León Valiente', 'El león era valiente y cuidaba de los animales.'),
('La Tortuga y la Liebre', 'La tortuga ganó la carrera con paciencia y determinación.'),
('The Brave Little Fox', 'Once upon a time, in the heart of a quiet forest, there lived a little fox named Finn. Finn was smaller than all the other foxes, but what he lacked in size, he made up for in courage and kindness.

While most foxes spent their days playing in the meadow, Finn loved to explore the deeper parts of the forest. The trees there were taller, the sounds were louder, and the shadows danced like magic.

One day, while Finn was chasing fireflies, he heard a soft cry. \"Help! Help!\" it called. He followed the sound and found a baby bird stuck on the ground. Its wing was hurt, and it couldn\'t fly. \"Don\'t worry,\" said Finn, his golden eyes full of determination. \"I\'ll help you.\" He gently picked up the little bird and carried it on his back. The bird was scared at first, but Finn spoke to it softly. \"I know a safe place for you,\" he said. 
He carefully made his way to an old oak tree where Grandma Owl lived. She was wise and kind, and she knew how to heal small creatures. \"Oh, Finn,\" said Grandma Owl with a smile. \"You have a brave heart to help someone in need.\" She took the little bird in her soft feathers and promised to care for it.
The next day, all the forest animals gathered around Finn. They had heard of his bravery. \"You may be small, but you have a big heart,\" said a big, proud stag. The rabbits, squirrels, and even the other foxes cheered for Finn.
From that day on, Finn was no longer seen as the smallest fox. He was known as the bravest little fox in the forest. And whenever anyone needed help, they knew exactly who to call.
Moral of the story: Being small doesn\'t mean you can\'t do big things. Courage and kindness make you truly strong.');

SELECT * FROM stories;
SELECT COUNT(*) AS total_stories FROM stories;
SELECT COUNT(DISTINCT titulo) AS unique_stories FROM stories;
TRUNCATE TABLE stories;
DELETE FROM stories;
SELECT COUNT(*) AS total_stories FROM stories;
SELECT * FROM stories WHERE id = 1;


