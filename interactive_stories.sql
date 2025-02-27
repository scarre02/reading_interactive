CREATE DATABASE interactive_stories;

USE interactive_stories;

CREATE TABLE stories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    image varchar(45) NOT NULL
);

CREATE TABLE keywords (
    id INT AUTO_INCREMENT PRIMARY KEY,
    keyword VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE story_keywords (
    story_id INT NOT NULL,
    keyword_id INT NOT NULL,
    PRIMARY KEY (story_id, keyword_id),
    FOREIGN KEY (story_id) REFERENCES stories(id) ON DELETE CASCADE,
    FOREIGN KEY (keyword_id) REFERENCES keywords(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE category (
    id_category INT NOT NULL AUTO_INCREMENT,
    name_category VARCHAR(255) NOT NULL UNIQUE,
    PRIMARY KEY (id_category)
) ENGINE=InnoDB;

INSERT INTO category (name_category) VALUES ('Story Selection'), ('Fairy Tales'), ('Animal Fables'), ('Stories to spark the imagination');



INSERT INTO stories (id, title, content, image, category_id) VALUES
(1, 'The Tale of Peter Rabbit', 'Once upon a time , there were four little rabbits named Flopsy, Mopsy, Cotton-tail, and Peter. They lived with their mother in a cozy burrow under the roots of a big fir tree.
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
The End.', 'story_1.webp', 1);

INSERT INTO stories (id, title, content, image, category_id) VALUES
(2, 'The Brave Lion', 'Once upon a time, in a vast and sunny savannah, there lived a young lion named Leo. 
Although Leo was smaller than most lions his age, he was known for his kind heart and strong sense of courage.
Every morning, Leo would trot around the savannah, greeting the zebras, antelopes, and even the wary gazelles with a friendly roar. While the other lions spent their time dozing in the shade, Leo loved exploring and helping any animal in need.
One hot afternoon, a fierce storm suddenly rolled in. Dark clouds covered the sky, and thunder boomed across the grasslands. Strong winds knocked down tall trees, and the heavy rain began to flood the rivers. Many of the smaller animals, like meerkats and rabbits, were terrified and didn\'t know how to find higher ground.
Leo saw how frightened they were. Even though he was scared, too, he mustered his courage and guided the animals to a safe, dry cave on the far side of the savannah. With lightning striking nearby, he calmly led everyone through the pouring rain, warning them of dangerous puddles and slippery rocks.
Inside the cave, the animals huddled together until the storm passed. Afterward, they emerged to see the sun shining once again. They realized it was Leo\'s bravery and kindness that had protected them from harm.
From that day on, all the animals respected Leo. They knew that being truly brave wasn\'t about being big or loud—it was about being willing to help others and face your fears. And so, Leo earned the proud title of The Brave Lion, reminding everyone that the greatest strength comes from a caring heart.',
'story_2.webp', 1);

INSERT INTO stories (id, title, content, image, category_id) VALUES
(3, 'The Tortoise and the Hare', 'Once upon a time in a lush green forest, all the animals gathered to watch a race. The Hare, known for his incredible speed, was very confident about winning. The Tortoise, on the other hand, was slow and steady, often seen taking his time to move.
As the race began, the Hare dashed off quickly, leaving the Tortoise far behind. Feeling certain of his victory, the Hare decided to take a nap under a shady tree, thinking he had plenty of time to finish the race later.
Meanwhile, the Tortoise kept moving forward, one slow step at a time. He didn’t stop or slow down, maintaining his steady pace throughout the journey.
When the Hare finally woke up, he saw the Tortoise nearing the finish line. Panicked, the Hare sprinted as fast as he could, but it was too late. The Tortoise had already crossed the finish line and won the race.
All the animals cheered for the Tortoise, celebrating his perseverance and determination. The Hare felt ashamed for underestimating his opponent and learned a valuable lesson about humility and consistency.
Moral of the Story: "Slow and steady wins the race."','story_3.webp', 1);

INSERT INTO stories (id, title, content, image, category_id) VALUES
(4, 'The Brave Little Fox', 'Once upon a time, in the heart of a quiet forest, there lived a little fox named Finn. Finn was smaller than all the other foxes, but what he lacked in size, he made up for in courage and kindness.
While most foxes spent their days playing in the meadow, Finn loved to explore the deeper parts of the forest. The trees there were taller, the sounds were louder, and the shadows danced like magic.
One day, while Finn was chasing fireflies, he heard a soft cry. \"Help! Help!\" it called. He followed the sound and found a baby bird stuck on the ground. Its wing was hurt, and it couldn\'t fly. \"Don\'t worry,\" said Finn, his golden eyes full of determination. \"I\'ll help you.\" He gently picked up the little bird and carried it on his back. The bird was scared at first, but Finn spoke to it softly. \"I know a safe place for you,\" he said. 
He carefully made his way to an old oak tree where Grandma Owl lived. She was wise and kind, and she knew how to heal small creatures. \"Oh, Finn,\" said Grandma Owl with a smile. \"You have a brave heart to help someone in need.\" She took the little bird in her soft feathers and promised to care for it.
The next day, all the forest animals gathered around Finn. They had heard of his bravery. \"You may be small, but you have a big heart,\" said a big, proud stag. The rabbits, squirrels, and even the other foxes cheered for Finn.
From that day on, Finn was no longer seen as the smallest fox. He was known as the bravest little fox in the forest. And whenever anyone needed help, they knew exactly who to call.
Moral of the story: Being small doesn\'t mean you can\'t do big things. Courage and kindness make you truly strong.', 'story_4.webp', 1);

INSERT INTO stories (id, title, content, image, category_id) VALUES
(5, 'The Lion and the Mouse','Once upon a time in a dense jungle, a mighty lion ruled as the king of the animals. One sunny afternoon, as the lion was taking a nap under the shade of a large tree, a little mouse happened to run over his paw. Startled, the lion awoke and trapped the mouse with his massive paw.
"Please let me go," squeaked the mouse. "I didn''t mean to disturb you. If you spare my life, I promise I''ll help you someday."
The lion laughed at the idea of such a tiny creature helping him but, amused by the mouse''s courage, decided to release him.
"Very well," said the lion, "go on your way, little one."
Days turned into weeks, and the lion continued his reign, strong and unchallenged. However, one day, hunters set a large net to capture the lion. Caught in the net, the lion roared loudly, struggling to free himself, but the ropes were too strong.
Hearing the lion''s cries, the little mouse remembered his promise. He scurried over to the net and began to gnaw through the ropes with his sharp teeth. Bit by bit, the mouse worked tirelessly until the lion was free.
"You were right," the lion said gratefully, "even the smallest of creatures can be of great help."
Moral of the Story: No act of kindness, no matter how small, is ever wasted. Even the smallest friends can prove to be the greatest allies.', 'story_5.webp', 1);

INSERT INTO stories (id, title, content, image, category_id) VALUES 
(6, 'Little Red Hen Story', 'Once upon a time, in a barnyard lived a Little Red Hen. She spent almost all her time walking around the barnyard, scratching everywhere for worms. She dearly loved fat and delicious worms and felt they were absolutely necessary for the health of her chicks. Whenever she found a worm, she would call “Chuck-chuck-chuck!” to her chicks. 
A cat used to nap lazily at the barn door, not even bothering to scare the rat who ran here and there. There also lived a pig who used to stay in the pigsty and did not care what happened, as long as he could eat and grow fat.
One day the Little Red Hen found a wheat seed. She bit the seed gently, thinking it was a worm, but it resembled a worm in no way! Carrying it around the barn, the Little Red Hen made many inquiries about what it might be. She discovered that it was a wheat seed and that, if planted, the seed would grow up, and when ripe, it could be made into flour that could be used to make bread.
But the seed had to be planted first. So, she thought of the Pig, Cat, and Rat for help and called out to them – “Who will plant the Seed?”

“Not I,” said the Pig,  
“Not I,” said the Cat,  
“Not I,” said the Rat.  

“Well, I will then,” said the Little Red Hen.  

After some months, the wheat grew taller and ready for harvest. So she ran about calling –  “Who will cut the wheat?”  

“Not I,” said the Pig,  
“Not I,” said the Cat,  
“Not I,” said the Rat.  

“Well, I will then,” said the Little Red Hen.  
She proceeded to cut off all of the big plants of wheat. Now was the time to thresh the wheat. In a very hopeful tone, she again called out, “Who will thresh the wheat?”  

“Not I,” said the Pig,  
“Not I,” said the Cat,  
“Not I,” said the Rat.  

“Well, I will, then.” said the Little Red Hen.  

After threshing the wheat, she again called out for help - “Who will help to carry the wheat to the mill to be ground?”  

“Not I,” said the Pig,  
“Not I,” said the Cat,  
“Not I,” said the Rat.  

“Well, I will then,” said the Little Red Hen.  

Carrying the sack of wheat, she trudged off to the mill. There she got the wheat ground into white flour.  
Now that the wheat was ground, it had to be made into bread.  
Still confident that the Pig, Cat and Rat would surely help, she sang out, “Who will make the bread?”  

“Not I,” said the Pig,  
“Not I,” said the Cat,  
“Not I,” said the Rat.  

Alas, all the hopes of the Little Red Hen were dashed. So, the Little Red Hen said again, “I will then”. She went and put on an apron, set the dough, brought out the moulding board and the baking tins, moulded the bread, divided it into loaves, and put them into the oven to bake.  
After some time, a delicious odour was in the air. The Little Red Hen pulled lovely brown loaves from the oven that were baked to perfection.  
Out of habit, the Little Red Hen called out – “Who will eat the bread?”  

“I will,” said the Pig,  
“I will,” said the Cat,  
“I will,” said the Rat.  

But this time, the Little Red Hen replied – “No, you won''t. I will.”  
The Little Red Hen called her chicks and ate up all the delicious bread. There was nothing left for the Pig, Cat and Rat.', 'story_6.webp', 1);  


INSERT INTO keywords (keyword) VALUES 
('time'),('rabbits'),('accident'),('carrots'),('blackberries');

INSERT INTO keywords (keyword) VALUES 
('lion'),('storm'),('courage'),('animals'),('heart');

INSERT INTO keywords (keyword) VALUES 
('speed'),('confident'),('stop'),('perseverance'),('race');

INSERT INTO keywords (keyword) VALUES 
('fox'),('forest'),('courage'),('kindness'),('bravery');

INSERT INTO keywords (keyword) VALUES 
('jungle'),('king'),('courage'),('promise'),('friends');

INSERT INTO keywords (keyword) VALUES 
('pigsty'),('discovered'),('seed'),('wheat'),('chicks');


-- Supongamos que los keyword_ids son 1, 2, 3, 4 y 5
INSERT INTO story_keywords (story_id, keyword_id) VALUES
(1, 1),  -- Relationship between story 1 and keyword 1
(1, 2),  -- Relationship between story 1 and keyword 2
(1, 3),  -- Relationship between story 1 and keyword 3
(1, 4),  -- Relationship between story 1 and keyword 4
(1, 5);  -- Relationship between story 1 and keyword 5

INSERT INTO story_keywords (story_id, keyword_id) VALUES
(2, 6),  -- Relationship between story 2 and keyword 1
(2, 7),  -- Relationship between story 2 and keyword 2
(2, 8),  -- Relationship between story 2 and keyword 3
(2, 9),  -- Relationship between story 2 and keyword 4
(2, 10);  -- Relationship between story 2 and keyword 5

INSERT INTO story_keywords (story_id, keyword_id) VALUES
(3, 11),  -- Relationship between story 3 and keyword 1
(3, 12),  -- Relationship between story 3 and keyword 2
(3, 13),  -- Relationship between story 3 and keyword 3
(3, 14),  -- Relationship between story 3 and keyword 4
(3, 15);  -- Relationship between story 3 and keyword 5

INSERT INTO story_keywords (story_id, keyword_id) VALUES
(4, 16),  -- Relationship between story 4 and keyword 1
(4, 17),  -- Relationship between story 4 and keyword 2
(4, 18),  -- Relationship between story 4 and keyword 3
(4, 19),  -- Relationship between story 4 and keyword 4
(4, 20);  -- Relationship between story 4 and keyword 5

INSERT INTO story_keywords (story_id, keyword_id) VALUES
(5, 21),  -- Relationship between story 5 and keyword 1
(5, 22),  -- Relationship between story 5 and keyword 2
(5, 23),  -- Relationship between story 5 and keyword 3
(5, 24),  -- Relationship between story 5 and keyword 4
(5, 25);  -- Relationship between story 5 and keyword 5

INSERT INTO story_keywords (story_id, keyword_id) VALUES
(6, 26),  -- Relationship between story 6 and keyword 1
(6, 27),  -- Relationship between story 6 and keyword 2
(6, 28),  -- Relationship between story 6 and keyword 3
(6, 29),  -- Relationship between story 6 and keyword 4
(6, 30);  -- Relationship between story 6 and keyword 5








