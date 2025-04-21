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

CREATE TABLE users (
  id_user INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) DEFAULT NULL, -- NULL para usuarios de Google
  dob DATE DEFAULT NULL,
  terms_accepted BOOLEAN DEFAULT FALSE,
  privacy_accepted BOOLEAN DEFAULT FALSE,
  is_verified BOOLEAN DEFAULT FALSE,
  verification_token VARCHAR(255) DEFAULT NULL,
  provider ENUM('local', 'google') DEFAULT 'local',
  earned_stars INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_user)
);

CREATE TABLE history (
  id_history INT NOT NULL AUTO_INCREMENT,
  users_id_user INT NOT NULL,
  stories_id INT NOT NULL,
  date_of_lecture DATE NOT NULL,
  PRIMARY KEY (id_history),
  KEY fk_users_has_stories_stories1_idx (stories_id),
  KEY fk_users_has_stories_users_idx (users_id_user),
  CONSTRAINT fk_users_has_stories_stories1 FOREIGN KEY (stories_id) REFERENCES stories (id),
  CONSTRAINT fk_users_has_stories_users FOREIGN KEY (users_id_user) REFERENCES users (id_user)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO category (name_category) VALUES ('Story Selection'), ('Fairy Tales'), ('Animal Fables'), ('Bedtime stories');

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

INSERT INTO keywords (id, keyword) VALUES 
(1, 'violin'),(2, 'sunshine'),(1, 'snow'),(4, 'starving'),(5, 'future');

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

INSERT INTO stories (id, title, content, image, category_id) VALUES
(7, 'Little Red Riding Hood', 'Once upon a time there was a dear little girl who was loved by every one who looked at her, but most of all by her grandmother, and there was nothing that she would not have given to the child. Once she gave her a little cap of red velvet, which suited her so well that she would never wear anything else. So she was always called Little Red Riding Hood.<br><br>

One day her mother said to her, "Come, Little Red Riding Hood, here is a piece of cake and a bottle of wine. Take them to your grandmother, she is ill and weak, and they will do her good. Set out before it gets hot, and when you are going, walk nicely and quietly and do not run off the path, or you may fall and break the bottle, and then your grandmother will get nothing. And when you go into her room, don’t forget to say, good-morning, and don’t peep into every corner before you do it."<br><br>

"I will take great care," said Little Red Riding Hood to her mother, and gave her hand on it.<br><br>

The grandmother lived out in the wood, half a league from the village, and just as Little Red Riding Hood entered the wood, a wolf met her. Little Red Riding Hood did not know what a wicked creature he was, and was not at all afraid of him.<br><br>

"Good-day, Little Red Riding Hood," said he.<br><br>

"Thank you kindly, wolf."<br><br>

"Whither away so early, Little Red Riding Hood?"<br><br>

"To my grandmother''s."<br><br>

"What have you got in your apron?"<br><br>

"Cake and wine. Yesterday was baking-day, so poor sick grandmother is to have something good, to make her stronger."<br><br>

"Where does your grandmother live, Little Red Riding Hood?"<br><br>

"A good quarter of a league farther on in the wood. Her house stands under the three large oak-trees, the nut-trees are just below. You surely must know it," replied Little Red Riding Hood.<br><br>

The wolf thought to himself, "What a tender young creature. What a nice plump mouthful, she will be better to eat than the old woman. I must act craftily, so as to catch both." So he walked for a short time by the side of Little Red Riding Hood, and then he said, "See, Little Red Riding Hood, how pretty the flowers are about here. Why do you not look round? I believe, too, that you do not hear how sweetly the little birds are singing. You walk gravely along as if you were going to school, while everything else out here in the wood is merry."<br><br>

Little Red Riding Hood raised her eyes, and when she saw the sunbeams dancing here and there through the trees, and pretty flowers growing everywhere, she thought, "Suppose I take grandmother a fresh nosegay. That would please her too. It is so early in the day that I shall still get there in good time." And so she ran from the path into the wood to look for flowers. And whenever she had picked one, she fancied that she saw a still prettier one farther on, and ran after it, and so got deeper and deeper into the wood.<br><br>

Meanwhile the wolf ran straight to the grandmother''s house and knocked at the door.<br><br>

"Who is there?"<br><br>

"Little Red Riding Hood," replied the wolf. "She is bringing cake and wine. Open the door."<br><br>

"Lift the latch," called out the grandmother, "I am too weak, and cannot get up."<br><br>

The wolf lifted the latch, the door sprang open, and without saying a word he went straight to the grandmother''s bed, and devoured her. Then he put on her clothes, dressed himself in her cap, laid himself in bed and drew the curtains.<br><br>

Little Red Riding Hood, however, had been running about picking flowers, and when she had gathered so many that she could carry no more, she remembered her grandmother, and set out on the way to her.<br><br>

She was surprised to find the cottage-door standing open, and when she went into the room, she had such a strange feeling that she said to herself, "Oh dear, how uneasy I feel today, and at other times I like being with grandmother so much."<br><br>

She called out, "Good morning," but received no answer. So she went to the bed and drew back the curtains. There lay her grandmother with her cap pulled far over her face, and looking very strange.<br><br>

"Oh, grandmother," she said, "what big ears you have."<br><br>

"The better to hear you with, my child," was the reply.<br><br>

"But, grandmother, what big eyes you have," she said.<br><br>

"The better to see you with, my dear."<br><br>

"But, grandmother, what large hands you have."<br><br>

"The better to hug you with."<br><br>

"Oh, but, grandmother, what a terrible big mouth you have."<br><br>

"The better to eat you with."<br><br>

And scarcely had the wolf said this, than with one bound he was out of bed and swallowed up Little Red Riding Hood.<br><br>

When the wolf had appeased his appetite, he lay down again in the bed, fell asleep and began to snore very loud. The huntsman was just passing the house, and thought to himself, "How the old woman is snoring. I must just see if she wants anything."<br><br>

So he went into the room, and when he came to the bed, he saw that the wolf was lying in it. "Do I find you here, you old sinner," said he. "I have long sought you."<br><br>

Then just as he was going to fire at him, it occurred to him that the wolf might have devoured the grandmother, and that she might still be saved, so he did not fire, but took a pair of scissors, and began to cut open the stomach of the sleeping wolf.<br><br>

When he had made two snips, he saw the Little Red Riding Hood shining, and then he made two snips more, and the little girl sprang out, crying, "Ah, how frightened I have been. How dark it was inside the wolf."<br><br>

And after that the aged grandmother came out alive also, but scarcely able to breathe. Little Red Riding Hood, however, quickly fetched great stones with which they filled the wolf''s belly, and when he awoke, he wanted to run away, but the stones were so heavy that he collapsed at once, and fell dead.<br><br>

Then all three were delighted. The huntsman drew off the wolf''s skin and went home with it. The grandmother ate the cake and drank the wine which Little Red Riding Hood had brought, and revived, but Little Red Riding Hood thought to herself, "As long as I live, I will never by myself leave the path, to run into the wood, when my mother has forbidden me to do so."<br><br>

The End.', 'story_7.webp', 2);

INSERT INTO stories (id, title, content, image, category_id) VALUES
(8, 'Sleeping Beauty', 'Once upon a time, in a land of magic, there lived a beautiful princess named Aurora. She was known throughout the kingdom for her kindness, grace, and her heartwarming smile. Her hair was as golden as the sun, her eyes as blue as the sky, and her laughter as sweet as a songbird''s.<br><br>

Aurora''s story began in a grand palace, where she was born to a loving king and queen. Her arrival brought great joy to the kingdom, and the king and queen celebrated her birth with a big feast. As the kingdom rejoiced, three good fairies, Flora, Fauna, and Merryweather, gave their blessings to the little princess.<br><br>

Flora, with her red dress and magical wand, gave Aurora the gift of beauty. Fauna, in her green dress, gave her the gift of song. Merryweather, in her blue dress, wanted to give Aurora a gift too, but before she could finish, an evil sorceress named Maleficent appeared. Angry that she had not been invited to the celebration, she placed a curse on the young princess.<br><br>

Maleficent declared that on Aurora''s sixteenth birthday, she would prick her finger on a spinning wheel''s spindle and fall into a deep sleep from which she could only be awakened by true love''s kiss. The kingdom was filled with sadness, and the good fairies were determined to protect the princess from the curse.<br><br>

To keep Aurora safe, they took her to a hidden cottage in the woods, where she was given a new name, Briar Rose. There, she lived a simple life with the fairies as her guardians, and she was told nothing of her true identity or the curse that hung over her.<br><br>

Years passed, and Aurora grew into a lovely young girl. She had a deep love for the forest and all its creatures. She would sing and dance with the animals, and they, in turn, became her dearest friends.<br><br>

On the eve of her sixteenth birthday, the fairies decided it was time to tell Aurora the truth. They took her back to the palace, where her heartwarming smile and her beauty made everyone happy. But as the evening wore on, Aurora was drawn to an old spinning wheel she found in a dark, hidden room.<br><br>

Despite the fairies'' warnings, she pricked her finger on the spindle and fell into a deep, enchanted sleep, just as Maleficent had said. The king and queen, filled with sadness, placed Aurora on a bed of flowers and cried for their beloved daughter.<br><br>

The good fairies knew that Aurora could only be awakened by true love''s kiss, and they set out to find the prince who could break the curse. Prince Phillip, a brave and kind young man, was the one who had met Aurora in the forest and fallen in love with her as Briar Rose.<br><br>

With the fairies'' help, Prince Phillip battled through thorns, defeated Maleficent in her fearsome dragon form, and reached Aurora''s side. With a gentle kiss, he awakened the princess from her deep sleep, and her eyes sparkled with love as she looked at the prince.<br><br>

The kingdom rejoiced, and Aurora and Prince Phillip were married in a grand and joyous ceremony. The prince had proven that true love could conquer any curse, and the two of them ruled the kingdom with kindness and grace.<br><br>

And so, my dear child, that is the end of the story of Sleeping Beauty. It reminds us that love and courage can overcome even the darkest of curses. Now, close your eyes and let your dreams take you to a world of magic and enchantment. Goodnight, and may your dreams be as beautiful as Aurora''s heart.<br><br>

The End.', 'story_8.webp', 2);

INSERT INTO stories (id, title, content, image, category_id) VALUES
(9, 'Jack and the Beanstalk', 'Once upon a time, there was a poor boy named Jack who lived with his mother in a small cottage.<br><br>

They had no money, and their only possession was a cow. One day, Jack''s mother told him to sell the cow at the market so they could buy food.<br><br>

On the way, Jack met a mysterious old man who offered him five magic beans in exchange for the cow. Jack was curious and traded the cow for the beans. But when he got home, his mother was very angry.<br><br>

"Magic beans? These are useless!" she cried and threw them out the window.<br><br>

The next morning, Jack woke up and saw a giant beanstalk reaching into the sky! The beans really were magic! Excited, he decided to climb the beanstalk.<br><br>

At the top, Jack found a huge castle in the clouds. He knocked on the door, and a giant''s wife opened it.<br><br>

"Please, ma’am, I’m very hungry," Jack said.<br><br>

The kind woman gave him some food, but suddenly, he heard loud footsteps.<br><br>

"FEE-FI-FO-FUM! I smell the blood of an Englishman!"<br><br>

It was the giant! The wife quickly hid Jack in a cupboard. The giant sat down, counted his gold coins, and soon fell asleep.<br><br>

Jack saw his chance! He grabbed a bag of gold and ran back down the beanstalk.<br><br>

Jack and his mother were happy, but soon, the gold ran out. So Jack climbed the beanstalk again. This time, he saw the giant''s golden hen, which laid eggs made of gold! While the giant was asleep, Jack took the hen and escaped.<br><br>

Jack''s mother was thrilled, but Jack wanted to go one more time.<br><br>

For the third time, Jack climbed the beanstalk and saw the giant''s magical harp that could sing by itself! As Jack picked it up, the harp cried,<br><br>

"Master! Master! Someone is stealing me!"<br><br>

The giant woke up and chased Jack.<br><br>

Jack ran as fast as he could, sliding down the beanstalk. The giant followed him.<br><br>

"Mother! Bring me an axe!" Jack shouted.<br><br>

As soon as he reached the ground, Jack chopped down the beanstalk with all his strength.<br><br>

The giant fell from the sky—and that was the end of him!<br><br>

From then on, Jack and his mother lived happily ever after with the golden hen and the magic harp.<br><br>

The End.', 'story_9.webp', 2);

INSERT INTO stories (id, title, content, image, category_id) VALUES
(10, 'The Shepherd Boy and The Wolf', 'Once upon a time, a young shepherd boy took care of his sheep near a quiet village. Every day, he sat on the hill watching his flock, but he felt bored and lonely.<br><br>

One day, to have some fun, he shouted, "Wolf! Wolf! Help! The wolf is attacking the sheep!"<br><br>

The villagers ran up the hill to help him. But when they arrived, they saw no wolf. The boy laughed, "I tricked you!" The villagers were angry and went back down.<br><br>

The next day, the boy did it again. "Wolf! Wolf!" he shouted. The villagers rushed to help, but again, there was no wolf. The boy laughed and laughed. The villagers were even angrier.<br><br>

A few days later, a real wolf came. The boy was scared and shouted, "Wolf! Wolf! Please help!" But this time, the villagers didn’t believe him. They thought he was joking again and didn’t come.<br><br>

The wolf chased the sheep, and the boy learned a very important lesson: Never tell lies, because people may not believe you when you are telling the truth.<br><br>

The End.', 'story_10.webp', 2);

INSERT INTO stories (id, title, content, image, category_id) VALUES
(11, 'Snow White and the Seven Dwarfs', 'Once upon a time, in a faraway kingdom, there was a beautiful princess named Snow White. She had skin as white as snow, lips as red as roses, and hair as black as ebony. But her stepmother, the Evil Queen, was jealous of her beauty. Every day, the Queen asked her magic mirror,<br><br>

"Mirror, mirror on the wall, who is the fairest of them all?"<br><br>

The mirror always replied, "You, my Queen, are the fairest of them all." But one day, the mirror said, "Snow White is the fairest of them all!"<br><br>

The Evil Queen was furious! She ordered a huntsman to take Snow White into the forest and get rid of her. But the kind huntsman felt sorry for Snow White and let her go.<br><br>

Snow White ran deep into the forest and found a small cottage. Inside, everything was tiny—tiny chairs, tiny beds, and tiny dishes. Tired and hungry, she ate a little food and fell asleep.<br><br>

When the seven dwarfs returned from working in the mines, they found her sleeping in their beds! Snow White woke up and was surprised to see them. The dwarfs introduced themselves: Doc, Grumpy, Happy, Sleepy, Bashful, Sneezy, and Dopey.<br><br>

They listened to her story and said, “You can stay with us, but beware of the Evil Queen!”<br><br>

Back at the castle, the Evil Queen discovered that Snow White was still alive. She disguised herself as an old woman and went to the cottage with a poisoned apple.<br><br>

“Take a bite, dear child,” the old woman said. Snow White took a bite and fell into a deep sleep! When the dwarfs returned, they were heartbroken. They placed her in a glass coffin in the forest, hoping she would wake up one day.<br><br>

One day, a handsome prince rode through the forest and saw Snow White. He had heard stories of her kindness and beauty. He leaned down and kissed her gently.<br><br>

Suddenly, Snow White opened her eyes! The poison was broken! The dwarfs cheered with joy, and Snow White and the Prince rode away to the castle. They lived happily ever after.<br><br>

Kindness and goodness always win in the end.<br><br>

The End.', 'story_11.webp', 2);

INSERT INTO stories (id, title, content, image, category_id) VALUES
(12, 'Cinderella', 'Once upon a time, in a faraway kingdom, there lived a kind and beautiful girl named Cinderella. She lived with her wicked stepmother and two stepsisters, who were cruel to her. They made her do all the household chores and treated her like a servant. Despite this, Cinderella remained kind and hopeful.<br><br>

One day, the king announced a grand ball at the palace, where the prince would choose a bride. Cinderella''s stepsisters were excited and prepared lavish dresses, but her stepmother forbade Cinderella from going. Heartbroken, she watched them leave.<br><br>

As she cried, a fairy godmother appeared and transformed her into a stunning princess. She gave Cinderella a beautiful gown, glass slippers, and a magical carriage made from a pumpkin. However, the magic would wear off at midnight. Cinderella hurried to the ball.<br><br>

At the palace, she captivated the prince, and they danced all night. But when the clock struck midnight, Cinderella ran away, losing one glass slipper on the staircase.<br><br>

The next day, the prince searched the kingdom for the girl who fit the slipper. When he arrived at Cinderella’s house, her stepsisters tried to force their feet into the shoe, but it didn’t fit. Then, Cinderella tried it on—it was a perfect fit!<br><br>

The prince and Cinderella were married, and she lived happily ever after, free from her cruel family.<br><br>

The End.', 'story_12.webp', 2);

INSERT INTO stories (id, title, content, image, category_id) VALUES
(13, 'The Tale of Peter Rabbit', 'Once upon a time, there were four little rabbits named Flopsy, Mopsy, Cotton-tail, and Peter.<br>
They lived with their mother in a cozy burrow under the roots of a big fir tree.<br><br>

One morning, Mrs. Rabbit said, "You may go into the fields or down the lane, but don’t go into Mr. McGregor’s garden.<br>
Your father had an accident there, and I don’t want the same to happen to you."<br><br>

Flopsy, Mopsy, and Cotton-tail were good little bunnies. They went to gather blackberries.<br>
But Peter, who was a bit more adventurous, ran straight to Mr. McGregor’s garden.<br><br>

Peter squeezed under the gate and found himself in a paradise of vegetables—lettuces, radishes, and carrots.<br>
He nibbled happily until he came to some parsley. But as he was munching, he heard a loud shout:<br>
"Stop, thief!" It was Mr. McGregor!<br><br>

Terrified, Peter ran as fast as his little legs could carry him. He dashed through the garden,<br>
knocking over flower pots and leaving a trail of footprints.<br><br>

Peter tried to find his way back to the gate but got lost. He hid in a watering can to catch his breath,<br>
but Mr. McGregor was close behind. Peter scrambled out and leaped into a gooseberry bush, tearing his jacket on the thorns.<br><br>

At last, Peter found a way out—a small hole in the garden fence. He wriggled through just in time<br>
and ran all the way home, leaving his blue jacket and shoes behind.<br><br>

When Peter reached the burrow, he was so tired that he flopped down on the soft sand floor.<br>
His mother shook her head when she saw him. "Peter, where is your jacket and shoes?" she asked.<br><br>

That evening, while Flopsy, Mopsy, and Cotton-tail enjoyed bread and blackberries, Peter had to go to bed early<br>
with chamomile tea, which he didn’t like at all.<br><br>

Peter learned a lesson that day about listening to his mother and staying out of trouble—at least for a little while!<br><br>

The End.', 'story_13.webp', 3);

INSERT INTO stories (id, title, content, image, category_id) VALUES
(14, 'The Brave Little Squirrel', 'Once upon a time in a lush green forest, there lived a little squirrel named Sammy. Sammy was afraid of heights, unlike his friends who loved to climb the tallest trees.<br><br>

One day, a storm hit the forest, and a baby bird fell from its nest. Sammy knew he had to help. Summoning all his courage, he climbed the tallest tree and returned the baby bird to its nest.<br><br>

From that day on, Sammy learned that bravery comes in all sizes, and he was no longer afraid of heights.<br><br>

Moral: Courage can help you overcome your fears.', 'story_14.webp', 3);

INSERT INTO stories (id, title, content, image, category_id) VALUES
(15, 'Luna and the Starry Night', 'In a small village, a little girl named Luna loved to gaze at the stars.<br><br>

One night, she noticed a star that seemed to twinkle just for her. Curious, she made a wish to visit the star. To her surprise, a friendly moonbeam appeared and took her on a magical journey through the night sky.<br><br>

They danced among the stars and learned about the constellations. When Luna returned home, she realized that the stars were always there, shining brightly, just like her dreams.<br><br>

Moral: Always believe in your dreams, for they can take you on wonderful adventures.', 'story_15.webp', 3);

INSERT INTO stories (id, title, content, image, category_id) VALUES
(16, 'The Kindness of the Little Mouse', 'In a bustling meadow, a little mouse named Max found a lost butterfly named Bella. Bella was sad and couldn’t find her way home.<br><br>

Max decided to help her, even though he was small. Together, they asked the wise old owl for directions. With his help, they traveled through the meadow, and Max showed Bella the beauty of friendship.<br><br>

Finally, they found Bella’s home, and she thanked Max for his kindness. From that day on, they became the best of friends.<br><br>

Moral: Kindness can create lasting friendships.', 'story_16.webp', 3);

INSERT INTO stories (id, title, content, image, category_id) VALUES
(17, 'The Adventure of the Lost Treasure', 'A group of friends—Tommy the turtle, Bella the bunny, and Leo the lion—decided to go on an adventure to find a hidden treasure.<br><br>

They followed a map that led them through a dark cave, across a wobbly bridge, and up a steep hill.<br><br>

Along the way, they faced challenges but worked together to overcome them.<br><br>

When they finally found the treasure, it was a chest filled with friendship and memories.<br><br>

They realized that the real treasure was the adventure they shared.<br><br>

Moral: The journey and friendships we make are more valuable than material treasures.', 'story_17.webp', 3);

INSERT INTO stories (id, title, content, image, category_id) VALUES
(18, 'The Little Cloud Who Could', 'In the sky, there was a little cloud named Cumulus who wanted to be big and fluffy like the other clouds. He felt small and insignificant.<br><br>

One day, he saw a parched field below and decided to help. Cumulus gathered all his strength and rained down, nourishing the plants and flowers. The farmers rejoiced, and the field bloomed beautifully.<br><br>

Cumulus learned that it’s not about size but the impact you can make.<br><br>

Moral: Everyone has the power to make a difference, no matter how small they may feel.', 'story_18.webp', 3);

INSERT INTO keywords (id, keyword) VALUES 
(1, 'violin'),(2, 'sunshine'),(3, 'snow'),(4, 'starving'),(5, 'future');

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

INSERT INTO keywords (id, keyword) VALUES 
(31, 'bottle'),(32, 'Cake'),(33, 'grandmother'),(34, 'corner'),(35, 'live');

INSERT INTO keywords (id, keyword) VALUES 
(36, 'palace'),(37, 'princess'),(38, 'kingdom'),(39, 'flowers'),(40, 'enchantment');

INSERT INTO keywords (id, keyword) VALUES 
(41, 'magic'),(42, 'beanstalk'),(43, 'mother'),(44, 'beanstalk'),(45, 'golden');

INSERT INTO keywords (id, keyword) VALUES 
(46, 'shepherd'),(47, 'arrived'),(48, 'wolf'),(49, 'villagers'),(50, 'lesson');

INSERT INTO keywords (id, keyword) VALUES 
(51, 'Queen'),(52, 'furious'),(53, 'hungry'),(54, 'woman'),(55, 'castle');

INSERT INTO keywords (id, keyword) VALUES 
(56, 'kingdom'),(57, 'servant'),(58, 'stunning'),(59, 'slippers'),(60, 'shoe');

INSERT INTO keywords (id, keyword) VALUES 
(61, 'time'),(62, 'rabbits'),(63, 'accident'),(64, 'carrots'),(65, 'blackberries');

INSERT INTO keywords (id, keyword) VALUES 
(66, 'squirrel'),(67, 'tallest'),(68, 'nest'),(69, 'bravery'),(70, 'heights');

INSERT INTO keywords (id, keyword) VALUES 
(71, 'stars'),(72, 'twinkle'),(73, 'night'),(74, 'constellations'),(75, 'shining');

INSERT INTO keywords (id, keyword) VALUES 
(76, 'mouse'),(77, 'butterfly'),(78, 'directions'),(79, 'home'),(80, 'became');

INSERT INTO keywords (id, keyword) VALUES 
(81, 'treasure'),(82, 'map'),(83, 'hill'),(84, 'memories'),(85, 'treasures');

INSERT INTO keywords (id, keyword) VALUES 
(86, 'cloud'),(87, 'small'),(88, 'below'),(89, 'plants'),(90, 'impact');

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

INSERT INTO story_keywords (story_id, keyword_id) VALUES
(7, 31),  -- Relationship between story 7 and keyword 1
(7, 32),  -- Relationship between story 7 and keyword 2
(7, 33),  -- Relationship between story 7 and keyword 3
(7, 34),  -- Relationship between story 7 and keyword 4
(7, 35);  -- Relationship between story 7 and keyword 5

INSERT INTO story_keywords (story_id, keyword_id) VALUES
(8, 36),  -- Relationship between story 8 and keyword 1
(8, 37),  -- Relationship between story 8 and keyword 2
(8, 38),  -- Relationship between story 8 and keyword 3
(8, 39),  -- Relationship between story 8 and keyword 4
(8, 40);  -- Relationship between story 8 and keyword 5

INSERT INTO story_keywords (story_id, keyword_id) VALUES
(9, 41),  -- Relationship between story 9 and keyword 1
(9, 42),  -- Relationship between story 9 and keyword 2
(9, 43),  -- Relationship between story 9 and keyword 3
(9, 44),  -- Relationship between story 9 and keyword 4
(9, 45);  -- Relationship between story 9 and keyword 5

INSERT INTO story_keywords (story_id, keyword_id) VALUES
(10, 46),  -- Relationship between story 10 and keyword 1
(10, 47),  -- Relationship between story 10 and keyword 2
(10, 48),  -- Relationship between story 10 and keyword 3
(10, 49),  -- Relationship between story 10 and keyword 4
(10, 50);  -- Relationship between story 10 and keyword 5

INSERT INTO story_keywords (story_id, keyword_id) VALUES
(11, 51),  -- Relationship between story 11 and keyword 1
(11, 52),  -- Relationship between story 11 and keyword 2
(11, 53),  -- Relationship between story 11 and keyword 3
(11, 54),  -- Relationship between story 11 and keyword 4
(11, 55);  -- Relationship between story 11 and keyword 5

INSERT INTO story_keywords (story_id, keyword_id) VALUES
(12, 56),  -- Relationship between story 12 and keyword 1
(12, 57),  -- Relationship between story 12 and keyword 2
(12, 58),  -- Relationship between story 12 and keyword 3
(12, 59),  -- Relationship between story 12 and keyword 4
(12, 60);  -- Relationship between story 12 and keyword 5

INSERT INTO story_keywords (story_id, keyword_id) VALUES
(13, 61),  -- Relationship between story 13 and keyword 1
(13, 62),  -- Relationship between story 13 and keyword 2
(13, 63),  -- Relationship between story 13 and keyword 3
(13, 64),  -- Relationship between story 13 and keyword 4
(13, 65);  -- Relationship between story 13 and keyword 5

INSERT INTO story_keywords (story_id, keyword_id) VALUES
(14, 66),  -- Relationship between story 14 and keyword 1
(14, 67),  -- Relationship between story 14 and keyword 2
(14, 68),  -- Relationship between story 14 and keyword 3
(14, 69),  -- Relationship between story 14 and keyword 4
(14, 70);  -- Relationship between story 14 and keyword 5

INSERT INTO story_keywords (story_id, keyword_id) VALUES
(15, 71),  -- Relationship between story 15 and keyword 1
(15, 72),  -- Relationship between story 15 and keyword 2
(15, 73),  -- Relationship between story 15 and keyword 3
(15, 74),  -- Relationship between story 15 and keyword 4
(15, 75);  -- Relationship between story 15 and keyword 5

INSERT INTO story_keywords (story_id, keyword_id) VALUES
(16, 76),  -- Relationship between story 16 and keyword 1
(16, 77),  -- Relationship between story 16 and keyword 2
(16, 78),  -- Relationship between story 16 and keyword 3
(16, 79),  -- Relationship between story 16 and keyword 4
(16, 80);  -- Relationship between story 16 and keyword 5

INSERT INTO story_keywords (story_id, keyword_id) VALUES
(17, 81),  -- Relationship between story 17 and keyword 1
(17, 82),  -- Relationship between story 17 and keyword 2
(17, 83),  -- Relationship between story 17 and keyword 3
(17, 84),  -- Relationship between story 17 and keyword 4
(17, 85);  -- Relationship between story 17 and keyword 5

INSERT INTO story_keywords (story_id, keyword_id) VALUES
(18, 86),  -- Relationship between story 18 and keyword 1
(18, 87),  -- Relationship between story 18 and keyword 2
(18, 88),  -- Relationship between story 18 and keyword 3
(18, 89),  -- Relationship between story 18 and keyword 4
(18, 90);  -- Relationship between story 18 and keyword 5
