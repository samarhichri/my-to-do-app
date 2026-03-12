-- =========================================
-- Database: todo_app
-- =========================================

CREATE DATABASE IF NOT EXISTS todo_app CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE todo_app;

-- =========================================
-- Users Table
-- =========================================
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =========================================
-- Tasks Table
-- =========================================
CREATE TABLE IF NOT EXISTS tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    status ENUM('pending', 'done') DEFAULT 'pending',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_status (status)
) ENGINE=InnoDB;

-- =========================================
-- Sample Data
-- =========================================
INSERT INTO users (username, email, password_hash) VALUES
('alice', 'alice@mail.com', 'hashed_password'),
('bob', 'bob@mail.com', 'hashed_password');

INSERT INTO tasks (user_id, title, description, status) VALUES
(1, 'Buy milk', 'Go to supermarket to buy milk', 'pending'),
(2, 'Finish report', 'Complete project report', 'done');