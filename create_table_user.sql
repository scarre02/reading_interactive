CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    dob DATE NOT NULL,
    terms_accepted BOOLEAN NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    CONSTRAINT_NAME, 
    REFERENCED_TABLE_NAME, 
    REFERENCED_COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    REFERENCED_TABLE_NAME = 'users';

DESCRIBE users;

-- aGREGAR UN NUEVO usuario
INSERT INTO users (name, email, dob, terms_accepted) 
VALUES ('Juan Pérez', 'juan@example.com', '1990-05-15', TRUE);

-- seleccionar ese usuario
SELECT id_user, name, email, dob, terms_accepted, registration_date FROM users;

SELECT * FROM users;
SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    CONSTRAINT_NAME, 
    REFERENCED_TABLE_NAME, 
    REFERENCED_COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    REFERENCED_TABLE_NAME = 'users';

SHOW DATABASES;
SHOW TABLES;
DESCRIBE users;







