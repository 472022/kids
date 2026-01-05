-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 31, 2025 at 09:38 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kids_learning`
--

-- --------------------------------------------------------

--
-- Table structure for table `achievements`
--

CREATE TABLE `achievements` (
  `achievement_id` int(11) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `badge_icon` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `achievements`
--

INSERT INTO `achievements` (`achievement_id`, `title`, `description`, `badge_icon`, `created_at`) VALUES
(1, 'First Lesson', 'Complete your first lesson.', '????', '2025-12-31 08:15:38'),
(2, 'First Game', 'Play your first game.', '????', '2025-12-31 08:15:38'),
(3, 'First Quiz', 'Complete your first quiz.', '❓', '2025-12-31 08:15:38'),
(4, 'Star Collector', 'Earn 50 stars.', '⭐', '2025-12-31 08:15:38'),
(5, 'Level Up!', 'Reach Level 2.', '????', '2025-12-31 08:15:38'),
(6, 'Super Scholar', 'Complete 5 lessons.', '????', '2025-12-31 08:15:38'),
(7, 'Game Master', 'Play 5 different games.', '????️', '2025-12-31 08:15:38'),
(8, 'Quiz Whiz', 'Score 10/10 on a quiz.', '????', '2025-12-31 08:15:38');

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `log_id` int(11) NOT NULL,
  `child_id` int(11) DEFAULT NULL,
  `activity_type` varchar(100) DEFAULT NULL,
  `activity_details` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`log_id`, `child_id`, `activity_type`, `activity_details`, `created_at`) VALUES
(1, 1, 'lesson', 'Completed lesson: basic english', '2025-12-31 08:18:15'),
(2, 1, 'quiz', 'Completed quiz with score 1/10', '2025-12-31 08:34:10');

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `admin_id` int(11) NOT NULL,
  `admin_name` varchar(100) NOT NULL,
  `admin_email` varchar(100) NOT NULL,
  `admin_password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`admin_id`, `admin_name`, `admin_email`, `admin_password`, `created_at`) VALUES
(1, 'Admin', 'admin@kids.com', '12345678', '2025-12-31 07:21:25');

-- --------------------------------------------------------

--
-- Table structure for table `children`
--

