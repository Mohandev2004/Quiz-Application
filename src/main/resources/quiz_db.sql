CREATE DATABASE IF NOT EXISTS quiz_db;
USE quiz_db;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question TEXT NOT NULL,
    option1 VARCHAR(255) NOT NULL,
    option2 VARCHAR(255) NOT NULL,
    option3 VARCHAR(255) NOT NULL,
    option4 VARCHAR(255) NOT NULL,
    correct_answer VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    score INT NOT NULL,
    total_questions INT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT IGNORE INTO users (username, password) VALUES ('admin', 'admin123');

INSERT INTO questions (question, option1, option2, option3, option4, correct_answer) VALUES 
('What is the default value of a boolean variable in Java?', 'true', 'false', '0', 'null', 'false'),
('Which of the following is not a Java features?', 'Dynamic', 'Architecture Neutral', 'Use of pointers', 'Object-oriented', 'Use of pointers'),
('What is the size of an int variable in Java?', '8 bit', '16 bit', '32 bit', '64 bit', '32 bit'),
('Which keyword is used to prevent a variable from being modified?', 'final', 'static', 'const', 'immutable', 'final'),
('Which method is the entry point for any Java program?', 'main', 'start', 'init', 'run', 'main');
