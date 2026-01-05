-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 05, 2026 at 07:30 AM
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
-- Database: `ai_timetable_scheduler`
--
CREATE DATABASE IF NOT EXISTS `ai_timetable_scheduler` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `ai_timetable_scheduler`;

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `attendance_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `timetable_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `status` enum('Present','Absent','Leave','Cancelled') DEFAULT 'Present',
  `remarks` text DEFAULT NULL,
  `marked_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `table_affected` varchar(100) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `batches`
--

CREATE TABLE `batches` (
  `batch_id` int(11) NOT NULL,
  `batch_name` varchar(50) NOT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `batches`
--

INSERT INTO `batches` (`batch_id`, `batch_name`, `dept_id`, `year`) VALUES
(1, 'A1', 1, 2025);

-- --------------------------------------------------------

--
-- Table structure for table `batch_subjects`
--

CREATE TABLE `batch_subjects` (
  `bs_id` int(11) NOT NULL,
  `batch_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `weekly_sessions` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `batch_subjects`
--

INSERT INTO `batch_subjects` (`bs_id`, `batch_id`, `subject_id`, `weekly_sessions`) VALUES
(1, 1, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `chatbot_queries`
--

CREATE TABLE `chatbot_queries` (
  `query_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_query` text DEFAULT NULL,
  `ai_response` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chat_logs`
--

CREATE TABLE `chat_logs` (
  `chat_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `query_text` varchar(255) DEFAULT NULL,
  `intent` varchar(64) DEFAULT NULL,
  `results_count` int(11) DEFAULT NULL,
  `answered_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat_logs`
--

INSERT INTO `chat_logs` (`chat_id`, `user_id`, `query_text`, `intent`, `results_count`, `answered_at`) VALUES
(1, 1, 'hi', 'auto', 0, '2025-11-04 11:18:18'),
(2, 1, 'hi', 'auto', 0, '2025-11-20 08:55:25'),
(3, 1, 'hi', 'auto', 0, '2025-11-20 08:55:37'),
(4, 1, 'hi', 'auto', 0, '2025-11-20 08:55:37'),
(5, 1, 'hi', 'auto', 0, '2025-11-20 08:55:38'),
(6, 1, 'hi', 'auto', 0, '2025-11-20 08:55:38'),
(7, 1, 'hi', 'auto', 0, '2025-11-20 08:55:38');

-- --------------------------------------------------------

--
-- Table structure for table `classrooms`
--

CREATE TABLE `classrooms` (
  `room_id` int(11) NOT NULL,
  `room_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `classrooms`
--

INSERT INTO `classrooms` (`room_id`, `room_name`) VALUES
(1, 'CR1'),
(2, 'CR2');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `dept_id` int(11) NOT NULL,
  `dept_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`dept_id`, `dept_name`, `description`) VALUES
(1, 'CSE', 'Computer science and engineering');

-- --------------------------------------------------------

--
-- Table structure for table `login_logs`
--

CREATE TABLE `login_logs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `logged_in_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login_logs`
--

INSERT INTO `login_logs` (`log_id`, `user_id`, `logged_in_at`) VALUES
(1, 1, '2025-11-03 12:50:59'),
(2, 1, '2025-11-03 12:53:41'),
(3, 1, '2025-11-03 12:54:17'),
(4, 1, '2025-11-03 12:54:35'),
(5, 1, '2025-11-03 12:54:43'),
(6, 1, '2025-11-03 14:05:47'),
(7, 1, '2025-11-04 10:31:22'),
(8, 2, '2025-11-04 10:32:12'),
(9, 1, '2025-11-04 10:44:29'),
(10, 1, '2025-11-04 10:50:57'),
(11, 1, '2025-11-04 10:54:38'),
(12, 1, '2025-11-04 10:55:14'),
(13, 2, '2025-11-04 11:05:08'),
(14, 2, '2025-11-04 11:05:43'),
(15, 2, '2025-11-04 11:06:05'),
(16, 2, '2025-11-04 11:06:31'),
(17, 1, '2025-11-04 11:07:01'),
(18, 1, '2025-11-04 11:17:46'),
(19, 1, '2025-11-07 15:38:21'),
(20, 1, '2025-11-20 08:54:46'),
(21, 3, '2025-11-20 09:22:34'),
(22, 3, '2025-11-20 09:25:12'),
(23, 3, '2025-11-20 09:25:39'),
(24, 1, '2025-11-20 13:53:48');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `permission_id` int(11) NOT NULL,
  `permission_key` varchar(100) NOT NULL,
  `label` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`permission_id`, `permission_key`, `label`, `description`) VALUES
(1, 'edit_timetable', 'Edit Timetable', 'Can create/update/delete timetable entries'),
(2, 'manage_settings', 'Manage Settings', 'Can update system settings'),
(3, 'manage_roles', 'Manage Roles', 'Can manage roles and permissions'),
(4, 'manage_users', 'Manage Users', 'Can add/edit/delete users'),
(5, 'assign_subjects', 'Assign Subjects', 'Can assign subjects to teachers'),
(6, 'view_reports', 'View Reports', 'Can access reports');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `report_id` int(11) NOT NULL,
  `report_name` varchar(100) NOT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `report_type` enum('Attendance','Timetable','Performance','Other') DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `request_logs`
--

CREATE TABLE `request_logs` (
  `log_id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `actor_user_id` int(11) NOT NULL,
  `action` varchar(50) NOT NULL,
  `message` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`, `description`) VALUES
(1, 'admin', 'admin'),
(2, 'Teacher', 'Teaching Staff'),
(3, 'Student', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`role_id`, `permission_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6);

-- --------------------------------------------------------

--
-- Table structure for table `scenario_adjustments`
--

CREATE TABLE `scenario_adjustments` (
  `adj_id` int(11) NOT NULL,
  `scenario_id` int(11) NOT NULL,
  `timetable_id` int(11) NOT NULL,
  `original_slot_id` int(11) NOT NULL,
  `original_teacher_id` int(11) NOT NULL,
  `original_classroom` varchar(100) DEFAULT NULL,
  `proposed_slot_id` int(11) DEFAULT NULL,
  `proposed_teacher_id` int(11) DEFAULT NULL,
  `proposed_classroom` varchar(100) DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `scenario_changes`
--

CREATE TABLE `scenario_changes` (
  `change_id` int(11) NOT NULL,
  `timetable_id` int(11) NOT NULL,
  `old_teacher_id` int(11) DEFAULT NULL,
  `new_teacher_id` int(11) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `scenario_plans`
--

CREATE TABLE `scenario_plans` (
  `scenario_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` enum('teacher','batch') NOT NULL,
  `entity_id` int(11) NOT NULL,
  `affected_slots` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `search_logs`
--

CREATE TABLE `search_logs` (
  `search_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `search_query` varchar(255) DEFAULT NULL,
  `results_count` int(11) DEFAULT NULL,
  `searched_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `setting_id` int(11) NOT NULL,
  `setting_name` varchar(100) NOT NULL,
  `setting_value` varchar(255) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `subject_id` int(11) NOT NULL,
  `subject_name` varchar(100) NOT NULL,
  `subject_code` varchar(20) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `credit_hours` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`subject_id`, `subject_name`, `subject_code`, `dept_id`, `credit_hours`) VALUES
(1, 'Java', '252', 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `teacher_requests`
--

CREATE TABLE `teacher_requests` (
  `request_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `type` enum('Leave','Reschedule') NOT NULL,
  `timetable_id` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `new_date` date DEFAULT NULL,
  `new_slot_id` int(11) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `status` enum('Pending','Approved','Rejected','Modified') DEFAULT 'Pending',
  `resolution_notes` text DEFAULT NULL,
  `resolved_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teacher_subjects`
--

CREATE TABLE `teacher_subjects` (
  `ts_id` int(11) NOT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teacher_subjects`
--

INSERT INTO `teacher_subjects` (`ts_id`, `teacher_id`, `subject_id`) VALUES
(1, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `teacher_unavailability`
--

CREATE TABLE `teacher_unavailability` (
  `tu_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `slot_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `ticket_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `timetable_id` int(11) DEFAULT NULL,
  `type` enum('Leave','Reschedule') NOT NULL,
  `reason` text DEFAULT NULL,
  `status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `timetable`
--

CREATE TABLE `timetable` (
  `timetable_id` int(11) NOT NULL,
  `slot_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `batch_id` int(11) NOT NULL,
  `classroom` varchar(50) DEFAULT NULL,
  `generated_by_ai` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `timetable`
--

INSERT INTO `timetable` (`timetable_id`, `slot_id`, `subject_id`, `teacher_id`, `batch_id`, `classroom`, `generated_by_ai`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, 1, 'CR1', 1, '2025-11-07 15:48:20', '2025-11-07 15:48:20');

-- --------------------------------------------------------

--
-- Table structure for table `time_slots`
--

CREATE TABLE `time_slots` (
  `slot_id` int(11) NOT NULL,
  `day_of_week` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `time_slots`
--

INSERT INTO `time_slots` (`slot_id`, `day_of_week`, `start_time`, `end_time`) VALUES
(1, 'Monday', '10:00:00', '17:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `batch_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `username`, `password`, `role_id`, `is_active`, `created_at`, `batch_id`) VALUES
(1, 'admin', 'a@gmail.com', 'admin', '1234', 1, 1, '2025-11-03 12:50:51', NULL),
(2, 'Prathamesh Halale', 'p@gmail.com', 'p', '1234', 2, 1, '2025-11-04 10:32:00', NULL),
(3, 'PrathameshHalale', 'q@gmail.com', 'q', '1234', 3, 1, '2025-11-20 09:22:18', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`attendance_id`),
  ADD UNIQUE KEY `uq_att` (`teacher_id`,`timetable_id`,`date`),
  ADD KEY `timetable_id` (`timetable_id`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `batches`
--
ALTER TABLE `batches`
  ADD PRIMARY KEY (`batch_id`),
  ADD KEY `dept_id` (`dept_id`);

--
-- Indexes for table `batch_subjects`
--
ALTER TABLE `batch_subjects`
  ADD PRIMARY KEY (`bs_id`),
  ADD UNIQUE KEY `uq_bs` (`batch_id`,`subject_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `chatbot_queries`
--
ALTER TABLE `chatbot_queries`
  ADD PRIMARY KEY (`query_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `chat_logs`
--
ALTER TABLE `chat_logs`
  ADD PRIMARY KEY (`chat_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `classrooms`
--
ALTER TABLE `classrooms`
  ADD PRIMARY KEY (`room_id`),
  ADD UNIQUE KEY `room_name` (`room_name`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`dept_id`);

--
-- Indexes for table `login_logs`
--
ALTER TABLE `login_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`permission_id`),
  ADD UNIQUE KEY `permission_key` (`permission_key`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `generated_by` (`generated_by`);

--
-- Indexes for table `request_logs`
--
ALTER TABLE `request_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `request_id` (`request_id`),
  ADD KEY `actor_user_id` (`actor_user_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_id`,`permission_id`),
  ADD KEY `permission_id` (`permission_id`);

--
-- Indexes for table `scenario_adjustments`
--
ALTER TABLE `scenario_adjustments`
  ADD PRIMARY KEY (`adj_id`),
  ADD KEY `scenario_id` (`scenario_id`),
  ADD KEY `timetable_id` (`timetable_id`);

--
-- Indexes for table `scenario_changes`
--
ALTER TABLE `scenario_changes`
  ADD PRIMARY KEY (`change_id`),
  ADD KEY `timetable_id` (`timetable_id`),
  ADD KEY `old_teacher_id` (`old_teacher_id`),
  ADD KEY `new_teacher_id` (`new_teacher_id`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `scenario_plans`
--
ALTER TABLE `scenario_plans`
  ADD PRIMARY KEY (`scenario_id`);

--
-- Indexes for table `search_logs`
--
ALTER TABLE `search_logs`
  ADD PRIMARY KEY (`search_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`setting_id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`subject_id`),
  ADD UNIQUE KEY `subject_code` (`subject_code`),
  ADD KEY `dept_id` (`dept_id`);

--
-- Indexes for table `teacher_requests`
--
ALTER TABLE `teacher_requests`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `teacher_id` (`teacher_id`),
  ADD KEY `timetable_id` (`timetable_id`),
  ADD KEY `new_slot_id` (`new_slot_id`),
  ADD KEY `resolved_by` (`resolved_by`);

--
-- Indexes for table `teacher_subjects`
--
ALTER TABLE `teacher_subjects`
  ADD PRIMARY KEY (`ts_id`),
  ADD KEY `teacher_id` (`teacher_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `teacher_unavailability`
--
ALTER TABLE `teacher_unavailability`
  ADD PRIMARY KEY (`tu_id`),
  ADD UNIQUE KEY `uq_tu` (`teacher_id`,`slot_id`),
  ADD KEY `slot_id` (`slot_id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`ticket_id`),
  ADD KEY `teacher_id` (`teacher_id`),
  ADD KEY `timetable_id` (`timetable_id`);

--
-- Indexes for table `timetable`
--
ALTER TABLE `timetable`
  ADD PRIMARY KEY (`timetable_id`),
  ADD KEY `slot_id` (`slot_id`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `teacher_id` (`teacher_id`),
  ADD KEY `batch_id` (`batch_id`);

--
-- Indexes for table `time_slots`
--
ALTER TABLE `time_slots`
  ADD PRIMARY KEY (`slot_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `fk_users_batch` (`batch_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `attendance_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `batches`
--
ALTER TABLE `batches`
  MODIFY `batch_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `batch_subjects`
--
ALTER TABLE `batch_subjects`
  MODIFY `bs_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `chatbot_queries`
--
ALTER TABLE `chatbot_queries`
  MODIFY `query_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_logs`
--
ALTER TABLE `chat_logs`
  MODIFY `chat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `classrooms`
--
ALTER TABLE `classrooms`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `dept_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `login_logs`
--
ALTER TABLE `login_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `permission_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `request_logs`
--
ALTER TABLE `request_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `scenario_adjustments`
--
ALTER TABLE `scenario_adjustments`
  MODIFY `adj_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `scenario_changes`
--
ALTER TABLE `scenario_changes`
  MODIFY `change_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `scenario_plans`
--
ALTER TABLE `scenario_plans`
  MODIFY `scenario_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `search_logs`
--
ALTER TABLE `search_logs`
  MODIFY `search_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `setting_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `subject_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `teacher_requests`
--
ALTER TABLE `teacher_requests`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `teacher_subjects`
--
ALTER TABLE `teacher_subjects`
  MODIFY `ts_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `teacher_unavailability`
--
ALTER TABLE `teacher_unavailability`
  MODIFY `tu_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `ticket_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `timetable`
--
ALTER TABLE `timetable`
  MODIFY `timetable_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `time_slots`
--
ALTER TABLE `time_slots`
  MODIFY `slot_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`timetable_id`) REFERENCES `timetable` (`timetable_id`);

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `batches`
--
ALTER TABLE `batches`
  ADD CONSTRAINT `batches_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `departments` (`dept_id`);

--
-- Constraints for table `batch_subjects`
--
ALTER TABLE `batch_subjects`
  ADD CONSTRAINT `batch_subjects_ibfk_1` FOREIGN KEY (`batch_id`) REFERENCES `batches` (`batch_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `batch_subjects_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`) ON DELETE CASCADE;

--
-- Constraints for table `chatbot_queries`
--
ALTER TABLE `chatbot_queries`
  ADD CONSTRAINT `chatbot_queries_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `chat_logs`
--
ALTER TABLE `chat_logs`
  ADD CONSTRAINT `chat_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `login_logs`
--
ALTER TABLE `login_logs`
  ADD CONSTRAINT `login_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`generated_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `request_logs`
--
ALTER TABLE `request_logs`
  ADD CONSTRAINT `request_logs_ibfk_1` FOREIGN KEY (`request_id`) REFERENCES `teacher_requests` (`request_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `request_logs_ibfk_2` FOREIGN KEY (`actor_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`permission_id`) ON DELETE CASCADE;

--
-- Constraints for table `scenario_adjustments`
--
ALTER TABLE `scenario_adjustments`
  ADD CONSTRAINT `scenario_adjustments_ibfk_1` FOREIGN KEY (`scenario_id`) REFERENCES `scenario_plans` (`scenario_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `scenario_adjustments_ibfk_2` FOREIGN KEY (`timetable_id`) REFERENCES `timetable` (`timetable_id`) ON DELETE CASCADE;

--
-- Constraints for table `scenario_changes`
--
ALTER TABLE `scenario_changes`
  ADD CONSTRAINT `scenario_changes_ibfk_1` FOREIGN KEY (`timetable_id`) REFERENCES `timetable` (`timetable_id`),
  ADD CONSTRAINT `scenario_changes_ibfk_2` FOREIGN KEY (`old_teacher_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `scenario_changes_ibfk_3` FOREIGN KEY (`new_teacher_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `scenario_changes_ibfk_4` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `search_logs`
--
ALTER TABLE `search_logs`
  ADD CONSTRAINT `search_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `subjects`
--
ALTER TABLE `subjects`
  ADD CONSTRAINT `subjects_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `departments` (`dept_id`);

--
-- Constraints for table `teacher_requests`
--
ALTER TABLE `teacher_requests`
  ADD CONSTRAINT `teacher_requests_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `teacher_requests_ibfk_2` FOREIGN KEY (`timetable_id`) REFERENCES `timetable` (`timetable_id`),
  ADD CONSTRAINT `teacher_requests_ibfk_3` FOREIGN KEY (`new_slot_id`) REFERENCES `time_slots` (`slot_id`),
  ADD CONSTRAINT `teacher_requests_ibfk_4` FOREIGN KEY (`resolved_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `teacher_subjects`
--
ALTER TABLE `teacher_subjects`
  ADD CONSTRAINT `teacher_subjects_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `teacher_subjects_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`);

--
-- Constraints for table `teacher_unavailability`
--
ALTER TABLE `teacher_unavailability`
  ADD CONSTRAINT `teacher_unavailability_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `teacher_unavailability_ibfk_2` FOREIGN KEY (`slot_id`) REFERENCES `time_slots` (`slot_id`) ON DELETE CASCADE;

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`timetable_id`) REFERENCES `timetable` (`timetable_id`);

--
-- Constraints for table `timetable`
--
ALTER TABLE `timetable`
  ADD CONSTRAINT `timetable_ibfk_1` FOREIGN KEY (`slot_id`) REFERENCES `time_slots` (`slot_id`),
  ADD CONSTRAINT `timetable_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`),
  ADD CONSTRAINT `timetable_ibfk_3` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `timetable_ibfk_4` FOREIGN KEY (`batch_id`) REFERENCES `batches` (`batch_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_batch` FOREIGN KEY (`batch_id`) REFERENCES `batches` (`batch_id`),
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`);
--
-- Database: `blog_scraper`
--
CREATE DATABASE IF NOT EXISTS `blog_scraper` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `blog_scraper`;

-- --------------------------------------------------------

--
-- Table structure for table `articles`
--

CREATE TABLE `articles` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `original_content_html` longtext DEFAULT NULL,
  `original_content_text` longtext DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `published_date` datetime DEFAULT NULL,
  `source_url` varchar(255) NOT NULL,
  `is_updated` tinyint(1) DEFAULT 0,
  `updated_content` longtext DEFAULT NULL,
  `references` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`references`)),
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `category` varchar(255) DEFAULT 'General'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `articles`
--

INSERT INTO `articles` (`id`, `title`, `original_content_html`, `original_content_text`, `author`, `published_date`, `source_url`, `is_updated`, `updated_content`, `references`, `created_at`, `updated_at`, `category`) VALUES
(1, 'AI in Healthcare: Hype or Reality?', '\n					<div class=\"e-con-inner\">\n				<div class=\"elementor-element elementor-element-b2a436b elementor-widget elementor-widget-theme-post-content\" data-id=\"b2a436b\" data-element_type=\"widget\" data-widget_type=\"theme-post-content.default\">\n					\n<p>Doctors and hospitals are <strong>slowly adopting AI in healthcare</strong>, but many <strong>still have doubts and concerns</strong> about how it will work. AI has already helped in many industries, from <strong>customer service chatbots</strong> to <strong>self-driving cars</strong>, but <strong>healthcare is different</strong>.</p>\n\n\n\n<p>I recently had a discussion with a <strong>medical professional at AIIMS, New Delhi</strong>, one of India’s top medical institutions. The topic?</p>\n\n\n\n<blockquote class=\"wp-block-quote is-layout-flow wp-block-quote-is-layout-flow\">\n<p><strong>What are Doctors’ biggest concerns about adopting AI in healthcare?</strong></p>\n</blockquote>\n\n\n\n<p>At BeyondChats, we’re redefining healthcare with AI—automating repetitive tasks, enhancing patient engagement, and giving doctors and nurses the freedom to focus on what truly matters: patient care. Our vision isn’t just about efficiency; it’s about transforming the future of healthcare.</p>\n\n\n\n<figure class=\"wp-block-image size-large\"><a href=\"https://beyondchats.com/wp-content/uploads/2025/03/Beyondchats-Interns.jpg\"><img fetchpriority=\"high\" decoding=\"async\" width=\"1024\" height=\"538\" src=\"https://beyondchats.com/wp-content/uploads/2025/03/Beyondchats-Interns-1024x538.jpg\" alt=\"Beyondchats AI in healthcare chatbot and A surprised doctor checking on if AI is a myth or reality.\" class=\"wp-image-7223\" srcset=\"https://beyondchats.com/wp-content/uploads/2025/03/Beyondchats-Interns-1024x538.jpg 1024w, https://beyondchats.com/wp-content/uploads/2025/03/Beyondchats-Interns-300x158.jpg 300w, https://beyondchats.com/wp-content/uploads/2025/03/Beyondchats-Interns-768x403.jpg 768w, https://beyondchats.com/wp-content/uploads/2025/03/Beyondchats-Interns-600x315.jpg 600w, https://beyondchats.com/wp-content/uploads/2025/03/Beyondchats-Interns.jpg 1200w\" sizes=\"(max-width: 1024px) 100vw, 1024px\"></a></figure>\n\n\n\n<p>The doctor listened but was skeptical. They acknowledged the disruptive potential of AI but also raised some <strong>critical concerns</strong> that can’t be ignored.</p>\n\n\n\n<p><strong>“Before we hand over the stethoscope to AI, let’s consider a few concerns,”</strong> they said.</p>\n\n\n\n<p>Here’s what we discussed.</p>\n\n\n\n<h4 class=\"wp-block-heading\"><mark class=\"has-inline-color has-palette-color-2-color\">Doctor: ???????????????? ???????? ???????????????????????????????????????? ???????????? ???????????????????????????????????????????????? ???????? ???????????????????????????? ?????????????????</mark></h4>\n\n\n\n<p>Healthcare is not just about numbers, reports, and medical data, it is about <strong>people, emotions, and trust</strong>.</p>\n\n\n\n<p>AI might be great at <strong>analysing patterns and making predictions</strong>, but does it also <strong>grasp the individual needs</strong> of each patient? </p>\n\n\n\n<p>Every patient has a <strong>unique medical history, lifestyle, and personal preferences</strong> that impact their treatment. A doctor uses more than just data to make decisions— they rely on <strong>experience, intuition, and direct human interaction</strong>.</p>\n\n\n\n<h5 class=\"wp-block-heading\"><strong><mark style=\"color:#6f3bb3\" class=\"has-inline-color\">My Thoughts: AI is a Support System</mark></strong></h5>\n\n\n\n<p>I completely understand your concern. AI is still evolving, and healthcare is <strong>one of the most regulated and risk-averse industries</strong>—rightly so. However, we are already seeing <strong>people using AI</strong> for highly personal matters.</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Many people <strong>ask AI for advice</strong> on relationships, personal issues, or even mental health.</li>\n\n\n\n<li>AI assistants are being used to <strong>help plan daily tasks, provide reminders, and answer sensitive questions</strong>.</li>\n\n\n\n<li>AI-powered chatbots are assisting with <strong>basic medical queries</strong> in hospitals and clinics worldwide.</li>\n</ul>\n\n\n\n<figure class=\"wp-block-image size-large\"><a href=\"https://beyondchats.com/wp-content/uploads/2025/03/Ai-is-not-a-replacement.jpg\"><img decoding=\"async\" width=\"1024\" height=\"538\" src=\"https://beyondchats.com/wp-content/uploads/2025/03/Ai-is-not-a-replacement-1024x538.jpg\" alt=\"Human hand and AI hand synchronising.\" class=\"wp-image-7225\" srcset=\"https://beyondchats.com/wp-content/uploads/2025/03/Ai-is-not-a-replacement-1024x538.jpg 1024w, https://beyondchats.com/wp-content/uploads/2025/03/Ai-is-not-a-replacement-300x158.jpg 300w, https://beyondchats.com/wp-content/uploads/2025/03/Ai-is-not-a-replacement-768x403.jpg 768w, https://beyondchats.com/wp-content/uploads/2025/03/Ai-is-not-a-replacement-600x315.jpg 600w, https://beyondchats.com/wp-content/uploads/2025/03/Ai-is-not-a-replacement.jpg 1200w\" sizes=\"(max-width: 1024px) 100vw, 1024px\"></a></figure>\n\n\n\n<p>If people are already trusting AI with such <strong>personal aspects of their lives</strong>, it is only a matter of time before they start expecting <strong>AI-powered digital assistants in every hospital and clinic</strong>.</p>\n\n\n\n<p>Startups like <strong>BeyondChats</strong> are working closely with hospitals to develop <strong>specialized AI models</strong> that are tailored to <strong>specific medical needs</strong>. These AI assistants are not aiming to replace doctors but will act as an additional layer of <strong>support—just like nurses, administrative staff, and help desks</strong> in hospitals today.</p>\n\n\n\n<p>In the future, hospitals will not just have <strong>nurses and front desk assistants</strong>—they will also have <strong>AI-driven digital assistants</strong> to help answer common patient questions, and provide <strong>quick, accurate medical guidance</strong> under a doctor’s supervision.</p>\n\n\n\n<p>This shift is not about <strong>replacing the human touch in medicine</strong>—it is about enhancing efficiency, <strong>freeing up doctors’ time</strong>, and ensuring patients <strong>get the right help much faster</strong>.</p>\n\n\n\n<h4 class=\"wp-block-heading\"><mark class=\"has-inline-color has-palette-color-2-color\">Doctor: ???????????????? ???????? ???????? ???????????????????????? ???????????????? ???????????????????????????????? ???????????? ?????????????????????????????</mark></h4>\n\n\n\n<p>They explained that many doctors worry about having to <strong>double-check AI-generated reports</strong>, correct mistakes, and spend time <strong>learning new systems</strong>. If AI suggests <strong>incorrect or incomplete information</strong>, it could lead to <strong>even more administrative burdens</strong>.</p>\n\n\n\n<p>Instead of saving time, doctors fear they might have to <strong>review and edit AI-generated recommendations</strong>, leading to <strong>longer work hours</strong> rather than efficiency. There is also concern that <strong>new AI systems</strong> may require extensive <strong>training and adaptation</strong>, which could disrupt hospital workflows.</p>\n\n\n\n<figure class=\"wp-block-image size-large\"><a href=\"https://beyondchats.com/wp-content/uploads/2025/03/AI-as-a-helping-hand.jpg\"><img decoding=\"async\" width=\"1024\" height=\"538\" src=\"https://beyondchats.com/wp-content/uploads/2025/03/AI-as-a-helping-hand-1024x538.jpg\" alt=\"AI is seen as a helping hand not a workload.\" class=\"wp-image-7226\" srcset=\"https://beyondchats.com/wp-content/uploads/2025/03/AI-as-a-helping-hand-1024x538.jpg 1024w, https://beyondchats.com/wp-content/uploads/2025/03/AI-as-a-helping-hand-300x158.jpg 300w, https://beyondchats.com/wp-content/uploads/2025/03/AI-as-a-helping-hand-768x403.jpg 768w, https://beyondchats.com/wp-content/uploads/2025/03/AI-as-a-helping-hand-600x315.jpg 600w, https://beyondchats.com/wp-content/uploads/2025/03/AI-as-a-helping-hand.jpg 1200w\" sizes=\"(max-width: 1024px) 100vw, 1024px\"></a></figure>\n\n\n\n<h5 class=\"wp-block-heading\"><strong><mark style=\"color:#6f3bb3\" class=\"has-inline-color\">My Thoughts: AI will save time, instead of being a burden</mark></strong></h5>\n\n\n\n<p>I completely understand why your concern exists. <strong>Technology should simplify work, not make it harder.</strong> However, <strong>modern AI—especially Large Language Models (LLMs)</strong>—is very different from traditional AI systems.</p>\n\n\n\n<p>Here’s why:</p>\n\n\n\n<ol class=\"wp-block-list\">\n<li><strong>LLMs Understand Real-World Data</strong>\n<ul class=\"wp-block-list\">\n<li>Traditional AI models relied on <span style=\"text-decoration: underline\">pre-set rules and limited data</span>. This meant doctors had to manually correct AI-generated outputs.</li>\n\n\n\n<li>LLMs, on the other hand, learn from vast medical datasets and continuously improve their accuracy over time. They <span style=\"text-decoration: underline\">can adapt to real-world patient interactions</span> and clinical guidelines much better than older AI models.</li>\n</ul>\n</li>\n\n\n\n<li><strong>AI Agents Can Take Action, Not Just Provide Data</strong>\n<ul class=\"wp-block-list\">\n<li>Earlier AI systems only processed and presented information, but they couldn’t automate workflows.</li>\n\n\n\n<li>AI-powered assistants today <span style=\"text-decoration: underline\">can schedule appointments, summarize patient records, flag urgent cases</span>, and provide structured insights—reducing manual tasks for doctors.</li>\n</ul>\n</li>\n\n\n\n<li><strong>AI Will Automate Repetitive Work, Not Increase It</strong>\n<ul class=\"wp-block-list\">\n<li>Many doctors and hospital staff spend hours on paperwork, patient history collection, and answering routine questions.</li>\n\n\n\n<li>AI-led hyper-focused healthcare solutions <span style=\"text-decoration: underline\">will handle administrative tasks, allowing doctors to focus on patient care</span> instead of documentation.</li>\n</ul>\n</li>\n\n\n\n<li><strong>AI Adapts to the Doctor’s Workflow, Not the Other Way Around</strong>\n<ul class=\"wp-block-list\">\n<li>The biggest fear is that doctors will have to change their entire way of working to fit into AI-driven systems.</li>\n\n\n\n<li>But smart AI assistants like BeyondChats are designed to integrate seamlessly into existing <span style=\"text-decoration: underline\">hospital software, requiring minimal adjustment</span> from doctors.</li>\n</ul>\n</li>\n</ol>\n\n\n\n<h4 class=\"wp-block-heading\"><mark class=\"has-inline-color has-palette-color-2-color\">Doctor: ???????????? ???????? ???????? ???????????????????????????????? ???????????????????????????? ?????????????????????</mark></h4>\n\n\n\n<p>Patients trust their doctors not just because of their medical knowledge, but because of <strong>human connection</strong>. A doctor listens to their concerns, understands their emotions, and builds a relationship over time.</p>\n\n\n\n<p>Trust in healthcare is deeply personal. Patients rely on their doctors because they know that behind every diagnosis and treatment plan, there is a <strong>real person who cares about their well-being</strong>.</p>\n\n\n\n<p>So, if AI starts playing a bigger role in healthcare, how do we ensure that <strong>patients trust AI-assisted decisions</strong> just as they trust human doctors? Will patients feel comfortable relying on <strong>a digital system</strong> instead of a real conversation with their doctor?</p>\n\n\n\n<figure class=\"wp-block-image size-large\"><a href=\"https://beyondchats.com/wp-content/uploads/2025/03/AI-as-a-reliable-partner.jpg\"><img loading=\"lazy\" decoding=\"async\" width=\"1024\" height=\"538\" src=\"https://beyondchats.com/wp-content/uploads/2025/03/AI-as-a-reliable-partner-1024x538.jpg\" alt=\"AI is shown as the healthcare partner. Understanding the human brain.\" class=\"wp-image-7227\" srcset=\"https://beyondchats.com/wp-content/uploads/2025/03/AI-as-a-reliable-partner-1024x538.jpg 1024w, https://beyondchats.com/wp-content/uploads/2025/03/AI-as-a-reliable-partner-300x158.jpg 300w, https://beyondchats.com/wp-content/uploads/2025/03/AI-as-a-reliable-partner-768x403.jpg 768w, https://beyondchats.com/wp-content/uploads/2025/03/AI-as-a-reliable-partner-600x315.jpg 600w, https://beyondchats.com/wp-content/uploads/2025/03/AI-as-a-reliable-partner.jpg 1200w\" sizes=\"(max-width: 1024px) 100vw, 1024px\"></a></figure>\n\n\n\n<h5 class=\"wp-block-heading\"><strong><mark style=\"color:#6f3bb3\" class=\"has-inline-color\">My Thoughts: AI will become a trusted partner for doctors</mark></strong></h5>\n\n\n\n<p>The key to building trust in AI in healthcare is <strong>transparency, reliability, and collaboration with doctors</strong>.</p>\n\n\n\n<ol class=\"wp-block-list\">\n<li><strong>AI Needs to Be Transparent and Explainable</strong>\n<ul class=\"wp-block-list\">\n<li>Patients will naturally be skeptical if AI works as a “black box,” providing recommendations without clear reasoning.</li>\n\n\n\n<li>AI must be able to <span style=\"text-decoration: underline\">explain why it makes certain suggestions</span> in simple terms, helping both patients and doctors understand its reasoning.</li>\n</ul>\n</li>\n\n\n\n<li><strong>AI Should Assist</strong>\n<ul class=\"wp-block-list\">\n<li>When AI is used to support doctors—rather than act as a standalone system—patients will be more likely to <span style=\"text-decoration: underline\">trust AI-backed recommendations</span>.</li>\n</ul>\n</li>\n\n\n\n<li><strong>Trust Comes from Proven Results</strong>\n<ul class=\"wp-block-list\">\n<li>The more AI helps doctors improve patient outcomes, the more it will be seen as a valuable part of healthcare.</li>\n\n\n\n<li>Over time, as AI continues to assist doctors in making accurate diagnoses, suggesting better treatments, and reducing errors, patients will naturally trust its role in their care.</li>\n</ul>\n</li>\n\n\n\n<li><strong>Personalized and Faster Patient Care</strong>\n<ul class=\"wp-block-list\">\n<li>AI enables more personalized healthcare by analyzing patient history, preferences, and symptoms instantly.</li>\n\n\n\n<li>Instead of replacing human interactions, AI can ensure that doctors spend more time on critical cases while AI in healthcare handles routine queries.</li>\n\n\n\n<li>This faster, smarter system will improve patient experience, making AI a trusted extension of the medical team.</li>\n</ul>\n</li>\n</ol>\n\n\n\n<h4 class=\"wp-block-heading\"><mark class=\"has-inline-color has-palette-color-2-color\">Doctor: ???????????????? ???????????????????????????????? ???????????? ???????????????????????????? ????????????????????????????????</mark></h4>\n\n\n\n<p>Healthcare data is <strong>extremely sensitive</strong>—it contains personal medical histories, diagnoses, treatment plans, and sometimes even psychological or genetic information. If this data falls into the wrong hands, it can lead to <strong>serious ethical, legal, and financial consequences</strong>.</p>\n\n\n\n<p>With AI systems like <strong>OpenAI and Gemini</strong> processing large amounts of data, there’s a fear that <strong>patient records could be exposed, misused, or even sold without consent</strong>. The risk isn’t just about cybercriminals hacking into hospital databases—it’s also about <strong>how AI companies store and process this data</strong>.</p>\n\n\n\n<p>If AI in healthcare is to be trusted, how do we <strong>ensure patient data is protected</strong> while still using AI to improve medical care?</p>\n\n\n\n<figure class=\"wp-block-image size-large\"><a href=\"https://beyondchats.com/wp-content/uploads/2025/03/Beyondchats-Interns-1.jpg\"><img loading=\"lazy\" decoding=\"async\" width=\"1024\" height=\"538\" src=\"https://beyondchats.com/wp-content/uploads/2025/03/Beyondchats-Interns-1-1024x538.jpg\" alt=\"AI chatbot taking care of privacy. With 2 humans interacting with the bot.\" class=\"wp-image-7228\" srcset=\"https://beyondchats.com/wp-content/uploads/2025/03/Beyondchats-Interns-1-1024x538.jpg 1024w, https://beyondchats.com/wp-content/uploads/2025/03/Beyondchats-Interns-1-300x158.jpg 300w, https://beyondchats.com/wp-content/uploads/2025/03/Beyondchats-Interns-1-768x403.jpg 768w, https://beyondchats.com/wp-content/uploads/2025/03/Beyondchats-Interns-1-600x315.jpg 600w, https://beyondchats.com/wp-content/uploads/2025/03/Beyondchats-Interns-1.jpg 1200w\" sizes=\"(max-width: 1024px) 100vw, 1024px\"></a></figure>\n\n\n\n<h5 class=\"wp-block-heading\"><strong><mark style=\"color:#6f3bb3\" class=\"has-inline-color\">My Thoughts: Security Must Be Built into AI from Day One</mark></strong></h5>\n\n\n\n<p>Data security is a <strong>real concern</strong>, and it should never be taken lightly. However, as AI and cybersecurity <strong>continue to advance</strong>, we now have <strong>stronger measures than ever before</strong> to ensure <strong>healthcare data remains safe</strong>.</p>\n\n\n\n<ol class=\"wp-block-list\">\n<li><strong>AI in healthcare are build with Strong Encryption and Security Standards</strong>\n<ul class=\"wp-block-list\">\n<li><span style=\"text-decoration: underline\">Robust encryption protocols</span> ensure that patient data is stored and transmitted securely.</li>\n\n\n\n<li>Hospitals and healthcare providers must use end-to-end encryption, so even if data is intercepted, it remains unreadable.</li>\n</ul>\n</li>\n\n\n\n<li><strong>AI in Healthcare don’t Use Open Data Models</strong>\n<ul class=\"wp-block-list\">\n<li>General AI models like <strong>OpenAI and Gemini</strong> train on vast amounts of user data, but healthcare AI should be different.</li>\n\n\n\n<li>Companies like <span style=\"text-decoration: underline\">Beyondchats</span> are building Healthcare-specific AI models. And these are trained in a <strong>secure, closed environment</strong> where patient data is <strong>never exposed to the public internet</strong>.</li>\n</ul>\n</li>\n\n\n\n<li><strong>Collaboration Between Tech and Healthcare Professionals</strong>\n<ul class=\"wp-block-list\">\n<li>Doctors and hospital administrators must work closely with AI developers to define clear boundaries for data usage.</li>\n\n\n\n<li>AI should only access data necessary for its task and should never store or use patient data beyond what is required for medical purposes.</li>\n</ul>\n</li>\n\n\n\n<li><strong>Patients Must Have Control Over Their Data</strong>\n<ul class=\"wp-block-list\">\n<li>Transparency is key—patients should always know when AI is being used and what data it is processing.</li>\n\n\n\n<li>Patients should have the option to opt-out of AI-based recommendations or data sharing if they choose.</li>\n</ul>\n</li>\n</ol>\n\n\n\n<p><a href=\"https://www.ft.com/content/5c356658-6db4-47c1-940b-b2e3cf3a51f3\" target=\"_blank\" rel=\"noopener\">AI in healthcare</a> is <strong>empowering healthcare providers</strong>. If done right, AI can be both <strong>a powerful medical tool and a secure guardian of patient data.</strong></p>\n\n\n\n<h4 class=\"wp-block-heading\"><strong><mark style=\"color:#2e532f\" class=\"has-inline-color\"><em>Conclusion: Collaboration is the Key to AI’s Success in Healthcare</em></mark></strong></h4>\n\n\n\n<p>For AI to <strong>revolutionize healthcare</strong>, it must be <strong>built in collaboration with medical professionals</strong>. This means:</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li><strong>Listening to doctors and nurses</strong> to understand their pain points.</li>\n\n\n\n<li><strong>Designing AI tools that are practical, user-friendly, and effective.</strong></li>\n\n\n\n<li><strong>Ensuring data privacy and security</strong> to build trust in AI systems.</li>\n</ul>\n\n\n\n<p>At <strong><a href=\"https://beyondchats.com/\">BeyondChats</a></strong>, we don’t see AI as a <strong>standalone technology</strong>—we see it as <strong>a partner in healthcare</strong>. We have created <strong>AI solutions that assist hospitals, support medical teams, and enhance patient experiences</strong>.</p>\n\n\n\n<p><strong>The future of healthcare is not AI replacing doctors—it’s AI working hand in hand with them to create a smarter, more efficient, and more accessible healthcare system.</strong></p>\n\n\n\n<p></p>\n<div class=\"has-social-placeholder has-content-area\" data-url=\"https://beyondchats.com/blogs/ai-in-healthcare-hype-or-reality/\" data-title=\"AI in Healthcare: Hype or Reality?\" data-hashtags=\"\" data-post-id=\"7221\"></div>				</div>\n				<div class=\"elementor-element elementor-element-106752c elementor-widget elementor-widget-shortcode\" data-id=\"106752c\" data-element_type=\"widget\" data-widget_type=\"shortcode.default\">\n							<div class=\"elementor-shortcode\">		<div data-elementor-type=\"container\" data-elementor-id=\"6196\" class=\"elementor elementor-6196\" data-elementor-post-type=\"elementor_library\">\n				<div class=\"elementor-element elementor-element-af06f6b elementor-hidden-mobile e-flex e-con-boxed e-con e-parent\" data-id=\"af06f6b\" data-element_type=\"container\">\n					<div class=\"e-con-inner\">\n		<div class=\"elementor-element elementor-element-190a40c e-con-full e-flex e-con e-child\" data-id=\"190a40c\" data-element_type=\"container\">\n		<div class=\"elementor-element elementor-element-21c23ec e-con-full e-flex e-con e-child\" data-id=\"21c23ec\" data-element_type=\"container\">\n				<div class=\"elementor-element elementor-element-30984ea elementor-widget elementor-widget-shortcode\" data-id=\"30984ea\" data-element_type=\"widget\" data-widget_type=\"shortcode.default\">\n							<div class=\"elementor-shortcode\">    <div class=\"wp-applause-container\" data-post-id=\"7221\">\n        <button class=\"wp-applause-button\" data-post-id=\"7221\">\n            <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" aria-label=\"clap\"><path fill-rule=\"evenodd\" d=\"M11.37.828 12 3.282l.63-2.454zM13.916 3.953l1.523-2.112-1.184-.39zM8.589 1.84l1.522 2.112-.337-2.501zM18.523 18.92c-.86.86-1.75 1.246-2.62 1.33a6 6 0 0 0 .407-.372c2.388-2.389 2.86-4.951 1.399-7.623l-.912-1.603-.79-1.672c-.26-.56-.194-.98.203-1.288a.7.7 0 0 1 .546-.132c.283.046.546.231.728.5l2.363 4.157c.976 1.624 1.141 4.237-1.324 6.702m-10.999-.438L3.37 14.328a.828.828 0 0 1 .585-1.408.83.83 0 0 1 .585.242l2.158 2.157a.365.365 0 0 0 .516-.516l-2.157-2.158-1.449-1.449a.826.826 0 0 1 1.167-1.17l3.438 3.44a.363.363 0 0 0 .516 0 .364.364 0 0 0 0-.516L5.293 9.513l-.97-.97a.826.826 0 0 1 0-1.166.84.84 0 0 1 1.167 0l.97.968 3.437 3.436a.36.36 0 0 0 .517 0 .366.366 0 0 0 0-.516L6.977 7.83a.82.82 0 0 1-.241-.584.82.82 0 0 1 .824-.826c.219 0 .43.087.584.242l5.787 5.787a.366.366 0 0 0 .587-.415l-1.117-2.363c-.26-.56-.194-.98.204-1.289a.7.7 0 0 1 .546-.132c.283.046.545.232.727.501l2.193 3.86c1.302 2.38.883 4.59-1.277 6.75-1.156 1.156-2.602 1.627-4.19 1.367-1.418-.236-2.866-1.033-4.079-2.246M10.75 5.971l2.12 2.12c-.41.502-.465 1.17-.128 1.89l.22.465-3.523-3.523a.8.8 0 0 1-.097-.368c0-.22.086-.428.241-.584a.847.847 0 0 1 1.167 0m7.355 1.705c-.31-.461-.746-.758-1.23-.837a1.44 1.44 0 0 0-1.11.275c-.312.24-.505.543-.59.881a1.74 1.74 0 0 0-.906-.465 1.47 1.47 0 0 0-.82.106l-2.182-2.182a1.56 1.56 0 0 0-2.2 0 1.54 1.54 0 0 0-.396.701 1.56 1.56 0 0 0-2.21-.01 1.55 1.55 0 0 0-.416.753c-.624-.624-1.649-.624-2.237-.037a1.557 1.557 0 0 0 0 2.2c-.239.1-.501.238-.715.453a1.56 1.56 0 0 0 0 2.2l.516.515a1.556 1.556 0 0 0-.753 2.615L7.01 19c1.32 1.319 2.909 2.189 4.475 2.449q.482.08.971.08c.85 0 1.653-.198 2.393-.579.231.033.46.054.686.054 1.266 0 2.457-.52 3.505-1.567 2.763-2.763 2.552-5.734 1.439-7.586z\" clip-rule=\"evenodd\"></path></svg>\n        </button>\n        <span class=\"wp-applause-count\">69</span>\n    </div>\n    </div>\n						</div>\n				<div class=\"elementor-element elementor-element-36e02a7 elementor-position-right elementor-mobile-position-left elementor-view-default elementor-widget elementor-widget-icon-box\" data-id=\"36e02a7\" data-element_type=\"widget\" data-widget_type=\"icon-box.default\">\n							<div class=\"elementor-icon-box-wrapper\">\n\n						<div class=\"elementor-icon-box-icon\">\n				<a href=\"#comments\" class=\"elementor-icon\" tabindex=\"-1\">\n				<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-far-comments\" viewBox=\"0 0 576 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M532 386.2c27.5-27.1 44-61.1 44-98.2 0-80-76.5-146.1-176.2-157.9C368.3 72.5 294.3 32 208 32 93.1 32 0 103.6 0 192c0 37 16.5 71 44 98.2-15.3 30.7-37.3 54.5-37.7 54.9-6.3 6.7-8.1 16.5-4.4 25 3.6 8.5 12 14 21.2 14 53.5 0 96.7-20.2 125.2-38.8 9.2 2.1 18.7 3.7 28.4 4.9C208.1 407.6 281.8 448 368 448c20.8 0 40.8-2.4 59.8-6.8C456.3 459.7 499.4 480 553 480c9.2 0 17.5-5.5 21.2-14 3.6-8.5 1.9-18.3-4.4-25-.4-.3-22.5-24.1-37.8-54.8zm-392.8-92.3L122.1 305c-14.1 9.1-28.5 16.3-43.1 21.4 2.7-4.7 5.4-9.7 8-14.8l15.5-31.1L77.7 256C64.2 242.6 48 220.7 48 192c0-60.7 73.3-112 160-112s160 51.3 160 112-73.3 112-160 112c-16.5 0-33-1.9-49-5.6l-19.8-4.5zM498.3 352l-24.7 24.4 15.5 31.1c2.6 5.1 5.3 10.1 8 14.8-14.6-5.1-29-12.3-43.1-21.4l-17.1-11.1-19.9 4.6c-16 3.7-32.5 5.6-49 5.6-54 0-102.2-20.1-131.3-49.7C338 339.5 416 272.9 416 192c0-3.4-.4-6.7-.7-10C479.7 196.5 528 238.8 528 288c0 28.7-16.2 50.6-29.7 64z\"></path></svg>				</a>\n			</div>\n			\n			\n		</div>\n						</div>\n				</div>\n		<div class=\"elementor-element elementor-element-82f4de6 e-con-full elementor-hidden-mobile e-flex e-con e-child\" data-id=\"82f4de6\" data-element_type=\"container\">\n				<div class=\"elementor-element elementor-element-cea0a0c elementor-share-buttons--view-icon elementor-share-buttons--skin-framed elementor-share-buttons--color-custom elementor-share-buttons--shape-square elementor-grid-0 elementor-widget elementor-widget-share-buttons\" data-id=\"cea0a0c\" data-element_type=\"widget\" data-widget_type=\"share-buttons.default\">\n							<div class=\"elementor-grid\" role=\"list\">\n								<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_facebook\" role=\"button\" tabindex=\"0\" aria-label=\"Share on facebook\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-facebook\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M504 256C504 119 393 8 256 8S8 119 8 256c0 123.78 90.69 226.38 209.25 245V327.69h-63V256h63v-54.64c0-62.15 37-96.48 93.67-96.48 27.14 0 55.52 4.84 55.52 4.84v61h-31.28c-30.8 0-40.41 19.12-40.41 38.73V256h68.78l-11 71.69h-57.78V501C413.31 482.38 504 379.78 504 256z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_x-twitter\" role=\"button\" tabindex=\"0\" aria-label=\"Share on x-twitter\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-x-twitter\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M389.2 48h70.6L305.6 224.2 487 464H345L233.7 318.6 106.5 464H35.8L200.7 275.5 26.8 48H172.4L272.9 180.9 389.2 48zM364.4 421.8h39.1L151.1 88h-42L364.4 421.8z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_pinterest\" role=\"button\" tabindex=\"0\" aria-label=\"Share on pinterest\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-pinterest\" viewBox=\"0 0 496 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M496 256c0 137-111 248-248 248-25.6 0-50.2-3.9-73.4-11.1 10.1-16.5 25.2-43.5 30.8-65 3-11.6 15.4-59 15.4-59 8.1 15.4 31.7 28.5 56.8 28.5 74.8 0 128.7-68.8 128.7-154.3 0-81.9-66.9-143.2-152.9-143.2-107 0-163.9 71.8-163.9 150.1 0 36.4 19.4 81.7 50.3 96.1 4.7 2.2 7.2 1.2 8.3-3.3.8-3.4 5-20.3 6.9-28.1.6-2.5.3-4.7-1.7-7.1-10.1-12.5-18.3-35.3-18.3-56.6 0-54.7 41.4-107.6 112-107.6 60.9 0 103.6 41.5 103.6 100.9 0 67.1-33.9 113.6-78 113.6-24.3 0-42.6-20.1-36.7-44.8 7-29.5 20.5-61.3 20.5-82.6 0-19-10.2-34.9-31.4-34.9-24.9 0-44.9 25.7-44.9 60.2 0 22 7.4 36.8 7.4 36.8s-24.5 103.8-29 123.2c-5 21.4-3 51.6-.9 71.2C65.4 450.9 0 361.1 0 256 0 119 111 8 248 8s248 111 248 248z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_linkedin\" role=\"button\" tabindex=\"0\" aria-label=\"Share on linkedin\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-linkedin\" viewBox=\"0 0 448 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M416 32H31.9C14.3 32 0 46.5 0 64.3v383.4C0 465.5 14.3 480 31.9 480H416c17.6 0 32-14.5 32-32.3V64.3c0-17.8-14.4-32.3-32-32.3zM135.4 416H69V202.2h66.5V416zm-33.2-243c-21.3 0-38.5-17.3-38.5-38.5S80.9 96 102.2 96c21.2 0 38.5 17.3 38.5 38.5 0 21.3-17.2 38.5-38.5 38.5zm282.1 243h-66.4V312c0-24.8-.5-56.7-34.5-56.7-34.6 0-39.9 27-39.9 54.9V416h-66.4V202.2h63.7v29.2h.9c8.9-16.8 30.6-34.5 62.9-34.5 67.2 0 79.7 44.3 79.7 101.9V416z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_reddit\" role=\"button\" tabindex=\"0\" aria-label=\"Share on reddit\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-reddit\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M201.5 305.5c-13.8 0-24.9-11.1-24.9-24.6 0-13.8 11.1-24.9 24.9-24.9 13.6 0 24.6 11.1 24.6 24.9 0 13.6-11.1 24.6-24.6 24.6zM504 256c0 137-111 248-248 248S8 393 8 256 119 8 256 8s248 111 248 248zm-132.3-41.2c-9.4 0-17.7 3.9-23.8 10-22.4-15.5-52.6-25.5-86.1-26.6l17.4-78.3 55.4 12.5c0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.3 24.9-24.9s-11.1-24.9-24.9-24.9c-9.7 0-18 5.8-22.1 13.8l-61.2-13.6c-3-.8-6.1 1.4-6.9 4.4l-19.1 86.4c-33.2 1.4-63.1 11.3-85.5 26.8-6.1-6.4-14.7-10.2-24.1-10.2-34.9 0-46.3 46.9-14.4 62.8-1.1 5-1.7 10.2-1.7 15.5 0 52.6 59.2 95.2 132 95.2 73.1 0 132.3-42.6 132.3-95.2 0-5.3-.6-10.8-1.9-15.8 31.3-16 19.8-62.5-14.9-62.5zM302.8 331c-18.2 18.2-76.1 17.9-93.6 0-2.2-2.2-6.1-2.2-8.3 0-2.5 2.5-2.5 6.4 0 8.6 22.8 22.8 87.3 22.8 110.2 0 2.5-2.2 2.5-6.1 0-8.6-2.2-2.2-6.1-2.2-8.3 0zm7.7-75c-13.6 0-24.6 11.1-24.6 24.9 0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.1 24.9-24.6 0-13.8-11-24.9-24.9-24.9z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_whatsapp\" role=\"button\" tabindex=\"0\" aria-label=\"Share on whatsapp\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-whatsapp\" viewBox=\"0 0 448 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M380.9 97.1C339 55.1 283.2 32 223.9 32c-122.4 0-222 99.6-222 222 0 39.1 10.2 77.3 29.6 111L0 480l117.7-30.9c32.4 17.7 68.9 27 106.1 27h.1c122.3 0 224.1-99.6 224.1-222 0-59.3-25.2-115-67.1-157zm-157 341.6c-33.2 0-65.7-8.9-94-25.7l-6.7-4-69.8 18.3L72 359.2l-4.4-7c-18.5-29.4-28.2-63.3-28.2-98.2 0-101.7 82.8-184.5 184.6-184.5 49.3 0 95.6 19.2 130.4 54.1 34.8 34.9 56.2 81.2 56.1 130.5 0 101.8-84.9 184.6-186.6 184.6zm101.2-138.2c-5.5-2.8-32.8-16.2-37.9-18-5.1-1.9-8.8-2.8-12.5 2.8-3.7 5.6-14.3 18-17.6 21.8-3.2 3.7-6.5 4.2-12 1.4-32.6-16.3-54-29.1-75.5-66-5.7-9.8 5.7-9.1 16.3-30.3 1.8-3.7.9-6.9-.5-9.7-1.4-2.8-12.5-30.1-17.1-41.2-4.5-10.8-9.1-9.3-12.5-9.5-3.2-.2-6.9-.2-10.6-.2-3.7 0-9.7 1.4-14.8 6.9-5.1 5.6-19.4 19-19.4 46.3 0 27.3 19.9 53.7 22.6 57.4 2.8 3.7 39.1 59.7 94.8 83.8 35.2 15.2 49 16.5 66.6 13.9 10.7-1.6 32.8-13.4 37.4-26.4 4.6-13 4.6-24.1 3.2-26.4-1.3-2.5-5-3.9-10.5-6.6z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_email\" role=\"button\" tabindex=\"0\" aria-label=\"Share on email\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fas-envelope\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M502.3 190.8c3.9-3.1 9.7-.2 9.7 4.7V400c0 26.5-21.5 48-48 48H48c-26.5 0-48-21.5-48-48V195.6c0-5 5.7-7.8 9.7-4.7 22.4 17.4 52.1 39.5 154.1 113.6 21.1 15.4 56.7 47.8 92.2 47.6 35.7.3 72-32.8 92.3-47.6 102-74.1 131.6-96.3 154-113.7zM256 320c23.2.4 56.6-29.2 73.4-41.4 132.7-96.3 142.8-104.7 173.4-128.7 5.8-4.5 9.2-11.5 9.2-18.9v-19c0-26.5-21.5-48-48-48H48C21.5 64 0 85.5 0 112v19c0 7.4 3.4 14.3 9.2 18.9 30.6 23.9 40.7 32.4 173.4 128.7 16.8 12.2 50.2 41.8 73.4 41.4z\"></path></svg>							</span>\n																				</div>\n					</div>\n						</div>\n						</div>\n				</div>\n				</div>\n					</div>\n				</div>\n		<div class=\"elementor-element elementor-element-95ebea8 elementor-hidden-desktop elementor-hidden-tablet e-flex e-con-boxed e-con e-parent\" data-id=\"95ebea8\" data-element_type=\"container\">\n					<div class=\"e-con-inner\">\n		<div class=\"elementor-element elementor-element-123fb1f e-con-full e-flex e-con e-child\" data-id=\"123fb1f\" data-element_type=\"container\">\n		<div class=\"elementor-element elementor-element-1b37cd3 e-con-full e-flex e-con e-child\" data-id=\"1b37cd3\" data-element_type=\"container\">\n				<div class=\"elementor-element elementor-element-837efb5 elementor-widget elementor-widget-shortcode\" data-id=\"837efb5\" data-element_type=\"widget\" data-widget_type=\"shortcode.default\">\n							<div class=\"elementor-shortcode\">    <div class=\"wp-applause-container\" data-post-id=\"7221\">\n        <button class=\"wp-applause-button\" data-post-id=\"7221\">\n            <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" aria-label=\"clap\"><path fill-rule=\"evenodd\" d=\"M11.37.828 12 3.282l.63-2.454zM13.916 3.953l1.523-2.112-1.184-.39zM8.589 1.84l1.522 2.112-.337-2.501zM18.523 18.92c-.86.86-1.75 1.246-2.62 1.33a6 6 0 0 0 .407-.372c2.388-2.389 2.86-4.951 1.399-7.623l-.912-1.603-.79-1.672c-.26-.56-.194-.98.203-1.288a.7.7 0 0 1 .546-.132c.283.046.546.231.728.5l2.363 4.157c.976 1.624 1.141 4.237-1.324 6.702m-10.999-.438L3.37 14.328a.828.828 0 0 1 .585-1.408.83.83 0 0 1 .585.242l2.158 2.157a.365.365 0 0 0 .516-.516l-2.157-2.158-1.449-1.449a.826.826 0 0 1 1.167-1.17l3.438 3.44a.363.363 0 0 0 .516 0 .364.364 0 0 0 0-.516L5.293 9.513l-.97-.97a.826.826 0 0 1 0-1.166.84.84 0 0 1 1.167 0l.97.968 3.437 3.436a.36.36 0 0 0 .517 0 .366.366 0 0 0 0-.516L6.977 7.83a.82.82 0 0 1-.241-.584.82.82 0 0 1 .824-.826c.219 0 .43.087.584.242l5.787 5.787a.366.366 0 0 0 .587-.415l-1.117-2.363c-.26-.56-.194-.98.204-1.289a.7.7 0 0 1 .546-.132c.283.046.545.232.727.501l2.193 3.86c1.302 2.38.883 4.59-1.277 6.75-1.156 1.156-2.602 1.627-4.19 1.367-1.418-.236-2.866-1.033-4.079-2.246M10.75 5.971l2.12 2.12c-.41.502-.465 1.17-.128 1.89l.22.465-3.523-3.523a.8.8 0 0 1-.097-.368c0-.22.086-.428.241-.584a.847.847 0 0 1 1.167 0m7.355 1.705c-.31-.461-.746-.758-1.23-.837a1.44 1.44 0 0 0-1.11.275c-.312.24-.505.543-.59.881a1.74 1.74 0 0 0-.906-.465 1.47 1.47 0 0 0-.82.106l-2.182-2.182a1.56 1.56 0 0 0-2.2 0 1.54 1.54 0 0 0-.396.701 1.56 1.56 0 0 0-2.21-.01 1.55 1.55 0 0 0-.416.753c-.624-.624-1.649-.624-2.237-.037a1.557 1.557 0 0 0 0 2.2c-.239.1-.501.238-.715.453a1.56 1.56 0 0 0 0 2.2l.516.515a1.556 1.556 0 0 0-.753 2.615L7.01 19c1.32 1.319 2.909 2.189 4.475 2.449q.482.08.971.08c.85 0 1.653-.198 2.393-.579.231.033.46.054.686.054 1.266 0 2.457-.52 3.505-1.567 2.763-2.763 2.552-5.734 1.439-7.586z\" clip-rule=\"evenodd\"></path></svg>\n        </button>\n        <span class=\"wp-applause-count\">69</span>\n    </div>\n    </div>\n						</div>\n				<div class=\"elementor-element elementor-element-5bf9dbd elementor-icon-list--layout-inline elementor-mobile-align-center elementor-list-item-link-full_width elementor-widget elementor-widget-icon-list\" data-id=\"5bf9dbd\" data-element_type=\"widget\" data-widget_type=\"icon-list.default\">\n							<ul class=\"elementor-icon-list-items elementor-inline-items\">\n							<li class=\"elementor-icon-list-item elementor-inline-item\">\n											<a href=\"#comments\">\n\n												<span class=\"elementor-icon-list-icon\">\n							<i aria-hidden=\"true\" class=\"huge huge-comment-01\"></i>						</span>\n										<span class=\"elementor-icon-list-text\"></span>\n											</a>\n									</li>\n								<li class=\"elementor-icon-list-item elementor-inline-item\">\n											<a href=\"#elementor-action%3Aaction%3Dpopup%3Aopen%26settings%3DeyJpZCI6IjYxOTMiLCJ0b2dnbGUiOmZhbHNlfQ%3D%3D\">\n\n												<span class=\"elementor-icon-list-icon\">\n							<i aria-hidden=\"true\" class=\"huge huge-share-05\"></i>						</span>\n										<span class=\"elementor-icon-list-text\"></span>\n											</a>\n									</li>\n						</ul>\n						</div>\n				</div>\n		<div class=\"elementor-element elementor-element-8608e80 e-con-full elementor-hidden-mobile e-flex e-con e-child\" data-id=\"8608e80\" data-element_type=\"container\">\n				<div class=\"elementor-element elementor-element-0bb15f1 elementor-share-buttons--view-icon elementor-share-buttons--skin-framed elementor-share-buttons--color-custom elementor-share-buttons--shape-square elementor-grid-0 elementor-widget elementor-widget-share-buttons\" data-id=\"0bb15f1\" data-element_type=\"widget\" data-widget_type=\"share-buttons.default\">\n							<div class=\"elementor-grid\" role=\"list\">\n								<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_facebook\" role=\"button\" tabindex=\"0\" aria-label=\"Share on facebook\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-facebook\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M504 256C504 119 393 8 256 8S8 119 8 256c0 123.78 90.69 226.38 209.25 245V327.69h-63V256h63v-54.64c0-62.15 37-96.48 93.67-96.48 27.14 0 55.52 4.84 55.52 4.84v61h-31.28c-30.8 0-40.41 19.12-40.41 38.73V256h68.78l-11 71.69h-57.78V501C413.31 482.38 504 379.78 504 256z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_x-twitter\" role=\"button\" tabindex=\"0\" aria-label=\"Share on x-twitter\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-x-twitter\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M389.2 48h70.6L305.6 224.2 487 464H345L233.7 318.6 106.5 464H35.8L200.7 275.5 26.8 48H172.4L272.9 180.9 389.2 48zM364.4 421.8h39.1L151.1 88h-42L364.4 421.8z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_pinterest\" role=\"button\" tabindex=\"0\" aria-label=\"Share on pinterest\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-pinterest\" viewBox=\"0 0 496 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M496 256c0 137-111 248-248 248-25.6 0-50.2-3.9-73.4-11.1 10.1-16.5 25.2-43.5 30.8-65 3-11.6 15.4-59 15.4-59 8.1 15.4 31.7 28.5 56.8 28.5 74.8 0 128.7-68.8 128.7-154.3 0-81.9-66.9-143.2-152.9-143.2-107 0-163.9 71.8-163.9 150.1 0 36.4 19.4 81.7 50.3 96.1 4.7 2.2 7.2 1.2 8.3-3.3.8-3.4 5-20.3 6.9-28.1.6-2.5.3-4.7-1.7-7.1-10.1-12.5-18.3-35.3-18.3-56.6 0-54.7 41.4-107.6 112-107.6 60.9 0 103.6 41.5 103.6 100.9 0 67.1-33.9 113.6-78 113.6-24.3 0-42.6-20.1-36.7-44.8 7-29.5 20.5-61.3 20.5-82.6 0-19-10.2-34.9-31.4-34.9-24.9 0-44.9 25.7-44.9 60.2 0 22 7.4 36.8 7.4 36.8s-24.5 103.8-29 123.2c-5 21.4-3 51.6-.9 71.2C65.4 450.9 0 361.1 0 256 0 119 111 8 248 8s248 111 248 248z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_linkedin\" role=\"button\" tabindex=\"0\" aria-label=\"Share on linkedin\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-linkedin\" viewBox=\"0 0 448 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M416 32H31.9C14.3 32 0 46.5 0 64.3v383.4C0 465.5 14.3 480 31.9 480H416c17.6 0 32-14.5 32-32.3V64.3c0-17.8-14.4-32.3-32-32.3zM135.4 416H69V202.2h66.5V416zm-33.2-243c-21.3 0-38.5-17.3-38.5-38.5S80.9 96 102.2 96c21.2 0 38.5 17.3 38.5 38.5 0 21.3-17.2 38.5-38.5 38.5zm282.1 243h-66.4V312c0-24.8-.5-56.7-34.5-56.7-34.6 0-39.9 27-39.9 54.9V416h-66.4V202.2h63.7v29.2h.9c8.9-16.8 30.6-34.5 62.9-34.5 67.2 0 79.7 44.3 79.7 101.9V416z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_reddit\" role=\"button\" tabindex=\"0\" aria-label=\"Share on reddit\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-reddit\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M201.5 305.5c-13.8 0-24.9-11.1-24.9-24.6 0-13.8 11.1-24.9 24.9-24.9 13.6 0 24.6 11.1 24.6 24.9 0 13.6-11.1 24.6-24.6 24.6zM504 256c0 137-111 248-248 248S8 393 8 256 119 8 256 8s248 111 248 248zm-132.3-41.2c-9.4 0-17.7 3.9-23.8 10-22.4-15.5-52.6-25.5-86.1-26.6l17.4-78.3 55.4 12.5c0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.3 24.9-24.9s-11.1-24.9-24.9-24.9c-9.7 0-18 5.8-22.1 13.8l-61.2-13.6c-3-.8-6.1 1.4-6.9 4.4l-19.1 86.4c-33.2 1.4-63.1 11.3-85.5 26.8-6.1-6.4-14.7-10.2-24.1-10.2-34.9 0-46.3 46.9-14.4 62.8-1.1 5-1.7 10.2-1.7 15.5 0 52.6 59.2 95.2 132 95.2 73.1 0 132.3-42.6 132.3-95.2 0-5.3-.6-10.8-1.9-15.8 31.3-16 19.8-62.5-14.9-62.5zM302.8 331c-18.2 18.2-76.1 17.9-93.6 0-2.2-2.2-6.1-2.2-8.3 0-2.5 2.5-2.5 6.4 0 8.6 22.8 22.8 87.3 22.8 110.2 0 2.5-2.2 2.5-6.1 0-8.6-2.2-2.2-6.1-2.2-8.3 0zm7.7-75c-13.6 0-24.6 11.1-24.6 24.9 0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.1 24.9-24.6 0-13.8-11-24.9-24.9-24.9z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_whatsapp\" role=\"button\" tabindex=\"0\" aria-label=\"Share on whatsapp\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-whatsapp\" viewBox=\"0 0 448 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M380.9 97.1C339 55.1 283.2 32 223.9 32c-122.4 0-222 99.6-222 222 0 39.1 10.2 77.3 29.6 111L0 480l117.7-30.9c32.4 17.7 68.9 27 106.1 27h.1c122.3 0 224.1-99.6 224.1-222 0-59.3-25.2-115-67.1-157zm-157 341.6c-33.2 0-65.7-8.9-94-25.7l-6.7-4-69.8 18.3L72 359.2l-4.4-7c-18.5-29.4-28.2-63.3-28.2-98.2 0-101.7 82.8-184.5 184.6-184.5 49.3 0 95.6 19.2 130.4 54.1 34.8 34.9 56.2 81.2 56.1 130.5 0 101.8-84.9 184.6-186.6 184.6zm101.2-138.2c-5.5-2.8-32.8-16.2-37.9-18-5.1-1.9-8.8-2.8-12.5 2.8-3.7 5.6-14.3 18-17.6 21.8-3.2 3.7-6.5 4.2-12 1.4-32.6-16.3-54-29.1-75.5-66-5.7-9.8 5.7-9.1 16.3-30.3 1.8-3.7.9-6.9-.5-9.7-1.4-2.8-12.5-30.1-17.1-41.2-4.5-10.8-9.1-9.3-12.5-9.5-3.2-.2-6.9-.2-10.6-.2-3.7 0-9.7 1.4-14.8 6.9-5.1 5.6-19.4 19-19.4 46.3 0 27.3 19.9 53.7 22.6 57.4 2.8 3.7 39.1 59.7 94.8 83.8 35.2 15.2 49 16.5 66.6 13.9 10.7-1.6 32.8-13.4 37.4-26.4 4.6-13 4.6-24.1 3.2-26.4-1.3-2.5-5-3.9-10.5-6.6z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_email\" role=\"button\" tabindex=\"0\" aria-label=\"Share on email\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fas-envelope\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M502.3 190.8c3.9-3.1 9.7-.2 9.7 4.7V400c0 26.5-21.5 48-48 48H48c-26.5 0-48-21.5-48-48V195.6c0-5 5.7-7.8 9.7-4.7 22.4 17.4 52.1 39.5 154.1 113.6 21.1 15.4 56.7 47.8 92.2 47.6 35.7.3 72-32.8 92.3-47.6 102-74.1 131.6-96.3 154-113.7zM256 320c23.2.4 56.6-29.2 73.4-41.4 132.7-96.3 142.8-104.7 173.4-128.7 5.8-4.5 9.2-11.5 9.2-18.9v-19c0-26.5-21.5-48-48-48H48C21.5 64 0 85.5 0 112v19c0 7.4 3.4 14.3 9.2 18.9 30.6 23.9 40.7 32.4 173.4 128.7 16.8 12.2 50.2 41.8 73.4 41.4z\"></path></svg>							</span>\n																				</div>\n					</div>\n						</div>\n						</div>\n				</div>\n				</div>\n					</div>\n				</div>\n				</div>\n		</div>\n						</div>\n					</div>\n				', 'Doctors and hospitals are slowly adopting AI in healthcare, but many still have doubts and concerns about how it will work. AI has already helped in many industries, from customer service chatbots to self-driving cars, but healthcare is different. I recently had a discussion with a medical professional at AIIMS, New Delhi, one of India’s top medical institutions. The topic? What are Doctors’ biggest concerns about adopting AI in healthcare? At BeyondChats, we’re redefining healthcare with AI—automating repetitive tasks, enhancing patient engagement, and giving doctors and nurses the freedom to focus on what truly matters: patient care. Our vision isn’t just about efficiency; it’s about transforming the future of healthcare. The doctor listened but was skeptical. They acknowledged the disruptive potential of AI but also raised some critical concerns that can’t be ignored. “Before we hand over the stethoscope to AI, let’s consider a few concerns,” they said. Here’s what we discussed. Doctor: ???????????????? ???????? ???????????????????????????????????????? ???????????? ???????????????????????????????????????????????? ???????? ???????????????????????????? ????????????????? Healthcare is not just about numbers, reports, and medical data, it is about people, emotions, and trust. AI might be great at analysing patterns and making predictions, but does it also grasp the individual needs of each patient? Every patient has a unique medical history, lifestyle, and personal preferences that impact their treatment. A doctor uses more than just data to make decisions— they rely on experience, intuition, and direct human interaction. My Thoughts: AI is a Support System I completely understand your concern. AI is still evolving, and healthcare is one of the most regulated and risk-averse industries—rightly so. However, we are already seeing people using AI for highly personal matters. Many people ask AI for advice on relationships, personal issues, or even mental health. AI assistants are being used to help plan daily tasks, provide reminders, and answer sensitive questions. AI-powered chatbots are assisting with basic medical queries in hospitals and clinics worldwide. If people are already trusting AI with such personal aspects of their lives, it is only a matter of time before they start expecting AI-powered digital assistants in every hospital and clinic. Startups like BeyondChats are working closely with hospitals to develop specialized AI models that are tailored to specific medical needs. These AI assistants are not aiming to replace doctors but will act as an additional layer of support—just like nurses, administrative staff, and help desks in hospitals today. In the future, hospitals will not just have nurses and front desk assistants—they will also have AI-driven digital assistants to help answer common patient questions, and provide quick, accurate medical guidance under a doctor’s supervision. This shift is not about replacing the human touch in medicine—it is about enhancing efficiency, freeing up doctors’ time, and ensuring patients get the right help much faster. Doctor: ???????????????? ???????? ???????? ???????????????????????? ???????????????? ???????????????????????????????? ???????????? ????????????????????????????? They explained that many doctors worry about having to double-check AI-generated reports, correct mistakes, and spend time learning new systems. If AI suggests incorrect or incomplete information, it could lead to even more administrative burdens. Instead of saving time, doctors fear they might have to review and edit AI-generated recommendations, leading to longer work hours rather than efficiency. There is also concern that new AI systems may require extensive training and adaptation, which could disrupt hospital workflows. My Thoughts: AI will save time, instead of being a burden I completely understand why your concern exists. Technology should simplify work, not make it harder. However, modern AI—especially Large Language Models (LLMs)—is very different from traditional AI systems. Here’s why: LLMs Understand Real-World Data Traditional AI models relied on pre-set rules and limited data. This meant doctors had to manually correct AI-generated outputs. LLMs, on the other hand, learn from vast medical datasets and continuously improve their accuracy over time. They can adapt to real-world patient interactions and clinical guidelines much better than older AI models. AI Agents Can Take Action, Not Just Provide Data Earlier AI systems only processed and presented information, but they couldn’t automate workflows. AI-powered assistants today can schedule appointments, summarize patient records, flag urgent cases, and provide structured insights—reducing manual tasks for doctors. AI Will Automate Repetitive Work, Not Increase It Many doctors and hospital staff spend hours on paperwork, patient history collection, and answering routine questions. AI-led hyper-focused healthcare solutions will handle administrative tasks, allowing doctors to focus on patient care instead of documentation. AI Adapts to the Doctor’s Workflow, Not the Other Way Around The biggest fear is that doctors will have to change their entire way of working to fit into AI-driven systems. But smart AI assistants like BeyondChats are designed to integrate seamlessly into existing hospital software, requiring minimal adjustment from doctors. Doctor: ???????????? ???????? ???????? ???????????????????????????????? ???????????????????????????? ????????????????????? Patients trust their doctors not just because of their medical knowledge, but because of human connection. A doctor listens to their concerns, understands their emotions, and builds a relationship over time. Trust in healthcare is deeply personal. Patients rely on their doctors because they know that behind every diagnosis and treatment plan, there is a real person who cares about their well-being. So, if AI starts playing a bigger role in healthcare, how do we ensure that patients trust AI-assisted decisions just as they trust human doctors? Will patients feel comfortable relying on a digital system instead of a real conversation with their doctor? My Thoughts: AI will become a trusted partner for doctors The key to building trust in AI in healthcare is transparency, reliability, and collaboration with doctors. AI Needs to Be Transparent and Explainable Patients will naturally be skeptical if AI works as a “black box,” providing recommendations without clear reasoning. AI must be able to explain why it makes certain suggestions in simple terms, helping both patients and doctors understand its reasoning. AI Should Assist When AI is used to support doctors—rather than act as a standalone system—patients will be more likely to trust AI-backed recommendations. Trust Comes from Proven Results The more AI helps doctors improve patient outcomes, the more it will be seen as a valuable part of healthcare. Over time, as AI continues to assist doctors in making accurate diagnoses, suggesting better treatments, and reducing errors, patients will naturally trust its role in their care. Personalized and Faster Patient Care AI enables more personalized healthcare by analyzing patient history, preferences, and symptoms instantly. Instead of replacing human interactions, AI can ensure that doctors spend more time on critical cases while AI in healthcare handles routine queries. This faster, smarter system will improve patient experience, making AI a trusted extension of the medical team. Doctor: ???????????????? ???????????????????????????????? ???????????? ???????????????????????????? ???????????????????????????????? Healthcare data is extremely sensitive—it contains personal medical histories, diagnoses, treatment plans, and sometimes even psychological or genetic information. If this data falls into the wrong hands, it can lead to serious ethical, legal, and financial consequences. With AI systems like OpenAI and Gemini processing large amounts of data, there’s a fear that patient records could be exposed, misused, or even sold without consent. The risk isn’t just about cybercriminals hacking into hospital databases—it’s also about how AI companies store and process this data. If AI in healthcare is to be trusted, how do we ensure patient data is protected while still using AI to improve medical care? My Thoughts: Security Must Be Built into AI from Day One Data security is a real concern, and it should never be taken lightly. However, as AI and cybersecurity continue to advance, we now have stronger measures than ever before to ensure healthcare data remains safe. AI in healthcare are build with Strong Encryption and Security Standards Robust encryption protocols ensure that patient data is stored and transmitted securely. Hospitals and healthcare providers must use end-to-end encryption, so even if data is intercepted, it remains unreadable. AI in Healthcare don’t Use Open Data Models General AI models like OpenAI and Gemini train on vast amounts of user data, but healthcare AI should be different. Companies like Beyondchats are building Healthcare-specific AI models. And these are trained in a secure, closed environment where patient data is never exposed to the public internet. Collaboration Between Tech and Healthcare Professionals Doctors and hospital administrators must work closely with AI developers to define clear boundaries for data usage. AI should only access data necessary for its task and should never store or use patient data beyond what is required for medical purposes. Patients Must Have Control Over Their Data Transparency is key—patients should always know when AI is being used and what data it is processing. Patients should have the option to opt-out of AI-based recommendations or data sharing if they choose. AI in healthcare is empowering healthcare providers. If done right, AI can be both a powerful medical tool and a secure guardian of patient data. Conclusion: Collaboration is the Key to AI’s Success in Healthcare For AI to revolutionize healthcare, it must be built in collaboration with medical professionals. This means: Listening to doctors and nurses to understand their pain points. Designing AI tools that are practical, user-friendly, and effective. Ensuring data privacy and security to build trust in AI systems. At BeyondChats, we don’t see AI as a standalone technology—we see it as a partner in healthcare. We have created AI solutions that assist hospitals, support medical teams, and enhance patient experiences. The future of healthcare is not AI replacing doctors—it’s AI working hand in hand with them to create a smarter, more efficient, and more accessible healthcare system. 69', NULL, '2025-03-20 18:30:00', 'https://beyondchats.com/blogs/ai-in-healthcare-hype-or-reality/', 0, NULL, NULL, '2025-12-30 13:04:58', '2025-12-30 13:04:58', 'General');
INSERT INTO `articles` (`id`, `title`, `original_content_html`, `original_content_text`, `author`, `published_date`, `source_url`, `is_updated`, `updated_content`, `references`, `created_at`, `updated_at`, `category`) VALUES
(2, 'What If AI Recommends the Wrong Medicine – Who’s to Blame?', '\n					<div class=\"e-con-inner\">\n				<div class=\"elementor-element elementor-element-b2a436b elementor-widget elementor-widget-theme-post-content\" data-id=\"b2a436b\" data-element_type=\"widget\" data-widget_type=\"theme-post-content.default\">\n					\n<h4 class=\"wp-block-heading has-large-font-size\"><strong>Introduction: The Unspoken Fear</strong></h4>\n\n\n\n<p>AI is changing the world fast. In many industries, it’s already improving speed, accuracy, and efficiency. In healthcare, the potential is massive. From reducing paperwork to helping with diagnosis, AI promises to save time and support doctors.</p>\n\n\n\n<p>But there’s a fear no one is talking about openly:</p>\n\n\n\n<blockquote class=\"wp-block-quote is-layout-flow wp-block-quote-is-layout-flow\">\n<p><strong>“What if the AI gives the wrong recommendation? Who will be blamed?”</strong></p>\n</blockquote>\n\n\n\n<p>It’s a fair question. Because healthcare isn’t like choosing a movie on Netflix. If a streaming app suggests a bad movie, the worst that happens is you waste two hours. But if an AI system suggests the wrong medicine, <strong>the consequences can be serious—even life-threatening.</strong></p>\n\n\n\n<p>This is the reason many doctors hesitate to bring AI into their clinics. Not because they don’t see the benefits, but because they’re unsure what happens <strong>if something goes wrong</strong>.</p>\n\n\n\n<p>In this blog, we’ll talk honestly about this concern. </p>\n\n\n\n<figure class=\"wp-block-image size-large\"><a href=\"https://beyondchats.com/wp-content/uploads/2025/03/Ai-as-a-doctor.jpg\"><img fetchpriority=\"high\" decoding=\"async\" width=\"1024\" height=\"538\" src=\"https://beyondchats.com/wp-content/uploads/2025/03/Ai-as-a-doctor-1024x538.jpg\" alt=\"AI is seen wearing a stethoscope in the hospital with nurses, medicine and the hospital equipments.\" class=\"wp-image-7247\" srcset=\"https://beyondchats.com/wp-content/uploads/2025/03/Ai-as-a-doctor-1024x538.jpg 1024w, https://beyondchats.com/wp-content/uploads/2025/03/Ai-as-a-doctor-300x158.jpg 300w, https://beyondchats.com/wp-content/uploads/2025/03/Ai-as-a-doctor-768x403.jpg 768w, https://beyondchats.com/wp-content/uploads/2025/03/Ai-as-a-doctor-600x315.jpg 600w, https://beyondchats.com/wp-content/uploads/2025/03/Ai-as-a-doctor.jpg 1200w\" sizes=\"(max-width: 1024px) 100vw, 1024px\"></a></figure>\n\n\n\n<p>Who’s responsible? How can you use AI safely? And most importantly how can you take advantage of AI without putting your license or your patients at risk?</p>\n\n\n\n<p>Let’s get into it.</p>\n\n\n\n<h4 class=\"wp-block-heading has-large-font-size\"><strong>How AI Works in Clinical Settings (and Where It Doesn’t)</strong></h4>\n\n\n\n<p>Before getting into liability, let’s understand what AI actually <em>can do</em> in clinics today and more importantly, what it won’t do.</p>\n\n\n\n<p>Most AI tools in healthcare are assistive, not autonomous.</p>\n\n\n\n<p>They don’t make final decisions. They support the existing processes at your clinic.</p>\n\n\n\n<p>For example:</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li><strong>AI-powered chatbots</strong> can answer general user queries, guide patients to book appointments, and help them understand pre-visit instructions.</li>\n\n\n\n<li><strong>Clinical decision support tools</strong> can highlight drug interactions or suggest possible diagnoses based on symptoms and test results.</li>\n\n\n\n<li><strong>Natural language processing (NLP)</strong> models can summarize patient notes, extract relevant information from records, and help doctors document faster.</li>\n\n\n\n<li><strong>Predictive algorithms</strong> may flag high-risk patients for follow-ups or recommend screening tests.</li>\n</ul>\n\n\n\n<p>But here’s the key: <strong>AI is not replacing clinical judgment.</strong> At least not in regulated, real-world use cases.</p>\n\n\n\n<p>The final responsibility to prescribe, diagnose, or act on AI recommendations still lies with the doctor.</p>\n\n\n\n<p>That said, the lines can get blurry when AI recommendations feel authoritative or when time pressure leads to over-reliance.</p>\n\n\n\n<p>Let’s say:</p>\n\n\n\n<p>An AI assistant suggests a medication. The doctor, overwhelmed with back-to-back patients, accepts the recommendation without verifying. The patient has an allergy and suffers a reaction.</p>\n\n\n\n<p>Now, was it the AI’s fault?</p>\n\n\n\n<p>Not quite. Because AI is not the licensed medical professional.</p>\n\n\n\n<p>But this is where it gets complicated and where systems, laws, and common sense need to work together.</p>\n\n\n\n<p>Let’s explore that next.</p>\n\n\n\n<h4 class=\"wp-block-heading has-large-font-size\"><strong>Who Is Legally Responsible if AI Gets It Wrong?</strong></h4>\n\n\n\n<p>This is the core concern many doctors raise and rightly so.</p>\n\n\n\n<p>If an AI tool suggests a wrong medication, and a patient is harmed, <em>who</em> is accountable?</p>\n\n\n\n<p>Let’s unpack it without the legal jargon.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>1. Doctors Are Still the Final Authority</strong></h4>\n\n\n\n<p>In most countries, AI tools in healthcare are classified as <strong>“decision support systems”</strong> not autonomous decision-makers.</p>\n\n\n\n<p>That means:</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li>The doctor is the one prescribing the medicine.</li>\n\n\n\n<li>The doctor is the one signing off on the treatment plan.</li>\n\n\n\n<li>And yes, if something goes wrong, the doctor is still liable.</li>\n</ul>\n\n\n\n<p>It’s not because AI can’t be useful, it’s because <strong>medical licenses are issued to people, not software.</strong></p>\n\n\n\n<p>In India, the <a href=\"https://esanjeevani.mohfw.gov.in/assets/guidelines/Telemedicine_Practice_Guidelines.pdf\" target=\"_blank\" rel=\"noopener\"><strong>Telemedicine Practice Guidelines</strong></a> (issued by the Ministry of Health and Family Welfare, 2020) clearly state:</p>\n\n\n\n<p>“The final responsibility of diagnosis and prescription lies with the registered medical practitioner.”</p>\n\n\n\n<p>The same principle applies under <a href=\"https://www.hhs.gov/hipaa/for-professionals/privacy/laws-regulations/index.html\" target=\"_blank\" rel=\"noopener\"><strong>HIPAA</strong></a><strong> in the U.S.</strong>, <a href=\"https://gdpr-info.eu/\" target=\"_blank\" rel=\"noopener\"><strong>GDPR</strong></a><strong> in Europe</strong>, and <a href=\"https://www.makeinindia.com/national-digital-health-mission\" target=\"_blank\" rel=\"noopener\"><strong>NDHM</strong></a><strong> (now ABDM) in India</strong>: AI tools must support—not replace—medical professionals.</p>\n\n\n\n<p>Also, If an AI assistant gives an incorrect recommendation directly to a patient such as suggesting the wrong medicine or misguiding them about a symptom the responsibility can become more complex. However, in most current legal frameworks, unless the AI is officially classified and regulated as a medical device, the liability often still circles back to the healthcare provider or institution overseeing its deployment.</p>\n\n\n\n<p>But here’s where things are changing.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>2. Shared Accountability Is Emerging</strong></h4>\n\n\n\n<p>In recent years, there’s been a growing debate: If AI is so advanced, shouldn’t the developers, vendors, or hospitals share responsibility too?</p>\n\n\n\n<p>That’s starting to happen.</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Some hospitals are now requiring <strong>AI vendors</strong> to include <strong>indemnity clauses</strong> in contracts.</li>\n\n\n\n<li>Regulators like the <strong>FDA (U.S.)</strong> and <strong>EMA (Europe)</strong> are evaluating how to classify AI tools as “medical devices”—which means they’ll need to meet strict safety and performance standards before deployment.</li>\n\n\n\n<li>In India, as the Ayushman Bharat Digital Mission expands, discussions around data privacy, clinical safety, and AI accountability are getting more attention.</li>\n</ul>\n\n\n\n<p>The future of AI in healthcare is moving toward shared responsibility. As AI tools become more common, especially in commercial use, developers and hospitals may also be held accountable. The goal is to avoid placing all the blame on doctors alone.</p>\n\n\n\n<h4 class=\"wp-block-heading has-large-font-size\"><strong>What Should Doctors Ask Before Using Any AI Tool in Their Clinic?</strong></h4>\n\n\n\n<p>Not all AI tools are the same. Some tools are helpful and safe. Others are poorly tested, overhyped, or just not made for real clinical environments.</p>\n\n\n\n<p>If you’re considering AI for your clinic, here are <strong>5 key questions</strong> to ask—without needing a legal team or tech background.</p>\n\n\n\n<hr class=\"wp-block-separator has-alpha-channel-opacity\">\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>1. Is the AI tool medically validated?</strong></h4>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Has it been tested in real clinics or hospitals?</li>\n\n\n\n<li>Are there peer-reviewed studies or user testimonials from other doctors?</li>\n</ul>\n\n\n\n<p>Don’t just take the vendor’s word for it—look for other customers’ validation.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>2. How does it handle sensitive patient data?</strong></h4>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Is patient data stored locally or sent to the cloud?</li>\n\n\n\n<li>Is the data encrypted and anonymized?</li>\n\n\n\n<li>Does it comply with <strong>NDHM/ABDM</strong> (India), <strong>HIPAA</strong> (US), or <strong>GDPR</strong> (Europe)?</li>\n</ul>\n\n\n\n<p>You’re still responsible for your patient’s privacy even if the AI tool is the one collecting data.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>3. Will it integrate with my existing workflow?</strong></h4>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Does it work with your current EMR or appointment system?</li>\n\n\n\n<li>Will your staff need hours of training to use it?</li>\n\n\n\n<li>Can it automate tasks <em>without</em> disrupting patient flow?</li>\n</ul>\n\n\n\n<p>A good AI tool should <strong>save time, not create new work</strong>.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>4. Can I easily override or edit its suggestions?</strong></h4>\n\n\n\n<ul class=\"wp-block-list\">\n<li>You should never feel like you have to follow what the AI says.</li>\n\n\n\n<li>Look for tools that support—not replace—your clinical judgment.</li>\n</ul>\n\n\n\n<p>You’re the doctor. The AI is the assistant, not the other way around.</p>\n\n\n\n<h3 class=\"wp-block-heading has-large-font-size\"><strong>What Can Doctors Do Today to Use AI Safely in Their Practice?</strong></h3>\n\n\n\n<p>You don’t need to wait for perfect regulation or 100% flawless tools. Many clinics are already using AI safely and getting real results.</p>\n\n\n\n<figure class=\"wp-block-embed is-type-video is-provider-youtube wp-block-embed-youtube wp-embed-aspect-16-9 wp-has-aspect-ratio\"><div class=\"wp-block-embed__wrapper\">\n<iframe title=\"The future of AI in medicine and what it means for physicians and practices with Tom Lawry\" width=\"1290\" height=\"726\" src=\"https://www.youtube.com/embed/MQN3AABMIzU?feature=oembed\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" referrerpolicy=\"strict-origin-when-cross-origin\" allowfullscreen=\"\"></iframe>\n</div><figcaption class=\"wp-element-caption\">The future of AI in medicine and what it means for physicians and practices with Tom Lawry</figcaption></figure>\n\n\n\n<p>Here’s what you can start doing right now:</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>1. Use AI for low-risk, repetitive tasks first</strong></h4>\n\n\n\n<p>Start with areas where mistakes are unlikely to cause harm:</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Appointment reminders</li>\n\n\n\n<li>Answering common patient questions</li>\n\n\n\n<li>Collecting patient history</li>\n\n\n\n<li>Sending pre-visit instructions</li>\n</ul>\n\n\n\n<p>These use cases save your team hours without touching medical decisions.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>2. Always keep human oversight in place</strong></h4>\n\n\n\n<p>No matter how smart the AI seems—don’t leave it unsupervised.</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Review any medical suggestion made by the AI</li>\n\n\n\n<li>Ensure nurses or admins double-check responses frequently</li>\n\n\n\n<li>Use AI as a draft generator, not a final decision-maker</li>\n</ul>\n\n\n\n<p>You remain the final authority. Always.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>3. Involve your team in the process</strong></h4>\n\n\n\n<p>Doctors, nurses, receptionists—everyone who uses the AI tool should have a say.</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Ask what’s working and what’s not</li>\n\n\n\n<li>Encourage feedback on AI mistakes or blind spots</li>\n\n\n\n<li>Make sure everyone knows when to escalate to a human expert</li>\n</ul>\n\n\n\n<p>The goal is not just tech adoption—it’s smarter team collaboration.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>4. Be transparent with patients (when needed)</strong></h4>\n\n\n\n<p>If AI is being used to respond to queries or collect symptoms:</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Let patients know it’s an automated system</li>\n\n\n\n<li>Reassure them that a human is still reviewing their case</li>\n\n\n\n<li>Give them the option to speak to a doctor directly</li>\n</ul>\n\n\n\n<p>This builds trust—and protects your clinic.</p>\n\n\n\n<h3 class=\"wp-block-heading has-large-font-size\"><strong>Why Doctors Will Always Remain Essential—No Matter How Smart AI Gets</strong></h3>\n\n\n\n<p>With all the talk about AI taking over, it’s easy to feel uncertain. But let’s take a step back and remember: AI might be fast, but it doesn’t replace what makes doctors truly valuable.</p>\n\n\n\n<p>Here’s why your role isn’t just safe, it’s irreplaceable.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>1. Medicine is about people, not just data</strong></h4>\n\n\n\n<p>AI can read reports.<br>It can process symptoms.<br>But it can’t sit across from a patient, notice the anxiety in their eyes, and say the right words to comfort them.</p>\n\n\n\n<p>That human connection?<br>That’s where healing often begins—and AI can’t replicate it.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>2. Your clinical judgment is built on years of training and experience</strong></h4>\n\n\n\n<p>AI can suggest a diagnosis.<br>But it doesn’t know your patient’s full story, the nuance in their symptoms, or what you’ve learned from years of seeing similar cases.</p>\n\n\n\n<p>You make decisions based not just on data—but on patterns, context, and real-life experience.<br>That’s something no algorithm can fully understand.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>3. Patients still want a human in charge</strong></h4>\n\n\n\n<p>Even if AI gets better at diagnosis or documentation, studies show patients still want to talk to a real doctor.<br>They want to know someone cares. That someone is responsible. That someone understands.</p>\n\n\n\n<p>You are the face of trust in healthcare.<br>And that doesn’t change—whether there’s AI in the room or not.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>4. AI still needs direction, limits, and supervision</strong></h4>\n\n\n\n<p>AI is like a powerful medical tool—just like an MRI or ultrasound machine.<br>It’s only as useful as the person using it.</p>\n\n\n\n<p>And in clinics, that person will always be you.</p>\n\n\n\n<p>Your role is shifting—not shrinking.<br>You’re no longer just diagnosing or prescribing; you’re leading the smart systems that support patient care.</p>\n\n\n\n<h4 class=\"wp-block-heading has-large-font-size\"><strong>Final Thoughts: Blame, Trust, and the Role of Doctors in an AI-Driven Future</strong></h4>\n\n\n\n<p>So, what happens if AI suggests the wrong medicine?</p>\n\n\n\n<p>The short answer: <strong>Doctors are still in charge, and hence responsible.</strong></p>\n\n\n\n<p>Even as AI tools become more advanced, healthcare decisions, especially ones involving medication—will continue to require human supervision. Doctors won’t just “use” AI. They’ll <strong>guide</strong> it, <strong>question</strong> it, and <strong>override</strong> it when necessary.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>So, where does that leave us?</strong></h4>\n\n\n\n<p>If used responsibly, AI won’t introduce risk—it’ll reduce it. It can:</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Help filter patient information quickly</li>\n\n\n\n<li>Flag inconsistencies or high-risk cases</li>\n\n\n\n<li>Reduce time spent on routine documentation</li>\n\n\n\n<li>Offer reminders, summaries, or decision-support tools</li>\n</ul>\n\n\n\n<p>And that’s where platforms like <strong>BeyondChats</strong> come in.</p>\n\n\n\n<p>At <strong>BeyondChats</strong>, we build AI-powered assistants for clinics and hospitals—not to replace staff, but to <strong>take over repetitive admin tasks</strong>, guide patients with common queries, and help surface actionable insights for the medical team. Our systems are <strong>custom-built for healthcare workflows</strong> and are always designed to keep the <strong>doctor in control</strong>.</p>\n\n\n\n<p>We understand the concerns around liability, patient safety, and professional autonomy—and we build with those priorities in mind.</p>\n\n\n\n<h4 class=\"wp-block-heading has-large-font-size\"><strong>The future of medicine isn’t AI vs. doctors.</strong></h4>\n\n\n\n<p>It’s <strong>AI </strong><strong><em>and</em></strong><strong> doctors</strong>, working together.</p>\n\n\n\n<p>Let AI handle the paperwork. Let it track patient follow-ups, qualify your patients, and answer basic questions.</p>\n\n\n\n<p>But when it comes to life, health, and healing—<strong>that’s still your call.</strong></p>\n\n\n\n<p>And it always will be.</p>\n\n\n\n<p>AI is a tool.<br>But doctors? You are—and always will be—the decision-makers in healthcare.</p>\n<div class=\"has-social-placeholder has-content-area\" data-url=\"https://beyondchats.com/blogs/what-if-ai-recommends-the-wrong-medicine-whos-to-blame/\" data-title=\"What If AI Recommends the Wrong Medicine – Who’s to Blame?\" data-hashtags=\"\" data-post-id=\"7245\"></div>				</div>\n				<div class=\"elementor-element elementor-element-106752c elementor-widget elementor-widget-shortcode\" data-id=\"106752c\" data-element_type=\"widget\" data-widget_type=\"shortcode.default\">\n							<div class=\"elementor-shortcode\">		<div data-elementor-type=\"container\" data-elementor-id=\"6196\" class=\"elementor elementor-6196\" data-elementor-post-type=\"elementor_library\">\n				<div class=\"elementor-element elementor-element-af06f6b elementor-hidden-mobile e-flex e-con-boxed e-con e-parent\" data-id=\"af06f6b\" data-element_type=\"container\">\n					<div class=\"e-con-inner\">\n		<div class=\"elementor-element elementor-element-190a40c e-con-full e-flex e-con e-child\" data-id=\"190a40c\" data-element_type=\"container\">\n		<div class=\"elementor-element elementor-element-21c23ec e-con-full e-flex e-con e-child\" data-id=\"21c23ec\" data-element_type=\"container\">\n				<div class=\"elementor-element elementor-element-30984ea elementor-widget elementor-widget-shortcode\" data-id=\"30984ea\" data-element_type=\"widget\" data-widget_type=\"shortcode.default\">\n							<div class=\"elementor-shortcode\">    <div class=\"wp-applause-container\" data-post-id=\"7245\">\n        <button class=\"wp-applause-button\" data-post-id=\"7245\">\n            <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" aria-label=\"clap\"><path fill-rule=\"evenodd\" d=\"M11.37.828 12 3.282l.63-2.454zM13.916 3.953l1.523-2.112-1.184-.39zM8.589 1.84l1.522 2.112-.337-2.501zM18.523 18.92c-.86.86-1.75 1.246-2.62 1.33a6 6 0 0 0 .407-.372c2.388-2.389 2.86-4.951 1.399-7.623l-.912-1.603-.79-1.672c-.26-.56-.194-.98.203-1.288a.7.7 0 0 1 .546-.132c.283.046.546.231.728.5l2.363 4.157c.976 1.624 1.141 4.237-1.324 6.702m-10.999-.438L3.37 14.328a.828.828 0 0 1 .585-1.408.83.83 0 0 1 .585.242l2.158 2.157a.365.365 0 0 0 .516-.516l-2.157-2.158-1.449-1.449a.826.826 0 0 1 1.167-1.17l3.438 3.44a.363.363 0 0 0 .516 0 .364.364 0 0 0 0-.516L5.293 9.513l-.97-.97a.826.826 0 0 1 0-1.166.84.84 0 0 1 1.167 0l.97.968 3.437 3.436a.36.36 0 0 0 .517 0 .366.366 0 0 0 0-.516L6.977 7.83a.82.82 0 0 1-.241-.584.82.82 0 0 1 .824-.826c.219 0 .43.087.584.242l5.787 5.787a.366.366 0 0 0 .587-.415l-1.117-2.363c-.26-.56-.194-.98.204-1.289a.7.7 0 0 1 .546-.132c.283.046.545.232.727.501l2.193 3.86c1.302 2.38.883 4.59-1.277 6.75-1.156 1.156-2.602 1.627-4.19 1.367-1.418-.236-2.866-1.033-4.079-2.246M10.75 5.971l2.12 2.12c-.41.502-.465 1.17-.128 1.89l.22.465-3.523-3.523a.8.8 0 0 1-.097-.368c0-.22.086-.428.241-.584a.847.847 0 0 1 1.167 0m7.355 1.705c-.31-.461-.746-.758-1.23-.837a1.44 1.44 0 0 0-1.11.275c-.312.24-.505.543-.59.881a1.74 1.74 0 0 0-.906-.465 1.47 1.47 0 0 0-.82.106l-2.182-2.182a1.56 1.56 0 0 0-2.2 0 1.54 1.54 0 0 0-.396.701 1.56 1.56 0 0 0-2.21-.01 1.55 1.55 0 0 0-.416.753c-.624-.624-1.649-.624-2.237-.037a1.557 1.557 0 0 0 0 2.2c-.239.1-.501.238-.715.453a1.56 1.56 0 0 0 0 2.2l.516.515a1.556 1.556 0 0 0-.753 2.615L7.01 19c1.32 1.319 2.909 2.189 4.475 2.449q.482.08.971.08c.85 0 1.653-.198 2.393-.579.231.033.46.054.686.054 1.266 0 2.457-.52 3.505-1.567 2.763-2.763 2.552-5.734 1.439-7.586z\" clip-rule=\"evenodd\"></path></svg>\n        </button>\n        <span class=\"wp-applause-count\">11</span>\n    </div>\n    </div>\n						</div>\n				<div class=\"elementor-element elementor-element-36e02a7 elementor-position-right elementor-mobile-position-left elementor-view-default elementor-widget elementor-widget-icon-box\" data-id=\"36e02a7\" data-element_type=\"widget\" data-widget_type=\"icon-box.default\">\n							<div class=\"elementor-icon-box-wrapper\">\n\n						<div class=\"elementor-icon-box-icon\">\n				<a href=\"#comments\" class=\"elementor-icon\" tabindex=\"-1\">\n				<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-far-comments\" viewBox=\"0 0 576 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M532 386.2c27.5-27.1 44-61.1 44-98.2 0-80-76.5-146.1-176.2-157.9C368.3 72.5 294.3 32 208 32 93.1 32 0 103.6 0 192c0 37 16.5 71 44 98.2-15.3 30.7-37.3 54.5-37.7 54.9-6.3 6.7-8.1 16.5-4.4 25 3.6 8.5 12 14 21.2 14 53.5 0 96.7-20.2 125.2-38.8 9.2 2.1 18.7 3.7 28.4 4.9C208.1 407.6 281.8 448 368 448c20.8 0 40.8-2.4 59.8-6.8C456.3 459.7 499.4 480 553 480c9.2 0 17.5-5.5 21.2-14 3.6-8.5 1.9-18.3-4.4-25-.4-.3-22.5-24.1-37.8-54.8zm-392.8-92.3L122.1 305c-14.1 9.1-28.5 16.3-43.1 21.4 2.7-4.7 5.4-9.7 8-14.8l15.5-31.1L77.7 256C64.2 242.6 48 220.7 48 192c0-60.7 73.3-112 160-112s160 51.3 160 112-73.3 112-160 112c-16.5 0-33-1.9-49-5.6l-19.8-4.5zM498.3 352l-24.7 24.4 15.5 31.1c2.6 5.1 5.3 10.1 8 14.8-14.6-5.1-29-12.3-43.1-21.4l-17.1-11.1-19.9 4.6c-16 3.7-32.5 5.6-49 5.6-54 0-102.2-20.1-131.3-49.7C338 339.5 416 272.9 416 192c0-3.4-.4-6.7-.7-10C479.7 196.5 528 238.8 528 288c0 28.7-16.2 50.6-29.7 64z\"></path></svg>				</a>\n			</div>\n			\n			\n		</div>\n						</div>\n				</div>\n		<div class=\"elementor-element elementor-element-82f4de6 e-con-full elementor-hidden-mobile e-flex e-con e-child\" data-id=\"82f4de6\" data-element_type=\"container\">\n				<div class=\"elementor-element elementor-element-cea0a0c elementor-share-buttons--view-icon elementor-share-buttons--skin-framed elementor-share-buttons--color-custom elementor-share-buttons--shape-square elementor-grid-0 elementor-widget elementor-widget-share-buttons\" data-id=\"cea0a0c\" data-element_type=\"widget\" data-widget_type=\"share-buttons.default\">\n							<div class=\"elementor-grid\" role=\"list\">\n								<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_facebook\" role=\"button\" tabindex=\"0\" aria-label=\"Share on facebook\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-facebook\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M504 256C504 119 393 8 256 8S8 119 8 256c0 123.78 90.69 226.38 209.25 245V327.69h-63V256h63v-54.64c0-62.15 37-96.48 93.67-96.48 27.14 0 55.52 4.84 55.52 4.84v61h-31.28c-30.8 0-40.41 19.12-40.41 38.73V256h68.78l-11 71.69h-57.78V501C413.31 482.38 504 379.78 504 256z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_x-twitter\" role=\"button\" tabindex=\"0\" aria-label=\"Share on x-twitter\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-x-twitter\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M389.2 48h70.6L305.6 224.2 487 464H345L233.7 318.6 106.5 464H35.8L200.7 275.5 26.8 48H172.4L272.9 180.9 389.2 48zM364.4 421.8h39.1L151.1 88h-42L364.4 421.8z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_pinterest\" role=\"button\" tabindex=\"0\" aria-label=\"Share on pinterest\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-pinterest\" viewBox=\"0 0 496 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M496 256c0 137-111 248-248 248-25.6 0-50.2-3.9-73.4-11.1 10.1-16.5 25.2-43.5 30.8-65 3-11.6 15.4-59 15.4-59 8.1 15.4 31.7 28.5 56.8 28.5 74.8 0 128.7-68.8 128.7-154.3 0-81.9-66.9-143.2-152.9-143.2-107 0-163.9 71.8-163.9 150.1 0 36.4 19.4 81.7 50.3 96.1 4.7 2.2 7.2 1.2 8.3-3.3.8-3.4 5-20.3 6.9-28.1.6-2.5.3-4.7-1.7-7.1-10.1-12.5-18.3-35.3-18.3-56.6 0-54.7 41.4-107.6 112-107.6 60.9 0 103.6 41.5 103.6 100.9 0 67.1-33.9 113.6-78 113.6-24.3 0-42.6-20.1-36.7-44.8 7-29.5 20.5-61.3 20.5-82.6 0-19-10.2-34.9-31.4-34.9-24.9 0-44.9 25.7-44.9 60.2 0 22 7.4 36.8 7.4 36.8s-24.5 103.8-29 123.2c-5 21.4-3 51.6-.9 71.2C65.4 450.9 0 361.1 0 256 0 119 111 8 248 8s248 111 248 248z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_linkedin\" role=\"button\" tabindex=\"0\" aria-label=\"Share on linkedin\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-linkedin\" viewBox=\"0 0 448 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M416 32H31.9C14.3 32 0 46.5 0 64.3v383.4C0 465.5 14.3 480 31.9 480H416c17.6 0 32-14.5 32-32.3V64.3c0-17.8-14.4-32.3-32-32.3zM135.4 416H69V202.2h66.5V416zm-33.2-243c-21.3 0-38.5-17.3-38.5-38.5S80.9 96 102.2 96c21.2 0 38.5 17.3 38.5 38.5 0 21.3-17.2 38.5-38.5 38.5zm282.1 243h-66.4V312c0-24.8-.5-56.7-34.5-56.7-34.6 0-39.9 27-39.9 54.9V416h-66.4V202.2h63.7v29.2h.9c8.9-16.8 30.6-34.5 62.9-34.5 67.2 0 79.7 44.3 79.7 101.9V416z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_reddit\" role=\"button\" tabindex=\"0\" aria-label=\"Share on reddit\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-reddit\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M201.5 305.5c-13.8 0-24.9-11.1-24.9-24.6 0-13.8 11.1-24.9 24.9-24.9 13.6 0 24.6 11.1 24.6 24.9 0 13.6-11.1 24.6-24.6 24.6zM504 256c0 137-111 248-248 248S8 393 8 256 119 8 256 8s248 111 248 248zm-132.3-41.2c-9.4 0-17.7 3.9-23.8 10-22.4-15.5-52.6-25.5-86.1-26.6l17.4-78.3 55.4 12.5c0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.3 24.9-24.9s-11.1-24.9-24.9-24.9c-9.7 0-18 5.8-22.1 13.8l-61.2-13.6c-3-.8-6.1 1.4-6.9 4.4l-19.1 86.4c-33.2 1.4-63.1 11.3-85.5 26.8-6.1-6.4-14.7-10.2-24.1-10.2-34.9 0-46.3 46.9-14.4 62.8-1.1 5-1.7 10.2-1.7 15.5 0 52.6 59.2 95.2 132 95.2 73.1 0 132.3-42.6 132.3-95.2 0-5.3-.6-10.8-1.9-15.8 31.3-16 19.8-62.5-14.9-62.5zM302.8 331c-18.2 18.2-76.1 17.9-93.6 0-2.2-2.2-6.1-2.2-8.3 0-2.5 2.5-2.5 6.4 0 8.6 22.8 22.8 87.3 22.8 110.2 0 2.5-2.2 2.5-6.1 0-8.6-2.2-2.2-6.1-2.2-8.3 0zm7.7-75c-13.6 0-24.6 11.1-24.6 24.9 0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.1 24.9-24.6 0-13.8-11-24.9-24.9-24.9z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_whatsapp\" role=\"button\" tabindex=\"0\" aria-label=\"Share on whatsapp\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-whatsapp\" viewBox=\"0 0 448 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M380.9 97.1C339 55.1 283.2 32 223.9 32c-122.4 0-222 99.6-222 222 0 39.1 10.2 77.3 29.6 111L0 480l117.7-30.9c32.4 17.7 68.9 27 106.1 27h.1c122.3 0 224.1-99.6 224.1-222 0-59.3-25.2-115-67.1-157zm-157 341.6c-33.2 0-65.7-8.9-94-25.7l-6.7-4-69.8 18.3L72 359.2l-4.4-7c-18.5-29.4-28.2-63.3-28.2-98.2 0-101.7 82.8-184.5 184.6-184.5 49.3 0 95.6 19.2 130.4 54.1 34.8 34.9 56.2 81.2 56.1 130.5 0 101.8-84.9 184.6-186.6 184.6zm101.2-138.2c-5.5-2.8-32.8-16.2-37.9-18-5.1-1.9-8.8-2.8-12.5 2.8-3.7 5.6-14.3 18-17.6 21.8-3.2 3.7-6.5 4.2-12 1.4-32.6-16.3-54-29.1-75.5-66-5.7-9.8 5.7-9.1 16.3-30.3 1.8-3.7.9-6.9-.5-9.7-1.4-2.8-12.5-30.1-17.1-41.2-4.5-10.8-9.1-9.3-12.5-9.5-3.2-.2-6.9-.2-10.6-.2-3.7 0-9.7 1.4-14.8 6.9-5.1 5.6-19.4 19-19.4 46.3 0 27.3 19.9 53.7 22.6 57.4 2.8 3.7 39.1 59.7 94.8 83.8 35.2 15.2 49 16.5 66.6 13.9 10.7-1.6 32.8-13.4 37.4-26.4 4.6-13 4.6-24.1 3.2-26.4-1.3-2.5-5-3.9-10.5-6.6z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_email\" role=\"button\" tabindex=\"0\" aria-label=\"Share on email\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fas-envelope\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M502.3 190.8c3.9-3.1 9.7-.2 9.7 4.7V400c0 26.5-21.5 48-48 48H48c-26.5 0-48-21.5-48-48V195.6c0-5 5.7-7.8 9.7-4.7 22.4 17.4 52.1 39.5 154.1 113.6 21.1 15.4 56.7 47.8 92.2 47.6 35.7.3 72-32.8 92.3-47.6 102-74.1 131.6-96.3 154-113.7zM256 320c23.2.4 56.6-29.2 73.4-41.4 132.7-96.3 142.8-104.7 173.4-128.7 5.8-4.5 9.2-11.5 9.2-18.9v-19c0-26.5-21.5-48-48-48H48C21.5 64 0 85.5 0 112v19c0 7.4 3.4 14.3 9.2 18.9 30.6 23.9 40.7 32.4 173.4 128.7 16.8 12.2 50.2 41.8 73.4 41.4z\"></path></svg>							</span>\n																				</div>\n					</div>\n						</div>\n						</div>\n				</div>\n				</div>\n					</div>\n				</div>\n		<div class=\"elementor-element elementor-element-95ebea8 elementor-hidden-desktop elementor-hidden-tablet e-flex e-con-boxed e-con e-parent\" data-id=\"95ebea8\" data-element_type=\"container\">\n					<div class=\"e-con-inner\">\n		<div class=\"elementor-element elementor-element-123fb1f e-con-full e-flex e-con e-child\" data-id=\"123fb1f\" data-element_type=\"container\">\n		<div class=\"elementor-element elementor-element-1b37cd3 e-con-full e-flex e-con e-child\" data-id=\"1b37cd3\" data-element_type=\"container\">\n				<div class=\"elementor-element elementor-element-837efb5 elementor-widget elementor-widget-shortcode\" data-id=\"837efb5\" data-element_type=\"widget\" data-widget_type=\"shortcode.default\">\n							<div class=\"elementor-shortcode\">    <div class=\"wp-applause-container\" data-post-id=\"7245\">\n        <button class=\"wp-applause-button\" data-post-id=\"7245\">\n            <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" aria-label=\"clap\"><path fill-rule=\"evenodd\" d=\"M11.37.828 12 3.282l.63-2.454zM13.916 3.953l1.523-2.112-1.184-.39zM8.589 1.84l1.522 2.112-.337-2.501zM18.523 18.92c-.86.86-1.75 1.246-2.62 1.33a6 6 0 0 0 .407-.372c2.388-2.389 2.86-4.951 1.399-7.623l-.912-1.603-.79-1.672c-.26-.56-.194-.98.203-1.288a.7.7 0 0 1 .546-.132c.283.046.546.231.728.5l2.363 4.157c.976 1.624 1.141 4.237-1.324 6.702m-10.999-.438L3.37 14.328a.828.828 0 0 1 .585-1.408.83.83 0 0 1 .585.242l2.158 2.157a.365.365 0 0 0 .516-.516l-2.157-2.158-1.449-1.449a.826.826 0 0 1 1.167-1.17l3.438 3.44a.363.363 0 0 0 .516 0 .364.364 0 0 0 0-.516L5.293 9.513l-.97-.97a.826.826 0 0 1 0-1.166.84.84 0 0 1 1.167 0l.97.968 3.437 3.436a.36.36 0 0 0 .517 0 .366.366 0 0 0 0-.516L6.977 7.83a.82.82 0 0 1-.241-.584.82.82 0 0 1 .824-.826c.219 0 .43.087.584.242l5.787 5.787a.366.366 0 0 0 .587-.415l-1.117-2.363c-.26-.56-.194-.98.204-1.289a.7.7 0 0 1 .546-.132c.283.046.545.232.727.501l2.193 3.86c1.302 2.38.883 4.59-1.277 6.75-1.156 1.156-2.602 1.627-4.19 1.367-1.418-.236-2.866-1.033-4.079-2.246M10.75 5.971l2.12 2.12c-.41.502-.465 1.17-.128 1.89l.22.465-3.523-3.523a.8.8 0 0 1-.097-.368c0-.22.086-.428.241-.584a.847.847 0 0 1 1.167 0m7.355 1.705c-.31-.461-.746-.758-1.23-.837a1.44 1.44 0 0 0-1.11.275c-.312.24-.505.543-.59.881a1.74 1.74 0 0 0-.906-.465 1.47 1.47 0 0 0-.82.106l-2.182-2.182a1.56 1.56 0 0 0-2.2 0 1.54 1.54 0 0 0-.396.701 1.56 1.56 0 0 0-2.21-.01 1.55 1.55 0 0 0-.416.753c-.624-.624-1.649-.624-2.237-.037a1.557 1.557 0 0 0 0 2.2c-.239.1-.501.238-.715.453a1.56 1.56 0 0 0 0 2.2l.516.515a1.556 1.556 0 0 0-.753 2.615L7.01 19c1.32 1.319 2.909 2.189 4.475 2.449q.482.08.971.08c.85 0 1.653-.198 2.393-.579.231.033.46.054.686.054 1.266 0 2.457-.52 3.505-1.567 2.763-2.763 2.552-5.734 1.439-7.586z\" clip-rule=\"evenodd\"></path></svg>\n        </button>\n        <span class=\"wp-applause-count\">11</span>\n    </div>\n    </div>\n						</div>\n				<div class=\"elementor-element elementor-element-5bf9dbd elementor-icon-list--layout-inline elementor-mobile-align-center elementor-list-item-link-full_width elementor-widget elementor-widget-icon-list\" data-id=\"5bf9dbd\" data-element_type=\"widget\" data-widget_type=\"icon-list.default\">\n							<ul class=\"elementor-icon-list-items elementor-inline-items\">\n							<li class=\"elementor-icon-list-item elementor-inline-item\">\n											<a href=\"#comments\">\n\n												<span class=\"elementor-icon-list-icon\">\n							<i aria-hidden=\"true\" class=\"huge huge-comment-01\"></i>						</span>\n										<span class=\"elementor-icon-list-text\"></span>\n											</a>\n									</li>\n								<li class=\"elementor-icon-list-item elementor-inline-item\">\n											<a href=\"#elementor-action%3Aaction%3Dpopup%3Aopen%26settings%3DeyJpZCI6IjYxOTMiLCJ0b2dnbGUiOmZhbHNlfQ%3D%3D\">\n\n												<span class=\"elementor-icon-list-icon\">\n							<i aria-hidden=\"true\" class=\"huge huge-share-05\"></i>						</span>\n										<span class=\"elementor-icon-list-text\"></span>\n											</a>\n									</li>\n						</ul>\n						</div>\n				</div>\n		<div class=\"elementor-element elementor-element-8608e80 e-con-full elementor-hidden-mobile e-flex e-con e-child\" data-id=\"8608e80\" data-element_type=\"container\">\n				<div class=\"elementor-element elementor-element-0bb15f1 elementor-share-buttons--view-icon elementor-share-buttons--skin-framed elementor-share-buttons--color-custom elementor-share-buttons--shape-square elementor-grid-0 elementor-widget elementor-widget-share-buttons\" data-id=\"0bb15f1\" data-element_type=\"widget\" data-widget_type=\"share-buttons.default\">\n							<div class=\"elementor-grid\" role=\"list\">\n								<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_facebook\" role=\"button\" tabindex=\"0\" aria-label=\"Share on facebook\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-facebook\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M504 256C504 119 393 8 256 8S8 119 8 256c0 123.78 90.69 226.38 209.25 245V327.69h-63V256h63v-54.64c0-62.15 37-96.48 93.67-96.48 27.14 0 55.52 4.84 55.52 4.84v61h-31.28c-30.8 0-40.41 19.12-40.41 38.73V256h68.78l-11 71.69h-57.78V501C413.31 482.38 504 379.78 504 256z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_x-twitter\" role=\"button\" tabindex=\"0\" aria-label=\"Share on x-twitter\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-x-twitter\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M389.2 48h70.6L305.6 224.2 487 464H345L233.7 318.6 106.5 464H35.8L200.7 275.5 26.8 48H172.4L272.9 180.9 389.2 48zM364.4 421.8h39.1L151.1 88h-42L364.4 421.8z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_pinterest\" role=\"button\" tabindex=\"0\" aria-label=\"Share on pinterest\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-pinterest\" viewBox=\"0 0 496 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M496 256c0 137-111 248-248 248-25.6 0-50.2-3.9-73.4-11.1 10.1-16.5 25.2-43.5 30.8-65 3-11.6 15.4-59 15.4-59 8.1 15.4 31.7 28.5 56.8 28.5 74.8 0 128.7-68.8 128.7-154.3 0-81.9-66.9-143.2-152.9-143.2-107 0-163.9 71.8-163.9 150.1 0 36.4 19.4 81.7 50.3 96.1 4.7 2.2 7.2 1.2 8.3-3.3.8-3.4 5-20.3 6.9-28.1.6-2.5.3-4.7-1.7-7.1-10.1-12.5-18.3-35.3-18.3-56.6 0-54.7 41.4-107.6 112-107.6 60.9 0 103.6 41.5 103.6 100.9 0 67.1-33.9 113.6-78 113.6-24.3 0-42.6-20.1-36.7-44.8 7-29.5 20.5-61.3 20.5-82.6 0-19-10.2-34.9-31.4-34.9-24.9 0-44.9 25.7-44.9 60.2 0 22 7.4 36.8 7.4 36.8s-24.5 103.8-29 123.2c-5 21.4-3 51.6-.9 71.2C65.4 450.9 0 361.1 0 256 0 119 111 8 248 8s248 111 248 248z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_linkedin\" role=\"button\" tabindex=\"0\" aria-label=\"Share on linkedin\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-linkedin\" viewBox=\"0 0 448 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M416 32H31.9C14.3 32 0 46.5 0 64.3v383.4C0 465.5 14.3 480 31.9 480H416c17.6 0 32-14.5 32-32.3V64.3c0-17.8-14.4-32.3-32-32.3zM135.4 416H69V202.2h66.5V416zm-33.2-243c-21.3 0-38.5-17.3-38.5-38.5S80.9 96 102.2 96c21.2 0 38.5 17.3 38.5 38.5 0 21.3-17.2 38.5-38.5 38.5zm282.1 243h-66.4V312c0-24.8-.5-56.7-34.5-56.7-34.6 0-39.9 27-39.9 54.9V416h-66.4V202.2h63.7v29.2h.9c8.9-16.8 30.6-34.5 62.9-34.5 67.2 0 79.7 44.3 79.7 101.9V416z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_reddit\" role=\"button\" tabindex=\"0\" aria-label=\"Share on reddit\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-reddit\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M201.5 305.5c-13.8 0-24.9-11.1-24.9-24.6 0-13.8 11.1-24.9 24.9-24.9 13.6 0 24.6 11.1 24.6 24.9 0 13.6-11.1 24.6-24.6 24.6zM504 256c0 137-111 248-248 248S8 393 8 256 119 8 256 8s248 111 248 248zm-132.3-41.2c-9.4 0-17.7 3.9-23.8 10-22.4-15.5-52.6-25.5-86.1-26.6l17.4-78.3 55.4 12.5c0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.3 24.9-24.9s-11.1-24.9-24.9-24.9c-9.7 0-18 5.8-22.1 13.8l-61.2-13.6c-3-.8-6.1 1.4-6.9 4.4l-19.1 86.4c-33.2 1.4-63.1 11.3-85.5 26.8-6.1-6.4-14.7-10.2-24.1-10.2-34.9 0-46.3 46.9-14.4 62.8-1.1 5-1.7 10.2-1.7 15.5 0 52.6 59.2 95.2 132 95.2 73.1 0 132.3-42.6 132.3-95.2 0-5.3-.6-10.8-1.9-15.8 31.3-16 19.8-62.5-14.9-62.5zM302.8 331c-18.2 18.2-76.1 17.9-93.6 0-2.2-2.2-6.1-2.2-8.3 0-2.5 2.5-2.5 6.4 0 8.6 22.8 22.8 87.3 22.8 110.2 0 2.5-2.2 2.5-6.1 0-8.6-2.2-2.2-6.1-2.2-8.3 0zm7.7-75c-13.6 0-24.6 11.1-24.6 24.9 0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.1 24.9-24.6 0-13.8-11-24.9-24.9-24.9z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_whatsapp\" role=\"button\" tabindex=\"0\" aria-label=\"Share on whatsapp\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-whatsapp\" viewBox=\"0 0 448 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M380.9 97.1C339 55.1 283.2 32 223.9 32c-122.4 0-222 99.6-222 222 0 39.1 10.2 77.3 29.6 111L0 480l117.7-30.9c32.4 17.7 68.9 27 106.1 27h.1c122.3 0 224.1-99.6 224.1-222 0-59.3-25.2-115-67.1-157zm-157 341.6c-33.2 0-65.7-8.9-94-25.7l-6.7-4-69.8 18.3L72 359.2l-4.4-7c-18.5-29.4-28.2-63.3-28.2-98.2 0-101.7 82.8-184.5 184.6-184.5 49.3 0 95.6 19.2 130.4 54.1 34.8 34.9 56.2 81.2 56.1 130.5 0 101.8-84.9 184.6-186.6 184.6zm101.2-138.2c-5.5-2.8-32.8-16.2-37.9-18-5.1-1.9-8.8-2.8-12.5 2.8-3.7 5.6-14.3 18-17.6 21.8-3.2 3.7-6.5 4.2-12 1.4-32.6-16.3-54-29.1-75.5-66-5.7-9.8 5.7-9.1 16.3-30.3 1.8-3.7.9-6.9-.5-9.7-1.4-2.8-12.5-30.1-17.1-41.2-4.5-10.8-9.1-9.3-12.5-9.5-3.2-.2-6.9-.2-10.6-.2-3.7 0-9.7 1.4-14.8 6.9-5.1 5.6-19.4 19-19.4 46.3 0 27.3 19.9 53.7 22.6 57.4 2.8 3.7 39.1 59.7 94.8 83.8 35.2 15.2 49 16.5 66.6 13.9 10.7-1.6 32.8-13.4 37.4-26.4 4.6-13 4.6-24.1 3.2-26.4-1.3-2.5-5-3.9-10.5-6.6z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_email\" role=\"button\" tabindex=\"0\" aria-label=\"Share on email\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fas-envelope\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M502.3 190.8c3.9-3.1 9.7-.2 9.7 4.7V400c0 26.5-21.5 48-48 48H48c-26.5 0-48-21.5-48-48V195.6c0-5 5.7-7.8 9.7-4.7 22.4 17.4 52.1 39.5 154.1 113.6 21.1 15.4 56.7 47.8 92.2 47.6 35.7.3 72-32.8 92.3-47.6 102-74.1 131.6-96.3 154-113.7zM256 320c23.2.4 56.6-29.2 73.4-41.4 132.7-96.3 142.8-104.7 173.4-128.7 5.8-4.5 9.2-11.5 9.2-18.9v-19c0-26.5-21.5-48-48-48H48C21.5 64 0 85.5 0 112v19c0 7.4 3.4 14.3 9.2 18.9 30.6 23.9 40.7 32.4 173.4 128.7 16.8 12.2 50.2 41.8 73.4 41.4z\"></path></svg>							</span>\n																				</div>\n					</div>\n						</div>\n						</div>\n				</div>\n				</div>\n					</div>\n				</div>\n				</div>\n		</div>\n						</div>\n					</div>\n				', 'Introduction: The Unspoken Fear AI is changing the world fast. In many industries, it’s already improving speed, accuracy, and efficiency. In healthcare, the potential is massive. From reducing paperwork to helping with diagnosis, AI promises to save time and support doctors. But there’s a fear no one is talking about openly: “What if the AI gives the wrong recommendation? Who will be blamed?” It’s a fair question. Because healthcare isn’t like choosing a movie on Netflix. If a streaming app suggests a bad movie, the worst that happens is you waste two hours. But if an AI system suggests the wrong medicine, the consequences can be serious—even life-threatening. This is the reason many doctors hesitate to bring AI into their clinics. Not because they don’t see the benefits, but because they’re unsure what happens if something goes wrong. In this blog, we’ll talk honestly about this concern. Who’s responsible? How can you use AI safely? And most importantly how can you take advantage of AI without putting your license or your patients at risk? Let’s get into it. How AI Works in Clinical Settings (and Where It Doesn’t) Before getting into liability, let’s understand what AI actually can do in clinics today and more importantly, what it won’t do. Most AI tools in healthcare are assistive, not autonomous. They don’t make final decisions. They support the existing processes at your clinic. For example: AI-powered chatbots can answer general user queries, guide patients to book appointments, and help them understand pre-visit instructions. Clinical decision support tools can highlight drug interactions or suggest possible diagnoses based on symptoms and test results. Natural language processing (NLP) models can summarize patient notes, extract relevant information from records, and help doctors document faster. Predictive algorithms may flag high-risk patients for follow-ups or recommend screening tests. But here’s the key: AI is not replacing clinical judgment. At least not in regulated, real-world use cases. The final responsibility to prescribe, diagnose, or act on AI recommendations still lies with the doctor. That said, the lines can get blurry when AI recommendations feel authoritative or when time pressure leads to over-reliance. Let’s say: An AI assistant suggests a medication. The doctor, overwhelmed with back-to-back patients, accepts the recommendation without verifying. The patient has an allergy and suffers a reaction. Now, was it the AI’s fault? Not quite. Because AI is not the licensed medical professional. But this is where it gets complicated and where systems, laws, and common sense need to work together. Let’s explore that next. Who Is Legally Responsible if AI Gets It Wrong? This is the core concern many doctors raise and rightly so. If an AI tool suggests a wrong medication, and a patient is harmed, who is accountable? Let’s unpack it without the legal jargon. 1. Doctors Are Still the Final Authority In most countries, AI tools in healthcare are classified as “decision support systems” not autonomous decision-makers. That means: The doctor is the one prescribing the medicine. The doctor is the one signing off on the treatment plan. And yes, if something goes wrong, the doctor is still liable. It’s not because AI can’t be useful, it’s because medical licenses are issued to people, not software. In India, the Telemedicine Practice Guidelines (issued by the Ministry of Health and Family Welfare, 2020) clearly state: “The final responsibility of diagnosis and prescription lies with the registered medical practitioner.” The same principle applies under HIPAA in the U.S., GDPR in Europe, and NDHM (now ABDM) in India: AI tools must support—not replace—medical professionals. Also, If an AI assistant gives an incorrect recommendation directly to a patient such as suggesting the wrong medicine or misguiding them about a symptom the responsibility can become more complex. However, in most current legal frameworks, unless the AI is officially classified and regulated as a medical device, the liability often still circles back to the healthcare provider or institution overseeing its deployment. But here’s where things are changing. 2. Shared Accountability Is Emerging In recent years, there’s been a growing debate: If AI is so advanced, shouldn’t the developers, vendors, or hospitals share responsibility too? That’s starting to happen. Some hospitals are now requiring AI vendors to include indemnity clauses in contracts. Regulators like the FDA (U.S.) and EMA (Europe) are evaluating how to classify AI tools as “medical devices”—which means they’ll need to meet strict safety and performance standards before deployment. In India, as the Ayushman Bharat Digital Mission expands, discussions around data privacy, clinical safety, and AI accountability are getting more attention. The future of AI in healthcare is moving toward shared responsibility. As AI tools become more common, especially in commercial use, developers and hospitals may also be held accountable. The goal is to avoid placing all the blame on doctors alone. What Should Doctors Ask Before Using Any AI Tool in Their Clinic? Not all AI tools are the same. Some tools are helpful and safe. Others are poorly tested, overhyped, or just not made for real clinical environments. If you’re considering AI for your clinic, here are 5 key questions to ask—without needing a legal team or tech background. 1. Is the AI tool medically validated? Has it been tested in real clinics or hospitals? Are there peer-reviewed studies or user testimonials from other doctors? Don’t just take the vendor’s word for it—look for other customers’ validation. 2. How does it handle sensitive patient data? Is patient data stored locally or sent to the cloud? Is the data encrypted and anonymized? Does it comply with NDHM/ABDM (India), HIPAA (US), or GDPR (Europe)? You’re still responsible for your patient’s privacy even if the AI tool is the one collecting data. 3. Will it integrate with my existing workflow? Does it work with your current EMR or appointment system? Will your staff need hours of training to use it? Can it automate tasks without disrupting patient flow? A good AI tool should save time, not create new work. 4. Can I easily override or edit its suggestions? You should never feel like you have to follow what the AI says. Look for tools that support—not replace—your clinical judgment. You’re the doctor. The AI is the assistant, not the other way around. What Can Doctors Do Today to Use AI Safely in Their Practice? You don’t need to wait for perfect regulation or 100% flawless tools. Many clinics are already using AI safely and getting real results. The future of AI in medicine and what it means for physicians and practices with Tom Lawry Here’s what you can start doing right now: 1. Use AI for low-risk, repetitive tasks first Start with areas where mistakes are unlikely to cause harm: Appointment reminders Answering common patient questions Collecting patient history Sending pre-visit instructions These use cases save your team hours without touching medical decisions. 2. Always keep human oversight in place No matter how smart the AI seems—don’t leave it unsupervised. Review any medical suggestion made by the AI Ensure nurses or admins double-check responses frequently Use AI as a draft generator, not a final decision-maker You remain the final authority. Always. 3. Involve your team in the process Doctors, nurses, receptionists—everyone who uses the AI tool should have a say. Ask what’s working and what’s not Encourage feedback on AI mistakes or blind spots Make sure everyone knows when to escalate to a human expert The goal is not just tech adoption—it’s smarter team collaboration. 4. Be transparent with patients (when needed) If AI is being used to respond to queries or collect symptoms: Let patients know it’s an automated system Reassure them that a human is still reviewing their case Give them the option to speak to a doctor directly This builds trust—and protects your clinic. Why Doctors Will Always Remain Essential—No Matter How Smart AI Gets With all the talk about AI taking over, it’s easy to feel uncertain. But let’s take a step back and remember: AI might be fast, but it doesn’t replace what makes doctors truly valuable. Here’s why your role isn’t just safe, it’s irreplaceable. 1. Medicine is about people, not just data AI can read reports. It can process symptoms. But it can’t sit across from a patient, notice the anxiety in their eyes, and say the right words to comfort them. That human connection? That’s where healing often begins—and AI can’t replicate it. 2. Your clinical judgment is built on years of training and experience AI can suggest a diagnosis. But it doesn’t know your patient’s full story, the nuance in their symptoms, or what you’ve learned from years of seeing similar cases. You make decisions based not just on data—but on patterns, context, and real-life experience. That’s something no algorithm can fully understand. 3. Patients still want a human in charge Even if AI gets better at diagnosis or documentation, studies show patients still want to talk to a real doctor. They want to know someone cares. That someone is responsible. That someone understands. You are the face of trust in healthcare. And that doesn’t change—whether there’s AI in the room or not. 4. AI still needs direction, limits, and supervision AI is like a powerful medical tool—just like an MRI or ultrasound machine. It’s only as useful as the person using it. And in clinics, that person will always be you. Your role is shifting—not shrinking. You’re no longer just diagnosing or prescribing; you’re leading the smart systems that support patient care. Final Thoughts: Blame, Trust, and the Role of Doctors in an AI-Driven Future So, what happens if AI suggests the wrong medicine? The short answer: Doctors are still in charge, and hence responsible. Even as AI tools become more advanced, healthcare decisions, especially ones involving medication—will continue to require human supervision. Doctors won’t just “use” AI. They’ll guide it, question it, and override it when necessary. So, where does that leave us? If used responsibly, AI won’t introduce risk—it’ll reduce it. It can: Help filter patient information quickly Flag inconsistencies or high-risk cases Reduce time spent on routine documentation Offer reminders, summaries, or decision-support tools And that’s where platforms like BeyondChats come in. At BeyondChats, we build AI-powered assistants for clinics and hospitals—not to replace staff, but to take over repetitive admin tasks, guide patients with common queries, and help surface actionable insights for the medical team. Our systems are custom-built for healthcare workflows and are always designed to keep the doctor in control. We understand the concerns around liability, patient safety, and professional autonomy—and we build with those priorities in mind. The future of medicine isn’t AI vs. doctors. It’s AI and doctors, working together. Let AI handle the paperwork. Let it track patient follow-ups, qualify your patients, and answer basic questions. But when it comes to life, health, and healing—that’s still your call. And it always will be. AI is a tool. But doctors? You are—and always will be—the decision-makers in healthcare. 11', NULL, '2025-03-23 18:30:00', 'https://beyondchats.com/blogs/what-if-ai-recommends-the-wrong-medicine-whos-to-blame/', 0, NULL, NULL, '2025-12-30 13:04:59', '2025-12-30 13:04:59', 'General');
INSERT INTO `articles` (`id`, `title`, `original_content_html`, `original_content_text`, `author`, `published_date`, `source_url`, `is_updated`, `updated_content`, `references`, `created_at`, `updated_at`, `category`) VALUES
(3, 'What If AI Recommends the Wrong Medicine – Who’s Responsible?', '\n					<div class=\"e-con-inner\">\n				<div class=\"elementor-element elementor-element-b2a436b elementor-widget elementor-widget-theme-post-content\" data-id=\"b2a436b\" data-element_type=\"widget\" data-widget_type=\"theme-post-content.default\">\n					\n<h4 class=\"wp-block-heading has-large-font-size\"><strong>Introduction: The Unspoken Fear</strong></h4>\n\n\n\n<p>AI is changing the world fast. In many industries, it’s already improving speed, accuracy, and efficiency. In healthcare, the potential is massive. From reducing paperwork to helping with diagnosis, AI promises to save time and support doctors.</p>\n\n\n\n<p>But there’s a fear no one is talking about openly:</p>\n\n\n\n<blockquote class=\"wp-block-quote is-layout-flow wp-block-quote-is-layout-flow\">\n<p><strong>“What if the AI gives the wrong recommendation? Who will be blamed?”</strong></p>\n</blockquote>\n\n\n\n<p>It’s a fair question. Because healthcare isn’t like choosing a movie on Netflix. If a streaming app suggests a bad movie, the worst that happens is you waste two hours. But if an AI system suggests the wrong medicine, <strong>the consequences can be serious—even life-threatening.</strong></p>\n\n\n\n<p>This is the reason many doctors hesitate to bring AI into their clinics. Not because they don’t see the benefits, but because they’re unsure what happens <strong>if something goes wrong</strong>.</p>\n\n\n\n<p>In this blog, we’ll talk honestly about this concern. </p>\n\n\n\n<figure class=\"wp-block-image size-large\"><a href=\"https://beyondchats.com/wp-content/uploads/2025/03/Ai-as-a-doctor.jpg\"><img fetchpriority=\"high\" decoding=\"async\" width=\"1024\" height=\"538\" src=\"https://beyondchats.com/wp-content/uploads/2025/03/Ai-as-a-doctor-1024x538.jpg\" alt=\"AI is seen wearing a stethoscope in the hospital with nurses, medicine and the hospital equipments.\" class=\"wp-image-7247\" srcset=\"https://beyondchats.com/wp-content/uploads/2025/03/Ai-as-a-doctor-1024x538.jpg 1024w, https://beyondchats.com/wp-content/uploads/2025/03/Ai-as-a-doctor-300x158.jpg 300w, https://beyondchats.com/wp-content/uploads/2025/03/Ai-as-a-doctor-768x403.jpg 768w, https://beyondchats.com/wp-content/uploads/2025/03/Ai-as-a-doctor-600x315.jpg 600w, https://beyondchats.com/wp-content/uploads/2025/03/Ai-as-a-doctor.jpg 1200w\" sizes=\"(max-width: 1024px) 100vw, 1024px\"></a></figure>\n\n\n\n<p>Who’s responsible? How can you use AI safely? And most importantly how can you take advantage of AI without putting your license or your patients at risk?</p>\n\n\n\n<p>Let’s get into it.</p>\n\n\n\n<h4 class=\"wp-block-heading has-large-font-size\"><strong>How AI Works in Clinical Settings (and Where It Doesn’t)</strong></h4>\n\n\n\n<p>Before getting into liability, let’s understand what AI actually <em>can do</em> in clinics today and more importantly, what it won’t do.</p>\n\n\n\n<p>Most AI tools in healthcare are assistive, not autonomous.</p>\n\n\n\n<p>They don’t make final decisions. They support the existing processes at your clinic.</p>\n\n\n\n<p>For example:</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li><strong>AI-powered chatbots</strong> can answer general user queries, guide patients to book appointments, and help them understand pre-visit instructions.</li>\n\n\n\n<li><strong>Clinical decision support tools</strong> can highlight drug interactions or suggest possible diagnoses based on symptoms and test results.</li>\n\n\n\n<li><strong>Natural language processing (NLP)</strong> models can summarize patient notes, extract relevant information from records, and help doctors document faster.</li>\n\n\n\n<li><strong>Predictive algorithms</strong> may flag high-risk patients for follow-ups or recommend screening tests.</li>\n</ul>\n\n\n\n<p>But here’s the key: <strong>AI is not replacing clinical judgment.</strong> At least not in regulated, real-world use cases.</p>\n\n\n\n<p>The final responsibility to prescribe, diagnose, or act on AI recommendations still lies with the doctor.</p>\n\n\n\n<p>That said, the lines can get blurry when AI recommendations feel authoritative or when time pressure leads to over-reliance.</p>\n\n\n\n<p>Let’s say:</p>\n\n\n\n<p>An AI assistant suggests a medication. The doctor, overwhelmed with back-to-back patients, accepts the recommendation without verifying. The patient has an allergy and suffers a reaction.</p>\n\n\n\n<p>Now, was it the AI’s fault?</p>\n\n\n\n<p>Not quite. Because AI is not the licensed medical professional.</p>\n\n\n\n<p>But this is where it gets complicated and where systems, laws, and common sense need to work together.</p>\n\n\n\n<p>Let’s explore that next.</p>\n\n\n\n<h4 class=\"wp-block-heading has-large-font-size\"><strong>Who Is Legally Responsible if AI Gets It Wrong?</strong></h4>\n\n\n\n<p>This is the core concern many doctors raise and rightly so.</p>\n\n\n\n<p>If an AI tool suggests a wrong medication, and a patient is harmed, <em>who</em> is accountable?</p>\n\n\n\n<p>Let’s unpack it without the legal jargon.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>1. Doctors Are Still the Final Authority</strong></h4>\n\n\n\n<p>In most countries, AI tools in healthcare are classified as <strong>“decision support systems”</strong> not autonomous decision-makers.</p>\n\n\n\n<p>That means:</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li>The doctor is the one prescribing the medicine.</li>\n\n\n\n<li>The doctor is the one signing off on the treatment plan.</li>\n\n\n\n<li>And yes, if something goes wrong, the doctor is still liable.</li>\n</ul>\n\n\n\n<p>It’s not because AI can’t be useful, it’s because <strong>medical licenses are issued to people, not software.</strong></p>\n\n\n\n<p>In India, the <a href=\"https://esanjeevani.mohfw.gov.in/assets/guidelines/Telemedicine_Practice_Guidelines.pdf\" target=\"_blank\" rel=\"noopener\"><strong>Telemedicine Practice Guidelines</strong></a> (issued by the Ministry of Health and Family Welfare, 2020) clearly state:</p>\n\n\n\n<p>“The final responsibility of diagnosis and prescription lies with the registered medical practitioner.”</p>\n\n\n\n<p>The same principle applies under <a href=\"https://www.hhs.gov/hipaa/for-professionals/privacy/laws-regulations/index.html\" target=\"_blank\" rel=\"noopener\"><strong>HIPAA</strong></a><strong> in the U.S.</strong>, <a href=\"https://gdpr-info.eu/\" target=\"_blank\" rel=\"noopener\"><strong>GDPR</strong></a><strong> in Europe</strong>, and <a href=\"https://www.makeinindia.com/national-digital-health-mission\" target=\"_blank\" rel=\"noopener\"><strong>NDHM</strong></a><strong> (now ABDM) in India</strong>: AI tools must support—not replace—medical professionals.</p>\n\n\n\n<p>Also, If an AI assistant gives an incorrect recommendation directly to a patient such as suggesting the wrong medicine or misguiding them about a symptom the responsibility can become more complex. However, in most current legal frameworks, unless the AI is officially classified and regulated as a medical device, the liability often still circles back to the healthcare provider or institution overseeing its deployment.</p>\n\n\n\n<p>But here’s where things are changing.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>2. Shared Accountability Is Emerging</strong></h4>\n\n\n\n<p>In recent years, there’s been a growing debate: If AI is so advanced, shouldn’t the developers, vendors, or hospitals share responsibility too?</p>\n\n\n\n<p>That’s starting to happen.</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Some hospitals are now requiring <strong>AI vendors</strong> to include <strong>indemnity clauses</strong> in contracts.</li>\n\n\n\n<li>Regulators like the <strong>FDA (U.S.)</strong> and <strong>EMA (Europe)</strong> are evaluating how to classify AI tools as “medical devices”—which means they’ll need to meet strict safety and performance standards before deployment.</li>\n\n\n\n<li>In India, as the Ayushman Bharat Digital Mission expands, discussions around data privacy, clinical safety, and AI accountability are getting more attention.</li>\n</ul>\n\n\n\n<p>The future of AI in healthcare is moving toward shared responsibility. As AI tools become more common, especially in commercial use, developers and hospitals may also be held accountable. The goal is to avoid placing all the blame on doctors alone.</p>\n\n\n\n<h4 class=\"wp-block-heading has-large-font-size\"><strong>What Should Doctors Ask Before Using Any AI Tool in Their Clinic?</strong></h4>\n\n\n\n<p>Not all AI tools are the same. Some tools are helpful and safe. Others are poorly tested, overhyped, or just not made for real clinical environments.</p>\n\n\n\n<p>If you’re considering AI for your clinic, here are <strong>5 key questions</strong> to ask—without needing a legal team or tech background.</p>\n\n\n\n<hr class=\"wp-block-separator has-alpha-channel-opacity\">\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>1. Is the AI tool medically validated?</strong></h4>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Has it been tested in real clinics or hospitals?</li>\n\n\n\n<li>Are there peer-reviewed studies or user testimonials from other doctors?</li>\n</ul>\n\n\n\n<p>Don’t just take the vendor’s word for it—look for other customers’ validation.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>2. How does it handle sensitive patient data?</strong></h4>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Is patient data stored locally or sent to the cloud?</li>\n\n\n\n<li>Is the data encrypted and anonymized?</li>\n\n\n\n<li>Does it comply with <strong>NDHM/ABDM</strong> (India), <strong>HIPAA</strong> (US), or <strong>GDPR</strong> (Europe)?</li>\n</ul>\n\n\n\n<p>You’re still responsible for your patient’s privacy even if the AI tool is the one collecting data.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>3. Will it integrate with my existing workflow?</strong></h4>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Does it work with your current EMR or appointment system?</li>\n\n\n\n<li>Will your staff need hours of training to use it?</li>\n\n\n\n<li>Can it automate tasks <em>without</em> disrupting patient flow?</li>\n</ul>\n\n\n\n<p>A good AI tool should <strong>save time, not create new work</strong>.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>4. Can I easily override or edit its suggestions?</strong></h4>\n\n\n\n<ul class=\"wp-block-list\">\n<li>You should never feel like you have to follow what the AI says.</li>\n\n\n\n<li>Look for tools that support—not replace—your clinical judgment.</li>\n</ul>\n\n\n\n<p>You’re the doctor. The AI is the assistant, not the other way around.</p>\n\n\n\n<h3 class=\"wp-block-heading has-large-font-size\"><strong>What Can Doctors Do Today to Use AI Safely in Their Practice?</strong></h3>\n\n\n\n<p>You don’t need to wait for perfect regulation or 100% flawless tools. Many clinics are already using AI safely and getting real results.</p>\n\n\n\n<figure class=\"wp-block-embed is-type-video is-provider-youtube wp-block-embed-youtube wp-embed-aspect-16-9 wp-has-aspect-ratio\"><div class=\"wp-block-embed__wrapper\">\n<iframe title=\"The future of AI in medicine and what it means for physicians and practices with Tom Lawry\" width=\"1290\" height=\"726\" src=\"https://www.youtube.com/embed/MQN3AABMIzU?feature=oembed\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" referrerpolicy=\"strict-origin-when-cross-origin\" allowfullscreen=\"\"></iframe>\n</div><figcaption class=\"wp-element-caption\">The future of AI in medicine and what it means for physicians and practices with Tom Lawry</figcaption></figure>\n\n\n\n<p>Here’s what you can start doing right now:</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>1. Use AI for low-risk, repetitive tasks first</strong></h4>\n\n\n\n<p>Start with areas where mistakes are unlikely to cause harm:</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Appointment reminders</li>\n\n\n\n<li>Answering common patient questions</li>\n\n\n\n<li>Collecting patient history</li>\n\n\n\n<li>Sending pre-visit instructions</li>\n</ul>\n\n\n\n<p>These use cases save your team hours without touching medical decisions.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>2. Always keep human oversight in place</strong></h4>\n\n\n\n<p>No matter how smart the AI seems—don’t leave it unsupervised.</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Review any medical suggestion made by the AI</li>\n\n\n\n<li>Ensure nurses or admins double-check responses frequently</li>\n\n\n\n<li>Use AI as a draft generator, not a final decision-maker</li>\n</ul>\n\n\n\n<p>You remain the final authority. Always.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>3. Involve your team in the process</strong></h4>\n\n\n\n<p>Doctors, nurses, receptionists—everyone who uses the AI tool should have a say.</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Ask what’s working and what’s not</li>\n\n\n\n<li>Encourage feedback on AI mistakes or blind spots</li>\n\n\n\n<li>Make sure everyone knows when to escalate to a human expert</li>\n</ul>\n\n\n\n<p>The goal is not just tech adoption—it’s smarter team collaboration.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>4. Be transparent with patients (when needed)</strong></h4>\n\n\n\n<p>If AI is being used to respond to queries or collect symptoms:</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Let patients know it’s an automated system</li>\n\n\n\n<li>Reassure them that a human is still reviewing their case</li>\n\n\n\n<li>Give them the option to speak to a doctor directly</li>\n</ul>\n\n\n\n<p>This builds trust—and protects your clinic.</p>\n\n\n\n<h3 class=\"wp-block-heading has-large-font-size\"><strong>Why Doctors Will Always Remain Essential—No Matter How Smart AI Gets</strong></h3>\n\n\n\n<p>With all the talk about AI taking over, it’s easy to feel uncertain. But let’s take a step back and remember: AI might be fast, but it doesn’t replace what makes doctors truly valuable.</p>\n\n\n\n<p>Here’s why your role isn’t just safe, it’s irreplaceable.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>1. Medicine is about people, not just data</strong></h4>\n\n\n\n<p>AI can read reports.<br>It can process symptoms.<br>But it can’t sit across from a patient, notice the anxiety in their eyes, and say the right words to comfort them.</p>\n\n\n\n<p>That human connection?<br>That’s where healing often begins—and AI can’t replicate it.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>2. Your clinical judgment is built on years of training and experience</strong></h4>\n\n\n\n<p>AI can suggest a diagnosis.<br>But it doesn’t know your patient’s full story, the nuance in their symptoms, or what you’ve learned from years of seeing similar cases.</p>\n\n\n\n<p>You make decisions based not just on data—but on patterns, context, and real-life experience.<br>That’s something no algorithm can fully understand.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>3. Patients still want a human in charge</strong></h4>\n\n\n\n<p>Even if AI gets better at diagnosis or documentation, studies show patients still want to talk to a real doctor.<br>They want to know someone cares. That someone is responsible. That someone understands.</p>\n\n\n\n<p>You are the face of trust in healthcare.<br>And that doesn’t change—whether there’s AI in the room or not.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>4. AI still needs direction, limits, and supervision</strong></h4>\n\n\n\n<p>AI is like a powerful medical tool—just like an MRI or ultrasound machine.<br>It’s only as useful as the person using it.</p>\n\n\n\n<p>And in clinics, that person will always be you.</p>\n\n\n\n<p>Your role is shifting—not shrinking.<br>You’re no longer just diagnosing or prescribing; you’re leading the smart systems that support patient care.</p>\n\n\n\n<h4 class=\"wp-block-heading has-large-font-size\"><strong>Final Thoughts: Blame, Trust, and the Role of Doctors in an AI-Driven Future</strong></h4>\n\n\n\n<p>So, what happens if AI suggests the wrong medicine?</p>\n\n\n\n<p>The short answer: <strong>Doctors are still in charge, and hence responsible.</strong></p>\n\n\n\n<p>Even as AI tools become more advanced, healthcare decisions, especially ones involving medication—will continue to require human supervision. Doctors won’t just “use” AI. They’ll <strong>guide</strong> it, <strong>question</strong> it, and <strong>override</strong> it when necessary.</p>\n\n\n\n<h4 class=\"wp-block-heading has-medium-font-size\"><strong>So, where does that leave us?</strong></h4>\n\n\n\n<p>If used responsibly, AI won’t introduce risk—it’ll reduce it. It can:</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Help filter patient information quickly</li>\n\n\n\n<li>Flag inconsistencies or high-risk cases</li>\n\n\n\n<li>Reduce time spent on routine documentation</li>\n\n\n\n<li>Offer reminders, summaries, or decision-support tools</li>\n</ul>\n\n\n\n<p>And that’s where platforms like <strong>BeyondChats</strong> come in.</p>\n\n\n\n<p>At <strong>BeyondChats</strong>, we build AI-powered assistants for clinics and hospitals—not to replace staff, but to <strong>take over repetitive admin tasks</strong>, guide patients with common queries, and help surface actionable insights for the medical team. Our systems are <strong>custom-built for healthcare workflows</strong> and are always designed to keep the <strong>doctor in control</strong>.</p>\n\n\n\n<p>We understand the concerns around liability, patient safety, and professional autonomy—and we build with those priorities in mind.</p>\n\n\n\n<h4 class=\"wp-block-heading has-large-font-size\"><strong>The future of medicine isn’t AI vs. doctors.</strong></h4>\n\n\n\n<p>It’s <strong>AI </strong><strong><em>and</em></strong><strong> doctors</strong>, working together.</p>\n\n\n\n<p>Let AI handle the paperwork. Let it track patient follow-ups, qualify your patients, and answer basic questions.</p>\n\n\n\n<p>But when it comes to life, health, and healing—<strong>that’s still your call.</strong></p>\n\n\n\n<p>And it always will be.</p>\n\n\n\n<p>AI is a tool.<br>But doctors? You are—and always will be—the decision-makers in healthcare.</p>\n<div class=\"has-social-placeholder has-content-area\" data-url=\"https://beyondchats.com/blogs/what-if-ai-recommends-the-wrong-medicine-whos-to-blame-2/\" data-title=\"What If AI Recommends the Wrong Medicine – Who’s Responsible?\" data-hashtags=\"\" data-post-id=\"7359\"></div>				</div>\n				<div class=\"elementor-element elementor-element-106752c elementor-widget elementor-widget-shortcode\" data-id=\"106752c\" data-element_type=\"widget\" data-widget_type=\"shortcode.default\">\n							<div class=\"elementor-shortcode\">		<div data-elementor-type=\"container\" data-elementor-id=\"6196\" class=\"elementor elementor-6196\" data-elementor-post-type=\"elementor_library\">\n				<div class=\"elementor-element elementor-element-af06f6b elementor-hidden-mobile e-flex e-con-boxed e-con e-parent\" data-id=\"af06f6b\" data-element_type=\"container\">\n					<div class=\"e-con-inner\">\n		<div class=\"elementor-element elementor-element-190a40c e-con-full e-flex e-con e-child\" data-id=\"190a40c\" data-element_type=\"container\">\n		<div class=\"elementor-element elementor-element-21c23ec e-con-full e-flex e-con e-child\" data-id=\"21c23ec\" data-element_type=\"container\">\n				<div class=\"elementor-element elementor-element-30984ea elementor-widget elementor-widget-shortcode\" data-id=\"30984ea\" data-element_type=\"widget\" data-widget_type=\"shortcode.default\">\n							<div class=\"elementor-shortcode\">    <div class=\"wp-applause-container\" data-post-id=\"7359\">\n        <button class=\"wp-applause-button\" data-post-id=\"7359\">\n            <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" aria-label=\"clap\"><path fill-rule=\"evenodd\" d=\"M11.37.828 12 3.282l.63-2.454zM13.916 3.953l1.523-2.112-1.184-.39zM8.589 1.84l1.522 2.112-.337-2.501zM18.523 18.92c-.86.86-1.75 1.246-2.62 1.33a6 6 0 0 0 .407-.372c2.388-2.389 2.86-4.951 1.399-7.623l-.912-1.603-.79-1.672c-.26-.56-.194-.98.203-1.288a.7.7 0 0 1 .546-.132c.283.046.546.231.728.5l2.363 4.157c.976 1.624 1.141 4.237-1.324 6.702m-10.999-.438L3.37 14.328a.828.828 0 0 1 .585-1.408.83.83 0 0 1 .585.242l2.158 2.157a.365.365 0 0 0 .516-.516l-2.157-2.158-1.449-1.449a.826.826 0 0 1 1.167-1.17l3.438 3.44a.363.363 0 0 0 .516 0 .364.364 0 0 0 0-.516L5.293 9.513l-.97-.97a.826.826 0 0 1 0-1.166.84.84 0 0 1 1.167 0l.97.968 3.437 3.436a.36.36 0 0 0 .517 0 .366.366 0 0 0 0-.516L6.977 7.83a.82.82 0 0 1-.241-.584.82.82 0 0 1 .824-.826c.219 0 .43.087.584.242l5.787 5.787a.366.366 0 0 0 .587-.415l-1.117-2.363c-.26-.56-.194-.98.204-1.289a.7.7 0 0 1 .546-.132c.283.046.545.232.727.501l2.193 3.86c1.302 2.38.883 4.59-1.277 6.75-1.156 1.156-2.602 1.627-4.19 1.367-1.418-.236-2.866-1.033-4.079-2.246M10.75 5.971l2.12 2.12c-.41.502-.465 1.17-.128 1.89l.22.465-3.523-3.523a.8.8 0 0 1-.097-.368c0-.22.086-.428.241-.584a.847.847 0 0 1 1.167 0m7.355 1.705c-.31-.461-.746-.758-1.23-.837a1.44 1.44 0 0 0-1.11.275c-.312.24-.505.543-.59.881a1.74 1.74 0 0 0-.906-.465 1.47 1.47 0 0 0-.82.106l-2.182-2.182a1.56 1.56 0 0 0-2.2 0 1.54 1.54 0 0 0-.396.701 1.56 1.56 0 0 0-2.21-.01 1.55 1.55 0 0 0-.416.753c-.624-.624-1.649-.624-2.237-.037a1.557 1.557 0 0 0 0 2.2c-.239.1-.501.238-.715.453a1.56 1.56 0 0 0 0 2.2l.516.515a1.556 1.556 0 0 0-.753 2.615L7.01 19c1.32 1.319 2.909 2.189 4.475 2.449q.482.08.971.08c.85 0 1.653-.198 2.393-.579.231.033.46.054.686.054 1.266 0 2.457-.52 3.505-1.567 2.763-2.763 2.552-5.734 1.439-7.586z\" clip-rule=\"evenodd\"></path></svg>\n        </button>\n        <span class=\"wp-applause-count\">12</span>\n    </div>\n    </div>\n						</div>\n				<div class=\"elementor-element elementor-element-36e02a7 elementor-position-right elementor-mobile-position-left elementor-view-default elementor-widget elementor-widget-icon-box\" data-id=\"36e02a7\" data-element_type=\"widget\" data-widget_type=\"icon-box.default\">\n							<div class=\"elementor-icon-box-wrapper\">\n\n						<div class=\"elementor-icon-box-icon\">\n				<a href=\"#comments\" class=\"elementor-icon\" tabindex=\"-1\">\n				<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-far-comments\" viewBox=\"0 0 576 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M532 386.2c27.5-27.1 44-61.1 44-98.2 0-80-76.5-146.1-176.2-157.9C368.3 72.5 294.3 32 208 32 93.1 32 0 103.6 0 192c0 37 16.5 71 44 98.2-15.3 30.7-37.3 54.5-37.7 54.9-6.3 6.7-8.1 16.5-4.4 25 3.6 8.5 12 14 21.2 14 53.5 0 96.7-20.2 125.2-38.8 9.2 2.1 18.7 3.7 28.4 4.9C208.1 407.6 281.8 448 368 448c20.8 0 40.8-2.4 59.8-6.8C456.3 459.7 499.4 480 553 480c9.2 0 17.5-5.5 21.2-14 3.6-8.5 1.9-18.3-4.4-25-.4-.3-22.5-24.1-37.8-54.8zm-392.8-92.3L122.1 305c-14.1 9.1-28.5 16.3-43.1 21.4 2.7-4.7 5.4-9.7 8-14.8l15.5-31.1L77.7 256C64.2 242.6 48 220.7 48 192c0-60.7 73.3-112 160-112s160 51.3 160 112-73.3 112-160 112c-16.5 0-33-1.9-49-5.6l-19.8-4.5zM498.3 352l-24.7 24.4 15.5 31.1c2.6 5.1 5.3 10.1 8 14.8-14.6-5.1-29-12.3-43.1-21.4l-17.1-11.1-19.9 4.6c-16 3.7-32.5 5.6-49 5.6-54 0-102.2-20.1-131.3-49.7C338 339.5 416 272.9 416 192c0-3.4-.4-6.7-.7-10C479.7 196.5 528 238.8 528 288c0 28.7-16.2 50.6-29.7 64z\"></path></svg>				</a>\n			</div>\n			\n			\n		</div>\n						</div>\n				</div>\n		<div class=\"elementor-element elementor-element-82f4de6 e-con-full elementor-hidden-mobile e-flex e-con e-child\" data-id=\"82f4de6\" data-element_type=\"container\">\n				<div class=\"elementor-element elementor-element-cea0a0c elementor-share-buttons--view-icon elementor-share-buttons--skin-framed elementor-share-buttons--color-custom elementor-share-buttons--shape-square elementor-grid-0 elementor-widget elementor-widget-share-buttons\" data-id=\"cea0a0c\" data-element_type=\"widget\" data-widget_type=\"share-buttons.default\">\n							<div class=\"elementor-grid\" role=\"list\">\n								<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_facebook\" role=\"button\" tabindex=\"0\" aria-label=\"Share on facebook\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-facebook\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M504 256C504 119 393 8 256 8S8 119 8 256c0 123.78 90.69 226.38 209.25 245V327.69h-63V256h63v-54.64c0-62.15 37-96.48 93.67-96.48 27.14 0 55.52 4.84 55.52 4.84v61h-31.28c-30.8 0-40.41 19.12-40.41 38.73V256h68.78l-11 71.69h-57.78V501C413.31 482.38 504 379.78 504 256z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_x-twitter\" role=\"button\" tabindex=\"0\" aria-label=\"Share on x-twitter\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-x-twitter\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M389.2 48h70.6L305.6 224.2 487 464H345L233.7 318.6 106.5 464H35.8L200.7 275.5 26.8 48H172.4L272.9 180.9 389.2 48zM364.4 421.8h39.1L151.1 88h-42L364.4 421.8z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_pinterest\" role=\"button\" tabindex=\"0\" aria-label=\"Share on pinterest\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-pinterest\" viewBox=\"0 0 496 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M496 256c0 137-111 248-248 248-25.6 0-50.2-3.9-73.4-11.1 10.1-16.5 25.2-43.5 30.8-65 3-11.6 15.4-59 15.4-59 8.1 15.4 31.7 28.5 56.8 28.5 74.8 0 128.7-68.8 128.7-154.3 0-81.9-66.9-143.2-152.9-143.2-107 0-163.9 71.8-163.9 150.1 0 36.4 19.4 81.7 50.3 96.1 4.7 2.2 7.2 1.2 8.3-3.3.8-3.4 5-20.3 6.9-28.1.6-2.5.3-4.7-1.7-7.1-10.1-12.5-18.3-35.3-18.3-56.6 0-54.7 41.4-107.6 112-107.6 60.9 0 103.6 41.5 103.6 100.9 0 67.1-33.9 113.6-78 113.6-24.3 0-42.6-20.1-36.7-44.8 7-29.5 20.5-61.3 20.5-82.6 0-19-10.2-34.9-31.4-34.9-24.9 0-44.9 25.7-44.9 60.2 0 22 7.4 36.8 7.4 36.8s-24.5 103.8-29 123.2c-5 21.4-3 51.6-.9 71.2C65.4 450.9 0 361.1 0 256 0 119 111 8 248 8s248 111 248 248z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_linkedin\" role=\"button\" tabindex=\"0\" aria-label=\"Share on linkedin\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-linkedin\" viewBox=\"0 0 448 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M416 32H31.9C14.3 32 0 46.5 0 64.3v383.4C0 465.5 14.3 480 31.9 480H416c17.6 0 32-14.5 32-32.3V64.3c0-17.8-14.4-32.3-32-32.3zM135.4 416H69V202.2h66.5V416zm-33.2-243c-21.3 0-38.5-17.3-38.5-38.5S80.9 96 102.2 96c21.2 0 38.5 17.3 38.5 38.5 0 21.3-17.2 38.5-38.5 38.5zm282.1 243h-66.4V312c0-24.8-.5-56.7-34.5-56.7-34.6 0-39.9 27-39.9 54.9V416h-66.4V202.2h63.7v29.2h.9c8.9-16.8 30.6-34.5 62.9-34.5 67.2 0 79.7 44.3 79.7 101.9V416z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_reddit\" role=\"button\" tabindex=\"0\" aria-label=\"Share on reddit\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-reddit\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M201.5 305.5c-13.8 0-24.9-11.1-24.9-24.6 0-13.8 11.1-24.9 24.9-24.9 13.6 0 24.6 11.1 24.6 24.9 0 13.6-11.1 24.6-24.6 24.6zM504 256c0 137-111 248-248 248S8 393 8 256 119 8 256 8s248 111 248 248zm-132.3-41.2c-9.4 0-17.7 3.9-23.8 10-22.4-15.5-52.6-25.5-86.1-26.6l17.4-78.3 55.4 12.5c0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.3 24.9-24.9s-11.1-24.9-24.9-24.9c-9.7 0-18 5.8-22.1 13.8l-61.2-13.6c-3-.8-6.1 1.4-6.9 4.4l-19.1 86.4c-33.2 1.4-63.1 11.3-85.5 26.8-6.1-6.4-14.7-10.2-24.1-10.2-34.9 0-46.3 46.9-14.4 62.8-1.1 5-1.7 10.2-1.7 15.5 0 52.6 59.2 95.2 132 95.2 73.1 0 132.3-42.6 132.3-95.2 0-5.3-.6-10.8-1.9-15.8 31.3-16 19.8-62.5-14.9-62.5zM302.8 331c-18.2 18.2-76.1 17.9-93.6 0-2.2-2.2-6.1-2.2-8.3 0-2.5 2.5-2.5 6.4 0 8.6 22.8 22.8 87.3 22.8 110.2 0 2.5-2.2 2.5-6.1 0-8.6-2.2-2.2-6.1-2.2-8.3 0zm7.7-75c-13.6 0-24.6 11.1-24.6 24.9 0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.1 24.9-24.6 0-13.8-11-24.9-24.9-24.9z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_whatsapp\" role=\"button\" tabindex=\"0\" aria-label=\"Share on whatsapp\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-whatsapp\" viewBox=\"0 0 448 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M380.9 97.1C339 55.1 283.2 32 223.9 32c-122.4 0-222 99.6-222 222 0 39.1 10.2 77.3 29.6 111L0 480l117.7-30.9c32.4 17.7 68.9 27 106.1 27h.1c122.3 0 224.1-99.6 224.1-222 0-59.3-25.2-115-67.1-157zm-157 341.6c-33.2 0-65.7-8.9-94-25.7l-6.7-4-69.8 18.3L72 359.2l-4.4-7c-18.5-29.4-28.2-63.3-28.2-98.2 0-101.7 82.8-184.5 184.6-184.5 49.3 0 95.6 19.2 130.4 54.1 34.8 34.9 56.2 81.2 56.1 130.5 0 101.8-84.9 184.6-186.6 184.6zm101.2-138.2c-5.5-2.8-32.8-16.2-37.9-18-5.1-1.9-8.8-2.8-12.5 2.8-3.7 5.6-14.3 18-17.6 21.8-3.2 3.7-6.5 4.2-12 1.4-32.6-16.3-54-29.1-75.5-66-5.7-9.8 5.7-9.1 16.3-30.3 1.8-3.7.9-6.9-.5-9.7-1.4-2.8-12.5-30.1-17.1-41.2-4.5-10.8-9.1-9.3-12.5-9.5-3.2-.2-6.9-.2-10.6-.2-3.7 0-9.7 1.4-14.8 6.9-5.1 5.6-19.4 19-19.4 46.3 0 27.3 19.9 53.7 22.6 57.4 2.8 3.7 39.1 59.7 94.8 83.8 35.2 15.2 49 16.5 66.6 13.9 10.7-1.6 32.8-13.4 37.4-26.4 4.6-13 4.6-24.1 3.2-26.4-1.3-2.5-5-3.9-10.5-6.6z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_email\" role=\"button\" tabindex=\"0\" aria-label=\"Share on email\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fas-envelope\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M502.3 190.8c3.9-3.1 9.7-.2 9.7 4.7V400c0 26.5-21.5 48-48 48H48c-26.5 0-48-21.5-48-48V195.6c0-5 5.7-7.8 9.7-4.7 22.4 17.4 52.1 39.5 154.1 113.6 21.1 15.4 56.7 47.8 92.2 47.6 35.7.3 72-32.8 92.3-47.6 102-74.1 131.6-96.3 154-113.7zM256 320c23.2.4 56.6-29.2 73.4-41.4 132.7-96.3 142.8-104.7 173.4-128.7 5.8-4.5 9.2-11.5 9.2-18.9v-19c0-26.5-21.5-48-48-48H48C21.5 64 0 85.5 0 112v19c0 7.4 3.4 14.3 9.2 18.9 30.6 23.9 40.7 32.4 173.4 128.7 16.8 12.2 50.2 41.8 73.4 41.4z\"></path></svg>							</span>\n																				</div>\n					</div>\n						</div>\n						</div>\n				</div>\n				</div>\n					</div>\n				</div>\n		<div class=\"elementor-element elementor-element-95ebea8 elementor-hidden-desktop elementor-hidden-tablet e-flex e-con-boxed e-con e-parent\" data-id=\"95ebea8\" data-element_type=\"container\">\n					<div class=\"e-con-inner\">\n		<div class=\"elementor-element elementor-element-123fb1f e-con-full e-flex e-con e-child\" data-id=\"123fb1f\" data-element_type=\"container\">\n		<div class=\"elementor-element elementor-element-1b37cd3 e-con-full e-flex e-con e-child\" data-id=\"1b37cd3\" data-element_type=\"container\">\n				<div class=\"elementor-element elementor-element-837efb5 elementor-widget elementor-widget-shortcode\" data-id=\"837efb5\" data-element_type=\"widget\" data-widget_type=\"shortcode.default\">\n							<div class=\"elementor-shortcode\">    <div class=\"wp-applause-container\" data-post-id=\"7359\">\n        <button class=\"wp-applause-button\" data-post-id=\"7359\">\n            <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" aria-label=\"clap\"><path fill-rule=\"evenodd\" d=\"M11.37.828 12 3.282l.63-2.454zM13.916 3.953l1.523-2.112-1.184-.39zM8.589 1.84l1.522 2.112-.337-2.501zM18.523 18.92c-.86.86-1.75 1.246-2.62 1.33a6 6 0 0 0 .407-.372c2.388-2.389 2.86-4.951 1.399-7.623l-.912-1.603-.79-1.672c-.26-.56-.194-.98.203-1.288a.7.7 0 0 1 .546-.132c.283.046.546.231.728.5l2.363 4.157c.976 1.624 1.141 4.237-1.324 6.702m-10.999-.438L3.37 14.328a.828.828 0 0 1 .585-1.408.83.83 0 0 1 .585.242l2.158 2.157a.365.365 0 0 0 .516-.516l-2.157-2.158-1.449-1.449a.826.826 0 0 1 1.167-1.17l3.438 3.44a.363.363 0 0 0 .516 0 .364.364 0 0 0 0-.516L5.293 9.513l-.97-.97a.826.826 0 0 1 0-1.166.84.84 0 0 1 1.167 0l.97.968 3.437 3.436a.36.36 0 0 0 .517 0 .366.366 0 0 0 0-.516L6.977 7.83a.82.82 0 0 1-.241-.584.82.82 0 0 1 .824-.826c.219 0 .43.087.584.242l5.787 5.787a.366.366 0 0 0 .587-.415l-1.117-2.363c-.26-.56-.194-.98.204-1.289a.7.7 0 0 1 .546-.132c.283.046.545.232.727.501l2.193 3.86c1.302 2.38.883 4.59-1.277 6.75-1.156 1.156-2.602 1.627-4.19 1.367-1.418-.236-2.866-1.033-4.079-2.246M10.75 5.971l2.12 2.12c-.41.502-.465 1.17-.128 1.89l.22.465-3.523-3.523a.8.8 0 0 1-.097-.368c0-.22.086-.428.241-.584a.847.847 0 0 1 1.167 0m7.355 1.705c-.31-.461-.746-.758-1.23-.837a1.44 1.44 0 0 0-1.11.275c-.312.24-.505.543-.59.881a1.74 1.74 0 0 0-.906-.465 1.47 1.47 0 0 0-.82.106l-2.182-2.182a1.56 1.56 0 0 0-2.2 0 1.54 1.54 0 0 0-.396.701 1.56 1.56 0 0 0-2.21-.01 1.55 1.55 0 0 0-.416.753c-.624-.624-1.649-.624-2.237-.037a1.557 1.557 0 0 0 0 2.2c-.239.1-.501.238-.715.453a1.56 1.56 0 0 0 0 2.2l.516.515a1.556 1.556 0 0 0-.753 2.615L7.01 19c1.32 1.319 2.909 2.189 4.475 2.449q.482.08.971.08c.85 0 1.653-.198 2.393-.579.231.033.46.054.686.054 1.266 0 2.457-.52 3.505-1.567 2.763-2.763 2.552-5.734 1.439-7.586z\" clip-rule=\"evenodd\"></path></svg>\n        </button>\n        <span class=\"wp-applause-count\">12</span>\n    </div>\n    </div>\n						</div>\n				<div class=\"elementor-element elementor-element-5bf9dbd elementor-icon-list--layout-inline elementor-mobile-align-center elementor-list-item-link-full_width elementor-widget elementor-widget-icon-list\" data-id=\"5bf9dbd\" data-element_type=\"widget\" data-widget_type=\"icon-list.default\">\n							<ul class=\"elementor-icon-list-items elementor-inline-items\">\n							<li class=\"elementor-icon-list-item elementor-inline-item\">\n											<a href=\"#comments\">\n\n												<span class=\"elementor-icon-list-icon\">\n							<i aria-hidden=\"true\" class=\"huge huge-comment-01\"></i>						</span>\n										<span class=\"elementor-icon-list-text\"></span>\n											</a>\n									</li>\n								<li class=\"elementor-icon-list-item elementor-inline-item\">\n											<a href=\"#elementor-action%3Aaction%3Dpopup%3Aopen%26settings%3DeyJpZCI6IjYxOTMiLCJ0b2dnbGUiOmZhbHNlfQ%3D%3D\">\n\n												<span class=\"elementor-icon-list-icon\">\n							<i aria-hidden=\"true\" class=\"huge huge-share-05\"></i>						</span>\n										<span class=\"elementor-icon-list-text\"></span>\n											</a>\n									</li>\n						</ul>\n						</div>\n				</div>\n		<div class=\"elementor-element elementor-element-8608e80 e-con-full elementor-hidden-mobile e-flex e-con e-child\" data-id=\"8608e80\" data-element_type=\"container\">\n				<div class=\"elementor-element elementor-element-0bb15f1 elementor-share-buttons--view-icon elementor-share-buttons--skin-framed elementor-share-buttons--color-custom elementor-share-buttons--shape-square elementor-grid-0 elementor-widget elementor-widget-share-buttons\" data-id=\"0bb15f1\" data-element_type=\"widget\" data-widget_type=\"share-buttons.default\">\n							<div class=\"elementor-grid\" role=\"list\">\n								<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_facebook\" role=\"button\" tabindex=\"0\" aria-label=\"Share on facebook\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-facebook\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M504 256C504 119 393 8 256 8S8 119 8 256c0 123.78 90.69 226.38 209.25 245V327.69h-63V256h63v-54.64c0-62.15 37-96.48 93.67-96.48 27.14 0 55.52 4.84 55.52 4.84v61h-31.28c-30.8 0-40.41 19.12-40.41 38.73V256h68.78l-11 71.69h-57.78V501C413.31 482.38 504 379.78 504 256z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_x-twitter\" role=\"button\" tabindex=\"0\" aria-label=\"Share on x-twitter\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-x-twitter\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M389.2 48h70.6L305.6 224.2 487 464H345L233.7 318.6 106.5 464H35.8L200.7 275.5 26.8 48H172.4L272.9 180.9 389.2 48zM364.4 421.8h39.1L151.1 88h-42L364.4 421.8z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_pinterest\" role=\"button\" tabindex=\"0\" aria-label=\"Share on pinterest\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-pinterest\" viewBox=\"0 0 496 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M496 256c0 137-111 248-248 248-25.6 0-50.2-3.9-73.4-11.1 10.1-16.5 25.2-43.5 30.8-65 3-11.6 15.4-59 15.4-59 8.1 15.4 31.7 28.5 56.8 28.5 74.8 0 128.7-68.8 128.7-154.3 0-81.9-66.9-143.2-152.9-143.2-107 0-163.9 71.8-163.9 150.1 0 36.4 19.4 81.7 50.3 96.1 4.7 2.2 7.2 1.2 8.3-3.3.8-3.4 5-20.3 6.9-28.1.6-2.5.3-4.7-1.7-7.1-10.1-12.5-18.3-35.3-18.3-56.6 0-54.7 41.4-107.6 112-107.6 60.9 0 103.6 41.5 103.6 100.9 0 67.1-33.9 113.6-78 113.6-24.3 0-42.6-20.1-36.7-44.8 7-29.5 20.5-61.3 20.5-82.6 0-19-10.2-34.9-31.4-34.9-24.9 0-44.9 25.7-44.9 60.2 0 22 7.4 36.8 7.4 36.8s-24.5 103.8-29 123.2c-5 21.4-3 51.6-.9 71.2C65.4 450.9 0 361.1 0 256 0 119 111 8 248 8s248 111 248 248z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_linkedin\" role=\"button\" tabindex=\"0\" aria-label=\"Share on linkedin\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-linkedin\" viewBox=\"0 0 448 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M416 32H31.9C14.3 32 0 46.5 0 64.3v383.4C0 465.5 14.3 480 31.9 480H416c17.6 0 32-14.5 32-32.3V64.3c0-17.8-14.4-32.3-32-32.3zM135.4 416H69V202.2h66.5V416zm-33.2-243c-21.3 0-38.5-17.3-38.5-38.5S80.9 96 102.2 96c21.2 0 38.5 17.3 38.5 38.5 0 21.3-17.2 38.5-38.5 38.5zm282.1 243h-66.4V312c0-24.8-.5-56.7-34.5-56.7-34.6 0-39.9 27-39.9 54.9V416h-66.4V202.2h63.7v29.2h.9c8.9-16.8 30.6-34.5 62.9-34.5 67.2 0 79.7 44.3 79.7 101.9V416z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_reddit\" role=\"button\" tabindex=\"0\" aria-label=\"Share on reddit\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-reddit\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M201.5 305.5c-13.8 0-24.9-11.1-24.9-24.6 0-13.8 11.1-24.9 24.9-24.9 13.6 0 24.6 11.1 24.6 24.9 0 13.6-11.1 24.6-24.6 24.6zM504 256c0 137-111 248-248 248S8 393 8 256 119 8 256 8s248 111 248 248zm-132.3-41.2c-9.4 0-17.7 3.9-23.8 10-22.4-15.5-52.6-25.5-86.1-26.6l17.4-78.3 55.4 12.5c0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.3 24.9-24.9s-11.1-24.9-24.9-24.9c-9.7 0-18 5.8-22.1 13.8l-61.2-13.6c-3-.8-6.1 1.4-6.9 4.4l-19.1 86.4c-33.2 1.4-63.1 11.3-85.5 26.8-6.1-6.4-14.7-10.2-24.1-10.2-34.9 0-46.3 46.9-14.4 62.8-1.1 5-1.7 10.2-1.7 15.5 0 52.6 59.2 95.2 132 95.2 73.1 0 132.3-42.6 132.3-95.2 0-5.3-.6-10.8-1.9-15.8 31.3-16 19.8-62.5-14.9-62.5zM302.8 331c-18.2 18.2-76.1 17.9-93.6 0-2.2-2.2-6.1-2.2-8.3 0-2.5 2.5-2.5 6.4 0 8.6 22.8 22.8 87.3 22.8 110.2 0 2.5-2.2 2.5-6.1 0-8.6-2.2-2.2-6.1-2.2-8.3 0zm7.7-75c-13.6 0-24.6 11.1-24.6 24.9 0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.1 24.9-24.6 0-13.8-11-24.9-24.9-24.9z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_whatsapp\" role=\"button\" tabindex=\"0\" aria-label=\"Share on whatsapp\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-whatsapp\" viewBox=\"0 0 448 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M380.9 97.1C339 55.1 283.2 32 223.9 32c-122.4 0-222 99.6-222 222 0 39.1 10.2 77.3 29.6 111L0 480l117.7-30.9c32.4 17.7 68.9 27 106.1 27h.1c122.3 0 224.1-99.6 224.1-222 0-59.3-25.2-115-67.1-157zm-157 341.6c-33.2 0-65.7-8.9-94-25.7l-6.7-4-69.8 18.3L72 359.2l-4.4-7c-18.5-29.4-28.2-63.3-28.2-98.2 0-101.7 82.8-184.5 184.6-184.5 49.3 0 95.6 19.2 130.4 54.1 34.8 34.9 56.2 81.2 56.1 130.5 0 101.8-84.9 184.6-186.6 184.6zm101.2-138.2c-5.5-2.8-32.8-16.2-37.9-18-5.1-1.9-8.8-2.8-12.5 2.8-3.7 5.6-14.3 18-17.6 21.8-3.2 3.7-6.5 4.2-12 1.4-32.6-16.3-54-29.1-75.5-66-5.7-9.8 5.7-9.1 16.3-30.3 1.8-3.7.9-6.9-.5-9.7-1.4-2.8-12.5-30.1-17.1-41.2-4.5-10.8-9.1-9.3-12.5-9.5-3.2-.2-6.9-.2-10.6-.2-3.7 0-9.7 1.4-14.8 6.9-5.1 5.6-19.4 19-19.4 46.3 0 27.3 19.9 53.7 22.6 57.4 2.8 3.7 39.1 59.7 94.8 83.8 35.2 15.2 49 16.5 66.6 13.9 10.7-1.6 32.8-13.4 37.4-26.4 4.6-13 4.6-24.1 3.2-26.4-1.3-2.5-5-3.9-10.5-6.6z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_email\" role=\"button\" tabindex=\"0\" aria-label=\"Share on email\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fas-envelope\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M502.3 190.8c3.9-3.1 9.7-.2 9.7 4.7V400c0 26.5-21.5 48-48 48H48c-26.5 0-48-21.5-48-48V195.6c0-5 5.7-7.8 9.7-4.7 22.4 17.4 52.1 39.5 154.1 113.6 21.1 15.4 56.7 47.8 92.2 47.6 35.7.3 72-32.8 92.3-47.6 102-74.1 131.6-96.3 154-113.7zM256 320c23.2.4 56.6-29.2 73.4-41.4 132.7-96.3 142.8-104.7 173.4-128.7 5.8-4.5 9.2-11.5 9.2-18.9v-19c0-26.5-21.5-48-48-48H48C21.5 64 0 85.5 0 112v19c0 7.4 3.4 14.3 9.2 18.9 30.6 23.9 40.7 32.4 173.4 128.7 16.8 12.2 50.2 41.8 73.4 41.4z\"></path></svg>							</span>\n																				</div>\n					</div>\n						</div>\n						</div>\n				</div>\n				</div>\n					</div>\n				</div>\n				</div>\n		</div>\n						</div>\n					</div>\n				', 'Introduction: The Unspoken Fear AI is changing the world fast. In many industries, it’s already improving speed, accuracy, and efficiency. In healthcare, the potential is massive. From reducing paperwork to helping with diagnosis, AI promises to save time and support doctors. But there’s a fear no one is talking about openly: “What if the AI gives the wrong recommendation? Who will be blamed?” It’s a fair question. Because healthcare isn’t like choosing a movie on Netflix. If a streaming app suggests a bad movie, the worst that happens is you waste two hours. But if an AI system suggests the wrong medicine, the consequences can be serious—even life-threatening. This is the reason many doctors hesitate to bring AI into their clinics. Not because they don’t see the benefits, but because they’re unsure what happens if something goes wrong. In this blog, we’ll talk honestly about this concern. Who’s responsible? How can you use AI safely? And most importantly how can you take advantage of AI without putting your license or your patients at risk? Let’s get into it. How AI Works in Clinical Settings (and Where It Doesn’t) Before getting into liability, let’s understand what AI actually can do in clinics today and more importantly, what it won’t do. Most AI tools in healthcare are assistive, not autonomous. They don’t make final decisions. They support the existing processes at your clinic. For example: AI-powered chatbots can answer general user queries, guide patients to book appointments, and help them understand pre-visit instructions. Clinical decision support tools can highlight drug interactions or suggest possible diagnoses based on symptoms and test results. Natural language processing (NLP) models can summarize patient notes, extract relevant information from records, and help doctors document faster. Predictive algorithms may flag high-risk patients for follow-ups or recommend screening tests. But here’s the key: AI is not replacing clinical judgment. At least not in regulated, real-world use cases. The final responsibility to prescribe, diagnose, or act on AI recommendations still lies with the doctor. That said, the lines can get blurry when AI recommendations feel authoritative or when time pressure leads to over-reliance. Let’s say: An AI assistant suggests a medication. The doctor, overwhelmed with back-to-back patients, accepts the recommendation without verifying. The patient has an allergy and suffers a reaction. Now, was it the AI’s fault? Not quite. Because AI is not the licensed medical professional. But this is where it gets complicated and where systems, laws, and common sense need to work together. Let’s explore that next. Who Is Legally Responsible if AI Gets It Wrong? This is the core concern many doctors raise and rightly so. If an AI tool suggests a wrong medication, and a patient is harmed, who is accountable? Let’s unpack it without the legal jargon. 1. Doctors Are Still the Final Authority In most countries, AI tools in healthcare are classified as “decision support systems” not autonomous decision-makers. That means: The doctor is the one prescribing the medicine. The doctor is the one signing off on the treatment plan. And yes, if something goes wrong, the doctor is still liable. It’s not because AI can’t be useful, it’s because medical licenses are issued to people, not software. In India, the Telemedicine Practice Guidelines (issued by the Ministry of Health and Family Welfare, 2020) clearly state: “The final responsibility of diagnosis and prescription lies with the registered medical practitioner.” The same principle applies under HIPAA in the U.S., GDPR in Europe, and NDHM (now ABDM) in India: AI tools must support—not replace—medical professionals. Also, If an AI assistant gives an incorrect recommendation directly to a patient such as suggesting the wrong medicine or misguiding them about a symptom the responsibility can become more complex. However, in most current legal frameworks, unless the AI is officially classified and regulated as a medical device, the liability often still circles back to the healthcare provider or institution overseeing its deployment. But here’s where things are changing. 2. Shared Accountability Is Emerging In recent years, there’s been a growing debate: If AI is so advanced, shouldn’t the developers, vendors, or hospitals share responsibility too? That’s starting to happen. Some hospitals are now requiring AI vendors to include indemnity clauses in contracts. Regulators like the FDA (U.S.) and EMA (Europe) are evaluating how to classify AI tools as “medical devices”—which means they’ll need to meet strict safety and performance standards before deployment. In India, as the Ayushman Bharat Digital Mission expands, discussions around data privacy, clinical safety, and AI accountability are getting more attention. The future of AI in healthcare is moving toward shared responsibility. As AI tools become more common, especially in commercial use, developers and hospitals may also be held accountable. The goal is to avoid placing all the blame on doctors alone. What Should Doctors Ask Before Using Any AI Tool in Their Clinic? Not all AI tools are the same. Some tools are helpful and safe. Others are poorly tested, overhyped, or just not made for real clinical environments. If you’re considering AI for your clinic, here are 5 key questions to ask—without needing a legal team or tech background. 1. Is the AI tool medically validated? Has it been tested in real clinics or hospitals? Are there peer-reviewed studies or user testimonials from other doctors? Don’t just take the vendor’s word for it—look for other customers’ validation. 2. How does it handle sensitive patient data? Is patient data stored locally or sent to the cloud? Is the data encrypted and anonymized? Does it comply with NDHM/ABDM (India), HIPAA (US), or GDPR (Europe)? You’re still responsible for your patient’s privacy even if the AI tool is the one collecting data. 3. Will it integrate with my existing workflow? Does it work with your current EMR or appointment system? Will your staff need hours of training to use it? Can it automate tasks without disrupting patient flow? A good AI tool should save time, not create new work. 4. Can I easily override or edit its suggestions? You should never feel like you have to follow what the AI says. Look for tools that support—not replace—your clinical judgment. You’re the doctor. The AI is the assistant, not the other way around. What Can Doctors Do Today to Use AI Safely in Their Practice? You don’t need to wait for perfect regulation or 100% flawless tools. Many clinics are already using AI safely and getting real results. The future of AI in medicine and what it means for physicians and practices with Tom Lawry Here’s what you can start doing right now: 1. Use AI for low-risk, repetitive tasks first Start with areas where mistakes are unlikely to cause harm: Appointment reminders Answering common patient questions Collecting patient history Sending pre-visit instructions These use cases save your team hours without touching medical decisions. 2. Always keep human oversight in place No matter how smart the AI seems—don’t leave it unsupervised. Review any medical suggestion made by the AI Ensure nurses or admins double-check responses frequently Use AI as a draft generator, not a final decision-maker You remain the final authority. Always. 3. Involve your team in the process Doctors, nurses, receptionists—everyone who uses the AI tool should have a say. Ask what’s working and what’s not Encourage feedback on AI mistakes or blind spots Make sure everyone knows when to escalate to a human expert The goal is not just tech adoption—it’s smarter team collaboration. 4. Be transparent with patients (when needed) If AI is being used to respond to queries or collect symptoms: Let patients know it’s an automated system Reassure them that a human is still reviewing their case Give them the option to speak to a doctor directly This builds trust—and protects your clinic. Why Doctors Will Always Remain Essential—No Matter How Smart AI Gets With all the talk about AI taking over, it’s easy to feel uncertain. But let’s take a step back and remember: AI might be fast, but it doesn’t replace what makes doctors truly valuable. Here’s why your role isn’t just safe, it’s irreplaceable. 1. Medicine is about people, not just data AI can read reports. It can process symptoms. But it can’t sit across from a patient, notice the anxiety in their eyes, and say the right words to comfort them. That human connection? That’s where healing often begins—and AI can’t replicate it. 2. Your clinical judgment is built on years of training and experience AI can suggest a diagnosis. But it doesn’t know your patient’s full story, the nuance in their symptoms, or what you’ve learned from years of seeing similar cases. You make decisions based not just on data—but on patterns, context, and real-life experience. That’s something no algorithm can fully understand. 3. Patients still want a human in charge Even if AI gets better at diagnosis or documentation, studies show patients still want to talk to a real doctor. They want to know someone cares. That someone is responsible. That someone understands. You are the face of trust in healthcare. And that doesn’t change—whether there’s AI in the room or not. 4. AI still needs direction, limits, and supervision AI is like a powerful medical tool—just like an MRI or ultrasound machine. It’s only as useful as the person using it. And in clinics, that person will always be you. Your role is shifting—not shrinking. You’re no longer just diagnosing or prescribing; you’re leading the smart systems that support patient care. Final Thoughts: Blame, Trust, and the Role of Doctors in an AI-Driven Future So, what happens if AI suggests the wrong medicine? The short answer: Doctors are still in charge, and hence responsible. Even as AI tools become more advanced, healthcare decisions, especially ones involving medication—will continue to require human supervision. Doctors won’t just “use” AI. They’ll guide it, question it, and override it when necessary. So, where does that leave us? If used responsibly, AI won’t introduce risk—it’ll reduce it. It can: Help filter patient information quickly Flag inconsistencies or high-risk cases Reduce time spent on routine documentation Offer reminders, summaries, or decision-support tools And that’s where platforms like BeyondChats come in. At BeyondChats, we build AI-powered assistants for clinics and hospitals—not to replace staff, but to take over repetitive admin tasks, guide patients with common queries, and help surface actionable insights for the medical team. Our systems are custom-built for healthcare workflows and are always designed to keep the doctor in control. We understand the concerns around liability, patient safety, and professional autonomy—and we build with those priorities in mind. The future of medicine isn’t AI vs. doctors. It’s AI and doctors, working together. Let AI handle the paperwork. Let it track patient follow-ups, qualify your patients, and answer basic questions. But when it comes to life, health, and healing—that’s still your call. And it always will be. AI is a tool. But doctors? You are—and always will be—the decision-makers in healthcare. 12', NULL, '2025-03-23 18:30:00', 'https://beyondchats.com/blogs/what-if-ai-recommends-the-wrong-medicine-whos-to-blame-2/', 0, NULL, NULL, '2025-12-30 13:05:01', '2025-12-30 13:05:01', 'General');
INSERT INTO `articles` (`id`, `title`, `original_content_html`, `original_content_text`, `author`, `published_date`, `source_url`, `is_updated`, `updated_content`, `references`, `created_at`, `updated_at`, `category`) VALUES
(4, 'Your website needs a receptionist', '\n					<div class=\"e-con-inner\">\n				<div class=\"elementor-element elementor-element-b2a436b elementor-widget elementor-widget-theme-post-content\" data-id=\"b2a436b\" data-element_type=\"widget\" data-widget_type=\"theme-post-content.default\">\n					\n<figure class=\"wp-block-image aligncenter size-large is-resized\"><a href=\"https://beyondchats.com/wp-content/uploads/2025/03/get-ai-receptionist-for-your-website-2.jpg\"><img decoding=\"async\" src=\"https://beyondchats.com/wp-content/uploads/2025/03/get-ai-receptionist-for-your-website-2-1024x1024.jpg\" alt=\"get ai receptionist for your website 2\" class=\"wp-image-7256\" style=\"width:446px;height:auto\"></a><figcaption class=\"wp-element-caption\">A receptionist on your website is as important as the one in your office!</figcaption></figure>\n\n\n\n<p><strong>Stop treating your website like a brochure</strong>!</p>\n\n\n\n<p>Do you have a receptionist / assistant present at your clinic or office whose sole responsibility is to talk to customers and make them feel at ease while they wait for you?</p>\n\n\n\n<p>Then why is your website—your <em>most visible</em> digital property, silent when someone walks in?</p>\n\n\n\n<hr class=\"wp-block-separator has-alpha-channel-opacity\">\n\n\n\n<h2 class=\"wp-block-heading\">People Are Landing on Your Website. Then Leaving.</h2>\n\n\n\n<p>Let me tell you what’s actually happening.</p>\n\n\n\n<p>Someone clicks your ad or finds you on Google. They land on your site. They scroll. They don’t find what they’re looking for. They leave.</p>\n\n\n\n<p>No booking. No contact. No engagement.</p>\n\n\n\n<p>You just lost a potential patient, client, or customer. And worse? You paid for that click.</p>\n\n\n\n<hr class=\"wp-block-separator has-alpha-channel-opacity\">\n\n\n\n<h2 class=\"wp-block-heading\">A Beautiful Website Isn’t Enough</h2>\n\n\n\n<p>You might be thinking, <em>“But we spent a lot on our website. It’s clean, it’s mobile-friendly, it has all the info!”</em></p>\n\n\n\n<p>Cool. So does everyone else.</p>\n\n\n\n<p><a href=\"https://www.reddit.com/r/webdev/comments/1jeqbfn/cool_websites_but_they_dont_convert/\" target=\"_blank\" rel=\"noopener\">Design alone doesn’t convert.</a> Information doesn’t engage. People need guidance.</p>\n\n\n\n<p>Imagine walking into a Doctor’s clinic and no one greets you, no one asks what you need, and you have to <em>find your way around alone</em>.</p>\n\n\n\n<p>That would be so confusing! Nobody will visit that clinic again! <br>That’s what your website is doing right now.</p>\n\n\n\n<hr class=\"wp-block-separator has-alpha-channel-opacity\">\n\n\n\n<h2 class=\"wp-block-heading\">What Would a Website Receptionist Do?</h2>\n\n\n\n<p>Glad you asked.</p>\n\n\n\n<p>Here’s what it <em>should</em> do:</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Greet every website visitor with a comforting message!</li>\n\n\n\n<li>Answer first-level of users’ questions (services, pricing, availability, queries about other info available on your website’s articles)</li>\n\n\n\n<li>Help people <em>book appointments</em> or understand which service is right for their needs</li>\n\n\n\n<li>Qualify leads into those most likely to use your services, so your team isn’t wasting time on “just curious” browsers</li>\n\n\n\n<li>Collect feedback, comfort users, and even flag urgent queries so you can be more effective at your job</li>\n</ul>\n\n\n\n<p>And all of this – without your users having to wait for their turn. Everyone gets your digital receptionist’s full attention instantly, every time!</p>\n\n\n\n<hr class=\"wp-block-separator has-alpha-channel-opacity\">\n\n\n\n<h2 class=\"wp-block-heading\">“But We Have a Contact Form”</h2>\n\n\n\n<p>No. Stop.</p>\n\n\n\n<p>That’s like putting a suggestion box at your clinic entrance and calling it customer service.</p>\n\n\n\n<figure class=\"wp-block-image aligncenter size-full is-resized\"><a href=\"https://beyondchats.com/wp-content/uploads/2025/03/empty-office-with-locked-suggestions-box.webp\"><img decoding=\"async\" src=\"https://beyondchats.com/wp-content/uploads/2025/03/empty-office-with-locked-suggestions-box.webp\" alt=\"empty office with locked suggestions\" class=\"wp-image-7261\" style=\"width:435px;height:auto\"></a></figure>\n\n\n\n<p>People don’t want to fill forms and wait. They want answers. Now.<br>They want to know they can trust you <em>before</em> they share their information with you.</p>\n\n\n\n<p>A good chatbot receptionist will give your users exactly that—a sense of being <em>heard</em>.<br>Once they feel heard, even if the users don’t buy your service this time, the next time they need something, they’ll prefer coming to your website than even searching on Google!</p>\n\n\n\n<p>Isn’t that why you created your website in the first place?</p>\n\n\n\n<hr class=\"wp-block-separator has-alpha-channel-opacity\">\n\n\n\n<h2 class=\"wp-block-heading\">Our case-study</h2>\n\n\n\n<p>One of our early clients – a fertility clinic had over 12,000 monthly visits. Guess how many <em>actual</em> inquiries they got?</p>\n\n\n\n<p>Under 2%.</p>\n\n\n\n<p>Once they integrated our chatbot receptionist on their website and whatsapp, that number jumped 5x! Without changing the website. Without spending more on ads.</p>\n\n\n\n<p>Just by allowing BeyondChats to <em>deliver an amazing experience to their online visitors</em>.</p>\n\n\n\n<p><a href=\"https://beyondchats.com/blogs/a-complete-ai-solution-for-doctors-beyondchats/\">Click here to read more</a> about the clinic and how they benefitted from partnering with BeyondChats.</p>\n\n\n\n<hr class=\"wp-block-separator has-alpha-channel-opacity\">\n\n\n\n<h2 class=\"wp-block-heading\">Here’s What You Should Do</h2>\n\n\n\n<p>Look, you don’t need a 10-slide pitch to convince you. Just open your website and ask yourself:</p>\n\n\n\n<p><strong>Would my users have a great experience if there was an experienced chatbot receptionist to greet them and guide them?</strong></p>\n\n\n\n<p>The answer is almost always—YES!</p>\n\n\n\n<p>So, here’s your action plan:</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li><a href=\"https://beyondchats.com/get-receptionist-for-your-website\">Add BeyondChats’ smart chatbot receptionist</a>. It takes less than 2 minutes to get started!</li>\n\n\n\n<li>Track your ROIs—bookings, leads qualification, users’ experience</li>\n\n\n\n<li>Reap the benefits of having a GREAT receptionist on your website and whatsapp!</li>\n</ul>\n\n\n\n<p>Start there. Measure results. Iterate.</p>\n<div class=\"has-social-placeholder has-content-area\" data-url=\"https://beyondchats.com/blogs/your-website-needs-a-receptionist/\" data-title=\"Your website needs a receptionist\" data-hashtags=\"\" data-post-id=\"7358\"></div>				</div>\n				<div class=\"elementor-element elementor-element-106752c elementor-widget elementor-widget-shortcode\" data-id=\"106752c\" data-element_type=\"widget\" data-widget_type=\"shortcode.default\">\n							<div class=\"elementor-shortcode\">		<div data-elementor-type=\"container\" data-elementor-id=\"6196\" class=\"elementor elementor-6196\" data-elementor-post-type=\"elementor_library\">\n				<div class=\"elementor-element elementor-element-af06f6b elementor-hidden-mobile e-flex e-con-boxed e-con e-parent\" data-id=\"af06f6b\" data-element_type=\"container\">\n					<div class=\"e-con-inner\">\n		<div class=\"elementor-element elementor-element-190a40c e-con-full e-flex e-con e-child\" data-id=\"190a40c\" data-element_type=\"container\">\n		<div class=\"elementor-element elementor-element-21c23ec e-con-full e-flex e-con e-child\" data-id=\"21c23ec\" data-element_type=\"container\">\n				<div class=\"elementor-element elementor-element-30984ea elementor-widget elementor-widget-shortcode\" data-id=\"30984ea\" data-element_type=\"widget\" data-widget_type=\"shortcode.default\">\n							<div class=\"elementor-shortcode\">    <div class=\"wp-applause-container\" data-post-id=\"7358\">\n        <button class=\"wp-applause-button\" data-post-id=\"7358\">\n            <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" aria-label=\"clap\"><path fill-rule=\"evenodd\" d=\"M11.37.828 12 3.282l.63-2.454zM13.916 3.953l1.523-2.112-1.184-.39zM8.589 1.84l1.522 2.112-.337-2.501zM18.523 18.92c-.86.86-1.75 1.246-2.62 1.33a6 6 0 0 0 .407-.372c2.388-2.389 2.86-4.951 1.399-7.623l-.912-1.603-.79-1.672c-.26-.56-.194-.98.203-1.288a.7.7 0 0 1 .546-.132c.283.046.546.231.728.5l2.363 4.157c.976 1.624 1.141 4.237-1.324 6.702m-10.999-.438L3.37 14.328a.828.828 0 0 1 .585-1.408.83.83 0 0 1 .585.242l2.158 2.157a.365.365 0 0 0 .516-.516l-2.157-2.158-1.449-1.449a.826.826 0 0 1 1.167-1.17l3.438 3.44a.363.363 0 0 0 .516 0 .364.364 0 0 0 0-.516L5.293 9.513l-.97-.97a.826.826 0 0 1 0-1.166.84.84 0 0 1 1.167 0l.97.968 3.437 3.436a.36.36 0 0 0 .517 0 .366.366 0 0 0 0-.516L6.977 7.83a.82.82 0 0 1-.241-.584.82.82 0 0 1 .824-.826c.219 0 .43.087.584.242l5.787 5.787a.366.366 0 0 0 .587-.415l-1.117-2.363c-.26-.56-.194-.98.204-1.289a.7.7 0 0 1 .546-.132c.283.046.545.232.727.501l2.193 3.86c1.302 2.38.883 4.59-1.277 6.75-1.156 1.156-2.602 1.627-4.19 1.367-1.418-.236-2.866-1.033-4.079-2.246M10.75 5.971l2.12 2.12c-.41.502-.465 1.17-.128 1.89l.22.465-3.523-3.523a.8.8 0 0 1-.097-.368c0-.22.086-.428.241-.584a.847.847 0 0 1 1.167 0m7.355 1.705c-.31-.461-.746-.758-1.23-.837a1.44 1.44 0 0 0-1.11.275c-.312.24-.505.543-.59.881a1.74 1.74 0 0 0-.906-.465 1.47 1.47 0 0 0-.82.106l-2.182-2.182a1.56 1.56 0 0 0-2.2 0 1.54 1.54 0 0 0-.396.701 1.56 1.56 0 0 0-2.21-.01 1.55 1.55 0 0 0-.416.753c-.624-.624-1.649-.624-2.237-.037a1.557 1.557 0 0 0 0 2.2c-.239.1-.501.238-.715.453a1.56 1.56 0 0 0 0 2.2l.516.515a1.556 1.556 0 0 0-.753 2.615L7.01 19c1.32 1.319 2.909 2.189 4.475 2.449q.482.08.971.08c.85 0 1.653-.198 2.393-.579.231.033.46.054.686.054 1.266 0 2.457-.52 3.505-1.567 2.763-2.763 2.552-5.734 1.439-7.586z\" clip-rule=\"evenodd\"></path></svg>\n        </button>\n        <span class=\"wp-applause-count\">97</span>\n    </div>\n    </div>\n						</div>\n				<div class=\"elementor-element elementor-element-36e02a7 elementor-position-right elementor-mobile-position-left elementor-view-default elementor-widget elementor-widget-icon-box\" data-id=\"36e02a7\" data-element_type=\"widget\" data-widget_type=\"icon-box.default\">\n							<div class=\"elementor-icon-box-wrapper\">\n\n						<div class=\"elementor-icon-box-icon\">\n				<a href=\"#comments\" class=\"elementor-icon\" tabindex=\"-1\">\n				<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-far-comments\" viewBox=\"0 0 576 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M532 386.2c27.5-27.1 44-61.1 44-98.2 0-80-76.5-146.1-176.2-157.9C368.3 72.5 294.3 32 208 32 93.1 32 0 103.6 0 192c0 37 16.5 71 44 98.2-15.3 30.7-37.3 54.5-37.7 54.9-6.3 6.7-8.1 16.5-4.4 25 3.6 8.5 12 14 21.2 14 53.5 0 96.7-20.2 125.2-38.8 9.2 2.1 18.7 3.7 28.4 4.9C208.1 407.6 281.8 448 368 448c20.8 0 40.8-2.4 59.8-6.8C456.3 459.7 499.4 480 553 480c9.2 0 17.5-5.5 21.2-14 3.6-8.5 1.9-18.3-4.4-25-.4-.3-22.5-24.1-37.8-54.8zm-392.8-92.3L122.1 305c-14.1 9.1-28.5 16.3-43.1 21.4 2.7-4.7 5.4-9.7 8-14.8l15.5-31.1L77.7 256C64.2 242.6 48 220.7 48 192c0-60.7 73.3-112 160-112s160 51.3 160 112-73.3 112-160 112c-16.5 0-33-1.9-49-5.6l-19.8-4.5zM498.3 352l-24.7 24.4 15.5 31.1c2.6 5.1 5.3 10.1 8 14.8-14.6-5.1-29-12.3-43.1-21.4l-17.1-11.1-19.9 4.6c-16 3.7-32.5 5.6-49 5.6-54 0-102.2-20.1-131.3-49.7C338 339.5 416 272.9 416 192c0-3.4-.4-6.7-.7-10C479.7 196.5 528 238.8 528 288c0 28.7-16.2 50.6-29.7 64z\"></path></svg>				</a>\n			</div>\n			\n			\n		</div>\n						</div>\n				</div>\n		<div class=\"elementor-element elementor-element-82f4de6 e-con-full elementor-hidden-mobile e-flex e-con e-child\" data-id=\"82f4de6\" data-element_type=\"container\">\n				<div class=\"elementor-element elementor-element-cea0a0c elementor-share-buttons--view-icon elementor-share-buttons--skin-framed elementor-share-buttons--color-custom elementor-share-buttons--shape-square elementor-grid-0 elementor-widget elementor-widget-share-buttons\" data-id=\"cea0a0c\" data-element_type=\"widget\" data-widget_type=\"share-buttons.default\">\n							<div class=\"elementor-grid\" role=\"list\">\n								<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_facebook\" role=\"button\" tabindex=\"0\" aria-label=\"Share on facebook\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-facebook\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M504 256C504 119 393 8 256 8S8 119 8 256c0 123.78 90.69 226.38 209.25 245V327.69h-63V256h63v-54.64c0-62.15 37-96.48 93.67-96.48 27.14 0 55.52 4.84 55.52 4.84v61h-31.28c-30.8 0-40.41 19.12-40.41 38.73V256h68.78l-11 71.69h-57.78V501C413.31 482.38 504 379.78 504 256z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_x-twitter\" role=\"button\" tabindex=\"0\" aria-label=\"Share on x-twitter\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-x-twitter\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M389.2 48h70.6L305.6 224.2 487 464H345L233.7 318.6 106.5 464H35.8L200.7 275.5 26.8 48H172.4L272.9 180.9 389.2 48zM364.4 421.8h39.1L151.1 88h-42L364.4 421.8z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_pinterest\" role=\"button\" tabindex=\"0\" aria-label=\"Share on pinterest\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-pinterest\" viewBox=\"0 0 496 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M496 256c0 137-111 248-248 248-25.6 0-50.2-3.9-73.4-11.1 10.1-16.5 25.2-43.5 30.8-65 3-11.6 15.4-59 15.4-59 8.1 15.4 31.7 28.5 56.8 28.5 74.8 0 128.7-68.8 128.7-154.3 0-81.9-66.9-143.2-152.9-143.2-107 0-163.9 71.8-163.9 150.1 0 36.4 19.4 81.7 50.3 96.1 4.7 2.2 7.2 1.2 8.3-3.3.8-3.4 5-20.3 6.9-28.1.6-2.5.3-4.7-1.7-7.1-10.1-12.5-18.3-35.3-18.3-56.6 0-54.7 41.4-107.6 112-107.6 60.9 0 103.6 41.5 103.6 100.9 0 67.1-33.9 113.6-78 113.6-24.3 0-42.6-20.1-36.7-44.8 7-29.5 20.5-61.3 20.5-82.6 0-19-10.2-34.9-31.4-34.9-24.9 0-44.9 25.7-44.9 60.2 0 22 7.4 36.8 7.4 36.8s-24.5 103.8-29 123.2c-5 21.4-3 51.6-.9 71.2C65.4 450.9 0 361.1 0 256 0 119 111 8 248 8s248 111 248 248z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_linkedin\" role=\"button\" tabindex=\"0\" aria-label=\"Share on linkedin\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-linkedin\" viewBox=\"0 0 448 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M416 32H31.9C14.3 32 0 46.5 0 64.3v383.4C0 465.5 14.3 480 31.9 480H416c17.6 0 32-14.5 32-32.3V64.3c0-17.8-14.4-32.3-32-32.3zM135.4 416H69V202.2h66.5V416zm-33.2-243c-21.3 0-38.5-17.3-38.5-38.5S80.9 96 102.2 96c21.2 0 38.5 17.3 38.5 38.5 0 21.3-17.2 38.5-38.5 38.5zm282.1 243h-66.4V312c0-24.8-.5-56.7-34.5-56.7-34.6 0-39.9 27-39.9 54.9V416h-66.4V202.2h63.7v29.2h.9c8.9-16.8 30.6-34.5 62.9-34.5 67.2 0 79.7 44.3 79.7 101.9V416z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_reddit\" role=\"button\" tabindex=\"0\" aria-label=\"Share on reddit\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-reddit\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M201.5 305.5c-13.8 0-24.9-11.1-24.9-24.6 0-13.8 11.1-24.9 24.9-24.9 13.6 0 24.6 11.1 24.6 24.9 0 13.6-11.1 24.6-24.6 24.6zM504 256c0 137-111 248-248 248S8 393 8 256 119 8 256 8s248 111 248 248zm-132.3-41.2c-9.4 0-17.7 3.9-23.8 10-22.4-15.5-52.6-25.5-86.1-26.6l17.4-78.3 55.4 12.5c0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.3 24.9-24.9s-11.1-24.9-24.9-24.9c-9.7 0-18 5.8-22.1 13.8l-61.2-13.6c-3-.8-6.1 1.4-6.9 4.4l-19.1 86.4c-33.2 1.4-63.1 11.3-85.5 26.8-6.1-6.4-14.7-10.2-24.1-10.2-34.9 0-46.3 46.9-14.4 62.8-1.1 5-1.7 10.2-1.7 15.5 0 52.6 59.2 95.2 132 95.2 73.1 0 132.3-42.6 132.3-95.2 0-5.3-.6-10.8-1.9-15.8 31.3-16 19.8-62.5-14.9-62.5zM302.8 331c-18.2 18.2-76.1 17.9-93.6 0-2.2-2.2-6.1-2.2-8.3 0-2.5 2.5-2.5 6.4 0 8.6 22.8 22.8 87.3 22.8 110.2 0 2.5-2.2 2.5-6.1 0-8.6-2.2-2.2-6.1-2.2-8.3 0zm7.7-75c-13.6 0-24.6 11.1-24.6 24.9 0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.1 24.9-24.6 0-13.8-11-24.9-24.9-24.9z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_whatsapp\" role=\"button\" tabindex=\"0\" aria-label=\"Share on whatsapp\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-whatsapp\" viewBox=\"0 0 448 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M380.9 97.1C339 55.1 283.2 32 223.9 32c-122.4 0-222 99.6-222 222 0 39.1 10.2 77.3 29.6 111L0 480l117.7-30.9c32.4 17.7 68.9 27 106.1 27h.1c122.3 0 224.1-99.6 224.1-222 0-59.3-25.2-115-67.1-157zm-157 341.6c-33.2 0-65.7-8.9-94-25.7l-6.7-4-69.8 18.3L72 359.2l-4.4-7c-18.5-29.4-28.2-63.3-28.2-98.2 0-101.7 82.8-184.5 184.6-184.5 49.3 0 95.6 19.2 130.4 54.1 34.8 34.9 56.2 81.2 56.1 130.5 0 101.8-84.9 184.6-186.6 184.6zm101.2-138.2c-5.5-2.8-32.8-16.2-37.9-18-5.1-1.9-8.8-2.8-12.5 2.8-3.7 5.6-14.3 18-17.6 21.8-3.2 3.7-6.5 4.2-12 1.4-32.6-16.3-54-29.1-75.5-66-5.7-9.8 5.7-9.1 16.3-30.3 1.8-3.7.9-6.9-.5-9.7-1.4-2.8-12.5-30.1-17.1-41.2-4.5-10.8-9.1-9.3-12.5-9.5-3.2-.2-6.9-.2-10.6-.2-3.7 0-9.7 1.4-14.8 6.9-5.1 5.6-19.4 19-19.4 46.3 0 27.3 19.9 53.7 22.6 57.4 2.8 3.7 39.1 59.7 94.8 83.8 35.2 15.2 49 16.5 66.6 13.9 10.7-1.6 32.8-13.4 37.4-26.4 4.6-13 4.6-24.1 3.2-26.4-1.3-2.5-5-3.9-10.5-6.6z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_email\" role=\"button\" tabindex=\"0\" aria-label=\"Share on email\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fas-envelope\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M502.3 190.8c3.9-3.1 9.7-.2 9.7 4.7V400c0 26.5-21.5 48-48 48H48c-26.5 0-48-21.5-48-48V195.6c0-5 5.7-7.8 9.7-4.7 22.4 17.4 52.1 39.5 154.1 113.6 21.1 15.4 56.7 47.8 92.2 47.6 35.7.3 72-32.8 92.3-47.6 102-74.1 131.6-96.3 154-113.7zM256 320c23.2.4 56.6-29.2 73.4-41.4 132.7-96.3 142.8-104.7 173.4-128.7 5.8-4.5 9.2-11.5 9.2-18.9v-19c0-26.5-21.5-48-48-48H48C21.5 64 0 85.5 0 112v19c0 7.4 3.4 14.3 9.2 18.9 30.6 23.9 40.7 32.4 173.4 128.7 16.8 12.2 50.2 41.8 73.4 41.4z\"></path></svg>							</span>\n																				</div>\n					</div>\n						</div>\n						</div>\n				</div>\n				</div>\n					</div>\n				</div>\n		<div class=\"elementor-element elementor-element-95ebea8 elementor-hidden-desktop elementor-hidden-tablet e-flex e-con-boxed e-con e-parent\" data-id=\"95ebea8\" data-element_type=\"container\">\n					<div class=\"e-con-inner\">\n		<div class=\"elementor-element elementor-element-123fb1f e-con-full e-flex e-con e-child\" data-id=\"123fb1f\" data-element_type=\"container\">\n		<div class=\"elementor-element elementor-element-1b37cd3 e-con-full e-flex e-con e-child\" data-id=\"1b37cd3\" data-element_type=\"container\">\n				<div class=\"elementor-element elementor-element-837efb5 elementor-widget elementor-widget-shortcode\" data-id=\"837efb5\" data-element_type=\"widget\" data-widget_type=\"shortcode.default\">\n							<div class=\"elementor-shortcode\">    <div class=\"wp-applause-container\" data-post-id=\"7358\">\n        <button class=\"wp-applause-button\" data-post-id=\"7358\">\n            <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" aria-label=\"clap\"><path fill-rule=\"evenodd\" d=\"M11.37.828 12 3.282l.63-2.454zM13.916 3.953l1.523-2.112-1.184-.39zM8.589 1.84l1.522 2.112-.337-2.501zM18.523 18.92c-.86.86-1.75 1.246-2.62 1.33a6 6 0 0 0 .407-.372c2.388-2.389 2.86-4.951 1.399-7.623l-.912-1.603-.79-1.672c-.26-.56-.194-.98.203-1.288a.7.7 0 0 1 .546-.132c.283.046.546.231.728.5l2.363 4.157c.976 1.624 1.141 4.237-1.324 6.702m-10.999-.438L3.37 14.328a.828.828 0 0 1 .585-1.408.83.83 0 0 1 .585.242l2.158 2.157a.365.365 0 0 0 .516-.516l-2.157-2.158-1.449-1.449a.826.826 0 0 1 1.167-1.17l3.438 3.44a.363.363 0 0 0 .516 0 .364.364 0 0 0 0-.516L5.293 9.513l-.97-.97a.826.826 0 0 1 0-1.166.84.84 0 0 1 1.167 0l.97.968 3.437 3.436a.36.36 0 0 0 .517 0 .366.366 0 0 0 0-.516L6.977 7.83a.82.82 0 0 1-.241-.584.82.82 0 0 1 .824-.826c.219 0 .43.087.584.242l5.787 5.787a.366.366 0 0 0 .587-.415l-1.117-2.363c-.26-.56-.194-.98.204-1.289a.7.7 0 0 1 .546-.132c.283.046.545.232.727.501l2.193 3.86c1.302 2.38.883 4.59-1.277 6.75-1.156 1.156-2.602 1.627-4.19 1.367-1.418-.236-2.866-1.033-4.079-2.246M10.75 5.971l2.12 2.12c-.41.502-.465 1.17-.128 1.89l.22.465-3.523-3.523a.8.8 0 0 1-.097-.368c0-.22.086-.428.241-.584a.847.847 0 0 1 1.167 0m7.355 1.705c-.31-.461-.746-.758-1.23-.837a1.44 1.44 0 0 0-1.11.275c-.312.24-.505.543-.59.881a1.74 1.74 0 0 0-.906-.465 1.47 1.47 0 0 0-.82.106l-2.182-2.182a1.56 1.56 0 0 0-2.2 0 1.54 1.54 0 0 0-.396.701 1.56 1.56 0 0 0-2.21-.01 1.55 1.55 0 0 0-.416.753c-.624-.624-1.649-.624-2.237-.037a1.557 1.557 0 0 0 0 2.2c-.239.1-.501.238-.715.453a1.56 1.56 0 0 0 0 2.2l.516.515a1.556 1.556 0 0 0-.753 2.615L7.01 19c1.32 1.319 2.909 2.189 4.475 2.449q.482.08.971.08c.85 0 1.653-.198 2.393-.579.231.033.46.054.686.054 1.266 0 2.457-.52 3.505-1.567 2.763-2.763 2.552-5.734 1.439-7.586z\" clip-rule=\"evenodd\"></path></svg>\n        </button>\n        <span class=\"wp-applause-count\">97</span>\n    </div>\n    </div>\n						</div>\n				<div class=\"elementor-element elementor-element-5bf9dbd elementor-icon-list--layout-inline elementor-mobile-align-center elementor-list-item-link-full_width elementor-widget elementor-widget-icon-list\" data-id=\"5bf9dbd\" data-element_type=\"widget\" data-widget_type=\"icon-list.default\">\n							<ul class=\"elementor-icon-list-items elementor-inline-items\">\n							<li class=\"elementor-icon-list-item elementor-inline-item\">\n											<a href=\"#comments\">\n\n												<span class=\"elementor-icon-list-icon\">\n							<i aria-hidden=\"true\" class=\"huge huge-comment-01\"></i>						</span>\n										<span class=\"elementor-icon-list-text\"></span>\n											</a>\n									</li>\n								<li class=\"elementor-icon-list-item elementor-inline-item\">\n											<a href=\"#elementor-action%3Aaction%3Dpopup%3Aopen%26settings%3DeyJpZCI6IjYxOTMiLCJ0b2dnbGUiOmZhbHNlfQ%3D%3D\">\n\n												<span class=\"elementor-icon-list-icon\">\n							<i aria-hidden=\"true\" class=\"huge huge-share-05\"></i>						</span>\n										<span class=\"elementor-icon-list-text\"></span>\n											</a>\n									</li>\n						</ul>\n						</div>\n				</div>\n		<div class=\"elementor-element elementor-element-8608e80 e-con-full elementor-hidden-mobile e-flex e-con e-child\" data-id=\"8608e80\" data-element_type=\"container\">\n				<div class=\"elementor-element elementor-element-0bb15f1 elementor-share-buttons--view-icon elementor-share-buttons--skin-framed elementor-share-buttons--color-custom elementor-share-buttons--shape-square elementor-grid-0 elementor-widget elementor-widget-share-buttons\" data-id=\"0bb15f1\" data-element_type=\"widget\" data-widget_type=\"share-buttons.default\">\n							<div class=\"elementor-grid\" role=\"list\">\n								<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_facebook\" role=\"button\" tabindex=\"0\" aria-label=\"Share on facebook\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-facebook\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M504 256C504 119 393 8 256 8S8 119 8 256c0 123.78 90.69 226.38 209.25 245V327.69h-63V256h63v-54.64c0-62.15 37-96.48 93.67-96.48 27.14 0 55.52 4.84 55.52 4.84v61h-31.28c-30.8 0-40.41 19.12-40.41 38.73V256h68.78l-11 71.69h-57.78V501C413.31 482.38 504 379.78 504 256z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_x-twitter\" role=\"button\" tabindex=\"0\" aria-label=\"Share on x-twitter\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-x-twitter\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M389.2 48h70.6L305.6 224.2 487 464H345L233.7 318.6 106.5 464H35.8L200.7 275.5 26.8 48H172.4L272.9 180.9 389.2 48zM364.4 421.8h39.1L151.1 88h-42L364.4 421.8z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_pinterest\" role=\"button\" tabindex=\"0\" aria-label=\"Share on pinterest\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-pinterest\" viewBox=\"0 0 496 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M496 256c0 137-111 248-248 248-25.6 0-50.2-3.9-73.4-11.1 10.1-16.5 25.2-43.5 30.8-65 3-11.6 15.4-59 15.4-59 8.1 15.4 31.7 28.5 56.8 28.5 74.8 0 128.7-68.8 128.7-154.3 0-81.9-66.9-143.2-152.9-143.2-107 0-163.9 71.8-163.9 150.1 0 36.4 19.4 81.7 50.3 96.1 4.7 2.2 7.2 1.2 8.3-3.3.8-3.4 5-20.3 6.9-28.1.6-2.5.3-4.7-1.7-7.1-10.1-12.5-18.3-35.3-18.3-56.6 0-54.7 41.4-107.6 112-107.6 60.9 0 103.6 41.5 103.6 100.9 0 67.1-33.9 113.6-78 113.6-24.3 0-42.6-20.1-36.7-44.8 7-29.5 20.5-61.3 20.5-82.6 0-19-10.2-34.9-31.4-34.9-24.9 0-44.9 25.7-44.9 60.2 0 22 7.4 36.8 7.4 36.8s-24.5 103.8-29 123.2c-5 21.4-3 51.6-.9 71.2C65.4 450.9 0 361.1 0 256 0 119 111 8 248 8s248 111 248 248z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_linkedin\" role=\"button\" tabindex=\"0\" aria-label=\"Share on linkedin\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-linkedin\" viewBox=\"0 0 448 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M416 32H31.9C14.3 32 0 46.5 0 64.3v383.4C0 465.5 14.3 480 31.9 480H416c17.6 0 32-14.5 32-32.3V64.3c0-17.8-14.4-32.3-32-32.3zM135.4 416H69V202.2h66.5V416zm-33.2-243c-21.3 0-38.5-17.3-38.5-38.5S80.9 96 102.2 96c21.2 0 38.5 17.3 38.5 38.5 0 21.3-17.2 38.5-38.5 38.5zm282.1 243h-66.4V312c0-24.8-.5-56.7-34.5-56.7-34.6 0-39.9 27-39.9 54.9V416h-66.4V202.2h63.7v29.2h.9c8.9-16.8 30.6-34.5 62.9-34.5 67.2 0 79.7 44.3 79.7 101.9V416z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_reddit\" role=\"button\" tabindex=\"0\" aria-label=\"Share on reddit\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-reddit\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M201.5 305.5c-13.8 0-24.9-11.1-24.9-24.6 0-13.8 11.1-24.9 24.9-24.9 13.6 0 24.6 11.1 24.6 24.9 0 13.6-11.1 24.6-24.6 24.6zM504 256c0 137-111 248-248 248S8 393 8 256 119 8 256 8s248 111 248 248zm-132.3-41.2c-9.4 0-17.7 3.9-23.8 10-22.4-15.5-52.6-25.5-86.1-26.6l17.4-78.3 55.4 12.5c0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.3 24.9-24.9s-11.1-24.9-24.9-24.9c-9.7 0-18 5.8-22.1 13.8l-61.2-13.6c-3-.8-6.1 1.4-6.9 4.4l-19.1 86.4c-33.2 1.4-63.1 11.3-85.5 26.8-6.1-6.4-14.7-10.2-24.1-10.2-34.9 0-46.3 46.9-14.4 62.8-1.1 5-1.7 10.2-1.7 15.5 0 52.6 59.2 95.2 132 95.2 73.1 0 132.3-42.6 132.3-95.2 0-5.3-.6-10.8-1.9-15.8 31.3-16 19.8-62.5-14.9-62.5zM302.8 331c-18.2 18.2-76.1 17.9-93.6 0-2.2-2.2-6.1-2.2-8.3 0-2.5 2.5-2.5 6.4 0 8.6 22.8 22.8 87.3 22.8 110.2 0 2.5-2.2 2.5-6.1 0-8.6-2.2-2.2-6.1-2.2-8.3 0zm7.7-75c-13.6 0-24.6 11.1-24.6 24.9 0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.1 24.9-24.6 0-13.8-11-24.9-24.9-24.9z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_whatsapp\" role=\"button\" tabindex=\"0\" aria-label=\"Share on whatsapp\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-whatsapp\" viewBox=\"0 0 448 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M380.9 97.1C339 55.1 283.2 32 223.9 32c-122.4 0-222 99.6-222 222 0 39.1 10.2 77.3 29.6 111L0 480l117.7-30.9c32.4 17.7 68.9 27 106.1 27h.1c122.3 0 224.1-99.6 224.1-222 0-59.3-25.2-115-67.1-157zm-157 341.6c-33.2 0-65.7-8.9-94-25.7l-6.7-4-69.8 18.3L72 359.2l-4.4-7c-18.5-29.4-28.2-63.3-28.2-98.2 0-101.7 82.8-184.5 184.6-184.5 49.3 0 95.6 19.2 130.4 54.1 34.8 34.9 56.2 81.2 56.1 130.5 0 101.8-84.9 184.6-186.6 184.6zm101.2-138.2c-5.5-2.8-32.8-16.2-37.9-18-5.1-1.9-8.8-2.8-12.5 2.8-3.7 5.6-14.3 18-17.6 21.8-3.2 3.7-6.5 4.2-12 1.4-32.6-16.3-54-29.1-75.5-66-5.7-9.8 5.7-9.1 16.3-30.3 1.8-3.7.9-6.9-.5-9.7-1.4-2.8-12.5-30.1-17.1-41.2-4.5-10.8-9.1-9.3-12.5-9.5-3.2-.2-6.9-.2-10.6-.2-3.7 0-9.7 1.4-14.8 6.9-5.1 5.6-19.4 19-19.4 46.3 0 27.3 19.9 53.7 22.6 57.4 2.8 3.7 39.1 59.7 94.8 83.8 35.2 15.2 49 16.5 66.6 13.9 10.7-1.6 32.8-13.4 37.4-26.4 4.6-13 4.6-24.1 3.2-26.4-1.3-2.5-5-3.9-10.5-6.6z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_email\" role=\"button\" tabindex=\"0\" aria-label=\"Share on email\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fas-envelope\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M502.3 190.8c3.9-3.1 9.7-.2 9.7 4.7V400c0 26.5-21.5 48-48 48H48c-26.5 0-48-21.5-48-48V195.6c0-5 5.7-7.8 9.7-4.7 22.4 17.4 52.1 39.5 154.1 113.6 21.1 15.4 56.7 47.8 92.2 47.6 35.7.3 72-32.8 92.3-47.6 102-74.1 131.6-96.3 154-113.7zM256 320c23.2.4 56.6-29.2 73.4-41.4 132.7-96.3 142.8-104.7 173.4-128.7 5.8-4.5 9.2-11.5 9.2-18.9v-19c0-26.5-21.5-48-48-48H48C21.5 64 0 85.5 0 112v19c0 7.4 3.4 14.3 9.2 18.9 30.6 23.9 40.7 32.4 173.4 128.7 16.8 12.2 50.2 41.8 73.4 41.4z\"></path></svg>							</span>\n																				</div>\n					</div>\n						</div>\n						</div>\n				</div>\n				</div>\n					</div>\n				</div>\n				</div>\n		</div>\n						</div>\n					</div>\n				', 'A receptionist on your website is as important as the one in your office! Stop treating your website like a brochure! Do you have a receptionist / assistant present at your clinic or office whose sole responsibility is to talk to customers and make them feel at ease while they wait for you? Then why is your website—your most visible digital property, silent when someone walks in? People Are Landing on Your Website. Then Leaving. Let me tell you what’s actually happening. Someone clicks your ad or finds you on Google. They land on your site. They scroll. They don’t find what they’re looking for. They leave. No booking. No contact. No engagement. You just lost a potential patient, client, or customer. And worse? You paid for that click. A Beautiful Website Isn’t Enough You might be thinking, “But we spent a lot on our website. It’s clean, it’s mobile-friendly, it has all the info!” Cool. So does everyone else. Design alone doesn’t convert. Information doesn’t engage. People need guidance. Imagine walking into a Doctor’s clinic and no one greets you, no one asks what you need, and you have to find your way around alone. That would be so confusing! Nobody will visit that clinic again! That’s what your website is doing right now. What Would a Website Receptionist Do? Glad you asked. Here’s what it should do: Greet every website visitor with a comforting message! Answer first-level of users’ questions (services, pricing, availability, queries about other info available on your website’s articles) Help people book appointments or understand which service is right for their needs Qualify leads into those most likely to use your services, so your team isn’t wasting time on “just curious” browsers Collect feedback, comfort users, and even flag urgent queries so you can be more effective at your job And all of this – without your users having to wait for their turn. Everyone gets your digital receptionist’s full attention instantly, every time! “But We Have a Contact Form” No. Stop. That’s like putting a suggestion box at your clinic entrance and calling it customer service. People don’t want to fill forms and wait. They want answers. Now. They want to know they can trust you before they share their information with you. A good chatbot receptionist will give your users exactly that—a sense of being heard. Once they feel heard, even if the users don’t buy your service this time, the next time they need something, they’ll prefer coming to your website than even searching on Google! Isn’t that why you created your website in the first place? Our case-study One of our early clients – a fertility clinic had over 12,000 monthly visits. Guess how many actual inquiries they got? Under 2%. Once they integrated our chatbot receptionist on their website and whatsapp, that number jumped 5x! Without changing the website. Without spending more on ads. Just by allowing BeyondChats to deliver an amazing experience to their online visitors. Click here to read more about the clinic and how they benefitted from partnering with BeyondChats. Here’s What You Should Do Look, you don’t need a 10-slide pitch to convince you. Just open your website and ask yourself: Would my users have a great experience if there was an experienced chatbot receptionist to greet them and guide them? The answer is almost always—YES! So, here’s your action plan: Add BeyondChats’ smart chatbot receptionist. It takes less than 2 minutes to get started! Track your ROIs—bookings, leads qualification, users’ experience Reap the benefits of having a GREAT receptionist on your website and whatsapp! Start there. Measure results. Iterate. 97', NULL, '2025-03-24 18:30:00', 'https://beyondchats.com/blogs/your-website-needs-a-receptionist/', 0, NULL, NULL, '2025-12-30 13:05:02', '2025-12-30 13:05:02', 'General');
INSERT INTO `articles` (`id`, `title`, `original_content_html`, `original_content_text`, `author`, `published_date`, `source_url`, `is_updated`, `updated_content`, `references`, `created_at`, `updated_at`, `category`) VALUES
(5, 'Will AI Understand the Complexities of Patient Care?', '\n					<div class=\"e-con-inner\">\n				<div class=\"elementor-element elementor-element-b2a436b elementor-widget elementor-widget-theme-post-content\" data-id=\"b2a436b\" data-element_type=\"widget\" data-widget_type=\"theme-post-content.default\">\n					\n<p>Artificial intelligence is no longer a futuristic idea in healthcare—it’s already here. From scheduling appointments and triaging symptoms to analyzing scans and streamlining paperwork, AI is being woven into how hospitals and clinics operate.</p>\n\n\n\n<p>But as this technology moves closer to the point of care, a deeper question surfaces:</p>\n\n\n\n<h3 class=\"wp-block-heading\"><strong>Can AI truly understand the human side of medicine?</strong></h3>\n\n\n\n<p>Because patient care isn’t just about test results or treatment protocols. It’s about listening, noticing what’s unsaid, understanding context, and building trust. These are things that don’t always show up in data but they shape outcomes in real, measurable ways.</p>\n\n\n\n<p>This article explores whether AI can rise to that challenge. We’ll look at where it’s helping today, where it still falls short, and what a thoughtful, balanced approach to AI in patient care might look like.</p>\n\n\n\n<figure class=\"wp-block-image size-large\"><a href=\"https://beyondchats.com/wp-content/uploads/2025/04/Will-AI-do-patient-care.jpg\"><img decoding=\"async\" src=\"https://beyondchats.com/wp-content/uploads/2025/04/Will-AI-do-patient-care-1024x538.jpg\" alt=\"A worried patient talking to a doctor through screen\n\" class=\"wp-image-7295\"></a></figure>\n\n\n\n<h3 class=\"wp-block-heading has-large-font-size\"><strong>What Makes Patient Care Complex</strong>?</h3>\n\n\n\n<p>Treating patients isn’t just about solving medical problems. It’s about understanding people each with their own fears, beliefs, background, and expectations.</p>\n\n\n\n<blockquote class=\"wp-block-quote is-layout-flow wp-block-quote-is-layout-flow\">\n<p>Two patients with the same diagnosis might need very different patient care. One may want every detail and full involvement in decision-making. The other may just want the doctor to choose what’s best. One might speak up. The other might silently endure.</p>\n</blockquote>\n\n\n\n<p>What makes patient care complex is:</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Emotional cues that aren’t documented anywhere.</li>\n\n\n\n<li>Cultural factors that shape how symptoms are described or treatment is accepted.</li>\n\n\n\n<li>Social conditions—like family support, income, or literacy—that impact health outcomes.</li>\n\n\n\n<li>Trust, or the lack of it, which influences how openly patients communicate.</li>\n</ul>\n\n\n\n<p>This is the part of patient care that isn’t written in guidelines or lab reports. It’s built in conversation, over time, with attention to nuance. It’s what makes healthcare deeply personal and why replicating it with algorithms is not as simple as feeding data into a model.</p>\n\n\n\n<h3 class=\"wp-block-heading has-large-font-size\"><strong>Where AI Helps Today</strong>?</h3>\n\n\n\n<p>While AI may not fully grasp the emotional layers of patient care, it’s already proving useful in areas where speed, structure, and scale matter.</p>\n\n\n\n<p>Today, AI is helping healthcare providers by:</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li><strong>Automating repetitive tasks</strong> like appointment scheduling, record-keeping, and follow-up reminders.</li>\n\n\n\n<li><strong>Assisting with clinical assessment</strong>, using chatbots or digital forms to sort symptoms and direct patients to the right level of patient care.</li>\n\n\n\n<li><strong>Summarizing patient data</strong> across records to give doctors a faster, clearer overview.</li>\n\n\n\n<li><strong>Supporting diagnosis</strong>, especially in radiology, dermatology, and pathology, where image recognition plays a key role.</li>\n</ul>\n\n\n\n<figure class=\"wp-block-image size-large\"><a href=\"https://beyondchats.com/wp-content/uploads/2025/04/Where-AI-Helps-Today-in-Patient-Care.jpg\"><img decoding=\"async\" src=\"https://beyondchats.com/wp-content/uploads/2025/04/Where-AI-Helps-Today-in-Patient-Care-1024x538.jpg\" alt=\"Areas where AI is helping today in patient care\" class=\"wp-image-7296\"></a></figure>\n\n\n\n<p>In each of these areas, AI acts as a force multiplier. It doesn’t make emotional decisions—but it handles the operational burden, giving clinicians more time and headspace for real patient interaction.</p>\n\n\n\n<blockquote class=\"wp-block-quote is-layout-flow wp-block-quote-is-layout-flow\">\n<p><mark style=\"background-color:rgba(0, 0, 0, 0)\" class=\"has-inline-color has-palette-color-2-color\">Used right, AI isn’t replacing patient care it’s <strong>making room for more of it</strong>.</mark></p>\n</blockquote>\n\n\n\n<h3 class=\"wp-block-heading has-large-font-size\"><strong>The Limits of AI in Understanding Patient Care</strong></h3>\n\n\n\n<p>AI has come a long way in processing medical data and supporting clinical decisions. But when it comes to understanding the emotional, cultural, and personal layers of patient care, it still has some growing to do.</p>\n\n\n\n<p>Today’s AI systems:</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li>Don’t pick up on <strong>emotional nuance</strong> the way a human can.</li>\n\n\n\n<li>Can’t fully interpret <strong>context</strong> like why a patient might hesitate to speak up, or how culture shapes medical decisions.</li>\n\n\n\n<li>Often work like a <strong>black box</strong>, where recommendations are made without clear reasoning.</li>\n\n\n\n<li>Are only as good as the data they’re trained on, which can sometimes miss underrepresented groups.</li>\n</ul>\n\n\n\n<p>These are challenges, not deal-breakers.</p>\n\n\n\n<p>The goal <strong><mark style=\"background-color:rgba(0, 0, 0, 0)\" class=\"has-inline-color has-palette-color-2-color\">isn’t to</mark></strong> <strong><mark style=\"background-color:rgba(0, 0, 0, 0)\" class=\"has-inline-color has-palette-color-2-color\">dismiss AI it’s to use it wisely</mark></strong>. Let it take care of the operational load, while humans handle the parts of care that require empathy, intuition, and trust.</p>\n\n\n\n<p>With the right guardrails and thoughtful design, AI can complement human care—not compete with it.</p>\n\n\n\n<h3 class=\"wp-block-heading has-large-font-size\"><strong>Can AI Evolve to Do More?</strong></h3>\n\n\n\n<p>AI is improving fast. What once required massive datasets and predefined rules can now be achieved with more flexible, adaptive models that learn on the go.</p>\n\n\n\n<p>We’re seeing early signs of progress in areas that hint at a deeper role for AI in care:</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li><strong>Multimodal models</strong> that combine text, images, voice, and sensor data to form a more complete view of the patient.</li>\n\n\n\n<li><strong>Explainable AI</strong>, which helps doctors and patients understand how and why a recommendation was made.</li>\n\n\n\n<li><strong>Digital twins</strong> virtual models of patients that simulate how an individual might respond to different treatments.</li>\n\n\n\n<li><strong><a href=\"https://www.drmalpani.com/amp\" target=\"_blank\" rel=\"noopener\">Conversational agents</a></strong> that are becoming more responsive, context-aware, and emotionally attuned.</li>\n</ul>\n\n\n\n<p>These aren’t perfect solutions, and they’re still evolving. But they point to a future where AI might not just <em>process</em> care but start to better <em>understand</em> it.</p>\n\n\n\n<p>The key is direction. If AI is developed to <strong>support human care</strong>, not replace it, we may get closer to systems that not only improve outcomes but also respect the complexity of being human.</p>\n\n\n\n<h3 class=\"wp-block-heading has-large-font-size\"><strong>What a Balanced Approach Looks Like</strong>?</h3>\n\n\n\n<p>The goal isn’t to choose between AI and human care. It’s to find the right mix where each does what it’s best at.</p>\n\n\n\n<p>A balanced approach means:</p>\n\n\n\n<ul class=\"wp-block-list\">\n<li><strong>Letting AI handle the predictable</strong>: scheduling, documentation, follow-ups, and pattern recognition. These tasks drain time and energy that could be better spent with patients.</li>\n\n\n\n<li><strong>Keeping <a href=\"https://beyondchats.com/blogs/what-if-ai-recommends-the-wrong-medicine-whos-to-blame/\">humans in charge of the unpredictable</a></strong>: complex decisions, emotional conversations, and building trust. This is where context, empathy, and intuition matter most.</li>\n\n\n\n<li><strong>Designing AI tools that fit into real workflows</strong>, not ones that disrupt or replace them. The best tools feel like quiet collaborators, not intrusions.</li>\n\n\n\n<li><strong>Training healthcare teams</strong> to use AI effectively knowing when to lean on it, and when to lead without it.</li>\n\n\n\n<li><strong>Prioritizing explainability and fairness</strong> in AI design, so that both clinicians and patients understand and trust the technology behind their care.</li>\n</ul>\n\n\n\n<blockquote class=\"wp-block-quote is-layout-flow wp-block-quote-is-layout-flow\">\n<p>It’s not about making care more technical.<br>It’s about making technology serve care <strong>not the other way around</strong>.</p>\n</blockquote>\n\n\n\n<h3 class=\"wp-block-heading has-large-font-size\"><strong>Conclusion</strong></h3>\n\n\n\n<p>AI is changing how healthcare operates. There’s no denying its impact faster workflows, earlier detection, better resource use. But the real test isn’t what AI can automate. It’s whether it can <strong>coexist with the human side of care</strong>.</p>\n\n\n\n<p>Because patient care isn’t just clinical it’s personal. It’s emotional. It’s built on trust, nuance, and connection. And that’s not something any algorithm can fully replicate.</p>\n\n\n\n<p>Will AI ever truly understand all of this? Maybe not.<br>But it doesn’t have to.</p>\n\n\n\n<p>If we build and use AI to <strong>support</strong>, not replace, the human parts of medicine, it can help us do what matters most: spend more time listening, connecting, and actually caring.</p>\n\n\n\n<p>That’s the future worth aiming for.</p>\n<div class=\"has-social-placeholder has-content-area\" data-url=\"https://beyondchats.com/blogs/will-ai-understand-the-complexities-of-patient-care/\" data-title=\"Will AI Understand the Complexities of Patient Care?\" data-hashtags=\"\" data-post-id=\"7360\"></div>				</div>\n				<div class=\"elementor-element elementor-element-106752c elementor-widget elementor-widget-shortcode\" data-id=\"106752c\" data-element_type=\"widget\" data-widget_type=\"shortcode.default\">\n							<div class=\"elementor-shortcode\">		<div data-elementor-type=\"container\" data-elementor-id=\"6196\" class=\"elementor elementor-6196\" data-elementor-post-type=\"elementor_library\">\n				<div class=\"elementor-element elementor-element-af06f6b elementor-hidden-mobile e-flex e-con-boxed e-con e-parent\" data-id=\"af06f6b\" data-element_type=\"container\">\n					<div class=\"e-con-inner\">\n		<div class=\"elementor-element elementor-element-190a40c e-con-full e-flex e-con e-child\" data-id=\"190a40c\" data-element_type=\"container\">\n		<div class=\"elementor-element elementor-element-21c23ec e-con-full e-flex e-con e-child\" data-id=\"21c23ec\" data-element_type=\"container\">\n				<div class=\"elementor-element elementor-element-30984ea elementor-widget elementor-widget-shortcode\" data-id=\"30984ea\" data-element_type=\"widget\" data-widget_type=\"shortcode.default\">\n							<div class=\"elementor-shortcode\">    <div class=\"wp-applause-container\" data-post-id=\"7360\">\n        <button class=\"wp-applause-button\" data-post-id=\"7360\">\n            <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" aria-label=\"clap\"><path fill-rule=\"evenodd\" d=\"M11.37.828 12 3.282l.63-2.454zM13.916 3.953l1.523-2.112-1.184-.39zM8.589 1.84l1.522 2.112-.337-2.501zM18.523 18.92c-.86.86-1.75 1.246-2.62 1.33a6 6 0 0 0 .407-.372c2.388-2.389 2.86-4.951 1.399-7.623l-.912-1.603-.79-1.672c-.26-.56-.194-.98.203-1.288a.7.7 0 0 1 .546-.132c.283.046.546.231.728.5l2.363 4.157c.976 1.624 1.141 4.237-1.324 6.702m-10.999-.438L3.37 14.328a.828.828 0 0 1 .585-1.408.83.83 0 0 1 .585.242l2.158 2.157a.365.365 0 0 0 .516-.516l-2.157-2.158-1.449-1.449a.826.826 0 0 1 1.167-1.17l3.438 3.44a.363.363 0 0 0 .516 0 .364.364 0 0 0 0-.516L5.293 9.513l-.97-.97a.826.826 0 0 1 0-1.166.84.84 0 0 1 1.167 0l.97.968 3.437 3.436a.36.36 0 0 0 .517 0 .366.366 0 0 0 0-.516L6.977 7.83a.82.82 0 0 1-.241-.584.82.82 0 0 1 .824-.826c.219 0 .43.087.584.242l5.787 5.787a.366.366 0 0 0 .587-.415l-1.117-2.363c-.26-.56-.194-.98.204-1.289a.7.7 0 0 1 .546-.132c.283.046.545.232.727.501l2.193 3.86c1.302 2.38.883 4.59-1.277 6.75-1.156 1.156-2.602 1.627-4.19 1.367-1.418-.236-2.866-1.033-4.079-2.246M10.75 5.971l2.12 2.12c-.41.502-.465 1.17-.128 1.89l.22.465-3.523-3.523a.8.8 0 0 1-.097-.368c0-.22.086-.428.241-.584a.847.847 0 0 1 1.167 0m7.355 1.705c-.31-.461-.746-.758-1.23-.837a1.44 1.44 0 0 0-1.11.275c-.312.24-.505.543-.59.881a1.74 1.74 0 0 0-.906-.465 1.47 1.47 0 0 0-.82.106l-2.182-2.182a1.56 1.56 0 0 0-2.2 0 1.54 1.54 0 0 0-.396.701 1.56 1.56 0 0 0-2.21-.01 1.55 1.55 0 0 0-.416.753c-.624-.624-1.649-.624-2.237-.037a1.557 1.557 0 0 0 0 2.2c-.239.1-.501.238-.715.453a1.56 1.56 0 0 0 0 2.2l.516.515a1.556 1.556 0 0 0-.753 2.615L7.01 19c1.32 1.319 2.909 2.189 4.475 2.449q.482.08.971.08c.85 0 1.653-.198 2.393-.579.231.033.46.054.686.054 1.266 0 2.457-.52 3.505-1.567 2.763-2.763 2.552-5.734 1.439-7.586z\" clip-rule=\"evenodd\"></path></svg>\n        </button>\n        <span class=\"wp-applause-count\">97</span>\n    </div>\n    </div>\n						</div>\n				<div class=\"elementor-element elementor-element-36e02a7 elementor-position-right elementor-mobile-position-left elementor-view-default elementor-widget elementor-widget-icon-box\" data-id=\"36e02a7\" data-element_type=\"widget\" data-widget_type=\"icon-box.default\">\n							<div class=\"elementor-icon-box-wrapper\">\n\n						<div class=\"elementor-icon-box-icon\">\n				<a href=\"#comments\" class=\"elementor-icon\" tabindex=\"-1\">\n				<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-far-comments\" viewBox=\"0 0 576 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M532 386.2c27.5-27.1 44-61.1 44-98.2 0-80-76.5-146.1-176.2-157.9C368.3 72.5 294.3 32 208 32 93.1 32 0 103.6 0 192c0 37 16.5 71 44 98.2-15.3 30.7-37.3 54.5-37.7 54.9-6.3 6.7-8.1 16.5-4.4 25 3.6 8.5 12 14 21.2 14 53.5 0 96.7-20.2 125.2-38.8 9.2 2.1 18.7 3.7 28.4 4.9C208.1 407.6 281.8 448 368 448c20.8 0 40.8-2.4 59.8-6.8C456.3 459.7 499.4 480 553 480c9.2 0 17.5-5.5 21.2-14 3.6-8.5 1.9-18.3-4.4-25-.4-.3-22.5-24.1-37.8-54.8zm-392.8-92.3L122.1 305c-14.1 9.1-28.5 16.3-43.1 21.4 2.7-4.7 5.4-9.7 8-14.8l15.5-31.1L77.7 256C64.2 242.6 48 220.7 48 192c0-60.7 73.3-112 160-112s160 51.3 160 112-73.3 112-160 112c-16.5 0-33-1.9-49-5.6l-19.8-4.5zM498.3 352l-24.7 24.4 15.5 31.1c2.6 5.1 5.3 10.1 8 14.8-14.6-5.1-29-12.3-43.1-21.4l-17.1-11.1-19.9 4.6c-16 3.7-32.5 5.6-49 5.6-54 0-102.2-20.1-131.3-49.7C338 339.5 416 272.9 416 192c0-3.4-.4-6.7-.7-10C479.7 196.5 528 238.8 528 288c0 28.7-16.2 50.6-29.7 64z\"></path></svg>				</a>\n			</div>\n			\n			\n		</div>\n						</div>\n				</div>\n		<div class=\"elementor-element elementor-element-82f4de6 e-con-full elementor-hidden-mobile e-flex e-con e-child\" data-id=\"82f4de6\" data-element_type=\"container\">\n				<div class=\"elementor-element elementor-element-cea0a0c elementor-share-buttons--view-icon elementor-share-buttons--skin-framed elementor-share-buttons--color-custom elementor-share-buttons--shape-square elementor-grid-0 elementor-widget elementor-widget-share-buttons\" data-id=\"cea0a0c\" data-element_type=\"widget\" data-widget_type=\"share-buttons.default\">\n							<div class=\"elementor-grid\" role=\"list\">\n								<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_facebook\" role=\"button\" tabindex=\"0\" aria-label=\"Share on facebook\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-facebook\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M504 256C504 119 393 8 256 8S8 119 8 256c0 123.78 90.69 226.38 209.25 245V327.69h-63V256h63v-54.64c0-62.15 37-96.48 93.67-96.48 27.14 0 55.52 4.84 55.52 4.84v61h-31.28c-30.8 0-40.41 19.12-40.41 38.73V256h68.78l-11 71.69h-57.78V501C413.31 482.38 504 379.78 504 256z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_x-twitter\" role=\"button\" tabindex=\"0\" aria-label=\"Share on x-twitter\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-x-twitter\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M389.2 48h70.6L305.6 224.2 487 464H345L233.7 318.6 106.5 464H35.8L200.7 275.5 26.8 48H172.4L272.9 180.9 389.2 48zM364.4 421.8h39.1L151.1 88h-42L364.4 421.8z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_pinterest\" role=\"button\" tabindex=\"0\" aria-label=\"Share on pinterest\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-pinterest\" viewBox=\"0 0 496 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M496 256c0 137-111 248-248 248-25.6 0-50.2-3.9-73.4-11.1 10.1-16.5 25.2-43.5 30.8-65 3-11.6 15.4-59 15.4-59 8.1 15.4 31.7 28.5 56.8 28.5 74.8 0 128.7-68.8 128.7-154.3 0-81.9-66.9-143.2-152.9-143.2-107 0-163.9 71.8-163.9 150.1 0 36.4 19.4 81.7 50.3 96.1 4.7 2.2 7.2 1.2 8.3-3.3.8-3.4 5-20.3 6.9-28.1.6-2.5.3-4.7-1.7-7.1-10.1-12.5-18.3-35.3-18.3-56.6 0-54.7 41.4-107.6 112-107.6 60.9 0 103.6 41.5 103.6 100.9 0 67.1-33.9 113.6-78 113.6-24.3 0-42.6-20.1-36.7-44.8 7-29.5 20.5-61.3 20.5-82.6 0-19-10.2-34.9-31.4-34.9-24.9 0-44.9 25.7-44.9 60.2 0 22 7.4 36.8 7.4 36.8s-24.5 103.8-29 123.2c-5 21.4-3 51.6-.9 71.2C65.4 450.9 0 361.1 0 256 0 119 111 8 248 8s248 111 248 248z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_linkedin\" role=\"button\" tabindex=\"0\" aria-label=\"Share on linkedin\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-linkedin\" viewBox=\"0 0 448 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M416 32H31.9C14.3 32 0 46.5 0 64.3v383.4C0 465.5 14.3 480 31.9 480H416c17.6 0 32-14.5 32-32.3V64.3c0-17.8-14.4-32.3-32-32.3zM135.4 416H69V202.2h66.5V416zm-33.2-243c-21.3 0-38.5-17.3-38.5-38.5S80.9 96 102.2 96c21.2 0 38.5 17.3 38.5 38.5 0 21.3-17.2 38.5-38.5 38.5zm282.1 243h-66.4V312c0-24.8-.5-56.7-34.5-56.7-34.6 0-39.9 27-39.9 54.9V416h-66.4V202.2h63.7v29.2h.9c8.9-16.8 30.6-34.5 62.9-34.5 67.2 0 79.7 44.3 79.7 101.9V416z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_reddit\" role=\"button\" tabindex=\"0\" aria-label=\"Share on reddit\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-reddit\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M201.5 305.5c-13.8 0-24.9-11.1-24.9-24.6 0-13.8 11.1-24.9 24.9-24.9 13.6 0 24.6 11.1 24.6 24.9 0 13.6-11.1 24.6-24.6 24.6zM504 256c0 137-111 248-248 248S8 393 8 256 119 8 256 8s248 111 248 248zm-132.3-41.2c-9.4 0-17.7 3.9-23.8 10-22.4-15.5-52.6-25.5-86.1-26.6l17.4-78.3 55.4 12.5c0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.3 24.9-24.9s-11.1-24.9-24.9-24.9c-9.7 0-18 5.8-22.1 13.8l-61.2-13.6c-3-.8-6.1 1.4-6.9 4.4l-19.1 86.4c-33.2 1.4-63.1 11.3-85.5 26.8-6.1-6.4-14.7-10.2-24.1-10.2-34.9 0-46.3 46.9-14.4 62.8-1.1 5-1.7 10.2-1.7 15.5 0 52.6 59.2 95.2 132 95.2 73.1 0 132.3-42.6 132.3-95.2 0-5.3-.6-10.8-1.9-15.8 31.3-16 19.8-62.5-14.9-62.5zM302.8 331c-18.2 18.2-76.1 17.9-93.6 0-2.2-2.2-6.1-2.2-8.3 0-2.5 2.5-2.5 6.4 0 8.6 22.8 22.8 87.3 22.8 110.2 0 2.5-2.2 2.5-6.1 0-8.6-2.2-2.2-6.1-2.2-8.3 0zm7.7-75c-13.6 0-24.6 11.1-24.6 24.9 0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.1 24.9-24.6 0-13.8-11-24.9-24.9-24.9z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_whatsapp\" role=\"button\" tabindex=\"0\" aria-label=\"Share on whatsapp\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-whatsapp\" viewBox=\"0 0 448 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M380.9 97.1C339 55.1 283.2 32 223.9 32c-122.4 0-222 99.6-222 222 0 39.1 10.2 77.3 29.6 111L0 480l117.7-30.9c32.4 17.7 68.9 27 106.1 27h.1c122.3 0 224.1-99.6 224.1-222 0-59.3-25.2-115-67.1-157zm-157 341.6c-33.2 0-65.7-8.9-94-25.7l-6.7-4-69.8 18.3L72 359.2l-4.4-7c-18.5-29.4-28.2-63.3-28.2-98.2 0-101.7 82.8-184.5 184.6-184.5 49.3 0 95.6 19.2 130.4 54.1 34.8 34.9 56.2 81.2 56.1 130.5 0 101.8-84.9 184.6-186.6 184.6zm101.2-138.2c-5.5-2.8-32.8-16.2-37.9-18-5.1-1.9-8.8-2.8-12.5 2.8-3.7 5.6-14.3 18-17.6 21.8-3.2 3.7-6.5 4.2-12 1.4-32.6-16.3-54-29.1-75.5-66-5.7-9.8 5.7-9.1 16.3-30.3 1.8-3.7.9-6.9-.5-9.7-1.4-2.8-12.5-30.1-17.1-41.2-4.5-10.8-9.1-9.3-12.5-9.5-3.2-.2-6.9-.2-10.6-.2-3.7 0-9.7 1.4-14.8 6.9-5.1 5.6-19.4 19-19.4 46.3 0 27.3 19.9 53.7 22.6 57.4 2.8 3.7 39.1 59.7 94.8 83.8 35.2 15.2 49 16.5 66.6 13.9 10.7-1.6 32.8-13.4 37.4-26.4 4.6-13 4.6-24.1 3.2-26.4-1.3-2.5-5-3.9-10.5-6.6z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_email\" role=\"button\" tabindex=\"0\" aria-label=\"Share on email\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fas-envelope\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M502.3 190.8c3.9-3.1 9.7-.2 9.7 4.7V400c0 26.5-21.5 48-48 48H48c-26.5 0-48-21.5-48-48V195.6c0-5 5.7-7.8 9.7-4.7 22.4 17.4 52.1 39.5 154.1 113.6 21.1 15.4 56.7 47.8 92.2 47.6 35.7.3 72-32.8 92.3-47.6 102-74.1 131.6-96.3 154-113.7zM256 320c23.2.4 56.6-29.2 73.4-41.4 132.7-96.3 142.8-104.7 173.4-128.7 5.8-4.5 9.2-11.5 9.2-18.9v-19c0-26.5-21.5-48-48-48H48C21.5 64 0 85.5 0 112v19c0 7.4 3.4 14.3 9.2 18.9 30.6 23.9 40.7 32.4 173.4 128.7 16.8 12.2 50.2 41.8 73.4 41.4z\"></path></svg>							</span>\n																				</div>\n					</div>\n						</div>\n						</div>\n				</div>\n				</div>\n					</div>\n				</div>\n		<div class=\"elementor-element elementor-element-95ebea8 elementor-hidden-desktop elementor-hidden-tablet e-flex e-con-boxed e-con e-parent\" data-id=\"95ebea8\" data-element_type=\"container\">\n					<div class=\"e-con-inner\">\n		<div class=\"elementor-element elementor-element-123fb1f e-con-full e-flex e-con e-child\" data-id=\"123fb1f\" data-element_type=\"container\">\n		<div class=\"elementor-element elementor-element-1b37cd3 e-con-full e-flex e-con e-child\" data-id=\"1b37cd3\" data-element_type=\"container\">\n				<div class=\"elementor-element elementor-element-837efb5 elementor-widget elementor-widget-shortcode\" data-id=\"837efb5\" data-element_type=\"widget\" data-widget_type=\"shortcode.default\">\n							<div class=\"elementor-shortcode\">    <div class=\"wp-applause-container\" data-post-id=\"7360\">\n        <button class=\"wp-applause-button\" data-post-id=\"7360\">\n            <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" aria-label=\"clap\"><path fill-rule=\"evenodd\" d=\"M11.37.828 12 3.282l.63-2.454zM13.916 3.953l1.523-2.112-1.184-.39zM8.589 1.84l1.522 2.112-.337-2.501zM18.523 18.92c-.86.86-1.75 1.246-2.62 1.33a6 6 0 0 0 .407-.372c2.388-2.389 2.86-4.951 1.399-7.623l-.912-1.603-.79-1.672c-.26-.56-.194-.98.203-1.288a.7.7 0 0 1 .546-.132c.283.046.546.231.728.5l2.363 4.157c.976 1.624 1.141 4.237-1.324 6.702m-10.999-.438L3.37 14.328a.828.828 0 0 1 .585-1.408.83.83 0 0 1 .585.242l2.158 2.157a.365.365 0 0 0 .516-.516l-2.157-2.158-1.449-1.449a.826.826 0 0 1 1.167-1.17l3.438 3.44a.363.363 0 0 0 .516 0 .364.364 0 0 0 0-.516L5.293 9.513l-.97-.97a.826.826 0 0 1 0-1.166.84.84 0 0 1 1.167 0l.97.968 3.437 3.436a.36.36 0 0 0 .517 0 .366.366 0 0 0 0-.516L6.977 7.83a.82.82 0 0 1-.241-.584.82.82 0 0 1 .824-.826c.219 0 .43.087.584.242l5.787 5.787a.366.366 0 0 0 .587-.415l-1.117-2.363c-.26-.56-.194-.98.204-1.289a.7.7 0 0 1 .546-.132c.283.046.545.232.727.501l2.193 3.86c1.302 2.38.883 4.59-1.277 6.75-1.156 1.156-2.602 1.627-4.19 1.367-1.418-.236-2.866-1.033-4.079-2.246M10.75 5.971l2.12 2.12c-.41.502-.465 1.17-.128 1.89l.22.465-3.523-3.523a.8.8 0 0 1-.097-.368c0-.22.086-.428.241-.584a.847.847 0 0 1 1.167 0m7.355 1.705c-.31-.461-.746-.758-1.23-.837a1.44 1.44 0 0 0-1.11.275c-.312.24-.505.543-.59.881a1.74 1.74 0 0 0-.906-.465 1.47 1.47 0 0 0-.82.106l-2.182-2.182a1.56 1.56 0 0 0-2.2 0 1.54 1.54 0 0 0-.396.701 1.56 1.56 0 0 0-2.21-.01 1.55 1.55 0 0 0-.416.753c-.624-.624-1.649-.624-2.237-.037a1.557 1.557 0 0 0 0 2.2c-.239.1-.501.238-.715.453a1.56 1.56 0 0 0 0 2.2l.516.515a1.556 1.556 0 0 0-.753 2.615L7.01 19c1.32 1.319 2.909 2.189 4.475 2.449q.482.08.971.08c.85 0 1.653-.198 2.393-.579.231.033.46.054.686.054 1.266 0 2.457-.52 3.505-1.567 2.763-2.763 2.552-5.734 1.439-7.586z\" clip-rule=\"evenodd\"></path></svg>\n        </button>\n        <span class=\"wp-applause-count\">97</span>\n    </div>\n    </div>\n						</div>\n				<div class=\"elementor-element elementor-element-5bf9dbd elementor-icon-list--layout-inline elementor-mobile-align-center elementor-list-item-link-full_width elementor-widget elementor-widget-icon-list\" data-id=\"5bf9dbd\" data-element_type=\"widget\" data-widget_type=\"icon-list.default\">\n							<ul class=\"elementor-icon-list-items elementor-inline-items\">\n							<li class=\"elementor-icon-list-item elementor-inline-item\">\n											<a href=\"#comments\">\n\n												<span class=\"elementor-icon-list-icon\">\n							<i aria-hidden=\"true\" class=\"huge huge-comment-01\"></i>						</span>\n										<span class=\"elementor-icon-list-text\"></span>\n											</a>\n									</li>\n								<li class=\"elementor-icon-list-item elementor-inline-item\">\n											<a href=\"#elementor-action%3Aaction%3Dpopup%3Aopen%26settings%3DeyJpZCI6IjYxOTMiLCJ0b2dnbGUiOmZhbHNlfQ%3D%3D\">\n\n												<span class=\"elementor-icon-list-icon\">\n							<i aria-hidden=\"true\" class=\"huge huge-share-05\"></i>						</span>\n										<span class=\"elementor-icon-list-text\"></span>\n											</a>\n									</li>\n						</ul>\n						</div>\n				</div>\n		<div class=\"elementor-element elementor-element-8608e80 e-con-full elementor-hidden-mobile e-flex e-con e-child\" data-id=\"8608e80\" data-element_type=\"container\">\n				<div class=\"elementor-element elementor-element-0bb15f1 elementor-share-buttons--view-icon elementor-share-buttons--skin-framed elementor-share-buttons--color-custom elementor-share-buttons--shape-square elementor-grid-0 elementor-widget elementor-widget-share-buttons\" data-id=\"0bb15f1\" data-element_type=\"widget\" data-widget_type=\"share-buttons.default\">\n							<div class=\"elementor-grid\" role=\"list\">\n								<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_facebook\" role=\"button\" tabindex=\"0\" aria-label=\"Share on facebook\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-facebook\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M504 256C504 119 393 8 256 8S8 119 8 256c0 123.78 90.69 226.38 209.25 245V327.69h-63V256h63v-54.64c0-62.15 37-96.48 93.67-96.48 27.14 0 55.52 4.84 55.52 4.84v61h-31.28c-30.8 0-40.41 19.12-40.41 38.73V256h68.78l-11 71.69h-57.78V501C413.31 482.38 504 379.78 504 256z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_x-twitter\" role=\"button\" tabindex=\"0\" aria-label=\"Share on x-twitter\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-x-twitter\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M389.2 48h70.6L305.6 224.2 487 464H345L233.7 318.6 106.5 464H35.8L200.7 275.5 26.8 48H172.4L272.9 180.9 389.2 48zM364.4 421.8h39.1L151.1 88h-42L364.4 421.8z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_pinterest\" role=\"button\" tabindex=\"0\" aria-label=\"Share on pinterest\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-pinterest\" viewBox=\"0 0 496 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M496 256c0 137-111 248-248 248-25.6 0-50.2-3.9-73.4-11.1 10.1-16.5 25.2-43.5 30.8-65 3-11.6 15.4-59 15.4-59 8.1 15.4 31.7 28.5 56.8 28.5 74.8 0 128.7-68.8 128.7-154.3 0-81.9-66.9-143.2-152.9-143.2-107 0-163.9 71.8-163.9 150.1 0 36.4 19.4 81.7 50.3 96.1 4.7 2.2 7.2 1.2 8.3-3.3.8-3.4 5-20.3 6.9-28.1.6-2.5.3-4.7-1.7-7.1-10.1-12.5-18.3-35.3-18.3-56.6 0-54.7 41.4-107.6 112-107.6 60.9 0 103.6 41.5 103.6 100.9 0 67.1-33.9 113.6-78 113.6-24.3 0-42.6-20.1-36.7-44.8 7-29.5 20.5-61.3 20.5-82.6 0-19-10.2-34.9-31.4-34.9-24.9 0-44.9 25.7-44.9 60.2 0 22 7.4 36.8 7.4 36.8s-24.5 103.8-29 123.2c-5 21.4-3 51.6-.9 71.2C65.4 450.9 0 361.1 0 256 0 119 111 8 248 8s248 111 248 248z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_linkedin\" role=\"button\" tabindex=\"0\" aria-label=\"Share on linkedin\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-linkedin\" viewBox=\"0 0 448 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M416 32H31.9C14.3 32 0 46.5 0 64.3v383.4C0 465.5 14.3 480 31.9 480H416c17.6 0 32-14.5 32-32.3V64.3c0-17.8-14.4-32.3-32-32.3zM135.4 416H69V202.2h66.5V416zm-33.2-243c-21.3 0-38.5-17.3-38.5-38.5S80.9 96 102.2 96c21.2 0 38.5 17.3 38.5 38.5 0 21.3-17.2 38.5-38.5 38.5zm282.1 243h-66.4V312c0-24.8-.5-56.7-34.5-56.7-34.6 0-39.9 27-39.9 54.9V416h-66.4V202.2h63.7v29.2h.9c8.9-16.8 30.6-34.5 62.9-34.5 67.2 0 79.7 44.3 79.7 101.9V416z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_reddit\" role=\"button\" tabindex=\"0\" aria-label=\"Share on reddit\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-reddit\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M201.5 305.5c-13.8 0-24.9-11.1-24.9-24.6 0-13.8 11.1-24.9 24.9-24.9 13.6 0 24.6 11.1 24.6 24.9 0 13.6-11.1 24.6-24.6 24.6zM504 256c0 137-111 248-248 248S8 393 8 256 119 8 256 8s248 111 248 248zm-132.3-41.2c-9.4 0-17.7 3.9-23.8 10-22.4-15.5-52.6-25.5-86.1-26.6l17.4-78.3 55.4 12.5c0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.3 24.9-24.9s-11.1-24.9-24.9-24.9c-9.7 0-18 5.8-22.1 13.8l-61.2-13.6c-3-.8-6.1 1.4-6.9 4.4l-19.1 86.4c-33.2 1.4-63.1 11.3-85.5 26.8-6.1-6.4-14.7-10.2-24.1-10.2-34.9 0-46.3 46.9-14.4 62.8-1.1 5-1.7 10.2-1.7 15.5 0 52.6 59.2 95.2 132 95.2 73.1 0 132.3-42.6 132.3-95.2 0-5.3-.6-10.8-1.9-15.8 31.3-16 19.8-62.5-14.9-62.5zM302.8 331c-18.2 18.2-76.1 17.9-93.6 0-2.2-2.2-6.1-2.2-8.3 0-2.5 2.5-2.5 6.4 0 8.6 22.8 22.8 87.3 22.8 110.2 0 2.5-2.2 2.5-6.1 0-8.6-2.2-2.2-6.1-2.2-8.3 0zm7.7-75c-13.6 0-24.6 11.1-24.6 24.9 0 13.6 11.1 24.6 24.6 24.6 13.8 0 24.9-11.1 24.9-24.6 0-13.8-11-24.9-24.9-24.9z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_whatsapp\" role=\"button\" tabindex=\"0\" aria-label=\"Share on whatsapp\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fab-whatsapp\" viewBox=\"0 0 448 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M380.9 97.1C339 55.1 283.2 32 223.9 32c-122.4 0-222 99.6-222 222 0 39.1 10.2 77.3 29.6 111L0 480l117.7-30.9c32.4 17.7 68.9 27 106.1 27h.1c122.3 0 224.1-99.6 224.1-222 0-59.3-25.2-115-67.1-157zm-157 341.6c-33.2 0-65.7-8.9-94-25.7l-6.7-4-69.8 18.3L72 359.2l-4.4-7c-18.5-29.4-28.2-63.3-28.2-98.2 0-101.7 82.8-184.5 184.6-184.5 49.3 0 95.6 19.2 130.4 54.1 34.8 34.9 56.2 81.2 56.1 130.5 0 101.8-84.9 184.6-186.6 184.6zm101.2-138.2c-5.5-2.8-32.8-16.2-37.9-18-5.1-1.9-8.8-2.8-12.5 2.8-3.7 5.6-14.3 18-17.6 21.8-3.2 3.7-6.5 4.2-12 1.4-32.6-16.3-54-29.1-75.5-66-5.7-9.8 5.7-9.1 16.3-30.3 1.8-3.7.9-6.9-.5-9.7-1.4-2.8-12.5-30.1-17.1-41.2-4.5-10.8-9.1-9.3-12.5-9.5-3.2-.2-6.9-.2-10.6-.2-3.7 0-9.7 1.4-14.8 6.9-5.1 5.6-19.4 19-19.4 46.3 0 27.3 19.9 53.7 22.6 57.4 2.8 3.7 39.1 59.7 94.8 83.8 35.2 15.2 49 16.5 66.6 13.9 10.7-1.6 32.8-13.4 37.4-26.4 4.6-13 4.6-24.1 3.2-26.4-1.3-2.5-5-3.9-10.5-6.6z\"></path></svg>							</span>\n																				</div>\n					</div>\n									<div class=\"elementor-grid-item\" role=\"listitem\">\n						<div class=\"elementor-share-btn elementor-share-btn_email\" role=\"button\" tabindex=\"0\" aria-label=\"Share on email\">\n															<span class=\"elementor-share-btn__icon\">\n								<svg aria-hidden=\"true\" class=\"e-font-icon-svg e-fas-envelope\" viewBox=\"0 0 512 512\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M502.3 190.8c3.9-3.1 9.7-.2 9.7 4.7V400c0 26.5-21.5 48-48 48H48c-26.5 0-48-21.5-48-48V195.6c0-5 5.7-7.8 9.7-4.7 22.4 17.4 52.1 39.5 154.1 113.6 21.1 15.4 56.7 47.8 92.2 47.6 35.7.3 72-32.8 92.3-47.6 102-74.1 131.6-96.3 154-113.7zM256 320c23.2.4 56.6-29.2 73.4-41.4 132.7-96.3 142.8-104.7 173.4-128.7 5.8-4.5 9.2-11.5 9.2-18.9v-19c0-26.5-21.5-48-48-48H48C21.5 64 0 85.5 0 112v19c0 7.4 3.4 14.3 9.2 18.9 30.6 23.9 40.7 32.4 173.4 128.7 16.8 12.2 50.2 41.8 73.4 41.4z\"></path></svg>							</span>\n																				</div>\n					</div>\n						</div>\n						</div>\n				</div>\n				</div>\n					</div>\n				</div>\n				</div>\n		</div>\n						</div>\n					</div>\n				', 'Artificial intelligence is no longer a futuristic idea in healthcare—it’s already here. From scheduling appointments and triaging symptoms to analyzing scans and streamlining paperwork, AI is being woven into how hospitals and clinics operate. But as this technology moves closer to the point of care, a deeper question surfaces: Can AI truly understand the human side of medicine? Because patient care isn’t just about test results or treatment protocols. It’s about listening, noticing what’s unsaid, understanding context, and building trust. These are things that don’t always show up in data but they shape outcomes in real, measurable ways. This article explores whether AI can rise to that challenge. We’ll look at where it’s helping today, where it still falls short, and what a thoughtful, balanced approach to AI in patient care might look like. What Makes Patient Care Complex? Treating patients isn’t just about solving medical problems. It’s about understanding people each with their own fears, beliefs, background, and expectations. Two patients with the same diagnosis might need very different patient care. One may want every detail and full involvement in decision-making. The other may just want the doctor to choose what’s best. One might speak up. The other might silently endure. What makes patient care complex is: Emotional cues that aren’t documented anywhere. Cultural factors that shape how symptoms are described or treatment is accepted. Social conditions—like family support, income, or literacy—that impact health outcomes. Trust, or the lack of it, which influences how openly patients communicate. This is the part of patient care that isn’t written in guidelines or lab reports. It’s built in conversation, over time, with attention to nuance. It’s what makes healthcare deeply personal and why replicating it with algorithms is not as simple as feeding data into a model. Where AI Helps Today? While AI may not fully grasp the emotional layers of patient care, it’s already proving useful in areas where speed, structure, and scale matter. Today, AI is helping healthcare providers by: Automating repetitive tasks like appointment scheduling, record-keeping, and follow-up reminders. Assisting with clinical assessment, using chatbots or digital forms to sort symptoms and direct patients to the right level of patient care. Summarizing patient data across records to give doctors a faster, clearer overview. Supporting diagnosis, especially in radiology, dermatology, and pathology, where image recognition plays a key role. In each of these areas, AI acts as a force multiplier. It doesn’t make emotional decisions—but it handles the operational burden, giving clinicians more time and headspace for real patient interaction. Used right, AI isn’t replacing patient care it’s making room for more of it. The Limits of AI in Understanding Patient Care AI has come a long way in processing medical data and supporting clinical decisions. But when it comes to understanding the emotional, cultural, and personal layers of patient care, it still has some growing to do. Today’s AI systems: Don’t pick up on emotional nuance the way a human can. Can’t fully interpret context like why a patient might hesitate to speak up, or how culture shapes medical decisions. Often work like a black box, where recommendations are made without clear reasoning. Are only as good as the data they’re trained on, which can sometimes miss underrepresented groups. These are challenges, not deal-breakers. The goal isn’t to dismiss AI it’s to use it wisely. Let it take care of the operational load, while humans handle the parts of care that require empathy, intuition, and trust. With the right guardrails and thoughtful design, AI can complement human care—not compete with it. Can AI Evolve to Do More? AI is improving fast. What once required massive datasets and predefined rules can now be achieved with more flexible, adaptive models that learn on the go. We’re seeing early signs of progress in areas that hint at a deeper role for AI in care: Multimodal models that combine text, images, voice, and sensor data to form a more complete view of the patient. Explainable AI, which helps doctors and patients understand how and why a recommendation was made. Digital twins virtual models of patients that simulate how an individual might respond to different treatments. Conversational agents that are becoming more responsive, context-aware, and emotionally attuned. These aren’t perfect solutions, and they’re still evolving. But they point to a future where AI might not just process care but start to better understand it. The key is direction. If AI is developed to support human care, not replace it, we may get closer to systems that not only improve outcomes but also respect the complexity of being human. What a Balanced Approach Looks Like? The goal isn’t to choose between AI and human care. It’s to find the right mix where each does what it’s best at. A balanced approach means: Letting AI handle the predictable: scheduling, documentation, follow-ups, and pattern recognition. These tasks drain time and energy that could be better spent with patients. Keeping humans in charge of the unpredictable: complex decisions, emotional conversations, and building trust. This is where context, empathy, and intuition matter most. Designing AI tools that fit into real workflows, not ones that disrupt or replace them. The best tools feel like quiet collaborators, not intrusions. Training healthcare teams to use AI effectively knowing when to lean on it, and when to lead without it. Prioritizing explainability and fairness in AI design, so that both clinicians and patients understand and trust the technology behind their care. It’s not about making care more technical. It’s about making technology serve care not the other way around. Conclusion AI is changing how healthcare operates. There’s no denying its impact faster workflows, earlier detection, better resource use. But the real test isn’t what AI can automate. It’s whether it can coexist with the human side of care. Because patient care isn’t just clinical it’s personal. It’s emotional. It’s built on trust, nuance, and connection. And that’s not something any algorithm can fully replicate. Will AI ever truly understand all of this? Maybe not. But it doesn’t have to. If we build and use AI to support, not replace, the human parts of medicine, it can help us do what matters most: spend more time listening, connecting, and actually caring. That’s the future worth aiming for. 97', NULL, '2025-04-01 18:30:00', 'https://beyondchats.com/blogs/will-ai-understand-the-complexities-of-patient-care/', 0, NULL, NULL, '2025-12-30 13:05:03', '2025-12-30 13:05:03', 'General');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `source_url` (`source_url`),
  ADD UNIQUE KEY `source_url_2` (`source_url`),
  ADD UNIQUE KEY `source_url_3` (`source_url`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `articles`
--
ALTER TABLE `articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- Database: `cibil`
--
CREATE DATABASE IF NOT EXISTS `cibil` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `cibil`;

-- --------------------------------------------------------

--
-- Table structure for table `activity_log`
--

CREATE TABLE `activity_log` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chatbot_history`
--

CREATE TABLE `chatbot_history` (
  `chat_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `query` text DEFAULT NULL,
  `ai_response` text DEFAULT NULL,
  `file_uploaded` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chat_messages`
--

CREATE TABLE `chat_messages` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role` enum('user','assistant') NOT NULL,
  `message_text` text DEFAULT NULL,
  `attachments_json` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat_messages`
--

INSERT INTO `chat_messages` (`id`, `user_id`, `role`, `message_text`, `attachments_json`, `created_at`) VALUES
(9, 2, 'user', 'hi', '[]', '2025-10-26 17:23:16'),
(10, 2, 'assistant', 'I didn’t find an exact answer for that. I can help with:\n• What is CIBIL?\n• What is EMI?\n• What\'s my CIBIL score?\n• Show my active loans\n• Calculate EMI (amount rate months)\n• Check upcoming reminders\n\nTry: Calculate EMI 250000 11 36', NULL, '2025-10-26 17:23:16'),
(11, 2, 'user', 'What\'s my CIBIL score?', '[]', '2025-10-26 17:23:22'),
(12, 2, 'assistant', 'CIBIL is India’s leading credit bureau; it calculates your 300–900 CIBIL score used by lenders.\n\nNo CIBIL score saved yet. Use Predictor to estimate and save it.', NULL, '2025-10-26 17:23:22'),
(13, 2, 'user', 'who are you', '[]', '2025-10-26 17:23:37'),
(14, 2, 'assistant', 'I didn’t find an exact answer for that. I can help with:\n• What is CIBIL?\n• What is EMI?\n• What\'s my CIBIL score?\n• Show my active loans\n• Calculate EMI (amount rate months)\n• Check upcoming reminders\n\nTry: Calculate EMI 250000 11 36', NULL, '2025-10-26 17:23:37'),
(43, 3, 'user', 'hi', '[]', '2025-10-29 10:57:41'),
(44, 3, 'assistant', 'Hi Prem! How can I help you today?\n', NULL, '2025-10-29 10:57:42'),
(45, 3, 'user', 'What\'s my CIBIL score?', '[]', '2025-10-29 10:57:47'),
(46, 3, 'assistant', 'I do not have your CIBIL score currently.\n', NULL, '2025-10-29 10:57:48'),
(47, 3, 'user', 'Show my active loans', '[]', '2025-10-29 10:57:56'),
(48, 3, 'assistant', 'Okay, Prem. You currently have ₹0.00 outstanding on your active loans.\n', NULL, '2025-10-29 10:57:57'),
(49, 3, 'user', 'Check upcoming reminders', '[]', '2025-10-29 10:58:05'),
(50, 3, 'assistant', 'I do not have information about any upcoming reminders for you, Prem.\n', NULL, '2025-10-29 10:58:06');

-- --------------------------------------------------------

--
-- Table structure for table `cibil_scores`
--

CREATE TABLE `cibil_scores` (
  `score_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `cibil_score` int(11) DEFAULT NULL CHECK (`cibil_score` between 300 and 900),
  `score_type` enum('Predicted','Official') DEFAULT 'Predicted',
  `prediction_source` enum('Manual','Database') DEFAULT NULL,
  `ai_model_used` varchar(100) DEFAULT 'Gemini API',
  `prediction_date` datetime DEFAULT current_timestamp(),
  `recommendation` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `doc_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `doc_title` varchar(255) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `storage_size_mb` decimal(8,2) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `doc_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`doc_id`, `user_id`, `doc_title`, `category`, `file_path`, `file_type`, `storage_size_mb`, `uploaded_at`, `doc_date`) VALUES
(1, 3, 'hjn', 'KYC', 'uploads/doc_69019cc92406e_EMGS_Approval_Letter.pdf', 'pdf', 0.01, '2025-10-29 04:49:13', '2025-10-29');

-- --------------------------------------------------------

--
-- Table structure for table `insurance`
--

CREATE TABLE `insurance` (
  `insurance_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `insurance_type` varchar(100) DEFAULT NULL,
  `premium_amount` decimal(12,2) DEFAULT NULL,
  `coverage_amount` decimal(12,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `eligibility_status` enum('Eligible','Not Eligible','Pending') DEFAULT NULL,
  `claim_status` enum('Not Claimed','Claimed','Rejected') DEFAULT 'Not Claimed',
  `remarks` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loans`
--

CREATE TABLE `loans` (
  `loan_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `loan_amount` decimal(15,2) NOT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `repayment_period` int(11) DEFAULT NULL,
  `installment_option` enum('Monthly','Quarterly','Yearly') DEFAULT 'Monthly',
  `status` enum('Active','Approved','Pending','Closed') DEFAULT 'Pending',
  `interest_rate` decimal(5,2) DEFAULT NULL,
  `emi_amount` decimal(12,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `recommendations`
--

CREATE TABLE `recommendations` (
  `rec_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `score_id` int(11) DEFAULT NULL,
  `recommendation_text` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reminders`
--

CREATE TABLE `reminders` (
  `reminder_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `status` enum('Upcoming','Completed','High Priority') DEFAULT 'Upcoming',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `notify_email` tinyint(1) DEFAULT 0,
  `notify_sms` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tutorials_library`
--

CREATE TABLE `tutorials_library` (
  `tutorial_id` int(11) NOT NULL,
  `type` enum('Video','Audio') DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(150) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `marital_status` enum('Single','Married','Divorced','Widowed') DEFAULT NULL,
  `employment_status` varchar(100) DEFAULT NULL,
  `employment_history` text DEFAULT NULL,
  `annual_income` decimal(12,2) DEFAULT NULL,
  `google_login` tinyint(1) DEFAULT 0,
  `profile_pic` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `notify_email_pref` tinyint(1) DEFAULT 1,
  `notify_sms_pref` tinyint(1) DEFAULT 0,
  `pref_ai_suggestions` tinyint(1) DEFAULT 1,
  `pref_tutorial_tips` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `email`, `phone`, `password_hash`, `address`, `dob`, `marital_status`, `employment_status`, `employment_history`, `annual_income`, `google_login`, `profile_pic`, `created_at`, `notify_email_pref`, `notify_sms_pref`, `pref_ai_suggestions`, `pref_tutorial_tips`) VALUES
(1, 'Rahul', 'Sharma', 'a@example.com', '+919876543210', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Flat 202, Green View Apartments, Pune, Maharashtra', '1997-05-12', 'Single', 'Software Engineer', 'Worked as Software Developer at Infosys (2020–2023)', 750000.00, 0, 'uploads/profile/rahul_sharma.jpg', '2025-10-22 08:21:39', 1, 0, 1, 1),
(2, 'p', 'h', 'p@gmail.com', '+918857845418', '$2y$10$nh6dtmBqBnGB1UCbenbiOOzvw74nlgXpL6vSgXmhyPo/seFeMi5WW', 'sdf', NULL, NULL, NULL, NULL, NULL, 0, NULL, '2025-10-22 08:23:53', 1, 0, 1, 1),
(3, 'Prem', 'p', 'a1@example.com', '+918857845419', '$2y$10$J7Heeit5wznRvZ/A93m/0OfMuWblciDHeyz.p1oV03SAc4IU/aQr.', 'sdf', NULL, NULL, NULL, NULL, NULL, 0, NULL, '2025-10-29 04:48:12', 1, 0, 1, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_log`
--
ALTER TABLE `activity_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `chatbot_history`
--
ALTER TABLE `chatbot_history`
  ADD PRIMARY KEY (`chat_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cibil_scores`
--
ALTER TABLE `cibil_scores`
  ADD PRIMARY KEY (`score_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`doc_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `insurance`
--
ALTER TABLE `insurance`
  ADD PRIMARY KEY (`insurance_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `loans`
--
ALTER TABLE `loans`
  ADD PRIMARY KEY (`loan_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `recommendations`
--
ALTER TABLE `recommendations`
  ADD PRIMARY KEY (`rec_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `score_id` (`score_id`);

--
-- Indexes for table `reminders`
--
ALTER TABLE `reminders`
  ADD PRIMARY KEY (`reminder_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `loan_id` (`loan_id`);

--
-- Indexes for table `tutorials_library`
--
ALTER TABLE `tutorials_library`
  ADD PRIMARY KEY (`tutorial_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chatbot_history`
--
ALTER TABLE `chatbot_history`
  MODIFY `chat_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_messages`
--
ALTER TABLE `chat_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `cibil_scores`
--
ALTER TABLE `cibil_scores`
  MODIFY `score_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `doc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `insurance`
--
ALTER TABLE `insurance`
  MODIFY `insurance_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loans`
--
ALTER TABLE `loans`
  MODIFY `loan_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `recommendations`
--
ALTER TABLE `recommendations`
  MODIFY `rec_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reminders`
--
ALTER TABLE `reminders`
  MODIFY `reminder_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tutorials_library`
--
ALTER TABLE `tutorials_library`
  MODIFY `tutorial_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_log`
--
ALTER TABLE `activity_log`
  ADD CONSTRAINT `activity_log_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `chatbot_history`
--
ALTER TABLE `chatbot_history`
  ADD CONSTRAINT `chatbot_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `cibil_scores`
--
ALTER TABLE `cibil_scores`
  ADD CONSTRAINT `cibil_scores_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `insurance`
--
ALTER TABLE `insurance`
  ADD CONSTRAINT `insurance_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `loans`
--
ALTER TABLE `loans`
  ADD CONSTRAINT `loans_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `recommendations`
--
ALTER TABLE `recommendations`
  ADD CONSTRAINT `recommendations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `recommendations_ibfk_2` FOREIGN KEY (`score_id`) REFERENCES `cibil_scores` (`score_id`) ON DELETE CASCADE;

--
-- Constraints for table `reminders`
--
ALTER TABLE `reminders`
  ADD CONSTRAINT `reminders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reminders_ibfk_2` FOREIGN KEY (`loan_id`) REFERENCES `loans` (`loan_id`) ON DELETE SET NULL;
--
-- Database: `event_management`
--
CREATE DATABASE IF NOT EXISTS `event_management` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `event_management`;

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `admin_id` int(11) NOT NULL,
  `admin_name` varchar(100) NOT NULL,
  `admin_email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`admin_id`, `admin_name`, `admin_email`, `password`, `created_at`) VALUES
(1, 'admin', 'admin@example.com', '$2y$10$jF9B35I1ChbVvCD38UJ1peVJC7ViUhlZQXa1H55a2eAZzkH8LPymS', '2025-11-07 08:41:23'),
(2, 'John Doe', 'john.doe@example.com', 'hashed_pass_123', '2025-11-16 02:52:00'),
(3, 'Priya Sharma', 'priya.sharma@example.com', 'hashed_pass_456', '2025-11-16 02:52:00'),
(4, 'Alex Johnson', 'alex.j@example.com', 'hashed_pass_789', '2025-11-16 02:52:00');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `booking_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `number_of_tickets` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `payment_status` enum('Pending','Paid','Failed') DEFAULT 'Pending',
  `booking_status` enum('Pending','Confirmed','Cancelled') DEFAULT 'Pending',
  `qr_code` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `user_id`, `event_id`, `category_id`, `booking_date`, `number_of_tickets`, `total_amount`, `payment_status`, `booking_status`, `qr_code`) VALUES
(5, 1, 1, 1, '2025-11-16 02:52:56', 2, 1998.00, 'Paid', 'Confirmed', 'QR123A'),
(6, 2, 1, 2, '2025-11-16 02:52:56', 1, 999.00, 'Paid', 'Confirmed', 'QR124B'),
(7, 3, 2, 1, '2025-11-16 02:52:56', 3, 1497.00, 'Pending', 'Pending', 'QR125C'),
(8, 1, 3, 3, '2025-11-16 02:52:56', 2, 3000.00, 'Failed', 'Confirmed', 'QR126D'),
(13, 1, 1, 1, '2025-11-16 02:58:42', 2, 1998.00, 'Paid', 'Confirmed', 'QR123A'),
(14, 2, 1, 2, '2025-11-16 02:58:42', 1, 1999.00, 'Paid', 'Confirmed', 'QR124B'),
(15, 3, 2, 3, '2025-11-16 02:58:42', 3, 1497.00, 'Pending', 'Pending', 'QR125C'),
(16, 1, 3, 4, '2025-11-16 02:58:42', 2, 3000.00, 'Failed', 'Cancelled', 'QR126D');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `event_id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `type` enum('Online','Offline') DEFAULT 'Offline',
  `category` varchar(100) DEFAULT NULL,
  `venue` varchar(200) DEFAULT NULL,
  `location_map_link` varchar(255) DEFAULT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `capacity` int(11) NOT NULL,
  `ticket_price` decimal(10,2) DEFAULT 0.00,
  `organizer_name` varchar(100) DEFAULT NULL,
  `organizer_contact` varchar(100) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`event_id`, `title`, `description`, `type`, `category`, `venue`, `location_map_link`, `date`, `time`, `capacity`, `ticket_price`, `organizer_name`, `organizer_contact`, `image`, `is_active`, `created_at`) VALUES
(3, 'asdf', 'asdf', 'Offline', NULL, 'ghodawat collage', NULL, '2025-11-16', '13:51:00', 100, 200.00, NULL, NULL, '/event/uploads/events/event_1763194704_06250202.jpg', 1, '2025-11-15 08:18:24'),
(4, 'Tech Innovators Summit', 'A national-level tech conference.', 'Offline', 'Technology', 'Mumbai Convention Center', 'https://maps.example.com/techsummit', '2025-01-20', '10:00:00', 500, 999.00, 'NextIn Events', '9876543210', 'techsummit.jpg', 1, '2025-11-16 02:52:14'),
(5, 'Online AI Bootcamp', 'A 3-day intensive AI learning program.', 'Online', 'Education', NULL, NULL, '2025-02-10', '09:00:00', 200, 499.00, 'AI Academy', '9123456780', 'aibootcamp.png', 1, '2025-11-16 02:52:14'),
(6, 'Music Festival 2025', 'Live music festival with multiple artists.', 'Offline', 'Entertainment', 'Delhi Open Grounds', 'https://maps.example.com/musicfest', '2025-03-15', '18:00:00', 2000, 1500.00, 'Star Events', '9988776655', 'musicfest.jpg', 1, '2025-11-16 02:52:14');

-- --------------------------------------------------------

--
-- Table structure for table `event_reviews`
--

CREATE TABLE `event_reviews` (
  `review_id` int(11) NOT NULL,
  `event_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` between 1 and 5),
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `event_reviews`
--

INSERT INTO `event_reviews` (`review_id`, `event_id`, `user_id`, `rating`, `comment`, `created_at`) VALUES
(5, 1, 1, 5, 'Amazing event! Great speakers and content.', '2025-11-16 02:55:37'),
(6, 1, 2, 4, 'Well organized but crowded.', '2025-11-16 02:55:37'),
(7, 2, 3, 5, 'Loved the bootcamp! Very informative.', '2025-11-16 02:55:37'),
(8, 3, 1, 4, 'Music was great but food stalls were expensive.', '2025-11-16 02:55:37');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `sent_via` enum('Email','SMS') DEFAULT NULL,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`notification_id`, `user_id`, `message`, `sent_via`, `sent_at`) VALUES
(4, 1, 'Your booking is confirmed for Tech Innovators Summit.', 'Email', '2025-11-16 02:55:50'),
(5, 2, 'Your payment was successful for VIP ticket.', 'SMS', '2025-11-16 02:55:50'),
(6, 3, 'Event reminder: AI Bootcamp starts tomorrow.', 'Email', '2025-11-16 02:55:50');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `otp_code` varchar(10) DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`id`, `email`, `otp_code`, `expires_at`, `created_at`) VALUES
(1, 'admin@example.com', 'c95699c5d9', '2025-11-07 10:43:00', '2025-11-07 08:43:00'),
(2, 'rahul@example.com', '123456', '2025-11-16 08:36:22', '2025-11-16 02:56:22'),
(3, 'sneha@example.com', '987654', '2025-11-16 08:36:22', '2025-11-16 02:56:22');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `booking_id` int(11) DEFAULT NULL,
  `payment_method` enum('UPI','Card','Net Banking','Wallet') NOT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `payment_status` enum('Success','Failed','Refunded') DEFAULT 'Success'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `booking_id`, `payment_method`, `transaction_id`, `amount`, `payment_date`, `payment_status`) VALUES
(5, 1, 'UPI', 'TXNUPI1001', 1998.00, '2025-11-16 02:55:23', 'Success'),
(6, 2, 'Card', 'TXNCARD1002', 1999.00, '2025-11-16 02:55:23', 'Success'),
(7, 3, 'Wallet', 'TXNWAL1003', 1497.00, '2025-11-16 02:55:23', 'Failed'),
(8, 4, 'UPI', 'TXNUPI1004', 3000.00, '2025-11-16 02:55:23', 'Refunded');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `report_id` int(11) NOT NULL,
  `report_type` enum('Event','Revenue','User','Booking') DEFAULT NULL,
  `generated_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `report_data` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`report_id`, `report_type`, `generated_date`, `report_data`) VALUES
(1, 'Event', '2025-11-16 02:56:06', 'Summary of all events for Jan–Mar 2025'),
(2, 'Revenue', '2025-11-16 02:56:06', 'Total revenue generated for Q1 2025'),
(3, 'User', '2025-11-16 02:56:06', 'Active user registration report'),
(4, 'Booking', '2025-11-16 02:56:06', 'Detailed booking analytics for all events');

-- --------------------------------------------------------

--
-- Table structure for table `ticket_categories`
--

CREATE TABLE `ticket_categories` (
  `category_id` int(11) NOT NULL,
  `event_id` int(11) DEFAULT NULL,
  `category_name` varchar(100) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `total_seats` int(11) DEFAULT NULL,
  `remaining_seats` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ticket_categories`
--

INSERT INTO `ticket_categories` (`category_id`, `event_id`, `category_name`, `price`, `total_seats`, `remaining_seats`) VALUES
(1, 3, 'asdf', 200.00, 100, 100);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `mobile_number` varchar(15) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `address` text DEFAULT NULL,
  `is_blocked` tinyint(1) DEFAULT 0,
  `is_verified` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `mobile_number`, `age`, `gender`, `address`, `is_blocked`, `is_verified`, `created_at`) VALUES
(1, 'p', 'p@gmail.com', '$2y$10$vrETKw.NfoigtjsTs0NCQegDMjLuUDd5c3lyIVddBXG4ionh.zbqG', '8857845418', 22, 'Male', 'sdf', 0, 0, '2025-11-07 09:10:36'),
(2, 'p', 'a@gmail.com', '$2y$10$jYZJBMgmRwyz.Sp6gvaVOuHDtwZJ5VMNSszKz/VtQ/2F3Bi0Lpr1y', '08857845417', 22, 'Male', 'sdfas', 0, 0, '2025-11-15 08:19:27'),
(3, 'p', 'ad@example.com', '$2y$10$U8Ty7FLqZjL7hDU4fguJZ.VJbwNTDh3OuUdJXe0QFSz2l.SA/Cy.O', '08857845418', 22, 'Male', 'devgad', 0, 0, '2025-11-20 03:02:43');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `admin_email` (`admin_email`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `event_id` (`event_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`event_id`);

--
-- Indexes for table `event_reviews`
--
ALTER TABLE `event_reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `event_id` (`event_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD UNIQUE KEY `transaction_id` (`transaction_id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`report_id`);

--
-- Indexes for table `ticket_categories`
--
ALTER TABLE `ticket_categories`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `event_id` (`event_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `mobile_number` (`mobile_number`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `event_reviews`
--
ALTER TABLE `event_reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ticket_categories`
--
ALTER TABLE `ticket_categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `ticket_categories` (`category_id`);

--
-- Constraints for table `event_reviews`
--
ALTER TABLE `event_reviews`
  ADD CONSTRAINT `event_reviews_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `event_reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`) ON DELETE CASCADE;

--
-- Constraints for table `ticket_categories`
--
ALTER TABLE `ticket_categories`
  ADD CONSTRAINT `ticket_categories_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE;
--
-- Database: `exam_portal`
--
CREATE DATABASE IF NOT EXISTS `exam_portal` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `exam_portal`;

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `action` varchar(100) NOT NULL,
  `entity_type` varchar(50) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `old_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_values`)),
  `new_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_values`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bulk_upload_sessions`
--

CREATE TABLE `bulk_upload_sessions` (
  `session_id` int(11) NOT NULL,
  `exam_event_id` int(11) NOT NULL,
  `uploaded_by` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `total_records` int(11) NOT NULL,
  `processed_records` int(11) DEFAULT 0,
  `success_records` int(11) DEFAULT 0,
  `error_records` int(11) DEFAULT 0,
  `status` enum('processing','completed','failed') NOT NULL DEFAULT 'processing',
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `completed_at` timestamp NULL DEFAULT NULL,
  `error_log` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `course_id` int(11) NOT NULL,
  `course_code` varchar(20) NOT NULL,
  `course_name` varchar(100) NOT NULL,
  `semester_id` int(11) NOT NULL,
  `credits` int(11) NOT NULL,
  `max_marks` int(11) NOT NULL DEFAULT 100,
  `pass_marks` int(11) NOT NULL DEFAULT 40,
  `is_elective` tinyint(1) DEFAULT 0,
  `description` text DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`course_id`, `course_code`, `course_name`, `semester_id`, `credits`, `max_marks`, `pass_marks`, `is_elective`, `description`, `status`, `created_at`) VALUES
(1, 'CS101', 'Programming Fundamentals', 1, 4, 100, 40, 0, 'Introduction to programming concepts and C language', 'active', '2025-08-26 09:16:45'),
(2, 'MA101', 'Engineering Mathematics I', 1, 4, 100, 40, 0, 'Calculus and linear algebra for engineers', 'active', '2025-08-26 09:16:45'),
(3, 'PH101', 'Engineering Physics', 1, 3, 100, 40, 0, 'Basic physics concepts for engineering students', 'active', '2025-08-26 09:16:45'),
(4, 'CS102', 'Data Structures', 2, 4, 100, 40, 0, 'Data structures and algorithms', 'active', '2025-08-26 09:16:45'),
(5, 'MA102', 'Engineering Mathematics II', 2, 4, 100, 40, 0, 'Differential equations and probability', 'active', '2025-08-26 09:16:45');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `department_id` int(11) NOT NULL,
  `department_code` varchar(20) NOT NULL,
  `department_name` varchar(100) NOT NULL,
  `school` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`department_id`, `department_code`, `department_name`, `school`, `description`, `status`, `created_at`) VALUES
(1, 'CSE', 'Computer Science and Engineering', 'School of Engineering', 'Department of Computer Science and Engineering', 'active', '2025-08-26 09:16:45'),
(2, 'ECE', 'Electronics and Communication Engineering', 'School of Engineering', 'Department of Electronics and Communication Engineering', 'active', '2025-08-26 09:16:45'),
(3, 'ME', 'Mechanical Engineering', 'School of Engineering', 'Department of Mechanical Engineering', 'active', '2025-08-26 09:16:45');

-- --------------------------------------------------------

--
-- Table structure for table `department_years`
--

CREATE TABLE `department_years` (
  `year_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `year_name` varchar(50) NOT NULL,
  `year_order` int(11) NOT NULL,
  `total_semesters` int(11) NOT NULL DEFAULT 2,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department_years`
--

INSERT INTO `department_years` (`year_id`, `department_id`, `year_name`, `year_order`, `total_semesters`, `status`, `created_at`) VALUES
(1, 1, 'First', 1, 2, 'active', '2025-08-26 09:16:45'),
(2, 1, 'Second', 2, 2, 'active', '2025-08-26 09:16:45'),
(3, 1, 'Third', 3, 2, 'active', '2025-08-26 09:16:45'),
(4, 1, 'Final', 4, 2, 'active', '2025-08-26 09:16:45'),
(5, 2, 'First', 1, 2, 'active', '2025-08-26 09:16:45'),
(6, 2, 'Second', 2, 2, 'active', '2025-08-26 09:16:45'),
(7, 2, 'Third', 3, 2, 'active', '2025-08-26 09:16:45'),
(8, 2, 'Final', 4, 2, 'active', '2025-08-26 09:16:45');

-- --------------------------------------------------------

--
-- Table structure for table `enrollments`
--

CREATE TABLE `enrollments` (
  `enrollment_id` int(11) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  `course_id` int(11) NOT NULL,
  `exam_event_id` int(11) NOT NULL,
  `enrollment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('enrolled','appeared','absent') NOT NULL DEFAULT 'enrolled'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exam_events`
--

CREATE TABLE `exam_events` (
  `event_id` int(11) NOT NULL,
  `event_name` varchar(100) NOT NULL,
  `department_id` int(11) NOT NULL,
  `year_id` int(11) NOT NULL,
  `semester_id` int(11) NOT NULL,
  `exam_type` enum('regular','backlog','revaluation') NOT NULL DEFAULT 'regular',
  `exam_date` date NOT NULL,
  `end_date` date NOT NULL,
  `start_time` time NOT NULL,
  `venue` varchar(100) DEFAULT NULL,
  `status` enum('upcoming','ongoing','completed','results_declared') NOT NULL DEFAULT 'upcoming',
  `result_locked` tinyint(1) DEFAULT 0,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exam_events`
--

INSERT INTO `exam_events` (`event_id`, `event_name`, `department_id`, `year_id`, `semester_id`, `exam_type`, `exam_date`, `end_date`, `start_time`, `venue`, `status`, `result_locked`, `created_by`, `created_at`) VALUES
(1, 'End Semester Examination - First Year Semester 1', 1, 1, 1, 'regular', '2024-12-15', '2024-12-20', '09:00:00', 'Main Campus', 'upcoming', 0, 1, '2025-08-26 09:16:45'),
(2, 'Backlog Examination - First Year Semester 1', 1, 1, 1, 'backlog', '2024-11-25', '2024-11-27', '14:00:00', 'Main Campus', 'upcoming', 0, 1, '2025-08-26 09:16:45');

-- --------------------------------------------------------

--
-- Table structure for table `marks`
--

CREATE TABLE `marks` (
  `mark_id` int(11) NOT NULL,
  `enrollment_id` int(11) NOT NULL,
  `ia_marks` decimal(5,2) DEFAULT 0.00,
  `practical_marks` decimal(5,2) DEFAULT 0.00,
  `end_sem_marks` decimal(5,2) DEFAULT 0.00,
  `total_marks` decimal(5,2) DEFAULT 0.00,
  `percentage` decimal(5,2) DEFAULT 0.00,
  `grade` varchar(2) DEFAULT NULL,
  `grade_points` decimal(3,2) DEFAULT NULL,
  `status` enum('pending','entered','verified','published') NOT NULL DEFAULT 'pending',
  `result_status` enum('pass','fail','absent') NOT NULL DEFAULT 'fail',
  `entered_by` int(11) DEFAULT NULL,
  `entered_at` timestamp NULL DEFAULT NULL,
  `verified_by` int(11) DEFAULT NULL,
  `verified_at` timestamp NULL DEFAULT NULL,
  `published_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `programs`
--

CREATE TABLE `programs` (
  `program_id` int(11) NOT NULL,
  `program_code` varchar(20) NOT NULL,
  `program_name` varchar(100) NOT NULL,
  `department_id` int(11) NOT NULL,
  `program_duration` int(11) NOT NULL DEFAULT 8,
  `total_credits` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `programs`
--

INSERT INTO `programs` (`program_id`, `program_code`, `program_name`, `department_id`, `program_duration`, `total_credits`, `description`, `status`) VALUES
(1, 'BTECH-CSE', 'Bachelor of Technology - Computer Science', 1, 8, 160, 'Four-year undergraduate program in Computer Science and Engineering', 'active'),
(2, 'BTECH-ECE', 'Bachelor of Technology - Electronics', 2, 8, 160, 'Four-year undergraduate program in Electronics and Communication Engineering', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `results_cumulative`
--

CREATE TABLE `results_cumulative` (
  `cumulative_id` int(11) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  `cgpa` decimal(3,2) DEFAULT NULL,
  `total_credits` int(11) DEFAULT NULL,
  `earned_credits` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `results_semester`
--

CREATE TABLE `results_semester` (
  `result_id` int(11) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  `exam_event_id` int(11) NOT NULL,
  `semester_id` int(11) NOT NULL,
  `sgpa` decimal(3,2) DEFAULT NULL,
  `total_credits` int(11) DEFAULT NULL,
  `earned_credits` int(11) DEFAULT NULL,
  `status` enum('processing','declared','withheld') NOT NULL DEFAULT 'processing',
  `declared_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `revaluations`
--

CREATE TABLE `revaluations` (
  `revaluation_id` int(11) NOT NULL,
  `enrollment_id` int(11) NOT NULL,
  `original_marks` decimal(5,2) DEFAULT NULL,
  `requested_marks` decimal(5,2) DEFAULT NULL,
  `final_marks` decimal(5,2) DEFAULT NULL,
  `request_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','approved','rejected','processed') NOT NULL DEFAULT 'pending',
  `decided_by` int(11) DEFAULT NULL,
  `decided_at` timestamp NULL DEFAULT NULL,
  `remarks` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `semesters`
--

CREATE TABLE `semesters` (
  `semester_id` int(11) NOT NULL,
  `year_id` int(11) NOT NULL,
  `semester_name` varchar(50) NOT NULL,
  `semester_number` int(11) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `semesters`
--

INSERT INTO `semesters` (`semester_id`, `year_id`, `semester_name`, `semester_number`, `status`, `created_at`) VALUES
(1, 1, 'Semester 1', 1, 'active', '2025-08-26 09:16:45'),
(2, 1, 'Semester 2', 2, 'active', '2025-08-26 09:16:45'),
(3, 2, 'Semester 3', 1, 'active', '2025-08-26 09:16:45'),
(4, 2, 'Semester 4', 2, 'active', '2025-08-26 09:16:45'),
(5, 3, 'Semester 5', 1, 'active', '2025-08-26 09:16:45'),
(6, 3, 'Semester 6', 2, 'active', '2025-08-26 09:16:45'),
(7, 4, 'Semester 7', 1, 'active', '2025-08-26 09:16:45'),
(8, 4, 'Semester 8', 2, 'active', '2025-08-26 09:16:45');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` varchar(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `current_year_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `batch_year` year(4) NOT NULL,
  `admission_year` date NOT NULL,
  `current_semester_id` int(11) DEFAULT NULL,
  `status` enum('active','inactive','graduated') NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `user_id`, `program_id`, `department_id`, `current_year_id`, `first_name`, `last_name`, `batch_year`, `admission_year`, `current_semester_id`, `status`) VALUES
('CSE001', 2, 1, 1, 1, 'John', 'Doe', '2024', '2024-08-01', 1, 'active'),
('CSE002', 3, 1, 1, 1, 'Jane', 'Smith', '2024', '2024-08-01', 1, 'active');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` enum('student','admin') NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_login_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `name`, `email`, `phone`, `role`, `password`, `status`, `created_at`, `last_login_at`) VALUES
(1, 'admin', 'Admin User', 'admin@example.com', '1234567890', 'admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'active', '2025-08-26 09:16:44', NULL),
(2, 'john_doe', 'John Doe', 'john@example.com', '9876543210', 'student', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'active', '2025-08-26 09:16:44', NULL),
(3, 'jane_smith', 'Jane Smith', 'jane@example.com', '5555555555', 'student', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'active', '2025-08-26 09:16:44', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `bulk_upload_sessions`
--
ALTER TABLE `bulk_upload_sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `exam_event_id` (`exam_event_id`),
  ADD KEY `uploaded_by` (`uploaded_by`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_id`),
  ADD UNIQUE KEY `course_code` (`course_code`),
  ADD KEY `semester_id` (`semester_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`department_id`),
  ADD UNIQUE KEY `department_code` (`department_code`);

--
-- Indexes for table `department_years`
--
ALTER TABLE `department_years`
  ADD PRIMARY KEY (`year_id`),
  ADD UNIQUE KEY `unique_dept_year` (`department_id`,`year_name`);

--
-- Indexes for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`enrollment_id`),
  ADD UNIQUE KEY `unique_enrollment` (`student_id`,`course_id`,`exam_event_id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `exam_event_id` (`exam_event_id`);

--
-- Indexes for table `exam_events`
--
ALTER TABLE `exam_events`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `year_id` (`year_id`),
  ADD KEY `semester_id` (`semester_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `marks`
--
ALTER TABLE `marks`
  ADD PRIMARY KEY (`mark_id`),
  ADD KEY `enrollment_id` (`enrollment_id`),
  ADD KEY `entered_by` (`entered_by`),
  ADD KEY `verified_by` (`verified_by`);

--
-- Indexes for table `programs`
--
ALTER TABLE `programs`
  ADD PRIMARY KEY (`program_id`),
  ADD UNIQUE KEY `program_code` (`program_code`),
  ADD KEY `department_id` (`department_id`);

--
-- Indexes for table `results_cumulative`
--
ALTER TABLE `results_cumulative`
  ADD PRIMARY KEY (`cumulative_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `results_semester`
--
ALTER TABLE `results_semester`
  ADD PRIMARY KEY (`result_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `exam_event_id` (`exam_event_id`),
  ADD KEY `semester_id` (`semester_id`);

--
-- Indexes for table `revaluations`
--
ALTER TABLE `revaluations`
  ADD PRIMARY KEY (`revaluation_id`),
  ADD KEY `enrollment_id` (`enrollment_id`),
  ADD KEY `decided_by` (`decided_by`);

--
-- Indexes for table `semesters`
--
ALTER TABLE `semesters`
  ADD PRIMARY KEY (`semester_id`),
  ADD UNIQUE KEY `unique_year_semester` (`year_id`,`semester_number`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `program_id` (`program_id`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `current_year_id` (`current_year_id`),
  ADD KEY `current_semester_id` (`current_semester_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bulk_upload_sessions`
--
ALTER TABLE `bulk_upload_sessions`
  MODIFY `session_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `department_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `department_years`
--
ALTER TABLE `department_years`
  MODIFY `year_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `enrollments`
--
ALTER TABLE `enrollments`
  MODIFY `enrollment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exam_events`
--
ALTER TABLE `exam_events`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `marks`
--
ALTER TABLE `marks`
  MODIFY `mark_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `programs`
--
ALTER TABLE `programs`
  MODIFY `program_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `results_cumulative`
--
ALTER TABLE `results_cumulative`
  MODIFY `cumulative_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `results_semester`
--
ALTER TABLE `results_semester`
  MODIFY `result_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `revaluations`
--
ALTER TABLE `revaluations`
  MODIFY `revaluation_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `semesters`
--
ALTER TABLE `semesters`
  MODIFY `semester_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `bulk_upload_sessions`
--
ALTER TABLE `bulk_upload_sessions`
  ADD CONSTRAINT `bulk_upload_sessions_ibfk_1` FOREIGN KEY (`exam_event_id`) REFERENCES `exam_events` (`event_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bulk_upload_sessions_ibfk_2` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`semester_id`) ON DELETE CASCADE;

--
-- Constraints for table `department_years`
--
ALTER TABLE `department_years`
  ADD CONSTRAINT `department_years_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE CASCADE;

--
-- Constraints for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `enrollments_ibfk_3` FOREIGN KEY (`exam_event_id`) REFERENCES `exam_events` (`event_id`) ON DELETE CASCADE;

--
-- Constraints for table `exam_events`
--
ALTER TABLE `exam_events`
  ADD CONSTRAINT `exam_events_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`),
  ADD CONSTRAINT `exam_events_ibfk_2` FOREIGN KEY (`year_id`) REFERENCES `department_years` (`year_id`),
  ADD CONSTRAINT `exam_events_ibfk_3` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`semester_id`),
  ADD CONSTRAINT `exam_events_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `marks`
--
ALTER TABLE `marks`
  ADD CONSTRAINT `marks_ibfk_1` FOREIGN KEY (`enrollment_id`) REFERENCES `enrollments` (`enrollment_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `marks_ibfk_2` FOREIGN KEY (`entered_by`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `marks_ibfk_3` FOREIGN KEY (`verified_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `programs`
--
ALTER TABLE `programs`
  ADD CONSTRAINT `programs_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`);

--
-- Constraints for table `results_cumulative`
--
ALTER TABLE `results_cumulative`
  ADD CONSTRAINT `results_cumulative_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- Constraints for table `results_semester`
--
ALTER TABLE `results_semester`
  ADD CONSTRAINT `results_semester_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `results_semester_ibfk_2` FOREIGN KEY (`exam_event_id`) REFERENCES `exam_events` (`event_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `results_semester_ibfk_3` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`semester_id`);

--
-- Constraints for table `revaluations`
--
ALTER TABLE `revaluations`
  ADD CONSTRAINT `revaluations_ibfk_1` FOREIGN KEY (`enrollment_id`) REFERENCES `enrollments` (`enrollment_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `revaluations_ibfk_2` FOREIGN KEY (`decided_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `semesters`
--
ALTER TABLE `semesters`
  ADD CONSTRAINT `semesters_ibfk_1` FOREIGN KEY (`year_id`) REFERENCES `department_years` (`year_id`) ON DELETE CASCADE;

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `students_ibfk_2` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`),
  ADD CONSTRAINT `students_ibfk_3` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`),
  ADD CONSTRAINT `students_ibfk_4` FOREIGN KEY (`current_year_id`) REFERENCES `department_years` (`year_id`),
  ADD CONSTRAINT `students_ibfk_5` FOREIGN KEY (`current_semester_id`) REFERENCES `semesters` (`semester_id`);
--
-- Database: `feedback_system`
--
CREATE DATABASE IF NOT EXISTS `feedback_system` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `feedback_system`;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `user` varchar(50) NOT NULL,
  `pass` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `user`, `pass`) VALUES
(1, 'admin@gmail.com', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` bigint(20) NOT NULL,
  `message` text NOT NULL,
  `Date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`id`, `name`, `email`, `mobile`, `message`, `Date`) VALUES
(5, 'dfd', 'sanjeevtech2@gmail.com', 9015501897, 'ddd', '2016-06-29 17:53:28'),
(6, 'dfd', 'sanjeevtech2@gmail.com', 9015501897, 'ddd', '2016-06-29 17:53:43');

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `id` int(11) NOT NULL,
  `user_alias` varchar(30) NOT NULL,
  `Name` varchar(30) NOT NULL,
  `designation` varchar(100) NOT NULL,
  `programme` varchar(50) NOT NULL,
  `semester` varchar(10) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(75) NOT NULL,
  `mobile` bigint(20) NOT NULL,
  `date` datetime NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`id`, `user_alias`, `Name`, `designation`, `programme`, `semester`, `email`, `password`, `mobile`, `date`, `status`) VALUES
(7, 'ravm5454', 'ravi', 'Associate Professior', 'B.Tech', 'ii', 'rav@gmail.com', 'ravi', 9015501897, '2016-07-13 14:30:53', 0),
(8, 'sanj9015', 'sanjeev kumar', 'Developer', 'B.tech', 'ii', 'sanjeevtech2@gmail.com', '2ddea1', 9015501897, '2016-07-13 14:37:35', 0),
(11, 'sanj9015', 'sanjeev kuma', 'aaaa', 'B.tec', 'i', 'sanjeevtechh2@gmail.com', 'dfdfd', 901550189, '2016-07-13 14:40:35', 1);

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` int(11) NOT NULL,
  `student_id` varchar(50) NOT NULL,
  `faculty_id` varchar(50) NOT NULL,
  `Teacher provided the course outline having weekly content plan w` enum('5','4','3','2','1') NOT NULL,
  `Course objectives,learning outcomes and grading criteria are cle` enum('5','4','3','2','1') NOT NULL,
  `Course integrates throretical course concepts with the real worl` enum('5','4','3','2','1') NOT NULL,
  `Teacher is punctual,arrives on time and leaves on time` enum('5','4','3','2','1') NOT NULL,
  `Teacher is good at stimulating the interest in the course conten` enum('5','4','3','2','1') NOT NULL,
  `Teacher is good at explaining the subject matter` enum('5','4','3','2','1') NOT NULL,
  `Teacher's presentation was clear,loud ad easy to understand` enum('5','4','3','2','1') NOT NULL,
  `Teacher is good at using innovative teaching methods/ways` enum('5','4','3','2','1') NOT NULL,
  `Teacher is available and helpful during counseling hours` enum('5','4','3','2','1') NOT NULL,
  `Teacher has competed the whole course as per course outline` enum('5','4','3','2','1') NOT NULL,
  `Teacher was always fair and impartial:` enum('5','4','3','2','1') NOT NULL,
  `Assessments conducted are clearly connected to maximize learinin` enum('5','4','3','2','1') NOT NULL,
  `What I liked about the course` text NOT NULL,
  `Why I disliked about the course` text NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `student_id`, `faculty_id`, `Teacher provided the course outline having weekly content plan w`, `Course objectives,learning outcomes and grading criteria are cle`, `Course integrates throretical course concepts with the real worl`, `Teacher is punctual,arrives on time and leaves on time`, `Teacher is good at stimulating the interest in the course conten`, `Teacher is good at explaining the subject matter`, `Teacher's presentation was clear,loud ad easy to understand`, `Teacher is good at using innovative teaching methods/ways`, `Teacher is available and helpful during counseling hours`, `Teacher has competed the whole course as per course outline`, `Teacher was always fair and impartial:`, `Assessments conducted are clearly connected to maximize learinin`, `What I liked about the course`, `Why I disliked about the course`, `date`) VALUES
(16, 'ravi@gmail.com', 'rav@gmail.com', '5', '5', '5', '5', '5', '5', '5', '5', '5', '5', '5', '5', '\r\nddddddddddddd', 'aa', '2016-07-15'),
(17, 'sanjeevtech2@gmail.com', 'rav@gmail.com', '5', '3', '1', '5', '5', '3', '3', '3', '3', '5', '5', '5', '\r\n', '\r\n', '2016-07-15'),
(18, 'warda@yahoo.com', 'rav@gmail.com', '5', '5', '5', '2', '1', '5', '5', '4', '5', '5', '5', '5', '\r\ndfdfdfdfdfd', '\r\n', '2016-07-17');

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE `files` (
  `notice_id` int(11) NOT NULL,
  `attachment` varchar(255) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `Description` text NOT NULL,
  `Date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `files`
--

INSERT INTO `files` (`notice_id`, `attachment`, `subject`, `Description`, `Date`) VALUES
(8, 'AteekCV_java (1).docx', 'aaaaa', 'dfdfdfd', '2016-07-03 12:39:35');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` char(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `pass` varchar(40) NOT NULL,
  `mobile` bigint(11) NOT NULL,
  `programme` varchar(20) NOT NULL,
  `semester` varchar(10) NOT NULL,
  `gender` varchar(40) NOT NULL,
  `hobbies` varchar(40) NOT NULL,
  `image` varchar(50) NOT NULL,
  `dob` date NOT NULL,
  `regid` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `pass`, `mobile`, `programme`, `semester`, `gender`, `hobbies`, `image`, `dob`, `regid`) VALUES
(10, 'sanjeev kumar', 'sanjeevtech2@gmail.com', '98d34c1758b15b5a359b69c2b08c5767', 9015501897, 'B.tech', '3rd', 'm', 'reading,playing', 'Jellyfish.jpg', '1961-09-15', '2147483647'),
(12, 'ravi', 'ravi@gmail.com', '63dd3e154ca6d948fc380fa576343ba6', 9015501897, 'M.Tech', 'ii', 'm', 'reading', 'Desert.jpg', '1965-10-15', '2016-07-13 15:52:01'),
(13, 'warda', 'warda@yahoo.com', '827ccb0eea8a706c4c34a16891f84e7b', 32457895212, 'BCA', 'ii', 'f', 'reading', 'Koala - Copy.jpg', '1965-10-06', '2016-07-17 15:39:08'),
(14, 'test', 'test@gmail.com', '098f6bcd4621d373cade4e832627b4f6', 989898989, 'MCA', 'i', 'm', 'reading,singin', 'Chrysanthemum.jpg', '1963-08-12', '2017-02-10 16:04:10'),
(15, 'pratha', 'h@gmail.com', 'bb7946e7d85c81a9e69fee1cea4a087c', 857845418, 'alkfd', 'slkdafj', 'm', 'aklfdsj', 'default.jpg', '0000-00-00', '2025-09-07 23:39:43');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`notice_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);
ALTER TABLE `user` ADD FULLTEXT KEY `name` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `faculty`
--
ALTER TABLE `faculty`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `files`
--
ALTER TABLE `files`
  MODIFY `notice_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- Database: `investment_advisory`
--
CREATE DATABASE IF NOT EXISTS `investment_advisory` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `investment_advisory`;

-- --------------------------------------------------------

--
-- Stand-in structure for view `active_subscriptions`
-- (See below for the actual view)
--
CREATE TABLE `active_subscriptions` (
`user_id` int(11)
,`full_name` varchar(255)
,`email` varchar(255)
,`phone` varchar(20)
,`plan_name` varchar(100)
,`plan_type` varchar(50)
,`amount` decimal(10,2)
,`subscription_start_date` date
,`subscription_end_date` date
,`payment_date` timestamp
);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `plan_id` int(11) NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `merchant_transaction_id` varchar(255) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(3) DEFAULT 'INR',
  `payment_status` enum('PENDING','SUCCESS','FAILED','CANCELLED') DEFAULT 'PENDING',
  `payment_method` varchar(50) DEFAULT 'PhonePe',
  `phonepe_response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`phonepe_response`)),
  `payment_date` timestamp NULL DEFAULT NULL,
  `subscription_start_date` date DEFAULT NULL,
  `subscription_end_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `user_id`, `plan_id`, `transaction_id`, `merchant_transaction_id`, `amount`, `currency`, `payment_status`, `payment_method`, `phonepe_response`, `payment_date`, `subscription_start_date`, `subscription_end_date`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '', 'TXN_20250831210643_B14AA9', 9000.00, 'INR', 'PENDING', 'PhonePe', NULL, NULL, NULL, NULL, '2025-08-31 15:36:43', '2025-08-31 15:36:43');

-- --------------------------------------------------------

--
-- Table structure for table `payment_callbacks`
--

CREATE TABLE `payment_callbacks` (
  `id` int(11) NOT NULL,
  `merchant_transaction_id` varchar(255) NOT NULL,
  `callback_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`callback_data`)),
  `callback_type` varchar(50) DEFAULT NULL,
  `processed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `payment_summary`
-- (See below for the actual view)
--
CREATE TABLE `payment_summary` (
`payment_date` date
,`plan_name` varchar(100)
,`total_payments` bigint(21)
,`total_amount` decimal(32,2)
,`successful_payments` bigint(21)
,`failed_payments` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `subscription_plans`
--

CREATE TABLE `subscription_plans` (
  `id` int(11) NOT NULL,
  `plan_name` varchar(100) NOT NULL,
  `plan_type` varchar(50) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `duration` varchar(20) DEFAULT 'Quarterly',
  `capital_required` varchar(100) DEFAULT NULL,
  `risk_level` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `features` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`features`)),
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subscription_plans`
--

INSERT INTO `subscription_plans` (`id`, `plan_name`, `plan_type`, `price`, `duration`, `capital_required`, `risk_level`, `description`, `features`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Equity Plan', 'Equity', 9000.00, 'Quarterly', 'Minimum 2-3 Lakhs', 'Moderate', 'Research-backed equity recommendations', '[\"Intraday calls\", \"Swing trading\", \"Risk management\"]', 1, '2025-08-31 15:36:30', '2025-08-31 15:36:30'),
(2, 'Futures Plan', 'Futures', 12000.00, 'Quarterly', 'Minimum 4-6 Lakhs', 'Moderate To High', 'Index & Equity futures trading', '[\"Index futures\", \"Equity futures\", \"Advanced strategies\"]', 1, '2025-08-31 15:36:30', '2025-08-31 15:36:30'),
(3, 'Options Plan', 'Options', 15000.00, 'Quarterly', 'Minimum 1-2 Lakhs', 'High', 'Index options trading strategies', '[\"Index options\", \"Weekly expiry\", \"Risk-defined strategies\"]', 1, '2025-08-31 15:36:30', '2025-08-31 15:36:30'),
(4, 'Commodity Plan', 'Commodity', 18000.00, 'Quarterly', 'Minimum 2-4 Lakhs', 'Moderate To High', 'Commodity trading recommendations', '[\"Gold\", \"Silver\", \"Crude oil\", \"Agricultural commodities\"]', 1, '2025-08-31 15:36:30', '2025-08-31 15:36:30'),
(5, 'Positional & Swing Trading Plan', 'Positional', 7500.00, 'Quarterly', 'Minimum 1-2 Lakhs', 'Moderate to High', 'Medium-term trading strategies', '[\"Swing trades\", \"Positional calls\", \"Technical analysis\"]', 1, '2025-08-31 15:36:30', '2025-08-31 15:36:30'),
(6, 'Mutual Funds & ETFs Plan', 'Mutual_Funds', 9000.00, 'Quarterly', 'Minimum 50,000 - 1 Lakh', 'Low to Moderate', 'Mutual fund and ETF recommendations', '[\"SIP recommendations\", \"ETF selection\", \"Portfolio allocation\"]', 1, '2025-08-31 15:36:30', '2025-08-31 15:36:30');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `pincode` varchar(10) DEFAULT NULL,
  `pan_number` varchar(10) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `annual_income` varchar(50) DEFAULT NULL,
  `investment_experience` varchar(50) DEFAULT NULL,
  `risk_tolerance` varchar(50) DEFAULT NULL,
  `agree_terms` tinyint(1) DEFAULT 0,
  `agree_disclaimer` tinyint(1) DEFAULT 0,
  `plan_id` int(11) DEFAULT NULL,
  `registration_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1,
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `phone`, `address`, `city`, `state`, `pincode`, `pan_number`, `date_of_birth`, `occupation`, `annual_income`, `investment_experience`, `risk_tolerance`, `agree_terms`, `agree_disclaimer`, `plan_id`, `registration_date`, `is_active`, `last_login`, `created_at`, `updated_at`) VALUES
(1, 'psfafdas', 'admin@example.com', '8857845418', 'sdfsafdgvcddfg', 'saf', 'asfd', '416613', 'BPYPH9827Q', '2000-01-03', 'business', '10_to_25_lakh', 'experienced', 'conservative', 1, 1, NULL, '2025-08-31 15:36:38', 1, NULL, '2025-08-31 15:36:38', '2025-08-31 15:36:38'),
(2, 'pfasdfdsad', 'admin1@example.com', '8857845417', 'sdfqasdfghbvcd', 'saf', 'asfd', '416613', 'BPYPH9827Q', '2004-08-24', 'business', '5_to_10_lakh', 'intermediate', 'moderate', 1, 1, NULL, '2025-08-31 15:43:31', 1, NULL, '2025-08-31 15:43:31', '2025-08-31 15:43:31'),
(3, 'asdffa', 'a@gmail.com', '8857845411', 'asdfsfdagcvafdg', 'asdf', 'asdf', '416613', 'BPYPH9827Q', '2002-08-14', 'business', '10_to_25_lakh', 'intermediate', 'conservative', 1, 1, NULL, '2025-08-31 15:55:35', 1, NULL, '2025-08-31 15:55:35', '2025-08-31 15:55:35'),
(4, 'afsdghasd', 'asd@gmail.com', '8857845416', 'asfgsdasdfhkjlk,mfg', 'afsda', 'asdfaf', '416613', 'BPYPH9827Q', '1998-07-08', 'professional', '5_to_10_lakh', 'intermediate', 'moderate', 1, 1, NULL, '2025-08-31 17:19:20', 1, NULL, '2025-08-31 17:19:20', '2025-08-31 17:19:20'),
(5, 'assd', 'asda@gmail.com', '8857845455', 'asdfgsdfsfdagfaca', 'asdfasg', 'afd', '416613', 'BPYPH9827Q', '1981-06-09', 'professional', '3_to_5_lakh', 'experienced', 'conservative', 1, 1, NULL, '2025-09-01 04:13:21', 1, NULL, '2025-09-01 04:13:21', '2025-09-01 04:13:21'),
(6, 'niraj halale', 'nirajhalale9767@gmail.com', '9975145411', 'asdfghjklp', 'devgad', 'maharashtra', '416613', 'BPYPH9827Q', '2007-08-22', 'salaried', 'above_50_lakh', 'expert', 'aggressive', 1, 1, NULL, '2025-09-01 14:45:03', 1, NULL, '2025-09-01 14:45:03', '2025-09-01 14:45:03'),
(7, 'psafa', 'admiadsn@example.com', '8857845418', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 5, '2025-09-02 05:45:28', 1, NULL, '2025-09-02 05:45:28', '2025-09-02 05:45:28'),
(8, 'asd', 'adminasqw@example.com', '8857845471', 'sdfadsfsdfggfc', 'saf', 'asfd', '416613', 'BPYPH9827Q', '2004-02-24', 'business', '3_to_5_lakh', 'intermediate', 'conservative', 1, 1, NULL, '2025-09-02 13:50:18', 1, NULL, '2025-09-02 13:50:18', '2025-09-02 13:50:18'),
(9, 'pfghjk', 'admin1234@example.com', '7857845418', 'sdfasdfghjk', 'saf', 'asfd', '416613', 'BPYPH9827Q', '2004-08-24', 'retired', '5_to_10_lakh', 'experienced', 'moderate', 1, 1, NULL, '2025-09-02 14:03:09', 1, NULL, '2025-09-02 14:03:09', '2025-09-02 14:03:09');

-- --------------------------------------------------------

--
-- Structure for view `active_subscriptions`
--
DROP TABLE IF EXISTS `active_subscriptions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `active_subscriptions`  AS SELECT `u`.`id` AS `user_id`, `u`.`full_name` AS `full_name`, `u`.`email` AS `email`, `u`.`phone` AS `phone`, `sp`.`plan_name` AS `plan_name`, `sp`.`plan_type` AS `plan_type`, `p`.`amount` AS `amount`, `p`.`subscription_start_date` AS `subscription_start_date`, `p`.`subscription_end_date` AS `subscription_end_date`, `p`.`payment_date` AS `payment_date` FROM ((`users` `u` join `payments` `p` on(`u`.`id` = `p`.`user_id`)) join `subscription_plans` `sp` on(`p`.`plan_id` = `sp`.`id`)) WHERE `p`.`payment_status` = 'SUCCESS' AND `p`.`subscription_end_date` >= curdate() AND `u`.`is_active` = 1 ;

-- --------------------------------------------------------

--
-- Structure for view `payment_summary`
--
DROP TABLE IF EXISTS `payment_summary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `payment_summary`  AS SELECT cast(`p`.`payment_date` as date) AS `payment_date`, `sp`.`plan_name` AS `plan_name`, count(0) AS `total_payments`, sum(`p`.`amount`) AS `total_amount`, count(case when `p`.`payment_status` = 'SUCCESS' then 1 end) AS `successful_payments`, count(case when `p`.`payment_status` = 'FAILED' then 1 end) AS `failed_payments` FROM (`payments` `p` join `subscription_plans` `sp` on(`p`.`plan_id` = `sp`.`id`)) WHERE `p`.`payment_date` is not null GROUP BY cast(`p`.`payment_date` as date), `sp`.`plan_name` ORDER BY cast(`p`.`payment_date` as date) DESC ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transaction_id` (`transaction_id`),
  ADD UNIQUE KEY `merchant_transaction_id` (`merchant_transaction_id`),
  ADD KEY `plan_id` (`plan_id`),
  ADD KEY `idx_payments_user_id` (`user_id`),
  ADD KEY `idx_payments_transaction_id` (`transaction_id`),
  ADD KEY `idx_payments_status` (`payment_status`),
  ADD KEY `idx_payments_date` (`payment_date`);

--
-- Indexes for table `payment_callbacks`
--
ALTER TABLE `payment_callbacks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_merchant_transaction_id` (`merchant_transaction_id`);

--
-- Indexes for table `subscription_plans`
--
ALTER TABLE `subscription_plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `plan_id` (`plan_id`),
  ADD KEY `idx_users_email` (`email`),
  ADD KEY `idx_users_phone` (`phone`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `payment_callbacks`
--
ALTER TABLE `payment_callbacks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscription_plans`
--
ALTER TABLE `subscription_plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`plan_id`) REFERENCES `subscription_plans` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`plan_id`) REFERENCES `subscription_plans` (`id`);
--
-- Database: `job_portal`
--
CREATE DATABASE IF NOT EXISTS `job_portal` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `job_portal`;

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` varchar(50) NOT NULL,
  `username` varchar(1000) NOT NULL,
  `password` varchar(1002) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `app_password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`, `email`, `app_password`) VALUES
('', '', '', '', ''),
('', 'admin', '1234', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `applications`
--

CREATE TABLE `applications` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `year` varchar(10) NOT NULL,
  `branch` varchar(255) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `experience` text NOT NULL,
  `resume` varchar(255) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'applied'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `applications`
--

INSERT INTO `applications` (`id`, `student_id`, `job_id`, `name`, `year`, `branch`, `domain`, `address`, `phone`, `email`, `experience`, `resume`, `photo`, `status`) VALUES
(8, 3, 5, 'rew', 'ty', 'cse', 'cse', 'Banwadi, Karad, Satara', '09075737702', 'shubhamuchougule@gmail.com', 'asdf', '../uploads/photopdf.pdf', '../uploads/IMG_20240420_165523.jpg', 'accepted'),
(11, 3, 17, 'rew', 'ty', 'cse', 'cse', 'Banwadi, Karad, Satara', '09075737702', 'shubhamuchsdfougule@gmail.com', 'no', '../uploads/python 4 5 6.pdf', '../uploads/msbte.jpg', 'accepted'),
(15, 22, 32, 'p', '', 'cse', 'stories', 'sdf', '08857845418', 'admin@example.com', 'azxcv', '../uploads/Mr. PRATHAMESH YOGESH HALALE GOI TO BLR TO KUL 19 SEP 25.pdf', '../uploads/PrathameshHalale_AE451184_PassportLastPage.jpg', 'accepted');

-- --------------------------------------------------------

--
-- Table structure for table `coordinators`
--

CREATE TABLE `coordinators` (
  `id` int(50) NOT NULL,
  `username` varchar(1000) NOT NULL,
  `email` text NOT NULL,
  `phone` int(100) NOT NULL,
  `password` varchar(1002) NOT NULL,
  `department` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `coordinators`
--

INSERT INTO `coordinators` (`id`, `username`, `email`, `phone`, `password`, `department`) VALUES
(4, 'halale', 'shubhamuchougule@gmail.com', 2147483647, '1234', 'CSE'),
(5, 'p', 'prathameshhalale1@gmail.com', 2147483647, '1234', 'Computer Engineering');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `created_at`) VALUES
(1, 'Computer Engineering', '2025-08-23 06:45:27'),
(2, 'Information Technology', '2025-08-23 06:45:27'),
(3, 'Electronics & Telecommunication', '2025-08-23 06:45:27'),
(4, 'Mechanical Engineering', '2025-08-23 06:45:27'),
(5, 'Civil Engineering', '2025-08-23 06:45:27'),
(6, 'Electrical Engineering', '2025-08-23 06:45:27'),
(7, 'halale', '2025-08-23 07:10:12'),
(8, 'fsda', '2025-10-27 02:38:47');

-- --------------------------------------------------------

--
-- Table structure for table `exams`
--

CREATE TABLE `exams` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `duration` int(11) NOT NULL,
  `passing_percentage` int(11) NOT NULL DEFAULT 40,
  `created_by` int(11) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exam_attempts`
--

CREATE TABLE `exam_attempts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `exam_id` int(11) NOT NULL,
  `start_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `end_time` timestamp NULL DEFAULT NULL,
  `score` int(11) DEFAULT 0,
  `percentage` decimal(5,2) DEFAULT 0.00,
  `status` enum('in_progress','completed','abandoned') DEFAULT 'in_progress',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `internships`
--

CREATE TABLE `internships` (
  `id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `stipend` decimal(10,2) DEFAULT NULL,
  `responsibilities` text DEFAULT NULL,
  `supervisor_name` varchar(255) DEFAULT NULL,
  `supervisor_contact` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` int(11) NOT NULL,
  `comname` mediumtext NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `skills` varchar(255) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `department` varchar(100) DEFAULT NULL,
  `position` varchar(255) NOT NULL,
  `experience` varchar(255) NOT NULL,
  `salary` varchar(255) NOT NULL,
  `openings` int(11) NOT NULL,
  `eligibility` varchar(255) NOT NULL,
  `shift` varchar(255) NOT NULL,
  `schedule` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `comname`, `title`, `description`, `skills`, `domain`, `department`, `position`, `experience`, `salary`, `openings`, `eligibility`, `shift`, `schedule`, `logo`, `location`) VALUES
(28, 'introo', 's', 's', 's', 'software', 'Computer Engineering', 'c', '5', '5', 5, '5', 'day', 'full-time', NULL, 'Mumbai'),
(29, 'introo', 'hakalfd', 'asfd', 'java', 'software', 'Computer Engineering', 'AWS', '2', '20000', 12, 'all clear', 'day', 'full-time', NULL, 'Mumbai'),
(30, '', '', 'sajfkdhsjkdc', '', '', 'Computer Engineering', '', '', '', 0, '', '', '', NULL, NULL),
(31, '', 'asdfgh', '<p>sdaf</p>', '', '', 'Civil Engineering', '', '', '', 0, '', '', '', NULL, NULL),
(32, '', 'asdfgh', '<p>sdaf</p>', '', '', 'Computer Engineering', '', '', '', 0, '', '', '', NULL, NULL),
(33, '', 'halale', '<p>sdaf</p>', '', '', 'Computer Science, Information Technology, Electronics, Electrical, Mechanical, Civil, Chemical, Biom', '', '', '', 0, '', '', '', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `milestones`
--

CREATE TABLE `milestones` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `milestones`
--

INSERT INTO `milestones` (`id`, `company_id`, `title`, `description`) VALUES
(1, 7, 'mock', 'give mock test'),
(2, 7, 'test', 'test'),
(3, 7, 'complete', 'done'),
(4, 7, 'mock', 'give mock test'),
(5, 7, 'test', 'test'),
(6, 7, 'complete', 'done');

-- --------------------------------------------------------

--
-- Table structure for table `performance_tracking`
--

CREATE TABLE `performance_tracking` (
  `id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `aptitude` enum('pending','completed') DEFAULT 'pending',
  `technical_interview` enum('pending','completed') DEFAULT 'pending',
  `offer_letter` enum('pending','completed') DEFAULT 'pending',
  `placed` enum('pending','completed') DEFAULT 'pending',
  `rejected` enum('yes','no') DEFAULT 'no',
  `rejection_reason` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `performance_tracking`
--

INSERT INTO `performance_tracking` (`id`, `application_id`, `aptitude`, `technical_interview`, `offer_letter`, `placed`, `rejected`, `rejection_reason`) VALUES
(2, 4, 'completed', 'completed', 'pending', 'completed', 'yes', NULL),
(3, 5, 'pending', 'pending', 'pending', 'pending', 'no', NULL),
(4, 6, 'completed', 'pending', 'completed', 'pending', 'yes', 'died'),
(5, 7, 'pending', 'pending', 'pending', 'pending', 'yes', NULL),
(6, 8, 'pending', 'pending', 'pending', 'pending', 'no', NULL),
(7, 9, 'completed', 'pending', 'pending', 'pending', 'no', NULL),
(8, 10, 'pending', 'pending', 'pending', 'pending', 'no', NULL),
(1659, 11, 'pending', 'pending', 'pending', 'pending', 'no', NULL),
(189562, 12, 'completed', 'completed', 'completed', 'completed', 'no', NULL),
(189566, 15, 'pending', 'pending', 'pending', 'pending', 'no', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `exam_id` int(11) NOT NULL,
  `question_text` text NOT NULL,
  `option_a` text NOT NULL,
  `option_b` text NOT NULL,
  `option_c` text NOT NULL,
  `option_d` text NOT NULL,
  `correct_option` enum('a','b','c','d') NOT NULL,
  `marks` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sent_mails`
--

CREATE TABLE `sent_mails` (
  `id` int(11) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `recipients` text NOT NULL,
  `send_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sent_mails`
--

INSERT INTO `sent_mails` (`id`, `subject`, `message`, `recipients`, `send_date`) VALUES
(1, 'test', 'hello', 'prathameshhalale1234@gmail.com,shubhamuchougule@gmail.com,shubhamucho2ugule@gmail.com', '2025-03-10 09:28:23'),
(2, 'test', 'hello', 'prathameshhalale1234@gmail.com,shubhamuchougule@gmail.com,shubhamucho2ugule@gmail.com', '2025-03-10 09:28:29'),
(3, 'test', 'hello', 'prathameshhalale1234@gmail.com,shubhamuchougule@gmail.com,shubhamucho2ugule@gmail.com', '2025-03-10 09:38:06'),
(4, 'hello', 'no', 'prathameshhalale1234@gmail.com,shubhamuchougule@gmail.com,shubhamucho2ugule@gmail.com', '2025-03-10 09:48:55');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `prn` varchar(255) NOT NULL,
  `roll_no` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `present_class` varchar(50) DEFAULT NULL,
  `branch` varchar(255) NOT NULL,
  `division` varchar(255) NOT NULL,
  `cgpa` decimal(4,2) DEFAULT NULL,
  `sem1_cgpa` decimal(4,2) DEFAULT NULL,
  `sem2_cgpa` decimal(4,2) DEFAULT NULL,
  `sem3_cgpa` decimal(4,2) DEFAULT NULL,
  `sem4_cgpa` decimal(4,2) DEFAULT NULL,
  `sem5_cgpa` decimal(4,2) DEFAULT NULL,
  `sem6_cgpa` decimal(4,2) DEFAULT NULL,
  `tenth_marks` decimal(5,2) DEFAULT NULL,
  `twelfth_marks` decimal(5,2) DEFAULT NULL,
  `backlogs` int(11) DEFAULT 0,
  `backlog_sem` text DEFAULT NULL,
  `certifications` text DEFAULT NULL,
  `technical_expert` text DEFAULT NULL,
  `soft_skills` text DEFAULT NULL,
  `internships` text DEFAULT NULL,
  `resume` varchar(255) DEFAULT NULL,
  `supporting_documents` text DEFAULT NULL,
  `linkedin_url` varchar(255) DEFAULT NULL,
  `github_url` varchar(255) DEFAULT NULL,
  `other_info` text DEFAULT NULL,
  `consent_given` tinyint(1) DEFAULT 0,
  `declaration_given` tinyint(1) DEFAULT 0,
  `address` text NOT NULL,
  `current_address` text DEFAULT NULL,
  `permanent_address` text DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `college_name` varchar(255) DEFAULT NULL,
  `program_name` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `aadhar_no` varchar(20) DEFAULT NULL,
  `approval_status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `prn`, `roll_no`, `name`, `gender`, `date_of_birth`, `present_class`, `branch`, `division`, `cgpa`, `sem1_cgpa`, `sem2_cgpa`, `sem3_cgpa`, `sem4_cgpa`, `sem5_cgpa`, `sem6_cgpa`, `tenth_marks`, `twelfth_marks`, `backlogs`, `backlog_sem`, `certifications`, `technical_expert`, `soft_skills`, `internships`, `resume`, `supporting_documents`, `linkedin_url`, `github_url`, `other_info`, `consent_given`, `declaration_given`, `address`, `current_address`, `permanent_address`, `photo`, `college_name`, `program_name`, `email`, `phone`, `aadhar_no`, `approval_status`, `username`, `password`) VALUES
(3, '23sc114282015', '23', 'rew', NULL, NULL, 'ty', 'cse', 'b', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'Banwadi, Karad, Satara', NULL, NULL, NULL, NULL, NULL, 'shubhamuchougule@gmail.com', '09075737702', NULL, 'approved', 'rew', '$2y$10$HJ76LIyqEtUHgLp/uQzhWuGBELgjZGx.ntyLfLQOzEifAiOJcbYhO'),
(6, '23sc114282016', '95', 'CHOUGULE SHUBHAM ULHAS', NULL, NULL, 'ty', 'cse', 'b', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'Banwadi, Karad, Satara', NULL, NULL, NULL, NULL, NULL, 'shubhamucho2ugule@gmail.com', '09075737702', NULL, 'approved', 'sid', '1234'),
(21, '23sc1142820221', '45', 'Prathamesh Halale', 'Male', '2025-07-31', 'Final Year', 'Computer Engineering', 'b', 8.00, 8.00, 8.00, 8.00, 8.00, 8.00, 8.00, 80.00, 80.00, 0, '0', 'afsd', 'asfd', 'asf', 'afsd', '1756118247_Exam Result Portal – Project Plan and Functional Structure.pdf', '1756118247_Exam Result Portal – Project Plan and Functional Structure.pdf', 'https://nextin.space', 'https://github.com', 'sfa', 0, 0, '', 'asdf', 'asfd', '1756118247_2tcj87po_doctor-neat-prescription-650_625x300_28_September_22.avif', 'sgu', 'btech', 'prathameshhalale1234@gmail.com', '7758090444', '123456789012', 'approved', 'p', '1234'),
(22, '23sc114282022', '78', 'p', 'Male', '2004-08-24', 'Final Year', 'Computer Engineering', 'b', 0.00, 8.00, 8.00, 8.00, 8.00, 8.00, 8.00, 80.00, 80.00, 0, '0', 'asdf', 'asdf', 'asdf', 'asfd', '1761530908_eVal.pdf', '1761530908_eVal.pdf', 'https://nextin.space', 'https://github.com', 'sadf', 0, 0, '', 'sdf', 'NEAR SANJAY GHODAWAT UNIVERSITY, KOLHAPUR', '', 'Sanjay Ghodawat University', '', 'admin@example.com', '08857845418', '123546789123', 'approved', 'hal', '$2y$10$AzIhay86ddSBdlqDVI.xZeoC3IO27IcTUryPSdg1sMZY7C9HT9uW2'),
(25, '23sc1142820333', '45', 'pa', 'Male', '2003-08-24', 'Final Year', 'Computer Engineering', 'b', NULL, 8.00, 8.00, 8.00, 8.00, 8.00, 8.00, 12.00, 12.00, 1, '1', '12ewqd', 'sd', 'sdfa', 'afsd', '1761564401_eVal.pdf', '1761564401_Evisa-Receipt-OO915-OPBMC035 (1).pdf', 'https://nextin.space', 'https://github.com', 'asdf', 0, 0, '', 'sdf', 'NEAR SANJAY GHODAWAT UNIVERSITY, KOLHAPUR', '', 'Sanjay Ghodawat University', '', 'admin1@example.com', '08857845418', '123546789123', 'approved', 'pa', '$2y$10$.V8NJsa9G0JVSW5eSFfNJOkb9IGUavCh.EHLdHamtFDM7aInux9hW'),
(26, '23sc1142820225', '32', 'ab', 'Male', '2001-02-24', 'Final Year', 'Computer Engineering', 'b', 0.00, 8.00, 8.00, 8.00, 8.00, 8.00, 8.00, 12.00, 12.00, 0, '0', 'ghjk', 'gdf', 'hgh', 'gbv', '1761564946_EMGS Approval Letter.pdf', '1761564946_Mr. PRATHAMESH YOGESH HALALE GOI TO BLR TO KUL 19 SEP 25.pdf', '', '', 'asdfghjk', 0, 0, '', 'sdf', 'NEAR SANJAY GHODAWAT UNIVERSITY, KOLHAPUR', '', 'Sanjay Ghodawat University', '', 'admi2n@example.com', '08857845418', '123546789123', 'approved', 'aa', '$2y$10$hSXNvUWn4ZPZ9sFUaKvC.eoSlvqlyAepKRXrvM4tIUI8L8VvEnpAy');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `role` enum('admin','teacher','student') NOT NULL DEFAULT 'student',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `full_name`, `role`, `created_at`, `updated_at`) VALUES
(1, 'admin', '$2y$10$8WxmVVhKZvSFfBEKPa1xo.GpNNFzIUQ.mJLHnvlsH1mEzOY9hO.Oa', 'admin@example.com', 'Administrator', 'admin', '2025-08-22 10:24:12', '2025-08-22 10:24:12');

-- --------------------------------------------------------

--
-- Table structure for table `user_answers`
--

CREATE TABLE `user_answers` (
  `id` int(11) NOT NULL,
  `attempt_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `selected_option` enum('a','b','c','d') NOT NULL,
  `is_correct` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `job_id` (`job_id`);

--
-- Indexes for table `coordinators`
--
ALTER TABLE `coordinators`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `exams`
--
ALTER TABLE `exams`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `exam_attempts`
--
ALTER TABLE `exam_attempts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `exam_id` (`exam_id`);

--
-- Indexes for table `internships`
--
ALTER TABLE `internships`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `milestones`
--
ALTER TABLE `milestones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_id` (`company_id`);

--
-- Indexes for table `performance_tracking`
--
ALTER TABLE `performance_tracking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `application_id` (`application_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exam_id` (`exam_id`);

--
-- Indexes for table `sent_mails`
--
ALTER TABLE `sent_mails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `prn` (`prn`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_answers`
--
ALTER TABLE `user_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attempt_id` (`attempt_id`),
  ADD KEY `question_id` (`question_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `applications`
--
ALTER TABLE `applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `coordinators`
--
ALTER TABLE `coordinators`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `exams`
--
ALTER TABLE `exams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exam_attempts`
--
ALTER TABLE `exam_attempts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `internships`
--
ALTER TABLE `internships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `milestones`
--
ALTER TABLE `milestones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `performance_tracking`
--
ALTER TABLE `performance_tracking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=189569;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sent_mails`
--
ALTER TABLE `sent_mails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_answers`
--
ALTER TABLE `user_answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `exams`
--
ALTER TABLE `exams`
  ADD CONSTRAINT `exams_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `exam_attempts`
--
ALTER TABLE `exam_attempts`
  ADD CONSTRAINT `exam_attempts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `exam_attempts_ibfk_2` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `internships`
--
ALTER TABLE `internships`
  ADD CONSTRAINT `internships_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`);

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_answers`
--
ALTER TABLE `user_answers`
  ADD CONSTRAINT `user_answers_ibfk_1` FOREIGN KEY (`attempt_id`) REFERENCES `exam_attempts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_answers_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE;
--
-- Database: `kids_learning`
--
CREATE DATABASE IF NOT EXISTS `kids_learning` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `kids_learning`;

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
(2, 1, 'quiz', 'Completed quiz with score 1/10', '2025-12-31 08:34:10'),
(3, 1, 'quiz', 'Completed quiz with score 1/10', '2026-01-01 15:52:17'),
(4, 1, 'lesson', 'Completed lesson: dsfasd', '2026-01-05 05:20:10');

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
(1, 1, 'prathamesh', 12, '1234', NULL, 1, 30, '2025-12-31 07:48:07');

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
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `quiz_question` text DEFAULT NULL,
  `option_a` varchar(255) DEFAULT NULL,
  `option_b` varchar(255) DEFAULT NULL,
  `option_c` varchar(255) DEFAULT NULL,
  `correct_option` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lessons`
--

INSERT INTO `lessons` (`lesson_id`, `subject_id`, `lesson_title`, `lesson_description`, `video_url`, `created_at`, `quiz_question`, `option_a`, `option_b`, `option_c`, `correct_option`) VALUES
(1, 1, 'basic english', 'basic english lesson for children', 'https://www.youtube.com/watch?v=iUShfR6MqaE&pp=ygUxbWFnaWNhaSBpbnN0YWxsYXRpb24gaG93IHRvIGJ5cGFzcyBsaXF1aWQgbGljZW5jZQ%3D%3D', '2025-12-31 08:05:39', NULL, NULL, NULL, NULL, NULL),
(2, 2, 'Basic GK', 'asdgdf', 'https://youtu.be/lFe5OA6uN8g', '2025-12-31 08:48:08', NULL, NULL, NULL, NULL, NULL),
(3, 1, 'dsfasd', 'fas', 'https://www.youtube.com/watch?v=1QtpQe-bFbw&pp=ygUcZGlyZWN0b3J5IGxpc3Rpbmcgb2YgY29tcGFueQ%3D%3D', '2026-01-05 05:19:35', 'as', 'aa', 'v', 's', 'B');

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
(1, 1, 1, 1, '2025-12-31 08:18:15'),
(2, 1, 3, 1, '2026-01-05 05:20:10');

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
(1, 1, 'fasd', '2025-12-31 08:33:24'),
(2, 1, 'new quiz', '2025-12-31 08:45:03');

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
(1, 1, 'asfd', 'asd', 'fd', 'df', 'df', 'A'),
(2, 2, 'asfd', 'a', 's', 'd', 'd', 'B');

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
(1, 1, 1, 1, 1, '2025-12-31 08:34:10'),
(2, 1, 2, 1, 1, '2026-01-01 15:52:16');

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
(1, 'english', 'assets/images/subjects/1767168295_gpay.png', '2025-12-31 08:04:55'),
(2, 'Gk', 'assets/images/subjects/1767170858_download.jpeg', '2025-12-31 08:47:38');

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
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `lesson_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `lesson_progress`
--
ALTER TABLE `lesson_progress`
  MODIFY `progress_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `parents`
--
ALTER TABLE `parents`
  MODIFY `parent_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `quiz_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `quiz_results`
--
ALTER TABLE `quiz_results`
  MODIFY `result_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `subject_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
--
-- Database: `kids_learning_platform`
--
CREATE DATABASE IF NOT EXISTS `kids_learning_platform` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `kids_learning_platform`;
--
-- Database: `market`
--
CREATE DATABASE IF NOT EXISTS `market` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `market`;

-- --------------------------------------------------------

--
-- Table structure for table `admin_users`
--

CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` enum('admin','editor','viewer') NOT NULL DEFAULT 'admin',
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_users`
--

INSERT INTO `admin_users` (`id`, `username`, `password`, `name`, `email`, `role`, `last_login`, `created_at`) VALUES
(1, 'admin', 'admin123', 'Administrator', 'admin@example.com', 'admin', NULL, '2025-08-09 08:43:59');

-- --------------------------------------------------------

--
-- Table structure for table `bonds`
--

CREATE TABLE `bonds` (
  `id` int(11) NOT NULL,
  `bond_name` varchar(255) NOT NULL,
  `issuer` varchar(255) NOT NULL,
  `face_value` decimal(15,2) NOT NULL,
  `coupon_rate` decimal(5,2) NOT NULL,
  `yield` decimal(5,2) NOT NULL,
  `maturity_date` date NOT NULL,
  `bond_type` varchar(50) NOT NULL,
  `rating` varchar(20) NOT NULL,
  `min_investment` decimal(15,2) NOT NULL,
  `available_units` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bonds`
--

INSERT INTO `bonds` (`id`, `bond_name`, `issuer`, `face_value`, `coupon_rate`, `yield`, `maturity_date`, `bond_type`, `rating`, `min_investment`, `available_units`, `description`, `created_at`) VALUES
(1, 'Government Treasury Bond 2025', 'US Treasury', 1000.00, 3.50, 3.65, '2025-06-15', 'Government', 'AAA', 1000.00, 500, 'US Treasury bonds with 3.5% coupon rate maturing in 2025', '2025-08-09 07:54:57'),
(2, 'Corporate Bond XYZ', 'XYZ Corporation', 5000.00, 5.75, 6.00, '2027-03-20', 'Corporate', 'AA', 5000.00, 200, 'High-grade corporate bonds from XYZ Corporation with attractive yield', '2025-08-09 07:54:57'),
(3, 'Municipal Bond Series A', 'City of Springfield', 2000.00, 4.25, 4.40, '2026-09-30', 'Municipal', 'A+', 2000.00, 150, 'Tax-exempt municipal bonds issued by the City of Springfield', '2025-08-09 07:54:57'),
(4, 'High-Yield Corporate Bond', 'ABC Industries', 10000.00, 7.50, 7.80, '2028-11-15', 'Corporate', 'BB+', 10000.00, 75, 'Higher yield corporate bonds with moderate risk profile', '2025-08-09 07:54:57'),
(5, 'Green Energy Bond', 'Renewable Energy Corp', 3000.00, 4.80, 5.00, '2029-05-10', 'Corporate', 'BBB', 3000.00, 100, 'Bonds supporting renewable energy projects with environmental benefits', '2025-08-09 07:54:57'),
(6, 'Short-Term Treasury Note', 'US Treasury', 1000.00, 2.75, 2.85, '2024-02-28', 'Government', 'AAA', 1000.00, 300, 'Short-term US Treasury notes maturing in 2024', '2025-08-09 07:54:57'),
(7, 'Infrastructure Development Bond', 'National Infrastructure Authority', 5000.00, 5.25, 5.40, '2030-12-01', 'Government', 'AA+', 5000.00, 120, 'Bonds funding critical infrastructure development projects', '2025-08-09 07:54:57'),
(8, 'Corporate Bond Series B', 'Global Tech Enterprises', 2500.00, 6.00, 6.20, '2026-07-15', 'Corporate', 'A', 2500.00, 180, 'Medium-term corporate bonds from leading technology company', '2025-08-09 07:54:57');

-- --------------------------------------------------------

--
-- Table structure for table `consultations`
--

CREATE TABLE `consultations` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `status` enum('Pending','In Progress','Completed') DEFAULT 'Pending',
  `scheduled_date` datetime DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `consultation_requests`
--

CREATE TABLE `consultation_requests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `investment_amount` decimal(15,2) NOT NULL,
  `investment_horizon` varchar(50) NOT NULL,
  `risk_tolerance` varchar(50) NOT NULL,
  `investment_goals` text NOT NULL,
  `preferred_contact_method` varchar(20) NOT NULL,
  `preferred_time` varchar(50) NOT NULL,
  `additional_notes` text DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `educational_videos`
--

CREATE TABLE `educational_videos` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `youtube_link` varchar(255) NOT NULL,
  `thumbnail` varchar(255) NOT NULL,
  `category` varchar(100) NOT NULL,
  `duration` varchar(20) NOT NULL,
  `views` int(11) DEFAULT 0,
  `likes` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `educational_videos`
--

INSERT INTO `educational_videos` (`id`, `title`, `description`, `youtube_link`, `thumbnail`, `category`, `duration`, `views`, `likes`, `created_at`) VALUES
(1, 'Understanding Stock Market Basics', 'Learn the fundamentals of stock market investing in this comprehensive guide for beginners. This video covers key concepts, terminology, and strategies to help you start your investment journey.', 'https://www.youtube.com/embed/Xn7KWR9EOGQ', 'https://img.youtube.com/vi/Xn7KWR9EOGQ/maxresdefault.jpg', 'Basics', '10:15', 1544, 120, '2025-08-09 07:47:22'),
(2, 'Technical Analysis Explained', 'Master the art of technical analysis with this in-depth tutorial. Learn how to read charts, identify patterns, and make informed trading decisions based on technical indicators.', 'https://www.youtube.com/embed/lJ7QRP4VxUo', 'https://img.youtube.com/vi/lJ7QRP4VxUo/maxresdefault.jpg', 'Technical Analysis', '15:30', 2345, 210, '2025-08-09 07:47:22'),
(3, 'Fundamental Analysis for Long-term Investing', 'Discover how to analyze company fundamentals for long-term investment success. This video explains financial statements, valuation metrics, and how to identify undervalued stocks.', 'https://www.youtube.com/embed/7gkQHSW3hkE', 'https://img.youtube.com/vi/7gkQHSW3hkE/maxresdefault.jpg', 'Fundamental Analysis', '12:45', 1876, 156, '2025-08-09 07:47:22'),
(4, 'Options Trading Strategies', 'Explore various options trading strategies for different market conditions. Learn about calls, puts, spreads, and how to manage risk effectively in options trading.', 'https://www.youtube.com/embed/kmQ20J_3K7Q', 'https://img.youtube.com/vi/kmQ20J_3K7Q/maxresdefault.jpg', 'Options', '18:20', 3210, 275, '2025-08-09 07:47:22'),
(5, 'Cryptocurrency Investment Guide', 'A comprehensive guide to investing in cryptocurrencies. Learn about blockchain technology, different types of cryptocurrencies, and strategies for building a crypto portfolio.', 'https://www.youtube.com/embed/VYWc9dFqROI', 'https://img.youtube.com/vi/VYWc9dFqROI/maxresdefault.jpg', 'Cryptocurrency', '14:50', 4532, 320, '2025-08-09 07:47:22');

-- --------------------------------------------------------

--
-- Table structure for table `fnance_portfolio`
--

CREATE TABLE `fnance_portfolio` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `portfolio_data` longtext DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `portfolio`
--

CREATE TABLE `portfolio` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `symbol` varchar(20) NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `buy_price` decimal(10,2) NOT NULL,
  `buy_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `setting_key` varchar(50) NOT NULL,
  `setting_value` text NOT NULL,
  `setting_description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`setting_key`, `setting_value`, `setting_description`, `created_at`, `updated_at`) VALUES
('contact_email', 'contact@shartrading.com', NULL, '2025-08-09 08:51:50', '2025-08-09 08:51:50'),
('currency_symbol', '₹', NULL, '2025-08-09 08:51:50', '2025-08-09 08:51:50'),
('date_format', 'Y-m-d', NULL, '2025-08-09 08:51:50', '2025-08-09 08:51:50'),
('default_subscription_id', '1', NULL, '2025-08-09 08:51:50', '2025-08-09 08:51:50'),
('enable_email_notifications', '1', NULL, '2025-08-09 08:51:50', '2025-08-09 08:51:50'),
('enable_password_reset', '1', NULL, '2025-08-09 08:51:50', '2025-08-09 08:51:50'),
('enable_registration', '1', NULL, '2025-08-09 08:51:50', '2025-08-09 08:51:50'),
('maintenance_message', 'The site is currently under maintenance. Please check back later.', NULL, '2025-08-09 08:51:50', '2025-08-09 08:51:50'),
('maintenance_mode', '0', NULL, '2025-08-09 08:51:50', '2025-08-09 08:51:50'),
('max_login_attempts', '5', NULL, '2025-08-09 08:51:50', '2025-08-09 08:51:50'),
('pagination_limit', '10', NULL, '2025-08-09 08:51:50', '2025-08-09 08:51:50'),
('session_timeout', '120', NULL, '2025-08-09 08:51:50', '2025-08-09 08:51:50'),
('site_description', 'Stock market trading and educational platform', NULL, '2025-08-09 08:51:50', '2025-08-09 08:51:50'),
('site_name', 'Shar Trading Platform', NULL, '2025-08-09 08:51:50', '2025-08-09 08:51:50'),
('stock_call_expiry_days', '30', NULL, '2025-08-09 08:51:50', '2025-08-09 08:51:50'),
('support_phone', '+91 1234567890', NULL, '2025-08-09 08:51:50', '2025-08-09 08:51:50'),
('timezone', 'Asia/Kolkata', NULL, '2025-08-09 08:51:50', '2025-08-09 08:51:50'),
('time_format', 'H:i:s', NULL, '2025-08-09 08:51:50', '2025-08-09 08:51:50');

-- --------------------------------------------------------

--
-- Table structure for table `stock_calls`
--

CREATE TABLE `stock_calls` (
  `id` int(11) NOT NULL,
  `symbol` varchar(20) NOT NULL,
  `current_price` decimal(10,2) NOT NULL,
  `target_price` decimal(10,2) NOT NULL,
  `stop_loss` decimal(10,2) NOT NULL,
  `time_frame` enum('Short Term','Medium Term','Long Term') NOT NULL,
  `recommendation` enum('Buy','Sell','Hold') NOT NULL,
  `analysis` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expiry_date` date NOT NULL,
  `status` enum('Active','Expired','Achieved') DEFAULT 'Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stock_calls`
--

INSERT INTO `stock_calls` (`id`, `symbol`, `current_price`, `target_price`, `stop_loss`, `time_frame`, `recommendation`, `analysis`, `created_at`, `expiry_date`, `status`) VALUES
(1, 'RELIANCE', 2467.85, 2650.00, 2380.00, 'Medium Term', 'Buy', 'Reliance Industries shows strong momentum with expanding retail and digital business. Technical indicators suggest a breakout from current consolidation pattern. Accumulate at current levels with a medium-term outlook.', '2025-08-09 07:33:13', '2025-09-08', 'Active'),
(2, 'INFY', 1560.40, 1650.00, 1480.00, 'Medium Term', 'Hold', 'Infosys is showing resilience despite global tech slowdown. Q1 results were in line with expectations, and management has maintained guidance. Hold positions with a medium-term view as the stock may consolidate before next move.', '2025-08-09 07:33:13', '2025-09-23', 'Active'),
(3, 'HDFCBANK', 1625.75, 1750.00, 1550.00, 'Long Term', 'Buy', 'HDFC Bank has completed its merger with HDFC Ltd. creating a banking behemoth. The synergies from this merger are expected to play out over the next few quarters. The stock is attractively priced considering its long-term growth potential.', '2025-08-09 07:33:13', '2025-11-07', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `subscription_plans`
--

CREATE TABLE `subscription_plans` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `duration_days` int(11) NOT NULL,
  `features` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subscription_plans`
--

INSERT INTO `subscription_plans` (`id`, `name`, `description`, `price`, `duration_days`, `features`, `created_at`) VALUES
(1, 'Basic', 'Basic trading features for beginners', 999.00, 30, 'Stock market access, Basic charts, Limited watchlist', '2025-08-09 08:54:30'),
(2, 'Premium', 'Advanced features for active traders', 1999.00, 90, 'Stock & Crypto market access, Advanced charts, Unlimited watchlist, Screeners access', '2025-08-09 08:54:30'),
(3, 'Pro', 'Professional trading suite for experts', 4999.00, 365, 'Full market access, Real-time data, Advanced analytics, Priority support, API access', '2025-08-09 08:54:30');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `symbol` varchar(20) NOT NULL,
  `transaction_type` enum('buy','sell') NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `transaction_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` text NOT NULL,
  `pan_number` varchar(10) NOT NULL,
  `aadhar_number` varchar(12) NOT NULL,
  `bank_account` varchar(50) NOT NULL,
  `ifsc_code` varchar(20) NOT NULL,
  `subscription_id` int(11) DEFAULT NULL,
  `subscription_start_date` timestamp NULL DEFAULT NULL,
  `subscription_end_date` timestamp NULL DEFAULT NULL,
  `payment_status` enum('pending','completed','failed') DEFAULT 'pending',
  `payment_id` varchar(100) DEFAULT NULL,
  `fnance_connected` tinyint(1) DEFAULT 0,
  `fnance_registration_id` varchar(100) DEFAULT NULL,
  `fnance_access_token` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `full_name`, `phone`, `address`, `pan_number`, `aadhar_number`, `bank_account`, `ifsc_code`, `subscription_id`, `subscription_start_date`, `subscription_end_date`, `payment_status`, `payment_id`, `fnance_connected`, `fnance_registration_id`, `fnance_access_token`, `created_at`) VALUES
(1, 'testuser', 'test@example.com', '1234', 'Test User', '9876543210', '123 Test Street, Test City', '', '', '', '', NULL, NULL, NULL, 'pending', NULL, 0, NULL, NULL, '2025-08-09 06:43:39'),
(2, 'rew', 'nextin.pvt@gmail.com', '$2y$10$XBKpW5vIE0dlpRRiz/QyMeuuEi92qf8Vdm5CcroSKE57psT7eKpk2', 'q', '8857845418', 'd', '', '', '', '', NULL, NULL, NULL, 'pending', NULL, 0, NULL, NULL, '2025-08-15 04:46:35'),
(3, 'dfg', 'admin4357@example.com', '$2y$10$HKHgYzxrLRXpIjn8YsLuWuKNOXt18a5oPIip4akMYYexgsR3PurjG', 'psgfd', '8857845418', 'fsd', '', '', '', '', NULL, NULL, NULL, 'pending', NULL, 0, NULL, NULL, '2025-08-25 12:47:49'),
(4, 'adminas', 'g@gmail.com', '$2y$10$uN7RfpY.eNqz9kp32ZBJSOkef2zFsUPScaRvmYfzyqFCv7ZgQegJK', 'asfd', '8857845418', 'afsd', '', '', '', '', NULL, NULL, NULL, 'pending', NULL, 0, NULL, NULL, '2025-08-31 12:40:05'),
(5, 'pa', 'admina@example.com', '$2y$10$J2RvYySejbwCxM4A/dCk9.eBMryZvV9i0nu.N.Q5A0idY8MlNDYPK', 'pads', '08857845418', 'sdf', '', '', '', '', NULL, NULL, NULL, 'pending', NULL, 0, NULL, NULL, '2025-09-12 08:04:48'),
(6, 'testusera', 'admian@example.com', '$2y$10$PX.fZyCBsfkYc4q2FoPZKOXDxrwK.K10OwK6fRYt0gfqjhKoGqzui', 'pasd', '08857845418', 'sdfafds', '', '', '', '', NULL, NULL, NULL, 'pending', NULL, 0, NULL, NULL, '2025-09-12 08:11:59');

-- --------------------------------------------------------

--
-- Table structure for table `user_settings`
--

CREATE TABLE `user_settings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `theme` varchar(20) DEFAULT 'light',
  `default_timeframe` varchar(10) DEFAULT '1D',
  `notification_enabled` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_settings`
--

INSERT INTO `user_settings` (`id`, `user_id`, `theme`, `default_timeframe`, `notification_enabled`) VALUES
(1, 1, 'light', '1D', 1),
(2, 1, 'light', '1D', 1);

-- --------------------------------------------------------

--
-- Table structure for table `watchlists`
--

CREATE TABLE `watchlists` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `symbol` varchar(20) NOT NULL,
  `added_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `watchlists`
--

INSERT INTO `watchlists` (`id`, `user_id`, `symbol`, `added_at`) VALUES
(1, 1, 'RELIANCE', '2025-08-09 06:43:39'),
(2, 1, 'TATASTEEL', '2025-08-09 06:43:39'),
(3, 1, 'INFY', '2025-08-09 06:43:39');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `bonds`
--
ALTER TABLE `bonds`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `consultations`
--
ALTER TABLE `consultations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `consultation_requests`
--
ALTER TABLE `consultation_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `educational_videos`
--
ALTER TABLE `educational_videos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fnance_portfolio`
--
ALTER TABLE `fnance_portfolio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `portfolio`
--
ALTER TABLE `portfolio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`setting_key`);

--
-- Indexes for table `stock_calls`
--
ALTER TABLE `stock_calls`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscription_plans`
--
ALTER TABLE `subscription_plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_settings`
--
ALTER TABLE `user_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `watchlists`
--
ALTER TABLE `watchlists`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_symbol` (`user_id`,`symbol`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `bonds`
--
ALTER TABLE `bonds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `consultations`
--
ALTER TABLE `consultations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `consultation_requests`
--
ALTER TABLE `consultation_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `educational_videos`
--
ALTER TABLE `educational_videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `fnance_portfolio`
--
ALTER TABLE `fnance_portfolio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `portfolio`
--
ALTER TABLE `portfolio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_calls`
--
ALTER TABLE `stock_calls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `fnance_portfolio`
--
ALTER TABLE `fnance_portfolio`
  ADD CONSTRAINT `fnance_portfolio_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
--
-- Database: `pet`
--
CREATE DATABASE IF NOT EXISTS `pet` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `pet`;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(1000) NOT NULL,
  `phone` int(11) NOT NULL,
  `password` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

--
-- Dumping data for table `pma__designer_settings`
--

INSERT INTO `pma__designer_settings` (`username`, `settings_data`) VALUES
('root', '{\"relation_lines\":\"true\",\"angular_direct\":\"direct\",\"snap_to_grid\":\"off\"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Dumping data for table `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"timetable\",\"table\":\"attendance\"},{\"db\":\"event_management\",\"table\":\"users\"},{\"db\":\"event_management\",\"table\":\"ticket_categories\"},{\"db\":\"event_management\",\"table\":\"reports\"},{\"db\":\"event_management\",\"table\":\"payments\"},{\"db\":\"event_management\",\"table\":\"notifications\"},{\"db\":\"event_management\",\"table\":\"event_reviews\"},{\"db\":\"event_management\",\"table\":\"events\"},{\"db\":\"event_management\",\"table\":\"bookings\"},{\"db\":\"event_management\",\"table\":\"admins\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2025-11-20 14:22:39', '{\"Console\\/Mode\":\"collapse\",\"lang\":\"en_GB\"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `sha`
--
CREATE DATABASE IF NOT EXISTS `sha` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `sha`;
--
-- Database: `shar_trading`
--
CREATE DATABASE IF NOT EXISTS `shar_trading` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `shar_trading`;
--
-- Database: `student_portal`
--
CREATE DATABASE IF NOT EXISTS `student_portal` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `student_portal`;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `course` varchar(50) DEFAULT NULL,
  `grade` char(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `name`, `email`, `course`, `grade`) VALUES
(1, 'Prathamesh', 'prathamesh@gmail.com', 'Web Development', 'A+'),
(2, 'Yogesh', 'yogesh@gmail.com', 'Database Systems', 'B');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
--
-- Database: `timetable`
--
CREATE DATABASE IF NOT EXISTS `timetable` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `timetable`;

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `attendance_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `timetable_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `status` enum('Present','Absent','Leave','Cancelled') DEFAULT 'Present',
  `remarks` text DEFAULT NULL,
  `marked_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `table_affected` varchar(100) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `batches`
--

CREATE TABLE `batches` (
  `batch_id` int(11) NOT NULL,
  `batch_name` varchar(50) NOT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `batches`
--

INSERT INTO `batches` (`batch_id`, `batch_name`, `dept_id`, `year`) VALUES
(1, 'A1', 1, 2025);

-- --------------------------------------------------------

--
-- Table structure for table `batch_subjects`
--

CREATE TABLE `batch_subjects` (
  `bs_id` int(11) NOT NULL,
  `batch_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `weekly_sessions` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `batch_subjects`
--

INSERT INTO `batch_subjects` (`bs_id`, `batch_id`, `subject_id`, `weekly_sessions`) VALUES
(1, 1, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `chatbot_queries`
--

CREATE TABLE `chatbot_queries` (
  `query_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_query` text DEFAULT NULL,
  `ai_response` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chat_logs`
--

CREATE TABLE `chat_logs` (
  `chat_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `query_text` varchar(255) DEFAULT NULL,
  `intent` varchar(64) DEFAULT NULL,
  `results_count` int(11) DEFAULT NULL,
  `answered_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat_logs`
--

INSERT INTO `chat_logs` (`chat_id`, `user_id`, `query_text`, `intent`, `results_count`, `answered_at`) VALUES
(1, 1, 'hi', 'auto', 0, '2025-11-04 11:18:18'),
(2, 1, 'hi', 'auto', 0, '2025-11-20 08:55:25'),
(3, 1, 'hi', 'auto', 0, '2025-11-20 08:55:37'),
(4, 1, 'hi', 'auto', 0, '2025-11-20 08:55:37'),
(5, 1, 'hi', 'auto', 0, '2025-11-20 08:55:38'),
(6, 1, 'hi', 'auto', 0, '2025-11-20 08:55:38'),
(7, 1, 'hi', 'auto', 0, '2025-11-20 08:55:38');

-- --------------------------------------------------------

--
-- Table structure for table `classrooms`
--

CREATE TABLE `classrooms` (
  `room_id` int(11) NOT NULL,
  `room_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `classrooms`
--

INSERT INTO `classrooms` (`room_id`, `room_name`) VALUES
(1, 'CR1'),
(2, 'CR2');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `dept_id` int(11) NOT NULL,
  `dept_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`dept_id`, `dept_name`, `description`) VALUES
(1, 'CSE', 'Computer science and engineering');

-- --------------------------------------------------------

--
-- Table structure for table `login_logs`
--

CREATE TABLE `login_logs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `logged_in_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login_logs`
--

INSERT INTO `login_logs` (`log_id`, `user_id`, `logged_in_at`) VALUES
(1, 1, '2025-11-03 12:50:59'),
(2, 1, '2025-11-03 12:53:41'),
(3, 1, '2025-11-03 12:54:17'),
(4, 1, '2025-11-03 12:54:35'),
(5, 1, '2025-11-03 12:54:43'),
(6, 1, '2025-11-03 14:05:47'),
(7, 1, '2025-11-04 10:31:22'),
(8, 2, '2025-11-04 10:32:12'),
(9, 1, '2025-11-04 10:44:29'),
(10, 1, '2025-11-04 10:50:57'),
(11, 1, '2025-11-04 10:54:38'),
(12, 1, '2025-11-04 10:55:14'),
(13, 2, '2025-11-04 11:05:08'),
(14, 2, '2025-11-04 11:05:43'),
(15, 2, '2025-11-04 11:06:05'),
(16, 2, '2025-11-04 11:06:31'),
(17, 1, '2025-11-04 11:07:01'),
(18, 1, '2025-11-04 11:17:46'),
(19, 1, '2025-11-07 15:38:21'),
(20, 1, '2025-11-20 08:54:46'),
(21, 3, '2025-11-20 09:22:34'),
(22, 3, '2025-11-20 09:25:12'),
(23, 3, '2025-11-20 09:25:39'),
(24, 1, '2025-11-20 13:53:48');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `permission_id` int(11) NOT NULL,
  `permission_key` varchar(100) NOT NULL,
  `label` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`permission_id`, `permission_key`, `label`, `description`) VALUES
(1, 'edit_timetable', 'Edit Timetable', 'Can create/update/delete timetable entries'),
(2, 'manage_settings', 'Manage Settings', 'Can update system settings'),
(3, 'manage_roles', 'Manage Roles', 'Can manage roles and permissions'),
(4, 'manage_users', 'Manage Users', 'Can add/edit/delete users'),
(5, 'assign_subjects', 'Assign Subjects', 'Can assign subjects to teachers'),
(6, 'view_reports', 'View Reports', 'Can access reports');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `report_id` int(11) NOT NULL,
  `report_name` varchar(100) NOT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `report_type` enum('Attendance','Timetable','Performance','Other') DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `request_logs`
--

CREATE TABLE `request_logs` (
  `log_id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `actor_user_id` int(11) NOT NULL,
  `action` varchar(50) NOT NULL,
  `message` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`, `description`) VALUES
(1, 'admin', 'admin'),
(2, 'Teacher', 'Teaching Staff'),
(3, 'Student', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`role_id`, `permission_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6);

-- --------------------------------------------------------

--
-- Table structure for table `scenario_adjustments`
--

CREATE TABLE `scenario_adjustments` (
  `adj_id` int(11) NOT NULL,
  `scenario_id` int(11) NOT NULL,
  `timetable_id` int(11) NOT NULL,
  `original_slot_id` int(11) NOT NULL,
  `original_teacher_id` int(11) NOT NULL,
  `original_classroom` varchar(100) DEFAULT NULL,
  `proposed_slot_id` int(11) DEFAULT NULL,
  `proposed_teacher_id` int(11) DEFAULT NULL,
  `proposed_classroom` varchar(100) DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `scenario_changes`
--

CREATE TABLE `scenario_changes` (
  `change_id` int(11) NOT NULL,
  `timetable_id` int(11) NOT NULL,
  `old_teacher_id` int(11) DEFAULT NULL,
  `new_teacher_id` int(11) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `scenario_plans`
--

CREATE TABLE `scenario_plans` (
  `scenario_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` enum('teacher','batch') NOT NULL,
  `entity_id` int(11) NOT NULL,
  `affected_slots` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `search_logs`
--

CREATE TABLE `search_logs` (
  `search_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `search_query` varchar(255) DEFAULT NULL,
  `results_count` int(11) DEFAULT NULL,
  `searched_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `setting_id` int(11) NOT NULL,
  `setting_name` varchar(100) NOT NULL,
  `setting_value` varchar(255) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `subject_id` int(11) NOT NULL,
  `subject_name` varchar(100) NOT NULL,
  `subject_code` varchar(20) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `credit_hours` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`subject_id`, `subject_name`, `subject_code`, `dept_id`, `credit_hours`) VALUES
(1, 'Java', '252', 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `teacher_requests`
--

CREATE TABLE `teacher_requests` (
  `request_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `type` enum('Leave','Reschedule') NOT NULL,
  `timetable_id` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `new_date` date DEFAULT NULL,
  `new_slot_id` int(11) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `status` enum('Pending','Approved','Rejected','Modified') DEFAULT 'Pending',
  `resolution_notes` text DEFAULT NULL,
  `resolved_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teacher_subjects`
--

CREATE TABLE `teacher_subjects` (
  `ts_id` int(11) NOT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teacher_subjects`
--

INSERT INTO `teacher_subjects` (`ts_id`, `teacher_id`, `subject_id`) VALUES
(1, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `teacher_unavailability`
--

CREATE TABLE `teacher_unavailability` (
  `tu_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `slot_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `ticket_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `timetable_id` int(11) DEFAULT NULL,
  `type` enum('Leave','Reschedule') NOT NULL,
  `reason` text DEFAULT NULL,
  `status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `timetable`
--

CREATE TABLE `timetable` (
  `timetable_id` int(11) NOT NULL,
  `slot_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `batch_id` int(11) NOT NULL,
  `classroom` varchar(50) DEFAULT NULL,
  `generated_by_ai` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `timetable`
--

INSERT INTO `timetable` (`timetable_id`, `slot_id`, `subject_id`, `teacher_id`, `batch_id`, `classroom`, `generated_by_ai`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, 1, 'CR1', 1, '2025-11-07 15:48:20', '2025-11-07 15:48:20');

-- --------------------------------------------------------

--
-- Table structure for table `time_slots`
--

CREATE TABLE `time_slots` (
  `slot_id` int(11) NOT NULL,
  `day_of_week` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `time_slots`
--

INSERT INTO `time_slots` (`slot_id`, `day_of_week`, `start_time`, `end_time`) VALUES
(1, 'Monday', '10:00:00', '17:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `batch_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `username`, `password`, `role_id`, `is_active`, `created_at`, `batch_id`) VALUES
(1, 'admin', 'a@gmail.com', 'admin', '1234', 1, 1, '2025-11-03 12:50:51', NULL),
(2, 'Prathamesh Halale', 'p@gmail.com', 'p', '1234', 2, 1, '2025-11-04 10:32:00', NULL),
(3, 'PrathameshHalale', 'q@gmail.com', 'q', '1234', 3, 1, '2025-11-20 09:22:18', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`attendance_id`),
  ADD UNIQUE KEY `uq_att` (`teacher_id`,`timetable_id`,`date`),
  ADD KEY `timetable_id` (`timetable_id`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `batches`
--
ALTER TABLE `batches`
  ADD PRIMARY KEY (`batch_id`),
  ADD KEY `dept_id` (`dept_id`);

--
-- Indexes for table `batch_subjects`
--
ALTER TABLE `batch_subjects`
  ADD PRIMARY KEY (`bs_id`),
  ADD UNIQUE KEY `uq_bs` (`batch_id`,`subject_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `chatbot_queries`
--
ALTER TABLE `chatbot_queries`
  ADD PRIMARY KEY (`query_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `chat_logs`
--
ALTER TABLE `chat_logs`
  ADD PRIMARY KEY (`chat_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `classrooms`
--
ALTER TABLE `classrooms`
  ADD PRIMARY KEY (`room_id`),
  ADD UNIQUE KEY `room_name` (`room_name`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`dept_id`);

--
-- Indexes for table `login_logs`
--
ALTER TABLE `login_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`permission_id`),
  ADD UNIQUE KEY `permission_key` (`permission_key`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `generated_by` (`generated_by`);

--
-- Indexes for table `request_logs`
--
ALTER TABLE `request_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `request_id` (`request_id`),
  ADD KEY `actor_user_id` (`actor_user_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_id`,`permission_id`),
  ADD KEY `permission_id` (`permission_id`);

--
-- Indexes for table `scenario_adjustments`
--
ALTER TABLE `scenario_adjustments`
  ADD PRIMARY KEY (`adj_id`),
  ADD KEY `scenario_id` (`scenario_id`),
  ADD KEY `timetable_id` (`timetable_id`);

--
-- Indexes for table `scenario_changes`
--
ALTER TABLE `scenario_changes`
  ADD PRIMARY KEY (`change_id`),
  ADD KEY `timetable_id` (`timetable_id`),
  ADD KEY `old_teacher_id` (`old_teacher_id`),
  ADD KEY `new_teacher_id` (`new_teacher_id`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `scenario_plans`
--
ALTER TABLE `scenario_plans`
  ADD PRIMARY KEY (`scenario_id`);

--
-- Indexes for table `search_logs`
--
ALTER TABLE `search_logs`
  ADD PRIMARY KEY (`search_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`setting_id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`subject_id`),
  ADD UNIQUE KEY `subject_code` (`subject_code`),
  ADD KEY `dept_id` (`dept_id`);

--
-- Indexes for table `teacher_requests`
--
ALTER TABLE `teacher_requests`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `teacher_id` (`teacher_id`),
  ADD KEY `timetable_id` (`timetable_id`),
  ADD KEY `new_slot_id` (`new_slot_id`),
  ADD KEY `resolved_by` (`resolved_by`);

--
-- Indexes for table `teacher_subjects`
--
ALTER TABLE `teacher_subjects`
  ADD PRIMARY KEY (`ts_id`),
  ADD KEY `teacher_id` (`teacher_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `teacher_unavailability`
--
ALTER TABLE `teacher_unavailability`
  ADD PRIMARY KEY (`tu_id`),
  ADD UNIQUE KEY `uq_tu` (`teacher_id`,`slot_id`),
  ADD KEY `slot_id` (`slot_id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`ticket_id`),
  ADD KEY `teacher_id` (`teacher_id`),
  ADD KEY `timetable_id` (`timetable_id`);

--
-- Indexes for table `timetable`
--
ALTER TABLE `timetable`
  ADD PRIMARY KEY (`timetable_id`),
  ADD KEY `slot_id` (`slot_id`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `teacher_id` (`teacher_id`),
  ADD KEY `batch_id` (`batch_id`);

--
-- Indexes for table `time_slots`
--
ALTER TABLE `time_slots`
  ADD PRIMARY KEY (`slot_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `fk_users_batch` (`batch_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `attendance_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `batches`
--
ALTER TABLE `batches`
  MODIFY `batch_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `batch_subjects`
--
ALTER TABLE `batch_subjects`
  MODIFY `bs_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `chatbot_queries`
--
ALTER TABLE `chatbot_queries`
  MODIFY `query_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_logs`
--
ALTER TABLE `chat_logs`
  MODIFY `chat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `classrooms`
--
ALTER TABLE `classrooms`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `dept_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `login_logs`
--
ALTER TABLE `login_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `permission_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `request_logs`
--
ALTER TABLE `request_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `scenario_adjustments`
--
ALTER TABLE `scenario_adjustments`
  MODIFY `adj_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `scenario_changes`
--
ALTER TABLE `scenario_changes`
  MODIFY `change_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `scenario_plans`
--
ALTER TABLE `scenario_plans`
  MODIFY `scenario_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `search_logs`
--
ALTER TABLE `search_logs`
  MODIFY `search_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `setting_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `subject_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `teacher_requests`
--
ALTER TABLE `teacher_requests`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `teacher_subjects`
--
ALTER TABLE `teacher_subjects`
  MODIFY `ts_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `teacher_unavailability`
--
ALTER TABLE `teacher_unavailability`
  MODIFY `tu_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `ticket_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `timetable`
--
ALTER TABLE `timetable`
  MODIFY `timetable_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `time_slots`
--
ALTER TABLE `time_slots`
  MODIFY `slot_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`timetable_id`) REFERENCES `timetable` (`timetable_id`);

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `batches`
--
ALTER TABLE `batches`
  ADD CONSTRAINT `batches_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `departments` (`dept_id`);

--
-- Constraints for table `batch_subjects`
--
ALTER TABLE `batch_subjects`
  ADD CONSTRAINT `batch_subjects_ibfk_1` FOREIGN KEY (`batch_id`) REFERENCES `batches` (`batch_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `batch_subjects_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`) ON DELETE CASCADE;

--
-- Constraints for table `chatbot_queries`
--
ALTER TABLE `chatbot_queries`
  ADD CONSTRAINT `chatbot_queries_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `chat_logs`
--
ALTER TABLE `chat_logs`
  ADD CONSTRAINT `chat_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `login_logs`
--
ALTER TABLE `login_logs`
  ADD CONSTRAINT `login_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`generated_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `request_logs`
--
ALTER TABLE `request_logs`
  ADD CONSTRAINT `request_logs_ibfk_1` FOREIGN KEY (`request_id`) REFERENCES `teacher_requests` (`request_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `request_logs_ibfk_2` FOREIGN KEY (`actor_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`permission_id`) ON DELETE CASCADE;

--
-- Constraints for table `scenario_adjustments`
--
ALTER TABLE `scenario_adjustments`
  ADD CONSTRAINT `scenario_adjustments_ibfk_1` FOREIGN KEY (`scenario_id`) REFERENCES `scenario_plans` (`scenario_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `scenario_adjustments_ibfk_2` FOREIGN KEY (`timetable_id`) REFERENCES `timetable` (`timetable_id`) ON DELETE CASCADE;

--
-- Constraints for table `scenario_changes`
--
ALTER TABLE `scenario_changes`
  ADD CONSTRAINT `scenario_changes_ibfk_1` FOREIGN KEY (`timetable_id`) REFERENCES `timetable` (`timetable_id`),
  ADD CONSTRAINT `scenario_changes_ibfk_2` FOREIGN KEY (`old_teacher_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `scenario_changes_ibfk_3` FOREIGN KEY (`new_teacher_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `scenario_changes_ibfk_4` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `search_logs`
--
ALTER TABLE `search_logs`
  ADD CONSTRAINT `search_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `subjects`
--
ALTER TABLE `subjects`
  ADD CONSTRAINT `subjects_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `departments` (`dept_id`);

--
-- Constraints for table `teacher_requests`
--
ALTER TABLE `teacher_requests`
  ADD CONSTRAINT `teacher_requests_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `teacher_requests_ibfk_2` FOREIGN KEY (`timetable_id`) REFERENCES `timetable` (`timetable_id`),
  ADD CONSTRAINT `teacher_requests_ibfk_3` FOREIGN KEY (`new_slot_id`) REFERENCES `time_slots` (`slot_id`),
  ADD CONSTRAINT `teacher_requests_ibfk_4` FOREIGN KEY (`resolved_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `teacher_subjects`
--
ALTER TABLE `teacher_subjects`
  ADD CONSTRAINT `teacher_subjects_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `teacher_subjects_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`);

--
-- Constraints for table `teacher_unavailability`
--
ALTER TABLE `teacher_unavailability`
  ADD CONSTRAINT `teacher_unavailability_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `teacher_unavailability_ibfk_2` FOREIGN KEY (`slot_id`) REFERENCES `time_slots` (`slot_id`) ON DELETE CASCADE;

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`timetable_id`) REFERENCES `timetable` (`timetable_id`);

--
-- Constraints for table `timetable`
--
ALTER TABLE `timetable`
  ADD CONSTRAINT `timetable_ibfk_1` FOREIGN KEY (`slot_id`) REFERENCES `time_slots` (`slot_id`),
  ADD CONSTRAINT `timetable_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`),
  ADD CONSTRAINT `timetable_ibfk_3` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `timetable_ibfk_4` FOREIGN KEY (`batch_id`) REFERENCES `batches` (`batch_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_batch` FOREIGN KEY (`batch_id`) REFERENCES `batches` (`batch_id`),
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`);
--
-- Database: `user_management`
--
CREATE DATABASE IF NOT EXISTS `user_management` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `user_management`;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `mobile_number` varchar(15) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `mobile_number`, `age`, `gender`, `address`, `created_at`) VALUES
(1, 'John Doe', 'john.doe@example.com', 'securePassword123', '9876543210', 25, 'Male', '123 Main Street, New York', '2025-11-11 12:59:51');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `mobile_number` (`mobile_number`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
