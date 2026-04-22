-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 22, 2026 at 03:03 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ojt_dtr`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendances`
--

CREATE TABLE `attendances` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'present',
  `remarks` text DEFAULT NULL,
  `time_in_am` time DEFAULT NULL,
  `time_out_am` time DEFAULT NULL,
  `time_in_pm` time DEFAULT NULL,
  `time_out_pm` time DEFAULT NULL,
  `hours_rendered` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attendances`
--

INSERT INTO `attendances` (`id`, `user_id`, `date`, `status`, `remarks`, `time_in_am`, `time_out_am`, `time_in_pm`, `time_out_pm`, `hours_rendered`, `created_at`, `updated_at`) VALUES
(1, 2, '2026-02-04', 'present', NULL, '07:54:00', '12:03:00', '12:58:00', '17:06:00', 8.28, '2026-04-07 17:20:52', '2026-04-07 17:20:52'),
(2, 2, '2026-02-19', 'present', 'Ramadan', NULL, NULL, NULL, NULL, 0.00, '2026-04-07 17:23:13', '2026-04-07 18:06:46'),
(3, 2, '2026-04-06', 'present', NULL, '07:29:00', '12:02:00', '12:59:00', '18:34:00', 10.13, '2026-04-07 17:29:40', '2026-04-07 17:29:40'),
(4, 2, '2026-02-05', 'present', NULL, '07:57:00', '12:02:00', '12:59:00', '17:05:00', 8.18, '2026-04-07 17:31:50', '2026-04-07 17:31:50'),
(5, 3, '2026-02-04', 'present', NULL, '07:54:00', '12:03:00', '12:58:00', '17:06:00', 8.28, '2026-04-07 17:34:35', '2026-04-07 17:34:35'),
(6, 3, '2026-02-05', 'present', NULL, '07:57:00', '12:02:00', '12:19:00', '17:05:00', 8.85, '2026-04-07 17:35:19', '2026-04-07 17:35:19'),
(7, 3, '2026-02-06', 'present', NULL, '07:57:00', '12:01:00', '12:58:00', '17:07:00', 8.22, '2026-04-07 17:35:47', '2026-04-07 17:35:47'),
(8, 3, '2026-02-07', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 17:59:57', '2026-04-07 18:02:16'),
(9, 2, '2026-02-07', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 18:03:50', '2026-04-07 18:06:13'),
(10, 2, '2026-04-09', 'holiday', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 18:04:22', '2026-04-07 18:08:22'),
(11, 3, '2026-02-08', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 18:47:08', '2026-04-07 18:47:08'),
(12, 3, '2026-02-09', 'present', NULL, '07:59:00', '12:01:00', '12:59:00', '17:01:00', 8.07, '2026-04-07 18:47:46', '2026-04-07 18:47:46'),
(13, 3, '2026-02-10', 'present', NULL, '07:55:00', '12:03:00', '12:58:00', '17:02:00', 8.20, '2026-04-07 18:48:45', '2026-04-07 18:48:45'),
(14, 3, '2026-02-11', 'present', NULL, '07:54:00', '12:02:00', '12:59:00', '17:06:00', 8.25, '2026-04-07 18:49:46', '2026-04-07 18:49:46'),
(15, 3, '2026-02-12', 'present', NULL, '07:59:00', '12:01:00', '12:57:00', '17:10:00', 8.25, '2026-04-07 18:50:16', '2026-04-07 18:50:16'),
(16, 3, '2026-02-13', 'present', NULL, '07:52:00', '12:05:00', '12:57:00', '17:09:00', 8.42, '2026-04-07 18:51:38', '2026-04-07 18:51:38'),
(17, 3, '2026-02-14', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 18:51:48', '2026-04-07 18:51:48'),
(18, 3, '2026-02-15', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 18:51:55', '2026-04-07 18:51:55'),
(19, 3, '2026-02-16', 'present', NULL, '07:57:00', '12:02:00', '12:59:00', '17:03:00', 8.15, '2026-04-07 18:52:52', '2026-04-07 21:41:29'),
(20, 3, '2026-02-17', 'holiday', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 18:54:19', '2026-04-07 18:54:19'),
(21, 3, '2026-02-18', 'present', NULL, '07:52:00', '12:02:00', '12:59:00', '17:07:00', 8.30, '2026-04-07 18:55:35', '2026-04-07 18:55:39'),
(22, 3, '2026-02-19', 'present', NULL, '07:27:00', NULL, NULL, '15:38:00', 8.18, '2026-04-07 21:30:03', '2026-04-07 21:30:03'),
(23, 3, '2026-02-20', 'present', NULL, '07:28:00', NULL, NULL, '15:35:00', 8.12, '2026-04-07 21:30:40', '2026-04-07 21:30:40'),
(24, 3, '2026-02-21', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 21:38:07', '2026-04-07 21:38:07'),
(25, 3, '2026-02-22', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 21:38:16', '2026-04-07 21:38:16'),
(26, 3, '2026-02-23', 'present', NULL, '07:25:00', NULL, NULL, '15:35:00', 8.17, '2026-04-07 21:39:14', '2026-04-07 21:39:14'),
(27, 3, '2026-02-24', 'present', NULL, '07:26:00', NULL, NULL, '15:37:00', 8.18, '2026-04-07 21:42:51', '2026-04-07 21:42:51'),
(28, 3, '2026-02-25', 'present', NULL, '07:24:00', NULL, NULL, '15:38:00', 8.23, '2026-04-07 21:43:09', '2026-04-07 21:43:09'),
(29, 3, '2026-02-26', 'present', NULL, '07:23:00', NULL, NULL, '15:31:00', 8.13, '2026-04-07 21:43:43', '2026-04-07 21:43:43'),
(30, 3, '2026-02-27', 'present', NULL, '07:24:00', NULL, NULL, '15:39:00', 8.25, '2026-04-07 21:44:01', '2026-04-07 21:44:01'),
(31, 3, '2026-02-28', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 21:44:11', '2026-04-07 21:44:11'),
(32, 3, '2026-03-01', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 21:44:38', '2026-04-07 21:44:38'),
(33, 3, '2026-03-02', 'present', NULL, '07:21:00', NULL, NULL, '15:37:00', 8.27, '2026-04-07 21:45:15', '2026-04-07 21:45:15'),
(34, 3, '2026-03-03', 'present', NULL, '07:24:00', NULL, NULL, '15:39:00', 8.25, '2026-04-07 21:45:35', '2026-04-07 21:45:35'),
(35, 3, '2026-03-04', 'present', NULL, '07:26:00', NULL, NULL, '15:33:00', 8.12, '2026-04-07 21:45:54', '2026-04-07 21:45:54'),
(36, 3, '2026-03-05', 'present', NULL, '07:29:00', NULL, NULL, '15:31:00', 8.03, '2026-04-07 21:46:10', '2026-04-07 21:46:10'),
(37, 3, '2026-03-06', 'present', NULL, '07:22:00', NULL, NULL, '15:34:00', 8.20, '2026-04-07 21:46:27', '2026-04-07 21:46:27'),
(38, 3, '2026-03-07', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 21:46:57', '2026-04-07 21:46:57'),
(39, 3, '2026-03-08', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 21:47:06', '2026-04-07 21:47:06'),
(40, 3, '2026-03-09', 'present', NULL, '07:24:00', NULL, NULL, '15:40:00', 8.27, '2026-04-07 21:54:47', '2026-04-07 21:54:47'),
(41, 3, '2026-03-10', 'present', NULL, '07:23:00', NULL, NULL, '15:35:00', 8.20, '2026-04-07 21:55:25', '2026-04-07 21:55:25'),
(42, 3, '2026-03-11', 'present', NULL, '07:25:00', NULL, NULL, '15:34:00', 8.15, '2026-04-07 21:56:08', '2026-04-07 21:56:08'),
(43, 3, '2026-03-12', 'present', NULL, '07:29:00', NULL, NULL, '15:33:00', 8.07, '2026-04-07 21:56:33', '2026-04-07 21:56:33'),
(44, 3, '2026-03-13', 'Dayoff', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 21:58:46', '2026-04-07 21:58:46'),
(45, 3, '2026-03-14', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 21:59:19', '2026-04-07 21:59:19'),
(46, 3, '2026-03-15', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 21:59:26', '2026-04-07 21:59:26'),
(47, 3, '2026-03-16', 'present', NULL, '07:27:00', NULL, NULL, '15:36:00', 8.15, '2026-04-07 22:00:11', '2026-04-07 22:00:11'),
(48, 3, '2026-03-17', 'present', NULL, '07:24:00', NULL, NULL, '15:39:00', 8.25, '2026-04-07 22:00:38', '2026-04-07 22:00:38'),
(49, 3, '2026-03-18', 'holiday', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 22:00:59', '2026-04-07 22:00:59'),
(50, 3, '2026-03-19', 'present', NULL, '07:26:00', NULL, NULL, '15:35:00', 8.15, '2026-04-07 22:01:35', '2026-04-07 22:01:35'),
(51, 3, '2026-03-20', 'holiday', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 22:02:07', '2026-04-07 22:02:07'),
(52, 3, '2026-03-21', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 22:02:18', '2026-04-07 22:02:18'),
(53, 3, '2026-03-22', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 22:02:34', '2026-04-07 22:02:34'),
(54, 3, '2026-03-23', 'present', NULL, '07:25:00', '12:02:00', '12:59:00', '18:33:00', 10.18, '2026-04-07 22:03:42', '2026-04-07 22:05:41'),
(55, 3, '2026-03-24', 'present', NULL, '07:24:00', '12:01:00', '12:57:00', '18:35:00', 10.25, '2026-04-07 22:06:06', '2026-04-07 22:06:06'),
(56, 3, '2026-03-25', 'present', NULL, '07:24:00', '12:05:00', '12:55:00', '18:37:00', 10.38, '2026-04-07 22:06:36', '2026-04-07 22:06:36'),
(57, 3, '2026-03-26', 'present', NULL, '07:22:00', '12:02:00', '12:57:00', '18:35:00', 10.30, '2026-04-07 22:08:53', '2026-04-07 22:08:53'),
(58, 3, '2026-03-27', 'Dayoff', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 22:09:25', '2026-04-07 22:09:25'),
(59, 3, '2026-03-28', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 22:09:35', '2026-04-07 22:09:35'),
(60, 3, '2026-03-29', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 22:09:45', '2026-04-07 22:09:45'),
(61, 3, '2026-03-30', 'present', NULL, '07:26:00', '12:04:00', '12:55:00', '18:33:00', 10.27, '2026-04-07 22:11:46', '2026-04-07 22:11:46'),
(62, 3, '2026-03-31', 'present', NULL, '07:24:00', '12:02:00', '12:57:00', '18:31:00', 10.20, '2026-04-07 22:12:07', '2026-04-07 22:12:07'),
(63, 3, '2026-04-01', 'Dayoff', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 22:13:55', '2026-04-07 22:13:55'),
(64, 3, '2026-04-02', 'holiday', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 22:14:04', '2026-04-07 22:14:04'),
(65, 3, '2026-04-03', 'holiday', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 22:14:12', '2026-04-07 22:14:12'),
(66, 3, '2026-04-04', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 22:14:21', '2026-04-07 22:14:21'),
(67, 3, '2026-04-05', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-07 22:14:35', '2026-04-07 22:14:35'),
(68, 3, '2026-04-06', 'present', NULL, '07:27:00', '12:04:00', '12:55:00', '18:31:00', 10.22, '2026-04-07 22:15:20', '2026-04-07 22:15:20'),
(69, 3, '2026-04-07', 'present', NULL, '07:25:00', '12:01:00', '12:56:00', '18:34:00', 10.23, '2026-04-07 22:15:39', '2026-04-07 22:15:39'),
(70, 3, '2026-04-08', 'present', NULL, '07:22:00', '12:02:00', '12:52:00', '18:37:00', 10.42, '2026-04-07 22:16:15', '2026-04-08 02:22:07'),
(71, 2, '2026-04-04', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-08 02:05:30', '2026-04-08 02:05:30'),
(72, 3, '2026-04-09', 'holiday', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-12 16:40:33', '2026-04-12 16:40:33'),
(73, 3, '2026-04-10', 'Dayoff', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-12 16:40:42', '2026-04-12 16:40:42'),
(74, 3, '2026-04-11', 'Dayoff', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-12 16:40:49', '2026-04-12 16:40:49'),
(75, 3, '2026-04-12', 'Dayoff', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-12 16:40:58', '2026-04-12 16:40:58'),
(76, 3, '2026-04-13', 'present', NULL, '07:24:00', '12:03:00', '12:55:00', '18:35:00', 10.32, '2026-04-12 16:42:10', '2026-04-13 07:23:46'),
(77, 3, '2026-04-14', 'present', NULL, '07:26:00', '12:06:00', '12:57:00', '18:39:00', 10.37, '2026-04-13 16:41:57', '2026-04-14 03:32:32'),
(78, 3, '2026-04-15', 'present', NULL, '07:27:00', '12:01:00', '12:57:00', '18:35:00', 10.20, '2026-04-15 02:09:06', '2026-04-19 16:49:16'),
(79, 3, '2026-04-16', 'absent', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-21 16:44:59', '2026-04-21 16:44:59'),
(80, 3, '2026-04-17', 'Dayoff', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-21 16:45:37', '2026-04-21 16:45:37'),
(81, 3, '2026-04-18', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-21 16:45:47', '2026-04-21 16:45:47'),
(82, 3, '2026-04-19', 'weekend', NULL, NULL, NULL, NULL, NULL, 0.00, '2026-04-21 16:46:00', '2026-04-21 16:46:00'),
(83, 3, '2026-04-20', 'present', NULL, '07:24:00', '12:02:00', '12:56:00', '18:36:00', 10.30, '2026-04-21 16:46:48', '2026-04-21 16:46:48'),
(84, 3, '2026-04-21', 'present', NULL, '07:26:00', '12:05:00', '12:58:00', '18:31:00', 10.20, '2026-04-21 16:47:44', '2026-04-21 16:47:44');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `name`, `address`, `logo`, `created_at`, `updated_at`) VALUES
(1, 'Bangsamoro Information Office', 'Cotabato City', 'companies/AgRDmHfB7tbIPpV5QMhJYf3khlyBycaThbi2yGzQ.png', '2026-04-07 17:10:22', '2026-04-07 17:10:36'),
(3, 'wewe', 'wewew', 'companies/g7xgZniU0VDI0267Mm3xKxEPo8rccnEyo21pVVX0.png', '2026-04-14 01:08:55', '2026-04-14 01:08:55');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_03_26_052621_add_role_to_users_table', 1),
(5, '2026_03_31_052757_create_companies_table', 1),
(6, '2026_03_31_072655_add_company_to_users_table', 1),
(7, '2026_03_31_074743_add_required_hours_to_users_table', 1),
(8, '2026_04_06_100551_add_rendered_hours_to_users_table', 1),
(9, '2026_04_06_101550_change_hours_to_decimal_in_users_table', 1),
(10, '2026_04_06_101745_change_required_hours_to_integer', 1),
(11, '2026_04_07_022420_create_attendances_table', 1),
(12, '2026_04_07_061743_add_signatory_to_users_table', 1),
(13, '2026_04_07_063658_add_signatory_position_to_users_table', 1),
(14, '2026_04_08_014213_add_status_and_remarks_to_attendances_table', 2),
(15, '2026_04_08_082334_add_profile_photo_to_users_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `profile_photo` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'user',
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `required_hours` int(11) NOT NULL DEFAULT 0,
  `rendered_hours` decimal(8,2) NOT NULL DEFAULT 0.00,
  `signatory_name` varchar(255) DEFAULT NULL,
  `signatory_position` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `profile_photo`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `role`, `company_id`, `required_hours`, `rendered_hours`, `signatory_name`, `signatory_position`) VALUES
(1, 'Admin', 'admin@gmail.com', NULL, NULL, '$2y$12$LIb/x74LayyjZ6bK9P8ASeRARo4837l5Zlnc9c6xrAr3QPikVLNbi', NULL, '2026-04-07 17:08:38', '2026-04-07 17:08:38', 'admin', NULL, 0, 0.00, NULL, NULL),
(2, 'Student User', 'student@gmail.com', NULL, NULL, '$2y$12$IE5T0tDhGfJEvExE6JgtyOZaZCV4v.ClBOw5mOX4ysvJa/cLrJkWS', NULL, '2026-04-07 17:08:38', '2026-04-07 18:06:46', 'user', 1, 486, 26.59, NULL, NULL),
(3, 'John Paul G. Ordoñez', 'jpgordonez@gmail.com', 'profiles/CV2HjVaZamEITf2ESuev9GhtjcccuXGBhwVJZ5Za.jpg', NULL, '$2y$12$YG4Zpzc2wxxPxJqXidHoA.BlYWlKklEmP2n37TfCwW7swt3dxEZSO', NULL, '2026-04-07 17:32:43', '2026-04-21 16:47:44', 'user', 1, 486, 382.20, 'AMEEN ANDREW L. ALONTO', 'Executive Director');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendances`
--
ALTER TABLE `attendances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attendances_user_id_foreign` (`user_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_company_id_foreign` (`company_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendances`
--
ALTER TABLE `attendances`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendances`
--
ALTER TABLE `attendances`
  ADD CONSTRAINT `attendances_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
