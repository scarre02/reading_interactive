CREATE DATABASE interactive_stories;

USE interactive_stories;

CREATE TABLE stories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    image VARCHAR(45) NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES category(id_category) ON DELETE CASCADE
) ENGINE=InnoDB;

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
(1, 'The ant and the Grasshopper', 'One summer, under the warm sun, a grasshopper spent her days singing and playing her violin, enjoying the beauty of the season.<br>
She danced among the flowers, laughed with the bees, and let the gentle breeze carry her melodies through the fields.<br><br>

Meanwhile, a hardworking ant was busy collecting food. She carried grains of wheat, one by one, to store in her underground home.<br>
The grasshopper watched and laughed, saying:<br><br>

"Why do you work so hard, dear Ant? Come, enjoy the sunshine! There is plenty of food everywhere!"<br><br>

But the Ant, without stopping, replied:<br><br>

"I am preparing for winter. When the cold comes, food will be scarce."<br><br>

The Grasshopper shrugged and continued playing, convinced that summer would last forever.<br><br>

Then, autumn passed, and winter arrived. The once warm fields were now covered in snow, and there was no food to be found.<br>
The Grasshopper, hungry and cold, wandered in search of something to eat, but all the plants were dead, and the insects had disappeared.<br><br>

At last, she came to the Ant’s house and knocked on the door.<br><br>

"Dear Ant, I am starving! Please, may I have some food?"<br><br>

The Ant looked at her sadly and said:<br><br>

"During the summer, I worked while you played. I saved food for winter, but you did not. Why should I share what I worked so hard for?"<br><br>

Ashamed, the Grasshopper realized her mistake. She had wasted the warm months without preparing for the future.<br><br>

The moral of the story?<br>
There is a time for work and a time for play. Those who plan ahead will not suffer when hard times come.', 'story_1.webp', 1);

INSERT INTO stories (id, title, content, image, category_id) VALUES
(2, 'The Brave Little Squirrel', 'In a vast and ancient forest, where the trees whispered secrets to the wind, lived a little squirrel named Pip.<br>
Pip was small but full of courage. He loved to climb the tallest trees and leap from branch to branch with fearless energy.<br><br>

One autumn morning, as Pip was gathering acorns for the winter, he overheard a group of birds talking anxiously.<br>
A great storm was coming, and it would be the fiercest the forest had seen in years.<br><br>

Pip’s heart pounded. He knew that the oldest oak tree, home to many animals, stood on a hill where the winds would be strongest.<br>
He had to warn them!<br><br>

Without hesitation, Pip raced up the tree trunks, leaping from branch to branch, spreading the warning.<br>
He told the rabbits to burrow deeper, the foxes to find shelter, and the deer to move to the denser parts of the forest.<br><br>

When he reached the old oak, he found a family of owls nestled inside. They were too young to fly far.<br>
Determined, Pip helped them move to a hollowed-out log near the ground, where they would be safe.<br><br>

Just as the last owl was tucked inside, the storm arrived. The wind howled, and rain poured down like a waterfall.<br>
Trees bent and cracked, but the animals were safe, thanks to Pip’s warning.<br><br>

When the storm passed, the sun peeked through the clouds, and the forest glistened with raindrops.<br>
The animals gathered around Pip, cheering and thanking him for his bravery.<br><br>

From that day on, Pip was not just the little squirrel who loved to jump—he was the hero of the forest.<br><br>

The moral of the story?<br>
Bravery isn’t about size or strength, but about caring for others and taking action when it matters most.', 'story_2.webp', 1);

INSERT INTO stories (id, title, content, image, category_id) VALUES 
(3, 'The Tortoise and the Hare', 'Once upon a time in a lush green forest, all the animals gathered to watch a race.<br><br>
The Hare, known for his incredible speed, was very confident about winning. The Tortoise, on the other hand, was slow and steady, often seen taking his time to move.<br><br>

As the race began, the Hare dashed off quickly, leaving the Tortoise far behind. Feeling certain of his victory, the Hare decided to take a nap under a shady tree, thinking he had plenty of time to finish the race later.<br><br>

Meanwhile, the Tortoise kept moving forward, one slow step at a time. He didn’t stop or slow down, maintaining his steady pace throughout the journey.<br><br>

When the Hare finally woke up, he saw the Tortoise nearing the finish line. Panicked, the Hare sprinted as fast as he could, but it was too late. The Tortoise had already crossed the finish line and won the race.<br><br>

All the animals cheered for the Tortoise, celebrating his perseverance and determination. The Hare felt ashamed for underestimating his opponent and learned a valuable lesson about humility and consistency.<br><br>

Moral of the Story: "Slow and steady wins the race."',
'story_3.webp', 1);


INSERT INTO stories (id, title, content, image, category_id) VALUES 
(4, 'The Brave Little Fox', 'Once upon a time, in the heart of a quiet forest, there lived a little fox named Finn.<br><br>

Finn was smaller than all the other foxes, but what he lacked in size, he made up for in courage and kindness.<br><br>

While most foxes spent their days playing in the meadow, Finn loved to explore the deeper parts of the forest.<br>
The trees there were taller, the sounds were louder, and the shadows danced like magic.<br><br>

One day, while Finn was chasing fireflies, he heard a soft cry. "Help! Help!" it called.<br>
He followed the sound and found a baby bird stuck on the ground. Its wing was hurt, and it couldn\'t fly.<br><br>

"Don\'t worry," said Finn, his golden eyes full of determination. "I\'ll help you."<br>
He gently picked up the little bird and carried it on his back. The bird was scared at first, but Finn spoke to it softly.<br>
"I know a safe place for you," he said.<br><br>

He carefully made his way to an old oak tree where Grandma Owl lived. She was wise and kind, and she knew how to heal small creatures.<br>
"Oh, Finn," said Grandma Owl with a smile. "You have a brave heart to help someone in need."<br>
She took the little bird in her soft feathers and promised to care for it.<br><br>

The next day, all the forest animals gathered around Finn. They had heard of his bravery.<br>
"You may be small, but you have a big heart," said a big, proud stag.<br>
The rabbits, squirrels, and even the other foxes cheered for Finn.<br><br>

From that day on, Finn was no longer seen as the smallest fox. He was known as the bravest little fox in the forest.<br>
And whenever anyone needed help, they knew exactly who to call.<br><br>

Moral of the story: Being small doesn\'t mean you can\'t do big things.<br>
Courage and kindness make you truly strong.', 'story_4.webp', 1);

INSERT INTO stories (id, title, content, image, category_id) VALUES 
(5, 'The Lion and the Mouse', 'Once upon a time in a dense jungle, a mighty lion ruled as the king of the animals.<br><br>

One sunny afternoon, as the lion was taking a nap under the shade of a large tree, a little mouse happened to run over his paw.<br>
Startled, the lion awoke and trapped the mouse with his massive paw.<br><br>

"Please let me go," squeaked the mouse. "I didn\'t mean to disturb you. If you spare my life, I promise I\'ll help you someday."<br><br>

The lion laughed at the idea of such a tiny creature helping him but, amused by the mouse\'s courage, decided to release him.<br><br>

"Very well," said the lion, "go on your way, little one."<br><br>

Days turned into weeks, and the lion continued his reign, strong and unchallenged.<br>
However, one day, hunters set a large net to capture the lion. Caught in the net, the lion roared loudly, struggling to free himself, but the ropes were too strong.<br><br>

Hearing the lion\'s cries, the little mouse remembered his promise.<br>
He scurried over to the net and began to gnaw through the ropes with his sharp teeth.<br>
Bit by bit, the mouse worked tirelessly until the lion was free.<br><br>

"You were right," the lion said gratefully, "even the smallest of creatures can be of great help."<br><br>

Moral of the Story: No act of kindness, no matter how small, is ever wasted.<br>
Even the smallest friends can prove to be the greatest allies.', 'story_5.webp', 1);

INSERT INTO stories (id, title, content, image, category_id) VALUES 
(6, 'Little Red Hen Story', 'Once upon a time, in a barnyard lived a Little Red Hen. She spent almost all her time walking around the barnyard, scratching everywhere for worms.<br>
She dearly loved fat and delicious worms and felt they were absolutely necessary for the health of her chicks.<br>
Whenever she found a worm, she would call “Chuck-chuck-chuck!” to her chicks.<br><br>

A cat used to nap lazily at the barn door, not even bothering to scare the rat who ran here and there.<br>
There also lived a pig who used to stay in the pigsty and did not care what happened, as long as he could eat and grow fat.<br><br>

One day, the Little Red Hen found a wheat seed. She bit the seed gently, thinking it was a worm, but it resembled a worm in no way!<br>
Carrying it around the barn, the Little Red Hen made many inquiries about what it might be.<br>
She discovered that it was a wheat seed and that, if planted, the seed would grow up, and when ripe, it could be made into flour that could be used to make bread.<br><br>

But the seed had to be planted first. So, she thought of the Pig, Cat, and Rat for help and called out to them –<br>
“Who will plant the Seed?”<br><br>

“Not I,” said the Pig,<br>
“Not I,” said the Cat,<br>
“Not I,” said the Rat.<br><br>

“Well, I will then,” said the Little Red Hen.<br><br>

After some months, the wheat grew taller and ready for harvest. So she ran about calling –<br>  
“Who will cut the wheat?”<br><br>

“Not I,” said the Pig,<br>
“Not I,” said the Cat,<br>
“Not I,” said the Rat.<br><br>

“Well, I will then,” said the Little Red Hen.<br><br>

She proceeded to cut off all of the big plants of wheat. Now was the time to thresh the wheat.<br>
In a very hopeful tone, she again called out, “Who will thresh the wheat?”<br><br>

“Not I,” said the Pig,<br>
“Not I,” said the Cat,<br>
“Not I,” said the Rat.<br><br>

“Well, I will then,” said the Little Red Hen.<br><br>

After threshing the wheat, she again called out for help –<br>  
“Who will help to carry the wheat to the mill to be ground?”<br><br>

“Not I,” said the Pig,<br>
“Not I,” said the Cat,<br>
“Not I,” said the Rat.<br><br>

“Well, I will then,” said the Little Red Hen.<br><br>

Carrying the sack of wheat, she trudged off to the mill. There she got the wheat ground into white flour.<br>  
Now that the wheat was ground, it had to be made into bread.<br><br>

Still confident that the Pig, Cat, and Rat would surely help, she sang out, “Who will make the bread?”<br><br>

“Not I,” said the Pig,<br>
“Not I,” said the Cat,<br>
“Not I,” said the Rat.<br><br>

Alas, all the hopes of the Little Red Hen were dashed.<br>
So, the Little Red Hen said again, “I will then.”<br>
She went and put on an apron, set the dough, brought out the moulding board and the baking tins,<br>
moulded the bread, divided it into loaves, and put them into the oven to bake.<br><br>

After some time, a delicious odour was in the air.<br>
The Little Red Hen pulled lovely brown loaves from the oven that were baked to perfection.<br><br>

Out of habit, the Little Red Hen called out –<br>  
“Who will eat the bread?”<br><br>

“I will,” said the Pig,<br>
“I will,” said the Cat,<br>
“I will,” said the Rat.<br><br>

But this time, the Little Red Hen replied – “No, you won\'t. I will.”<br><br>

The Little Red Hen called her chicks and ate up all the delicious bread.<br>
There was nothing left for the Pig, Cat, and Rat.', 'story_6.webp', 1);


INSERT INTO keywords (id, keyword) VALUES 
(1, 'violin'),(2, 'undergound'),(3, 'playing'),(4, 'starving'),(5, 'future');

INSERT INTO keywords (id, keyword) VALUES 
(6, 'lion'),(7, 'storm'),(8, 'courage'),(9, 'animals'),(10, 'heart');

INSERT INTO keywords (id, keyword) VALUES 
(11, 'speed'),(12, 'confident'),(13, 'stop'),(14, 'perseverance'),(15, 'race');

INSERT INTO keywords (id, keyword) VALUES 
(16, 'fox'),(17, 'forest'),(18, 'courage'),(19, 'kindness'),(20, 'bravery');

INSERT INTO keywords (id, keyword) VALUES 
(21, 'jungle'),(22, 'king'),(23, 'courage'),(24, 'promise'),(25, 'friends');

INSERT INTO keywords (id, keyword) VALUES 
(26, 'pigsty'),(27, 'discovered'),(28, 'seed'),(29, 'wheat'),(30, 'chicks');




-- Insertar relaciones entre historia y palabras clave en story_keywords
INSERT INTO story_keywords (story_id, keyword_id) VALUES
(1, 1), -- Relationship between story 1 and keyword 1
(1, 2), -- Relationship between story 1 and keyword 2
(1, 3), -- Relationship between story 1 and keyword 3 
(1, 4), -- Relationship between story 1 and keyword 4 
(1, 5); -- Relationship between story 1 and keyword 5

INSERT INTO story_keywords (story_id, keyword_id) VALUES
(2, 6),  -- Relationship between story 2 and keyword 1
(2, 7),  -- Relationship between story 2 and keyword 2
(2, 8),  -- Relationship between story 2 and keyword 3
(2, 9),  -- Relationship between story 2 and keyword 4
(2, 10); -- Relationship between story 2 and keyword 5

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










