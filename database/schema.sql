-- =========================================
-- Database: todo_app
-- =========================================

CREATE DATABASE IF NOT EXISTS todo_app
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE todo_app;


-- =========================================
-- Users Table
-- =========================================

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
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
    status ENUM('pending', 'done') NOT NULL DEFAULT 'pending',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_tasks_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    INDEX idx_tasks_user_id (user_id),
    INDEX idx_tasks_status (status)
) ENGINE=InnoDB;


-- =========================================
-- Sample Users
-- =========================================

INSERT INTO users (username, email)
VALUES
    ('alice', 'alice@mail.com'),
    ('bob', 'bob@mail.com')
ON DUPLICATE KEY UPDATE
    username = VALUES(username);


-- =========================================
-- Sample Tasks
-- =========================================

INSERT INTO tasks (user_id, title, description, status)
SELECT
    u.id,
    'Buy milk',
    'Go to supermarket to buy milk',
    'pending'
FROM users u
WHERE u.username = 'alice'
  AND NOT EXISTS (
      SELECT 1
      FROM tasks t
      WHERE t.user_id = u.id
        AND t.title = 'Buy milk'
  );


INSERT INTO tasks (user_id, title, description, status)
SELECT
    u.id,
    'Finish report',
    'Complete project report',
    'done'
FROM users u
WHERE u.username = 'bob'
  AND NOT EXISTS (
      SELECT 1
      FROM tasks t
      WHERE t.user_id = u.id
        AND t.title = 'Finish report'
  );
