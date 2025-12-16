-- ============================================================
-- HRMS-Babylon Project Database Schema
-- Created: 2025-12-16 23:26:58
-- Purpose: Initialize the Human Resource Management System database
-- ============================================================

-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS `hrms_babylon`
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- Select the database
USE `hrms_babylon`;

-- ============================================================
-- Table: departments
-- Description: Stores department information
-- ============================================================
CREATE TABLE IF NOT EXISTS `departments` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL UNIQUE,
    `description` TEXT,
    `manager_id` INT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_active` BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- Table: employees
-- Description: Stores employee information
-- ============================================================
CREATE TABLE IF NOT EXISTS `employees` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(100) NOT NULL,
    `last_name` VARCHAR(100) NOT NULL,
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `phone` VARCHAR(20),
    `date_of_birth` DATE,
    `gender` ENUM('M', 'F', 'Other'),
    `department_id` INT,
    `position` VARCHAR(100),
    `hire_date` DATE NOT NULL,
    `employment_type` ENUM('Full-Time', 'Part-Time', 'Contract', 'Temporary') DEFAULT 'Full-Time',
    `salary` DECIMAL(10, 2),
    `address` TEXT,
    `city` VARCHAR(100),
    `country` VARCHAR(100),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_active` BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- Table: positions
-- Description: Stores job positions information
-- ============================================================
CREATE TABLE IF NOT EXISTS `positions` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(255) NOT NULL UNIQUE,
    `description` TEXT,
    `department_id` INT,
    `salary_range_min` DECIMAL(10, 2),
    `salary_range_max` DECIMAL(10, 2),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_active` BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- Table: attendance
-- Description: Stores employee attendance records
-- ============================================================
CREATE TABLE IF NOT EXISTS `attendance` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `employee_id` INT NOT NULL,
    `attendance_date` DATE NOT NULL,
    `check_in_time` TIME,
    `check_out_time` TIME,
    `status` ENUM('Present', 'Absent', 'Late', 'Half-Day', 'Leave') DEFAULT 'Absent',
    `notes` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE,
    UNIQUE KEY `unique_attendance` (`employee_id`, `attendance_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- Table: leave_requests
-- Description: Stores employee leave requests
-- ============================================================
CREATE TABLE IF NOT EXISTS `leave_requests` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `employee_id` INT NOT NULL,
    `leave_type` ENUM('Sick', 'Vacation', 'Personal', 'Maternity', 'Other') DEFAULT 'Personal',
    `start_date` DATE NOT NULL,
    `end_date` DATE NOT NULL,
    `reason` TEXT,
    `status` ENUM('Pending', 'Approved', 'Rejected', 'Cancelled') DEFAULT 'Pending',
    `approver_id` INT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE,
    FOREIGN KEY (`approver_id`) REFERENCES `employees` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- Table: payroll
-- Description: Stores payroll records
-- ============================================================
CREATE TABLE IF NOT EXISTS `payroll` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `employee_id` INT NOT NULL,
    `pay_period_start` DATE NOT NULL,
    `pay_period_end` DATE NOT NULL,
    `basic_salary` DECIMAL(10, 2) NOT NULL,
    `allowances` DECIMAL(10, 2) DEFAULT 0,
    `deductions` DECIMAL(10, 2) DEFAULT 0,
    `net_salary` DECIMAL(10, 2) NOT NULL,
    `payment_date` DATE,
    `status` ENUM('Draft', 'Processed', 'Paid', 'Failed') DEFAULT 'Draft',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- Table: performance_reviews
-- Description: Stores employee performance reviews
-- ============================================================
CREATE TABLE IF NOT EXISTS `performance_reviews` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `employee_id` INT NOT NULL,
    `reviewer_id` INT,
    `review_date` DATE NOT NULL,
    `rating` INT CHECK (rating >= 1 AND rating <= 5),
    `comments` TEXT,
    `strengths` TEXT,
    `areas_for_improvement` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE,
    FOREIGN KEY (`reviewer_id`) REFERENCES `employees` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- Table: users
-- Description: Stores system user accounts
-- ============================================================
CREATE TABLE IF NOT EXISTS `users` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `employee_id` INT,
    `username` VARCHAR(100) NOT NULL UNIQUE,
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `password_hash` VARCHAR(255) NOT NULL,
    `role` ENUM('Admin', 'Manager', 'HR', 'Employee') DEFAULT 'Employee',
    `is_active` BOOLEAN DEFAULT TRUE,
    `last_login` TIMESTAMP NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- Table: documents
-- Description: Stores employee documents
-- ============================================================
CREATE TABLE IF NOT EXISTS `documents` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `employee_id` INT NOT NULL,
    `document_type` VARCHAR(100) NOT NULL,
    `file_name` VARCHAR(255) NOT NULL,
    `file_path` VARCHAR(500),
    `upload_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `expiry_date` DATE,
    `notes` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- Table: audit_logs
-- Description: Stores system audit trail
-- ============================================================
CREATE TABLE IF NOT EXISTS `audit_logs` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT,
    `action` VARCHAR(255) NOT NULL,
    `entity_type` VARCHAR(100),
    `entity_id` INT,
    `changes` JSON,
    `ip_address` VARCHAR(45),
    `user_agent` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
    INDEX `idx_user_id` (`user_id`),
    INDEX `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- Create Indexes for Better Query Performance
-- ============================================================

-- Employees indexes
CREATE INDEX `idx_employees_department_id` ON `employees` (`department_id`);
CREATE INDEX `idx_employees_hire_date` ON `employees` (`hire_date`);
CREATE INDEX `idx_employees_is_active` ON `employees` (`is_active`);

-- Attendance indexes
CREATE INDEX `idx_attendance_employee_id` ON `attendance` (`employee_id`);
CREATE INDEX `idx_attendance_date` ON `attendance` (`attendance_date`);

-- Leave requests indexes
CREATE INDEX `idx_leave_requests_employee_id` ON `leave_requests` (`employee_id`);
CREATE INDEX `idx_leave_requests_status` ON `leave_requests` (`status`);

-- Payroll indexes
CREATE INDEX `idx_payroll_employee_id` ON `payroll` (`employee_id`);
CREATE INDEX `idx_payroll_pay_period` ON `payroll` (`pay_period_start`, `pay_period_end`);

-- Performance reviews indexes
CREATE INDEX `idx_performance_reviews_employee_id` ON `performance_reviews` (`employee_id`);
CREATE INDEX `idx_performance_reviews_review_date` ON `performance_reviews` (`review_date`);

-- Users indexes
CREATE INDEX `idx_users_employee_id` ON `users` (`employee_id`);
CREATE INDEX `idx_users_role` ON `users` (`role`);

-- Documents indexes
CREATE INDEX `idx_documents_employee_id` ON `documents` (`employee_id`);
CREATE INDEX `idx_documents_expiry_date` ON `documents` (`expiry_date`);

-- ============================================================
-- End of Database Schema
-- ============================================================
