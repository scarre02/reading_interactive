CREATE DATABASE interactive_stories;

USE interactive_stories;

CREATE TABLE stories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL
);

INSERT INTO stories (title, content) VALUES
('The Tale of Petter Rabbit', 'Once upon a time, there were four little rabbits named Flopsy, Mopsy, Cotton-tail, and Peter. They lived with their mother in a cozy burrow under the roots of a big fir tree.
One morning, Mrs. Rabbit said, "You may go into the fields or down the lane, but don’t go into Mr. McGregor’s garden. Your father had an accident there, and I don’t want the same to happen to you."
Flopsy, Mopsy, and Cotton-tail were good little bunnies. They went to gather blackberries. But Peter, who was a bit more adventurous, ran straight to Mr. McGregor’s garden.
Peter squeezed under the gate and found himself in a paradise of vegetables—lettuces, radishes, and carrots. He nibbled happily until he came to some parsley. But as he was munching, he heard a loud shout:
"Stop, thief!" It was Mr. McGregor!
Terrified, Peter ran as fast as his little legs could carry him. He dashed through the garden, knocking over flower pots and leaving a trail of footprints.
Peter tried to find his way back to the gate but got lost. He hid in a watering can to catch his breath, but Mr. McGregor was close behind. Peter scrambled out and leaped into a gooseberry bush, tearing his jacket on the thorns.
At last, Peter found a way out—a small hole in the garden fence. He wriggled through just in time and ran all the way home, leaving his blue jacket and shoes behind.
When Peter reached the burrow, he was so tired that he flopped down on the soft sand floor. His mother shook her head when she saw him. "Peter, where is your jacket and shoes?" she asked.
That evening, while Flopsy, Mopsy, and Cotton-tail enjoyed bread and blackberries, Peter had to go to bed early with chamomile tea, which he didn’t like at all.
Peter learned a lesson that day about listening to his mother and staying out of trouble—at least for a little while!
The End.'),
('The brave lion', 'El león era valiente y cuidaba de los animales.'),
('The Tortoise and the Hare', 'La tortuga ganó la carrera con paciencia y determinación.'),
('The Brave Little Fox', 'Once upon a time, in the heart of a quiet forest, there lived a little fox named Finn. Finn was smaller than all the other foxes, but what he lacked in size, he made up for in courage and kindness.
While most foxes spent their days playing in the meadow, Finn loved to explore the deeper parts of the forest. The trees there were taller, the sounds were louder, and the shadows danced like magic.
One day, while Finn was chasing fireflies, he heard a soft cry. \"Help! Help!\" it called. He followed the sound and found a baby bird stuck on the ground. Its wing was hurt, and it couldn\'t fly. \"Don\'t worry,\" said Finn, his golden eyes full of determination. \"I\'ll help you.\" He gently picked up the little bird and carried it on his back. The bird was scared at first, but Finn spoke to it softly. \"I know a safe place for you,\" he said. 
He carefully made his way to an old oak tree where Grandma Owl lived. She was wise and kind, and she knew how to heal small creatures. \"Oh, Finn,\" said Grandma Owl with a smile. \"You have a brave heart to help someone in need.\" She took the little bird in her soft feathers and promised to care for it.
The next day, all the forest animals gathered around Finn. They had heard of his bravery. \"You may be small, but you have a big heart,\" said a big, proud stag. The rabbits, squirrels, and even the other foxes cheered for Finn.
From that day on, Finn was no longer seen as the smallest fox. He was known as the bravest little fox in the forest. And whenever anyone needed help, they knew exactly who to call.
Moral of the story: Being small doesn\'t mean you can\'t do big things. Courage and kindness make you truly strong.');

SELECT * FROM stories;

UPDATE stories
SET keywords = '["Rabbit", "Garden", "Carrots", "Shout", "Shoes"]'
WHERE title = 'The Tale of Petter Rabbit';
SET SQL_SAFE_UPDATES = 0;

CREATE TABLE stories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    author VARCHAR(255) DEFAULT NULL,
    category_id_category INT DEFAULT 0,
    quantity_words INT DEFAULT 0
);

SELECT id, title, keywords FROM stories;

UPDATE stories
SET keywords = '["Fox", "Forest", "Courage", "Kindness", "Bravery"]'
WHERE title = 'The Brave Little Fox';

DESCRIBE stories;

CREATE TABLE keywords (
    id INT AUTO_INCREMENT PRIMARY KEY,
    keyword VARCHAR(255) NOT NULL
);

CREATE TABLE story_keywords (
    story_id INT,
    keyword_id INT,
    PRIMARY KEY (story_id, keyword_id),
    FOREIGN KEY (story_id) REFERENCES stories(id),
    FOREIGN KEY (keyword_id) REFERENCES keywords(id)
);

INSERT INTO keywords (keyword) VALUES 
('rabbit'),
('adventure'),
('nature'),
('children'),
('story');

SELECT id FROM stories WHERE title = 'The Tale of Peter Rabbit';
SELECT id, title FROM stories;
SELECT * FROM keywords;
SELECT * FROM story_keywords WHERE story_id =1;

-- Supongamos que los keyword_ids son 1, 2, 3, 4 y 5
INSERT INTO story_keywords (story_id, keyword_id)
VALUES
(1, 1),  -- Relación entre historia 1 y palabra clave 1
(1, 2),  -- Relación entre historia 1 y palabra clave 2
(1, 3),  -- Relación entre historia 1 y palabra clave 3
(1, 4),  -- Relación entre historia 1 y palabra clave 4
(1, 5);  -- Relación entre historia 1 y palabra clave 5



