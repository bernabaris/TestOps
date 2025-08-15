CREATE DATABASE IF NOT EXISTS testdb;

USE testdb;

CREATE TABLE IF NOT EXISTS users (
                                     id INT PRIMARY KEY AUTO_INCREMENT,
                                     username VARCHAR(50),
    email VARCHAR(100)
    );

INSERT INTO users (username, email) VALUES
                                        ('testuser1', 'test1@example.com'),
                                        ('testuser2', 'test2@example.com');
