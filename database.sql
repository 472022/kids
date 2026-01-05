CREATE DATABASE IF NOT EXISTS kids_learning;
USE kids_learning;

-- Admins Table
CREATE TABLE IF NOT EXISTS admins (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    admin_name VARCHAR(100) NOT NULL,
    admin_email VARCHAR(100) UNIQUE NOT NULL,
    admin_password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Parents Table
CREATE TABLE IF NOT EXISTS parents (
    parent_id INT AUTO_INCREMENT PRIMARY KEY,
    parent_name VARCHAR(100) NOT NULL,
    parent_email VARCHAR(100) UNIQUE NOT NULL,
    parent_phone VARCHAR(15) NOT NULL,
    parent_password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Children Table
CREATE TABLE IF NOT EXISTS children (
    child_id INT AUTO_INCREMENT PRIMARY KEY,
    parent_id INT NOT NULL,
    child_name VARCHAR(100) NOT NULL,
    child_age INT NOT NULL,
    child_password VARCHAR(255) NOT NULL,
    avatar VARCHAR(255),
    level INT DEFAULT 1,
    total_stars INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_id) REFERENCES parents(parent_id) ON DELETE CASCADE
);

-- Subjects Table
CREATE TABLE IF NOT EXISTS subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    subject_icon VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Lessons Table
CREATE TABLE IF NOT EXISTS lessons (
    lesson_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_id INT NOT NULL,
    lesson_title VARCHAR(200) NOT NULL,
    lesson_description TEXT,
    video_url TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id) ON DELETE CASCADE
);

-- Lesson Progress
CREATE TABLE IF NOT EXISTS lesson_progress (
    progress_id INT AUTO_INCREMENT PRIMARY KEY,
    child_id INT NOT NULL,
    lesson_id INT NOT NULL,
    is_completed BOOLEAN DEFAULT FALSE,
    completed_at TIMESTAMP NULL,
    FOREIGN KEY (child_id) REFERENCES children(child_id) ON DELETE CASCADE,
    FOREIGN KEY (lesson_id) REFERENCES lessons(lesson_id) ON DELETE CASCADE,
    UNIQUE (child_id, lesson_id)
);

-- Games Table
CREATE TABLE IF NOT EXISTS games (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    game_name VARCHAR(100) NOT NULL,
    game_type VARCHAR(100),
    description TEXT,
    learning_outcome TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Game Progress
CREATE TABLE IF NOT EXISTS game_progress (
    game_progress_id INT AUTO_INCREMENT PRIMARY KEY,
    child_id INT NOT NULL,
    game_id INT NOT NULL,
    score INT DEFAULT 0,
    stars_earned INT DEFAULT 0,
    level_completed INT DEFAULT 1,
    last_played TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (child_id) REFERENCES children(child_id) ON DELETE CASCADE,
    FOREIGN KEY (game_id) REFERENCES games(game_id) ON DELETE CASCADE
);

-- Quizzes Table
CREATE TABLE IF NOT EXISTS quizzes (
    quiz_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_id INT NOT NULL,
    quiz_title VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id) ON DELETE CASCADE
);

-- Quiz Questions
CREATE TABLE IF NOT EXISTS quiz_questions (
    question_id INT AUTO_INCREMENT PRIMARY KEY,
    quiz_id INT NOT NULL,
    question TEXT NOT NULL,
    option_a VARCHAR(255),
    option_b VARCHAR(255),
    option_c VARCHAR(255),
    option_d VARCHAR(255),
    correct_option CHAR(1),
    FOREIGN KEY (quiz_id) REFERENCES quizzes(quiz_id) ON DELETE CASCADE
);

-- Quiz Results
CREATE TABLE IF NOT EXISTS quiz_results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    child_id INT NOT NULL,
    quiz_id INT NOT NULL,
    score INT,
    is_completed BOOLEAN DEFAULT FALSE,
    attempted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (child_id) REFERENCES children(child_id) ON DELETE CASCADE,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(quiz_id) ON DELETE CASCADE
);

-- Achievements
CREATE TABLE IF NOT EXISTS achievements (
    achievement_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    description TEXT,
    badge_icon VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Child Achievements
CREATE TABLE IF NOT EXISTS child_achievements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    child_id INT NOT NULL,
    achievement_id INT NOT NULL,
    earned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (child_id) REFERENCES children(child_id) ON DELETE CASCADE,
    FOREIGN KEY (achievement_id) REFERENCES achievements(achievement_id) ON DELETE CASCADE
);

-- Drawings
CREATE TABLE IF NOT EXISTS drawings (
    drawing_id INT AUTO_INCREMENT PRIMARY KEY,
    child_id INT NOT NULL,
    drawing_image TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (child_id) REFERENCES children(child_id) ON DELETE CASCADE
);

-- Activity Logs
CREATE TABLE IF NOT EXISTS activity_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    child_id INT,
    activity_type VARCHAR(100),
    activity_details TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (child_id) REFERENCES children(child_id) ON DELETE CASCADE
);

-- Sample Admin Insert
-- Password is 'admin123' (plain text)
INSERT INTO admins (admin_name, admin_email, admin_password) 
VALUES ('Admin', 'admin@kids.com', 'admin123');
