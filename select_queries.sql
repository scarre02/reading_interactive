
-- Para confirmar tanto las historias como las palabras clave, puedes hacer una consulta combinada:
SELECT 
    s.id AS story_id, 
    s.title, 
    k.keyword
FROM 
    stories s
LEFT JOIN 
    story_keywords sk ON s.id = sk.story_id
LEFT JOIN 
    keywords k ON sk.keyword_id = k.id
WHERE 
    s.id = 4;

-- Asegúrate de que hay relaciones en la tabla story_keywords para el story_id = 1
SELECT * FROM story_keywords WHERE story_id = 4;

-- Verificar la fila de la historia con el id correcto
SELECT id, title, content FROM stories WHERE id = 1;

SELECT 
    k.id AS keyword_id,
    k.keyword
FROM 
    story_keywords sk
JOIN 
    keywords k 
ON 
    sk.keyword_id = k.id
WHERE 
    sk.story_id = 1;
    
DELETE FROM story_keywords
WHERE story_id = 2;

-- con esto me dice el story_id y el story_keywords
SELECT * FROM story_keywords WHERE story_id = 4;

-- Consulta para obtener los textos de las keywords
SELECT 
    sk.story_id,
    k.keyword
FROM 
    story_keywords sk
JOIN 
    keywords k 
ON 
    sk.keyword_id = k.id
WHERE 
    sk.story_id = 4;
    


SELECT id, keyword FROM keywords 
WHERE keyword IN ('time', 'rabbits', 'accident', 'carrots', 'blackberries');
SELECT id, keyword FROM keywords 
WHERE keyword IN ('lion','storm','courage','animals','heart');
-- Obtener los IDs recién insertados
SELECT id FROM keywords WHERE keyword IN ('time', 'rabbits', 'accident', 'carrots', 'blackberries');



-- Supongamos que los IDs son 1, 2, 3, 4, 5

-- Para reiniciar el contador autoincrement desde 1
ALTER TABLE keywords AUTO_INCREMENT = 1;


-- Obtener los IDs recién insertados
SELECT id FROM keywords WHERE keyword IN ('lion', 'storm', 'courage', 'animals', 'heart');

-- Supongamos que los IDs son 6, 7, 8, 9, 10

-- Asociar estas palabras clave con story_id 2
INSERT INTO story_keywords (story_id, keyword_id) VALUES
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10);

-- Para recuperar las palabras clave asociadas a un story_id específico (por ejemplo, story_id = 1)
SELECT k.keyword
FROM keywords k
JOIN story_keywords sk ON k.id = sk.keyword_id
WHERE sk.story_id = 2;

SELECT id, keyword FROM keywords WHERE keyword IN ('time','rabbits','accident','carrots','blackberries');

SELECT 
    sk.story_id, 
    k.keyword
FROM 
    story_keywords sk
JOIN 
    keywords k 
ON 
    sk.keyword_id = k.id
WHERE 
    sk.story_id = 1;
    
DELETE FROM story_keywords
WHERE keyword_id = 1;

SELECT id FROM keywords;

SELECT id, keyword FROM keywords WHERE keyword IN ('savannah','courage','thunder','kindness','braverys');

DELETE FROM keywords;

SELECT id FROM stories WHERE title = 'The Tale of Peter Rabbit';
SELECT id, title FROM stories;
SELECT * FROM keywords;
SELECT * FROM story_keywords WHERE story_id =1;

SELECT id FROM stories WHERE title = 'The Brave Lion';
SELECT * FROM story_keywords WHERE story_id =2;

SELECT * FROM stories
WHERE content LIKE '%La tortuga ganó la carrera con paciencia y determinación%';
SELECT * FROM stories
WHERE content = 'La tortuga ganó la carrera con paciencia y determinación';
DELETE FROM stories WHERE id = 3;





SELECT * FROM stories WHERE id = 1;

DELETE FROM stories WHERE id = 1;
DELETE FROM story_keywords WHERE story_id = 1;


SELECT * FROM stories WHERE id = 1;
SELECT id, title, content FROM stories WHERE id = 1;

SELECT id, title, content 
FROM stories;

-- checkamos
SELECT * FROM story_keywords WHERE story_id =6;
-- ver cuantos id en keywords van quedando
SELECT * FROM keywords;
-- borrarlos
DELETE FROM keywords
WHERE id BETWEEN 30 AND 36;


DELETE FROM story_keywords
WHERE story_id = 6
  AND keyword_id IN (
    SELECT id FROM keywords 
    WHERE keyword IN ('time', 'rabbits', 'accident', 'carrots', 'blackberries')
  );

SELECT id 
FROM keywords 
WHERE keyword IN ('jungle','king','courage','promise','friends');

    
-- Para recuperar las palabras clave asociadas a un story_id específico (por ejemplo, story_id = 1)
SELECT k.keyword
FROM keywords k
JOIN story_keywords sk ON k.id = sk.keyword_id
WHERE sk.story_id = 6;

SELECT * FROM stories WHERE title = 'The Lion and the Mouse';
SELECT id, keyword 
FROM keywords 
WHERE keyword IN ('time', 'rabbits', 'accident', 'carrots', 'backberries');

DELETE FROM story_keywords
WHERE story_id = 3 AND keyword_id = 5;

SELECT * FROM story_keywords;
SELECT * FROM keywords;
