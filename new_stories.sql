INSERT INTO stories (title, content) VALUES
('The Shepherd and the Wolf', 'Once upon a time, there was a young shepherd boy tending a farmer’s sheep on a hill near a village. Around the hill were fields and woods, and the sheep grazed peacefully in the sunshine.
The boy often found it boring to watch the sheep eat and doze all day. So he thought of a prank to bring a little excitement into his day.
One day he got up, ran down to the village and shouted as loud as he could: “Wolf! Wolf! A wolf is attacking the sheep!” 
The villagers heard his cries and rushed up the hill armed with sticks and stones to save the sheep.
When they arrived, they saw that there was no wolf there at all. The boy laughed and said, “It was just a joke! Look how quickly you all came!”
The villagers were not amused. They scolded the boy and went back to the village.
A few days later, the boy repeated his prank. He ran into the village again and shouted: “Wolf! Wolf! The wolf is back!” Again the villagers came to help, and again they found no wolf.
The boy laughed even louder than last time and the villagers were even angrier. They warned him that lying could have dire consequences.
Then, one day, a big, hungry wolf crept up to the sheep and the boy saw him. Terrified, he ran into the village and shouted: “Wolf! Wolf! Please help! This time it really is a wolf!”
But this time the villagers didn’t take him seriously. They thought it was just another one of his jokes and they ignored him. The wolf seized the opportunity, attacked the sheep and caused great mischief.
When the boy saw what had happened, he felt very sad and alone. He realized that his lies had serious consequences.');

INSERT INTO stories (title, content) VALUES
('The Goose That Laid The Golden Eggs', 'A farmer lived with eight cows and four geese on a small farm on the outskirts of town.
Every morning, the farmer had the same routine. First, he went into the cowshed to milk the cows. 
Once he had placed the large milking bucket under the first cow, he would begin to milk gently. After a few practiced moves, the bucket would be filled. He would repeat this for each cow and they would thank him with a loud “mooooo”.
Next, he went into the goose shed to collect their eggs. He carefully placed them one by one in a small basket and patted the geese lovingly.
Every Wednesday and Saturday, the farmer took the milk and eggs to the small market square in the center of town where many farmers offered their goods for sale.
The farmer led a happy life. He had everything he needed.
One morning when he went into the goose house with his little basket to collect the eggs, he was startled to find a very different looking egg. 
It flashed in the nest of the largest and most magnificent goose. It was not white and dull like the other eggs, but radiant gold. 
The farmer euphorically grabbed the golden egg and ran to his living room where he examined it in detail. The entire egg was made of pure gold.
Overjoyed, the farmer took the egg to the marketplace and presented it to the local jewelry dealer. 
“You’ve found a particularly valuable treasure,” said the merchant. “I’ll pay you a good price if you sell me this egg!” 
The farmer agreed and returned to his farm with his pockets full of money.
The next morning, he could hardly believe his luck when another golden egg lay in the nest of the largest and most magnificent goose. Again, he sold it for a small fortune in the town’s marketplace.
This went on, day after day, and the farmer quickly became a wealthy man. But it wasn’t long until the farmer became impatient. He wondered why the goose couldn’t lay two or three golden eggs a day. That would make him richer much faster. 
Then, he had a thought. “If the big, beautiful goose lays a golden egg every morning, she must be made entirely of pure gold herself. Why should I wait for a small golden egg each day when I have a big goose made of pure gold?” 
The farmer rushed into the goose house and slaughtered the large, magnificent goose. But what he saw shook him to the core. The goose was not made of pure gold, but of ordinary goose meat, just like any other. 
In no time at all, the farmer had lost both his large, magnificent goose and a golden egg every morning.');

SELECT * FROM stories;
SET @row_number = 0;
-- Crear una copia de la tabla original
SELECT * FROM stories WHERE id > 4 ORDER BY id;

-- Seleccionar los registros que se eliminarán
DELETE FROM stories
WHERE id =5;

SELECT 
    s.id AS story_id,
    s.title,
    s.content,
    GROUP_CONCAT(k.keyword SEPARATOR ', ') AS keywords
FROM 
    stories s
LEFT JOIN 
    story_keywords sk ON s.id = sk.story_id
LEFT JOIN 
    keywords k ON sk.keyword_id = k.id
WHERE 
    s.id = 3
GROUP BY 
    s.id, s.title, s.content;