CREATE TABLE `children` (
  `child_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `child_name` varchar(100) NOT NULL,
  `child_age` int(11) NOT NULL,
  `child_password` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `level` int(11) DEFAULT 1,
  `total_stars` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `children`
--

INSERT INTO `children` (`child_id`, `parent_id`, `child_name`, `child_age`, `child_password`, `avatar`, `level`, `total_stars`, `created_at`) VALUES
(1, 1, 'prathamesh', 12, '1234', NULL, 1, 15, '2025-12-31 07:48:07');

-- --------------------------------------------------------

--
-- Table structure for table `child_achievements`
--

CREATE TABLE `child_achievements` (
  `id` int(11) NOT NULL,
  `child_id` int(11) NOT NULL,
  `achievement_id` int(11) NOT NULL,
  `earned_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `child_achievements`
--

INSERT INTO `child_achievements` (`id`, `child_id`, `achievement_id`, `earned_at`) VALUES
(1, 1, 1, '2025-12-31 08:18:15'),
(2, 1, 3, '2025-12-31 08:34:10');

-- --------------------------------------------------------

--
-- Table structure for table `drawings`
--

CREATE TABLE `drawings` (
  `drawing_id` int(11) NOT NULL,
  `child_id` int(11) NOT NULL,
  `drawing_image` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `games`
--

CREATE TABLE `games` (
  `game_id` int(11) NOT NULL,
  `game_name` varchar(100) NOT NULL,
  `game_type` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `learning_outcome` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `games`
--

INSERT INTO `games` (`game_id`, `game_name`, `game_type`, `description`, `learning_outcome`, `created_at`, `notes`) VALUES
(1, 'Alphabet Adventure', 'Language', 'Match letters to objects! Learn your ABCs.', 'Alphabet recognition, Phonics', '2025-12-31 08:08:19', 'alphabet.js'),
(2, 'Number Jump', 'Math', 'Jump on the correct numbers!', 'Counting, Number sequencing', '2025-12-31 08:08:19', 'number_jump.js'),
(3, 'Shape Builder', 'Logic', 'Drag shapes to build objects.', 'Shape recognition, Logic', '2025-12-31 08:08:19', 'shape_builder.js'),
(4, 'Math Hero', 'Math', 'Defeat enemies with math power!', 'Addition, Subtraction', '2025-12-31 08:08:19', 'math_hero.js'),
(5, 'Memory Flip', 'Memory', 'Find the matching pairs.', 'Memory, Concentration', '2025-12-31 08:08:19', 'memory_flip.js');

-- --------------------------------------------------------

--
-- Table structure for table `game_progress`
--

CREATE TABLE `game_progress` (
  `game_progress_id` int(11) NOT NULL,
  `child_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `score` int(11) DEFAULT 0,
  `stars_earned` int(11) DEFAULT 0,
  `level_completed` int(11) DEFAULT 1,
  `last_played` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lessons`
--

CREATE TABLE `lessons` (
  `lesson_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `lesson_title` varchar(200) NOT NULL,
  `lesson_description` text DEFAULT NULL,
  `video_url` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lessons`
--

INSERT INTO `lessons` (`lesson_id`, `subject_id`, `lesson_title`, `lesson_description`, `video_url`, `created_at`) VALUES
(1, 1, 'basic english', 'basic english lesson for children', 'https://www.youtube.com/watch?v=iUShfR6MqaE&pp=ygUxbWFnaWNhaSBpbnN0YWxsYXRpb24gaG93IHRvIGJ5cGFzcyBsaXF1aWQgbGljZW5jZQ%3D%3D', '2025-12-31 08:05:39');

-- --------------------------------------------------------

--
-- Table structure for table `lesson_progress`
--

CREATE TABLE `lesson_progress` (
  `progress_id` int(11) NOT NULL,
  `child_id` int(11) NOT NULL,
  `lesson_id` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `completed_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lesson_progress`
--

INSERT INTO `lesson_progress` (`progress_id`, `child_id`, `lesson_id`, `is_completed`, `completed_at`) VALUES
(1, 1, 1, 1, '2025-12-31 08:18:15');

-- --------------------------------------------------------

--
-- Table structure for table `parents`
--

CREATE TABLE `parents` (
  `parent_id` int(11) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_email` varchar(100) NOT NULL,
  `parent_phone` varchar(15) NOT NULL,
  `parent_password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `parents`
--

INSERT INTO `parents` (`parent_id`, `parent_name`, `parent_email`, `parent_phone`, `parent_password`, `created_at`) VALUES
(1, 'yogesh halale', 'ykhalale@gmail.com', '9421145418', '1234', '2025-12-31 07:48:07');

-- --------------------------------------------------------

--
-- Table structure for table `quizzes`
--

CREATE TABLE `quizzes` (
  `quiz_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `quiz_title` varchar(200) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quizzes`
--

INSERT INTO `quizzes` (`quiz_id`, `subject_id`, `quiz_title`, `created_at`) VALUES
(1, 1, 'fasd', '2025-12-31 08:33:24');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_questions`
--

CREATE TABLE `quiz_questions` (
  `question_id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `question` text NOT NULL,
  `option_a` varchar(255) DEFAULT NULL,
  `option_b` varchar(255) DEFAULT NULL,
  `option_c` varchar(255) DEFAULT NULL,
  `option_d` varchar(255) DEFAULT NULL,
  `correct_option` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quiz_questions`
--

INSERT INTO `quiz_questions` (`question_id`, `quiz_id`, `question`, `option_a`, `option_b`, `option_c`, `option_d`, `correct_option`) VALUES
(1, 1, 'asfd', 'asd', 'fd', 'df', 'df', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_results`
--

CREATE TABLE `quiz_results` (
  `result_id` int(11) NOT NULL,
  `child_id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `score` int(11) DEFAULT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `attempted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quiz_results`
--

INSERT INTO `quiz_results` (`result_id`, `child_id`, `quiz_id`, `score`, `is_completed`, `attempted_at`) VALUES
(1, 1, 1, 1, 1, '2025-12-31 08:34:10');

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `subject_id` int(11) NOT NULL,
  `subject_name` varchar(100) NOT NULL,
  `subject_icon` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`subject_id`, `subject_name`, `subject_icon`, `created_at`) VALUES
(1, 'english', 'assets/images/subjects/1767168295_gpay.png', '2025-12-31 08:04:55');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `achievements`
--
ALTER TABLE `achievements`
  ADD PRIMARY KEY (`achievement_id`);

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `child_id` (`child_id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `admin_email` (`admin_email`);

--
-- Indexes for table `children`
--
ALTER TABLE `children`
  ADD PRIMARY KEY (`child_id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `child_achievements`
--
ALTER TABLE `child_achievements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `child_id` (`child_id`),
  ADD KEY `achievement_id` (`achievement_id`);

--
-- Indexes for table `drawings`
--
ALTER TABLE `drawings`
  ADD PRIMARY KEY (`drawing_id`),
  ADD KEY `child_id` (`child_id`);

--
-- Indexes for table `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`game_id`);

--
-- Indexes for table `game_progress`
--
ALTER TABLE `game_progress`
  ADD PRIMARY KEY (`game_progress_id`),
  ADD KEY `child_id` (`child_id`),
  ADD KEY `game_id` (`game_id`);

--
-- Indexes for table `lessons`
--
ALTER TABLE `lessons`
  ADD PRIMARY KEY (`lesson_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `lesson_progress`
--
ALTER TABLE `lesson_progress`
  ADD PRIMARY KEY (`progress_id`),
  ADD UNIQUE KEY `child_id` (`child_id`,`lesson_id`),
  ADD KEY `lesson_id` (`lesson_id`);

--
-- Indexes for table `parents`
--
ALTER TABLE `parents`
  ADD PRIMARY KEY (`parent_id`),
  ADD UNIQUE KEY `parent_email` (`parent_email`);

--
-- Indexes for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`quiz_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  ADD PRIMARY KEY (`question_id`),
  ADD KEY `quiz_id` (`quiz_id`);

--
-- Indexes for table `quiz_results`
--
ALTER TABLE `quiz_results`
  ADD PRIMARY KEY (`result_id`),
  ADD KEY `child_id` (`child_id`),
  ADD KEY `quiz_id` (`quiz_id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`subject_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `achievements`
--
ALTER TABLE `achievements`
  MODIFY `achievement_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `children`
--
ALTER TABLE `children`
  MODIFY `child_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `child_achievements`
--
ALTER TABLE `child_achievements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `drawings`
--
ALTER TABLE `drawings`
  MODIFY `drawing_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `games`
--
ALTER TABLE `games`
  MODIFY `game_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `game_progress`
--
ALTER TABLE `game_progress`
  MODIFY `game_progress_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lessons`
--
ALTER TABLE `lessons`
  MODIFY `lesson_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `lesson_progress`
--
ALTER TABLE `lesson_progress`
  MODIFY `progress_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `parents`
--
ALTER TABLE `parents`
  MODIFY `parent_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `quiz_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `quiz_results`
--
ALTER TABLE `quiz_results`
  MODIFY `result_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `subject_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `children` (`child_id`) ON DELETE CASCADE;

--
-- Constraints for table `children`
--
ALTER TABLE `children`
  ADD CONSTRAINT `children_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `parents` (`parent_id`) ON DELETE CASCADE;

--
-- Constraints for table `child_achievements`
--
ALTER TABLE `child_achievements`
  ADD CONSTRAINT `child_achievements_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `children` (`child_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `child_achievements_ibfk_2` FOREIGN KEY (`achievement_id`) REFERENCES `achievements` (`achievement_id`) ON DELETE CASCADE;

--
-- Constraints for table `drawings`
--
ALTER TABLE `drawings`
  ADD CONSTRAINT `drawings_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `children` (`child_id`) ON DELETE CASCADE;

--
-- Constraints for table `game_progress`
--
ALTER TABLE `game_progress`
  ADD CONSTRAINT `game_progress_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `children` (`child_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `game_progress_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `games` (`game_id`) ON DELETE CASCADE;

--
-- Constraints for table `lessons`
--
ALTER TABLE `lessons`
  ADD CONSTRAINT `lessons_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`) ON DELETE CASCADE;

--
-- Constraints for table `lesson_progress`
--
ALTER TABLE `lesson_progress`
  ADD CONSTRAINT `lesson_progress_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `children` (`child_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `lesson_progress_ibfk_2` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`lesson_id`) ON DELETE CASCADE;

--
-- Constraints for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD CONSTRAINT `quizzes_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`) ON DELETE CASCADE;

--
-- Constraints for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  ADD CONSTRAINT `quiz_questions_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`quiz_id`) ON DELETE CASCADE;

--
-- Constraints for table `quiz_results`
--
ALTER TABLE `quiz_results`
  ADD CONSTRAINT `quiz_results_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `children` (`child_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quiz_results_ibfk_2` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`quiz_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
