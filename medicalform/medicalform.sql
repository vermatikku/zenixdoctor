-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 26, 2020 at 11:28 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `medicalform`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(4, 'business_admin'),
(3, 'clinic_admin'),
(2, 'doctors'),
(1, 'patients');

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add business admin', 7, 'add_businessadmin'),
(26, 'Can change business admin', 7, 'change_businessadmin'),
(27, 'Can delete business admin', 7, 'delete_businessadmin'),
(28, 'Can view business admin', 7, 'view_businessadmin'),
(29, 'Can add business profile', 8, 'add_businessprofile'),
(30, 'Can change business profile', 8, 'change_businessprofile'),
(31, 'Can delete business profile', 8, 'delete_businessprofile'),
(32, 'Can view business profile', 8, 'view_businessprofile'),
(33, 'Can add clinic profile', 9, 'add_clinicprofile'),
(34, 'Can change clinic profile', 9, 'change_clinicprofile'),
(35, 'Can delete clinic profile', 9, 'delete_clinicprofile'),
(36, 'Can view clinic profile', 9, 'view_clinicprofile'),
(37, 'Can add clinic admin', 10, 'add_clinicadmin'),
(38, 'Can change clinic admin', 10, 'change_clinicadmin'),
(39, 'Can delete clinic admin', 10, 'delete_clinicadmin'),
(40, 'Can view clinic admin', 10, 'view_clinicadmin'),
(41, 'Can add doctor clinic relation', 11, 'add_doctorclinicrelation'),
(42, 'Can change doctor clinic relation', 11, 'change_doctorclinicrelation'),
(43, 'Can delete doctor clinic relation', 11, 'delete_doctorclinicrelation'),
(44, 'Can view doctor clinic relation', 11, 'view_doctorclinicrelation'),
(45, 'Can add doctor occupation', 12, 'add_doctoroccupation'),
(46, 'Can change doctor occupation', 12, 'change_doctoroccupation'),
(47, 'Can delete doctor occupation', 12, 'delete_doctoroccupation'),
(48, 'Can view doctor occupation', 12, 'view_doctoroccupation'),
(49, 'Can add doctor occupation relation', 13, 'add_doctoroccupationrelation'),
(50, 'Can change doctor occupation relation', 13, 'change_doctoroccupationrelation'),
(51, 'Can delete doctor occupation relation', 13, 'delete_doctoroccupationrelation'),
(52, 'Can view doctor occupation relation', 13, 'view_doctoroccupationrelation'),
(53, 'Can add doctor profile', 14, 'add_doctorprofile'),
(54, 'Can change doctor profile', 14, 'change_doctorprofile'),
(55, 'Can delete doctor profile', 14, 'delete_doctorprofile'),
(56, 'Can view doctor profile', 14, 'view_doctorprofile'),
(57, 'Can add doctor qualification', 15, 'add_doctorqualification'),
(58, 'Can change doctor qualification', 15, 'change_doctorqualification'),
(59, 'Can delete doctor qualification', 15, 'delete_doctorqualification'),
(60, 'Can view doctor qualification', 15, 'view_doctorqualification'),
(61, 'Can add doctor qualification relation', 16, 'add_doctorqualificationrelation'),
(62, 'Can change doctor qualification relation', 16, 'change_doctorqualificationrelation'),
(63, 'Can delete doctor qualification relation', 16, 'delete_doctorqualificationrelation'),
(64, 'Can view doctor qualification relation', 16, 'view_doctorqualificationrelation'),
(65, 'Can add patient profile', 17, 'add_patientprofile'),
(66, 'Can change patient profile', 17, 'change_patientprofile'),
(67, 'Can delete patient profile', 17, 'delete_patientprofile'),
(68, 'Can view patient profile', 17, 'view_patientprofile'),
(69, 'Can add patient doctor relation', 18, 'add_patientdoctorrelation'),
(70, 'Can change patient doctor relation', 18, 'change_patientdoctorrelation'),
(71, 'Can delete patient doctor relation', 18, 'delete_patientdoctorrelation'),
(72, 'Can view patient doctor relation', 18, 'view_patientdoctorrelation'),
(73, 'Can add patient clinic relation', 19, 'add_patientclinicrelation'),
(74, 'Can change patient clinic relation', 19, 'change_patientclinicrelation'),
(75, 'Can delete patient clinic relation', 19, 'delete_patientclinicrelation'),
(76, 'Can view patient clinic relation', 19, 'view_patientclinicrelation'),
(77, 'Can add medical form', 20, 'add_medicalform'),
(78, 'Can change medical form', 20, 'change_medicalform'),
(79, 'Can delete medical form', 20, 'delete_medicalform'),
(80, 'Can view medical form', 20, 'view_medicalform'),
(81, 'Can add medical form attribute', 21, 'add_medicalformattribute'),
(82, 'Can change medical form attribute', 21, 'change_medicalformattribute'),
(83, 'Can delete medical form attribute', 21, 'delete_medicalformattribute'),
(84, 'Can view medical form attribute', 21, 'view_medicalformattribute'),
(85, 'Can add medical form and attribute relation', 22, 'add_medicalformandattributerelation'),
(86, 'Can change medical form and attribute relation', 22, 'change_medicalformandattributerelation'),
(87, 'Can delete medical form and attribute relation', 22, 'delete_medicalformandattributerelation'),
(88, 'Can view medical form and attribute relation', 22, 'view_medicalformandattributerelation'),
(89, 'Can add medical form attribute filled', 23, 'add_medicalformattributefilled'),
(90, 'Can change medical form attribute filled', 23, 'change_medicalformattributefilled'),
(91, 'Can delete medical form attribute filled', 23, 'delete_medicalformattributefilled'),
(92, 'Can view medical form attribute filled', 23, 'view_medicalformattributefilled');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$216000$ldKe94p0Bzty$ujrRpy5dTJkFYKh1dIhSfevK5+sDtOsTfYbimAoVrIo=', '2020-08-26 09:19:13.054801', 1, 'ideateadmin', '', '', 'contact@ideatebox.com', 1, 1, '2020-08-13 07:03:45.121504'),
(19, 'pbkdf2_sha256$216000$Y6bqH5KCwuCe$pbmGs2vxsprG8hiiLYcaLy/8Zaoh3jeWMyDjv9M0TZ0=', '2020-08-13 19:06:14.879283', 0, 'vermatikku', 'satya', 'prakash ', 'vermatikkusg@gmail.com', 0, 1, '2020-08-13 18:49:30.125490'),
(20, 'pbkdf2_sha256$216000$m5tcd49zGHJf$PRrQP82f5XpuL6HbBVAFTmo3Ez3eZUgqu2g73vt27yA=', NULL, 0, 'gurinder', 'gurinder', 'singh', '', 0, 1, '2020-08-14 14:31:42.000000'),
(21, 'pbkdf2_sha256$216000$CGJwtbXJPkti$n41fq7IDgDJ2M0twtCf1TY+ZGHIGEWuoBsHg/kf9vNA=', '2020-08-25 09:36:27.155825', 0, 'taylor', 'taylor', '', '', 0, 1, '2020-08-14 14:32:04.000000'),
(22, 'pbkdf2_sha256$216000$FslZh5fHMVdU$48314JtFfzzMwnNOouRCBNv9Sg7jDomEJOp0fTS3gPI=', NULL, 0, 'doc_1', '', '', '', 0, 1, '2020-08-14 14:32:25.348059'),
(23, 'pbkdf2_sha256$216000$ueDGblfwoSpE$8nbq8JCPDrSA4zXbwm6RHI3y2uagnzeWS5NdvXqaNI0=', NULL, 0, 'pat_1', '', '', '', 0, 1, '2020-08-14 14:32:55.909024'),
(34, 'pbkdf2_sha256$216000$Mcwd0WGrXUsO$WQp6+ZW0TRwb5YyrTXN+BIIecIIUmBeUfcA3gap/M34=', '2020-08-20 14:59:02.411487', 0, 'satya.technotricky@gmail.com', 'satya', 'prakash', 'satya.technotricky@gmail.com', 0, 1, '2020-08-20 14:46:27.387562'),
(35, 'pbkdf2_sha256$216000$0vk1FH5sYKao$OSbukVASc9ho3X80tacmdTO3u3xtRgv2VFDPs1u9bO8=', NULL, 0, 'vermatikkusg', 'satya', 'prakash', 'vermatikku@gmail.com', 0, 0, '2020-08-20 16:27:49.000000'),
(36, 'pbkdf2_sha256$216000$QMmqo9kc4cjS$ZeyMcht5U78bDbb0wy2nWrGYd94tlBqrk8EZuOqPmk4=', NULL, 0, 'ignousatyaindia@gmail.com', 'satya', 'prakash', 'ignousatyaindia@gmail.com', 0, 0, '2020-08-20 16:29:41.426808'),
(37, 'pbkdf2_sha256$216000$nyu8WwDbP04x$nWt8evf7zUL5Mj5ToHMwHA5J4hFYB63rmYW7PACUN+Q=', NULL, 0, 'ignousatya2', 'satya', '', 'ignousatya2@gmail.com', 0, 0, '2020-08-21 02:44:25.000000'),
(38, 'pbkdf2_sha256$216000$LE73RDfaUZD1$H+kBT8Op7eNd2wkxne6ssQpX+6SrBFEo59kzqBcUbZg=', NULL, 0, 'gurinder.singh.rahal@gmail.com', 'Gurinder', 'Singh', 'gurinder.singh.rahal@gmail.com', 0, 0, '2020-08-21 02:49:05.095754');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `auth_user_groups`
--

INSERT INTO `auth_user_groups` (`id`, `user_id`, `group_id`) VALUES
(16, 19, 1),
(17, 20, 4),
(18, 21, 3),
(26, 34, 1),
(27, 35, 2),
(28, 36, 1),
(29, 37, 2),
(30, 38, 1);

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `business_businessadmin`
--

CREATE TABLE `business_businessadmin` (
  `id` int(11) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `active` varchar(1) NOT NULL,
  `date_created` datetime(6) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `business_businessadmin`
--

INSERT INTO `business_businessadmin` (`id`, `phone`, `active`, `date_created`, `user_id`) VALUES
(2, '403607', 'Y', '2020-08-14 14:48:41.242726', 20);

-- --------------------------------------------------------

--
-- Table structure for table `business_businessprofile`
--

CREATE TABLE `business_businessprofile` (
  `id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `active` varchar(1) NOT NULL,
  `date_created` datetime(6) DEFAULT NULL,
  `busness_admin_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `business_businessprofile`
--

INSERT INTO `business_businessprofile` (`id`, `name`, `description`, `active`, `date_created`, `busness_admin_id`) VALUES
(1, 'expressionsdental', 'medical', 'Y', '2020-08-14 14:49:24.170598', 2);

-- --------------------------------------------------------

--
-- Table structure for table `clinic_clinicadmin`
--

CREATE TABLE `clinic_clinicadmin` (
  `id` int(11) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `active` varchar(1) NOT NULL,
  `date_created` datetime(6) NOT NULL,
  `clinic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `clinic_clinicadmin`
--

INSERT INTO `clinic_clinicadmin` (`id`, `phone`, `active`, `date_created`, `clinic_id`, `user_id`) VALUES
(1, '95123', 'Y', '2020-08-14 14:50:07.367680', 1, 21);

-- --------------------------------------------------------

--
-- Table structure for table `clinic_clinicprofile`
--

CREATE TABLE `clinic_clinicprofile` (
  `id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `addresses` longtext DEFAULT NULL,
  `active` varchar(1) NOT NULL,
  `date_created` datetime(6) NOT NULL,
  `business_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `clinic_clinicprofile`
--

INSERT INTO `clinic_clinicprofile` (`id`, `name`, `addresses`, `active`, `date_created`, `business_id`) VALUES
(1, 'Expression Dental', 'ca', 'Y', '2020-08-14 14:49:50.180553', 1);

-- --------------------------------------------------------

--
-- Table structure for table `clinic_medicalform`
--

CREATE TABLE `clinic_medicalform` (
  `id` int(11) NOT NULL,
  `form_name` varchar(50) NOT NULL,
  `form_path` varchar(100) NOT NULL,
  `active` varchar(1) NOT NULL,
  `date_created` datetime(6) NOT NULL,
  `clinic_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `clinic_medicalform`
--

INSERT INTO `clinic_medicalform` (`id`, `form_name`, `form_path`, `active`, `date_created`, `clinic_id`) VALUES
(1, 'Medical History', 'medical-form.html', 'Y', '2020-08-18 12:30:57.112155', 1),
(2, 'Insurance Form', 'insurance-form.html', 'Y', '2020-08-18 12:31:30.167697', 1),
(3, 'botox form', 'botox-form.html', 'Y', '2020-08-18 12:31:50.364675', 1);

-- --------------------------------------------------------

--
-- Table structure for table `clinic_medicalformandattributerelation`
--

CREATE TABLE `clinic_medicalformandattributerelation` (
  `id` int(11) NOT NULL,
  `required` varchar(1) NOT NULL,
  `active` varchar(1) NOT NULL,
  `date_created` datetime(6) NOT NULL,
  `attribute_id` int(11) NOT NULL,
  `form_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `clinic_medicalformandattributerelation`
--

INSERT INTO `clinic_medicalformandattributerelation` (`id`, `required`, `active`, `date_created`, `attribute_id`, `form_id`) VALUES
(1, 'Y', 'Y', '2020-08-25 10:28:16.016646', 6, 1),
(2, 'Y', 'Y', '2020-08-25 10:28:26.172961', 7, 1);

-- --------------------------------------------------------

--
-- Table structure for table `clinic_medicalformattribute`
--

CREATE TABLE `clinic_medicalformattribute` (
  `id` int(11) NOT NULL,
  `attribute_name` varchar(50) NOT NULL,
  `attribute_type` varchar(10) NOT NULL,
  `attribute_option` varchar(500) DEFAULT NULL,
  `active` varchar(1) NOT NULL,
  `date_created` datetime(6) NOT NULL,
  `clinic_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `clinic_medicalformattribute`
--

INSERT INTO `clinic_medicalformattribute` (`id`, `attribute_name`, `attribute_type`, `attribute_option`, `active`, `date_created`, `clinic_id`) VALUES
(1, 'name', 'text', '0', 'Y', '2020-08-18 12:37:44.374418', 1),
(2, 'date_of_birth', 'date', '0', 'Y', '2020-08-18 12:38:35.644680', 1),
(3, 'gender', 'radio', '\"Male\",\"Female\",\"Other\"', 'Y', '2020-08-18 12:39:35.096835', 1),
(4, 'address', 'textarea', '0', 'Y', '2020-08-18 12:40:33.860108', 1),
(5, 'Insurance Number', 'text', '0', 'Y', '2020-08-18 12:41:16.465024', 1),
(6, 'current_treatment_yn', 'radio', '{\'Y\',\'N\'}', 'Y', '2020-08-25 10:27:14.157351', 1),
(7, 'current_treatment_explanation', 'text', '0', 'Y', '2020-08-25 10:27:47.934119', 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2020-08-13 07:19:27.374906', '1', 'patient', 1, '[{\"added\": {}}]', 3, 1),
(2, '2020-08-13 07:19:34.942780', '2', 'doctor', 1, '[{\"added\": {}}]', 3, 1),
(3, '2020-08-13 07:19:45.853581', '3', 'clinic_admin', 1, '[{\"added\": {}}]', 3, 1),
(4, '2020-08-13 07:19:58.780521', '4', 'business_admin', 1, '[{\"added\": {}}]', 3, 1),
(5, '2020-08-13 09:38:33.681362', '2', 'vermatikkusg', 3, '', 4, 1),
(6, '2020-08-13 09:44:22.757302', '3', 'vermatikku', 3, '', 4, 1),
(7, '2020-08-13 11:05:18.221082', '4', 'vermatikku', 3, '', 4, 1),
(8, '2020-08-13 11:13:06.555436', '7', 'vermatikkusg', 3, '', 4, 1),
(9, '2020-08-13 11:13:12.797359', '6', 'vematikku', 3, '', 4, 1),
(10, '2020-08-13 11:13:20.978961', '5', 'h', 3, '', 4, 1),
(11, '2020-08-13 11:14:19.154835', '9', 'vermatikkusg', 3, '', 4, 1),
(12, '2020-08-13 11:15:21.260893', '10', 'vermatikkusg', 3, '', 4, 1),
(13, '2020-08-13 11:16:09.571349', '11', 'vermatikkusg', 3, '', 4, 1),
(14, '2020-08-13 11:18:25.103718', '12', 'vermatikkusg', 3, '', 4, 1),
(15, '2020-08-13 11:54:34.868152', '13', 'vermatikkusg', 3, '', 4, 1),
(16, '2020-08-13 11:56:34.762928', '14', 'vermatikkusg', 3, '', 4, 1),
(17, '2020-08-13 11:58:04.510609', '15', 'vermatikkusg', 3, '', 4, 1),
(18, '2020-08-13 12:00:30.198010', '16', 'vermatikkusg', 3, '', 4, 1),
(19, '2020-08-13 18:46:20.670963', '17', 'vermatikkusg', 3, '', 4, 1),
(20, '2020-08-13 18:49:24.247128', '18', 'vermatikku', 3, '', 4, 1),
(21, '2020-08-14 14:31:42.780151', '20', 'gurinder', 1, '[{\"added\": {}}]', 4, 1),
(22, '2020-08-14 14:32:04.223516', '21', 'taylor', 1, '[{\"added\": {}}]', 4, 1),
(23, '2020-08-14 14:32:25.472765', '22', 'doc_1', 1, '[{\"added\": {}}]', 4, 1),
(24, '2020-08-14 14:32:56.037166', '23', 'pat_1', 1, '[{\"added\": {}}]', 4, 1),
(25, '2020-08-14 14:48:41.245718', '2', ' ', 1, '[{\"added\": {}}]', 7, 1),
(26, '2020-08-14 14:49:03.536476', '20', 'gurinder', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\"]}}]', 4, 1),
(27, '2020-08-14 14:49:24.171595', '1', 'expressionsdental', 1, '[{\"added\": {}}]', 8, 1),
(28, '2020-08-14 14:49:50.191314', '1', 'medical form', 1, '[{\"added\": {}}]', 9, 1),
(29, '2020-08-14 14:50:07.379098', '1', ' ', 1, '[{\"added\": {}}]', 10, 1),
(30, '2020-08-14 14:50:25.088270', '21', 'taylor', 2, '[{\"changed\": {\"fields\": [\"First name\"]}}]', 4, 1),
(31, '2020-08-18 12:18:44.064837', '1', 'Expression Dental', 2, '[{\"changed\": {\"fields\": [\"Name\"]}}]', 9, 1),
(32, '2020-08-18 12:30:57.125176', '1', 'Medical History', 1, '[{\"added\": {}}]', 20, 1),
(33, '2020-08-18 12:31:30.178978', '2', 'Insurance Form', 1, '[{\"added\": {}}]', 20, 1),
(34, '2020-08-18 12:31:50.367647', '3', 'botox form', 1, '[{\"added\": {}}]', 20, 1),
(35, '2020-08-18 12:37:44.386669', '1', 'name', 1, '[{\"added\": {}}]', 21, 1),
(36, '2020-08-18 12:38:35.657177', '2', 'date_of_birth', 1, '[{\"added\": {}}]', 21, 1),
(37, '2020-08-18 12:39:35.099783', '3', 'gender', 1, '[{\"added\": {}}]', 21, 1),
(38, '2020-08-18 12:40:33.872112', '4', 'address', 1, '[{\"added\": {}}]', 21, 1),
(39, '2020-08-18 12:41:16.477474', '5', 'Insurance Number', 1, '[{\"added\": {}}]', 21, 1),
(40, '2020-08-20 02:21:01.727930', '1', 'Medical History', 2, '[{\"changed\": {\"fields\": [\"Form path\"]}}]', 20, 1),
(41, '2020-08-20 12:07:10.250646', '26', 'sdskverma@gmail.com', 3, '', 4, 1),
(42, '2020-08-20 12:18:45.855142', '29', 'sdskverma1@gmail.com', 3, '', 4, 1),
(43, '2020-08-20 12:18:54.924694', '27', 'sdskverma@gmail.com', 3, '', 4, 1),
(44, '2020-08-20 13:31:15.513956', '30', 'sdskverma@gmail.com', 3, '', 4, 1),
(45, '2020-08-20 13:32:41.301223', '31', 'sdskverma@gmail.com', 3, '', 4, 1),
(46, '2020-08-20 13:33:35.414411', '25', 'vermatikkusg', 3, '', 4, 1),
(47, '2020-08-20 14:46:13.225790', '33', 'satya.technotricky@gmail.com', 3, '', 4, 1),
(48, '2020-08-20 14:46:18.858667', '32', 'sdskverma@gmail.com', 3, '', 4, 1),
(49, '2020-08-25 08:31:11.183512', '37', 'ignousatya2', 2, '[{\"changed\": {\"fields\": [\"Username\"]}}]', 4, 1),
(50, '2020-08-25 08:31:23.948946', '35', 'vermatikkusg', 2, '[{\"changed\": {\"fields\": [\"Username\"]}}]', 4, 1),
(51, '2020-08-25 09:36:17.264836', '21', 'taylor', 2, '[{\"changed\": {\"fields\": [\"First name\"]}}]', 4, 1),
(52, '2020-08-25 10:27:14.160313', '6', 'current_treatment_yn', 1, '[{\"added\": {}}]', 21, 1),
(53, '2020-08-25 10:27:47.942715', '7', 'current_treatment_explanation', 1, '[{\"added\": {}}]', 21, 1),
(54, '2020-08-25 10:28:16.026620', '1', 'Medical History - current_treatment_yn', 1, '[{\"added\": {}}]', 22, 1),
(55, '2020-08-25 10:28:26.172961', '2', 'Medical History - current_treatment_explanation', 1, '[{\"added\": {}}]', 22, 1),
(56, '2020-08-25 10:48:10.823774', '2', 'Y', 1, '[{\"added\": {}}]', 23, 1),
(57, '2020-08-25 10:48:25.701599', '3', 'i will not explain', 1, '[{\"added\": {}}]', 23, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(7, 'business', 'businessadmin'),
(8, 'business', 'businessprofile'),
(10, 'clinic', 'clinicadmin'),
(9, 'clinic', 'clinicprofile'),
(20, 'clinic', 'medicalform'),
(22, 'clinic', 'medicalformandattributerelation'),
(21, 'clinic', 'medicalformattribute'),
(5, 'contenttypes', 'contenttype'),
(11, 'doctor', 'doctorclinicrelation'),
(12, 'doctor', 'doctoroccupation'),
(13, 'doctor', 'doctoroccupationrelation'),
(14, 'doctor', 'doctorprofile'),
(15, 'doctor', 'doctorqualification'),
(16, 'doctor', 'doctorqualificationrelation'),
(23, 'patient', 'medicalformattributefilled'),
(19, 'patient', 'patientclinicrelation'),
(18, 'patient', 'patientdoctorrelation'),
(17, 'patient', 'patientprofile'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2020-08-13 07:03:11.469351'),
(2, 'auth', '0001_initial', '2020-08-13 07:03:11.659834'),
(3, 'admin', '0001_initial', '2020-08-13 07:03:12.321722'),
(4, 'admin', '0002_logentry_remove_auto_add', '2020-08-13 07:03:12.476199'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2020-08-13 07:03:12.505121'),
(6, 'contenttypes', '0002_remove_content_type_name', '2020-08-13 07:03:12.604854'),
(7, 'auth', '0002_alter_permission_name_max_length', '2020-08-13 07:03:12.671755'),
(8, 'auth', '0003_alter_user_email_max_length', '2020-08-13 07:03:12.693697'),
(9, 'auth', '0004_alter_user_username_opts', '2020-08-13 07:03:12.701676'),
(10, 'auth', '0005_alter_user_last_login_null', '2020-08-13 07:03:12.783526'),
(11, 'auth', '0006_require_contenttypes_0002', '2020-08-13 07:03:12.787503'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2020-08-13 07:03:12.794483'),
(13, 'auth', '0008_alter_user_username_max_length', '2020-08-13 07:03:12.816460'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2020-08-13 07:03:12.838367'),
(15, 'auth', '0010_alter_group_name_max_length', '2020-08-13 07:03:12.857366'),
(16, 'auth', '0011_update_proxy_permissions', '2020-08-13 07:03:12.867342'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2020-08-13 07:03:12.887286'),
(18, 'business', '0001_initial', '2020-08-13 07:03:12.970065'),
(19, 'clinic', '0001_initial', '2020-08-13 07:03:13.217344'),
(20, 'doctor', '0001_initial', '2020-08-13 07:03:14.066680'),
(21, 'doctor', '0002_doctorprofile_is_email_validated', '2020-08-13 07:03:14.324136'),
(22, 'patient', '0001_initial', '2020-08-13 07:03:14.372007'),
(23, 'patient', '0002_auto_20200813_0311', '2020-08-13 07:03:14.779088'),
(24, 'patient', '0003_auto_20200813_1233', '2020-08-13 07:03:15.160392'),
(25, 'sessions', '0001_initial', '2020-08-13 07:03:15.196288'),
(26, 'clinic', '0002_medicalform_medicalformattribute', '2020-08-18 12:16:10.503994'),
(27, 'clinic', '0003_auto_20200818_1803', '2020-08-18 12:33:16.771676'),
(28, 'clinic', '0004_auto_20200818_1805', '2020-08-18 12:35:15.461259'),
(29, 'clinic', '0005_auto_20200818_1806', '2020-08-18 12:36:11.676815'),
(30, 'clinic', '0006_medicalformandattributerelation_medicalformattributefilld', '2020-08-19 08:09:35.086341'),
(31, 'clinic', '0007_delete_medicalformattributefilld', '2020-08-19 08:09:35.470952'),
(32, 'patient', '0004_medicalformattributefilled', '2020-08-19 08:09:35.539076'),
(33, 'patient', '0005_medicalformattributefilled_filled_value', '2020-08-25 10:46:16.067326');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('5lrlskayostt718no8n0nt9nfgzn6hb0', '.eJxVjDsOwjAQBe_iGlmJ8ZeSnjNYu14vDiBHipMKcXdiKQW0b-bNW0TY1hK3lpc4kbiIUZx-N4T0zLUDekC9zzLNdV0mlF2RB23yNlN-XQ_3L1CglZ5NxCOFgDkE41CTNi6BZ-vZD44UauSzsuCAtR3Y7MZ-CKw4G58Vi88XAY845A:1k8nFG:mM2Id0OCYLyRGVc3nX7CYTbMqEaHV8-OdEzB_TPrrKw', '2020-09-03 16:16:54.492484'),
('5nksu0agmxv068v1rg9yyj8omj6f7xh4', '.eJxVjEEOwiAQRe_C2pAyFASX7nsGMjCDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwk7gIUOL0O0ZMD647oTvWW5Op1XWZo9wVedAup0b8vB7u30HBXr519jZZrZ2Oic85R5OMHiNkNhaiGpEMGwBHZD0kdEiOM6Izw6DAW8_i_QEh8jig:1k8h6f:Z1obI9Cq4mc_wNm73JIwA4YR3AcIgmqoA7AKnUi-GRk', '2020-09-03 09:43:37.123693'),
('9cmkbdlfj1liy7urqgoviqvxc70kyigw', '.eJxVjEEOwiAQRe_C2pAyFASX7nsGMjCDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwk7gIUOL0O0ZMD647oTvWW5Op1XWZo9wVedAup0b8vB7u30HBXr519jZZrZ2Oic85R5OMHiNkNhaiGpEMGwBHZD0kdEiOM6Izw6DAW8_i_QEh8jig:1kAVNT:Kk0jNaSll9nwFVK-SUiDglC7k4MkmId0aclX3HWvqnU', '2020-09-08 09:36:27.159954'),
('ah4xdknir2t24amqy92vwvem3w8sux50', '.eJxVjDsOwjAQBe_iGlmJ8ZeSnjNYu14vDiBHipMKcXdiKQW0b-bNW0TY1hK3lpc4kbiIUZx-N4T0zLUDekC9zzLNdV0mlF2RB23yNlN-XQ_3L1CglZ5NxCOFgDkE41CTNi6BZ-vZD44UauSzsuCAtR3Y7MZ-CKw4G58Vi88XAY845A:1kAraL:o3Cgv2nIVceE7Z05RefsLME8FU0j9_Mo38Youwadjh4', '2020-09-09 09:19:13.065773'),
('avipe63t40wi0r1qaiiyh9ndetcmycbn', '.eJxVjDsOwjAQBe_iGlmJ8ZeSnjNYu14vDiBHipMKcXdiKQW0b-bNW0TY1hK3lpc4kbiIUZx-N4T0zLUDekC9zzLNdV0mlF2RB23yNlN-XQ_3L1CglZ5NxCOFgDkE41CTNi6BZ-vZD44UauSzsuCAtR3Y7MZ-CKw4G58Vi88XAY845A:1kAU8i:Twp-3fogw4ttsAXrkKtjGZdZ0YzBkD38rQd3piibEeE', '2020-09-08 08:17:08.802757'),
('pdsqfog8upvn8kapkfgyd3vgv35ipsdv', '.eJxVjEEOwiAQRe_C2pAyFASX7nsGMjCDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwk7gIUOL0O0ZMD647oTvWW5Op1XWZo9wVedAup0b8vB7u30HBXr519jZZrZ2Oic85R5OMHiNkNhaiGpEMGwBHZD0kdEiOM6Izw6DAW8_i_QEh8jig:1k8aMs:5LO18n2j49F_e3w50dUuA0B77QXn95Qn57zYGHTON74', '2020-09-03 02:31:54.103949'),
('r0ppty4b88anbwwyg87j5bc15xeh73zg', '.eJxVjDsOwjAQBe_iGlmJ8ZeSnjNYu14vDiBHipMKcXdiKQW0b-bNW0TY1hK3lpc4kbiIUZx-N4T0zLUDekC9zzLNdV0mlF2RB23yNlN-XQ_3L1CglZ5NxCOFgDkE41CTNi6BZ-vZD44UauSzsuCAtR3Y7MZ-CKw4G58Vi88XAY845A:1k67HP:iRX3LRdIECvpCV_limgFN781xeL8GgDfkfg42H0w1RQ', '2020-08-27 07:04:03.682957'),
('sij7nthunf2wjtahz44bty8uqga7l2b8', '.eJxVjDsOwjAQBe_iGlmJ8ZeSnjNYu14vDiBHipMKcXdiKQW0b-bNW0TY1hK3lpc4kbiIUZx-N4T0zLUDekC9zzLNdV0mlF2RB23yNlN-XQ_3L1CglZ5NxCOFgDkE41CTNi6BZ-vZD44UauSzsuCAtR3Y7MZ-CKw4G58Vi88XAY845A:1k8xLG:Xoospf_2PiV0cfjlwA9_WtMSQqtuVe01B8LL9uyxFT0', '2020-09-04 03:03:46.243566');

-- --------------------------------------------------------

--
-- Table structure for table `doctor_doctorclinicrelation`
--

CREATE TABLE `doctor_doctorclinicrelation` (
  `id` int(11) NOT NULL,
  `date_created` datetime(6) DEFAULT NULL,
  `join_date` datetime(6) DEFAULT NULL,
  `leave_date` datetime(6) DEFAULT NULL,
  `clinic_profile_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `doctor_doctorclinicrelation`
--

INSERT INTO `doctor_doctorclinicrelation` (`id`, `date_created`, `join_date`, `leave_date`, `clinic_profile_id`, `doctor_id`) VALUES
(3, '2020-08-20 16:27:50.205321', NULL, NULL, 1, 6),
(4, '2020-08-21 02:44:25.230448', NULL, NULL, 1, 7);

-- --------------------------------------------------------

--
-- Table structure for table `doctor_doctoroccupation`
--

CREATE TABLE `doctor_doctoroccupation` (
  `id` int(11) NOT NULL,
  `occupation` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `doctor_doctoroccupationrelation`
--

CREATE TABLE `doctor_doctoroccupationrelation` (
  `id` int(11) NOT NULL,
  `date_created` datetime(6) DEFAULT NULL,
  `doctor_id` int(11) NOT NULL,
  `occupation_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `doctor_doctorprofile`
--

CREATE TABLE `doctor_doctorprofile` (
  `id` int(11) NOT NULL,
  `profile_pic` varchar(100) NOT NULL,
  `practice_start_date` date DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `active` varchar(1) NOT NULL,
  `date_created` datetime(6) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `is_email_validated` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `doctor_doctorprofile`
--

INSERT INTO `doctor_doctorprofile` (`id`, `profile_pic`, `practice_start_date`, `description`, `phone`, `active`, `date_created`, `user_id`, `is_email_validated`) VALUES
(6, 'user_default_pic.png', NULL, NULL, NULL, 'Y', '2020-08-20 16:27:50.190360', 35, 'N'),
(7, 'user_default_pic.png', NULL, NULL, NULL, 'Y', '2020-08-21 02:44:25.219478', 37, 'N');

-- --------------------------------------------------------

--
-- Table structure for table `doctor_doctorqualification`
--

CREATE TABLE `doctor_doctorqualification` (
  `id` int(11) NOT NULL,
  `qualification` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `doctor_doctorqualificationrelation`
--

CREATE TABLE `doctor_doctorqualificationrelation` (
  `id` int(11) NOT NULL,
  `date_created` datetime(6) DEFAULT NULL,
  `doctor_id` int(11) NOT NULL,
  `qualification_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `patient_medicalformattributefilled`
--

CREATE TABLE `patient_medicalformattributefilled` (
  `id` int(11) NOT NULL,
  `required` varchar(1) NOT NULL,
  `active` varchar(1) NOT NULL,
  `date_created` datetime(6) NOT NULL,
  `form_attribute_rel_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `filled_value` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patient_medicalformattributefilled`
--

INSERT INTO `patient_medicalformattributefilled` (`id`, `required`, `active`, `date_created`, `form_attribute_rel_id`, `patient_id`, `filled_value`) VALUES
(2, 'Y', 'Y', '2020-08-25 10:48:10.822782', 1, 16, 'Y'),
(3, 'Y', 'Y', '2020-08-25 10:48:25.691574', 2, 16, 'i will not explain');

-- --------------------------------------------------------

--
-- Table structure for table `patient_patientclinicrelation`
--

CREATE TABLE `patient_patientclinicrelation` (
  `id` int(11) NOT NULL,
  `visit_date` datetime(6) DEFAULT NULL,
  `clinic_profile_id` int(11) NOT NULL,
  `patient_profile_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patient_patientclinicrelation`
--

INSERT INTO `patient_patientclinicrelation` (`id`, `visit_date`, `clinic_profile_id`, `patient_profile_id`) VALUES
(3, NULL, 1, 20),
(4, NULL, 1, 21),
(5, NULL, 1, 22);

-- --------------------------------------------------------

--
-- Table structure for table `patient_patientdoctorrelation`
--

CREATE TABLE `patient_patientdoctorrelation` (
  `id` int(11) NOT NULL,
  `visit_date` datetime(6) DEFAULT NULL,
  `doctor_profile_id` int(11) NOT NULL,
  `patient_profile_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `patient_patientprofile`
--

CREATE TABLE `patient_patientprofile` (
  `id` int(11) NOT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `active` varchar(1) NOT NULL,
  `date_created` datetime(6) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `address` longtext DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `home_contact` varchar(10) DEFAULT NULL,
  `is_email_validated` varchar(1) NOT NULL,
  `postalcode` varchar(50) DEFAULT NULL,
  `profile_pic` varchar(100) NOT NULL,
  `work_contact` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patient_patientprofile`
--

INSERT INTO `patient_patientprofile` (`id`, `phone`, `active`, `date_created`, `user_id`, `address`, `dob`, `home_contact`, `is_email_validated`, `postalcode`, `profile_pic`, `work_contact`) VALUES
(16, '9525950123', 'Y', '2020-08-13 18:49:30.581000', 19, 'madhepura', '1995-01-02', '9525950123', 'N', '852113', 'user_default_pic.png', '9525950123'),
(20, '9525950123', 'Y', '2020-08-20 14:46:27.545693', 34, NULL, '1995-01-02', NULL, 'N', NULL, 'user_default_pic.png', NULL),
(21, '9525950124', 'Y', '2020-08-20 16:29:41.603351', 36, NULL, '1995-02-01', NULL, 'N', NULL, 'user_default_pic.png', NULL),
(22, '', 'Y', '2020-08-21 02:49:05.273484', 38, NULL, '1975-01-01', NULL, 'N', NULL, 'user_default_pic.png', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `business_businessadmin`
--
ALTER TABLE `business_businessadmin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `business_businessprofile`
--
ALTER TABLE `business_businessprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `busness_admin_id` (`busness_admin_id`);

--
-- Indexes for table `clinic_clinicadmin`
--
ALTER TABLE `clinic_clinicadmin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clinic_id` (`clinic_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `clinic_clinicprofile`
--
ALTER TABLE `clinic_clinicprofile`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clinic_clinicprofile_business_id_24836417_fk_business_` (`business_id`);

--
-- Indexes for table `clinic_medicalform`
--
ALTER TABLE `clinic_medicalform`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clinic_medicalform_clinic_id_7bb9d325_fk_clinic_clinicprofile_id` (`clinic_id`);

--
-- Indexes for table `clinic_medicalformandattributerelation`
--
ALTER TABLE `clinic_medicalformandattributerelation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clinic_medicalforman_attribute_id_3c24e44e_fk_clinic_me` (`attribute_id`),
  ADD KEY `clinic_medicalforman_form_id_36e570ce_fk_clinic_me` (`form_id`);

--
-- Indexes for table `clinic_medicalformattribute`
--
ALTER TABLE `clinic_medicalformattribute`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clinic_medicalformat_clinic_id_47daf98e_fk_clinic_cl` (`clinic_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `doctor_doctorclinicrelation`
--
ALTER TABLE `doctor_doctorclinicrelation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctor_doctorclinicr_doctor_id_0674d32c_fk_doctor_do` (`doctor_id`),
  ADD KEY `doctor_doctorclinicr_clinic_profile_id_50afcaeb_fk_clinic_cl` (`clinic_profile_id`);

--
-- Indexes for table `doctor_doctoroccupation`
--
ALTER TABLE `doctor_doctoroccupation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `doctor_doctoroccupationrelation`
--
ALTER TABLE `doctor_doctoroccupationrelation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctor_doctoroccupat_doctor_id_ac659051_fk_doctor_do` (`doctor_id`),
  ADD KEY `doctor_doctoroccupat_occupation_id_e9cb0e7d_fk_doctor_do` (`occupation_id`);

--
-- Indexes for table `doctor_doctorprofile`
--
ALTER TABLE `doctor_doctorprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `doctor_doctorqualification`
--
ALTER TABLE `doctor_doctorqualification`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `doctor_doctorqualificationrelation`
--
ALTER TABLE `doctor_doctorqualificationrelation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctor_doctorqualifi_doctor_id_7669c784_fk_doctor_do` (`doctor_id`),
  ADD KEY `doctor_doctorqualifi_qualification_id_b514d8cb_fk_doctor_do` (`qualification_id`);

--
-- Indexes for table `patient_medicalformattributefilled`
--
ALTER TABLE `patient_medicalformattributefilled`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_medicalforma_form_attribute_rel_i_2adc3b6e_fk_clinic_me` (`form_attribute_rel_id`),
  ADD KEY `patient_medicalforma_patient_id_7569b06d_fk_patient_p` (`patient_id`);

--
-- Indexes for table `patient_patientclinicrelation`
--
ALTER TABLE `patient_patientclinicrelation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_patientclini_clinic_profile_id_c7d9c2fc_fk_clinic_cl` (`clinic_profile_id`),
  ADD KEY `patient_patientclini_patient_profile_id_26cb133a_fk_patient_p` (`patient_profile_id`);

--
-- Indexes for table `patient_patientdoctorrelation`
--
ALTER TABLE `patient_patientdoctorrelation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_patientdocto_doctor_profile_id_9db83541_fk_doctor_do` (`doctor_profile_id`),
  ADD KEY `patient_patientdocto_patient_profile_id_8d3b1d50_fk_patient_p` (`patient_profile_id`);

--
-- Indexes for table `patient_patientprofile`
--
ALTER TABLE `patient_patientprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `business_businessadmin`
--
ALTER TABLE `business_businessadmin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `business_businessprofile`
--
ALTER TABLE `business_businessprofile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `clinic_clinicadmin`
--
ALTER TABLE `clinic_clinicadmin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `clinic_clinicprofile`
--
ALTER TABLE `clinic_clinicprofile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `clinic_medicalform`
--
ALTER TABLE `clinic_medicalform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `clinic_medicalformandattributerelation`
--
ALTER TABLE `clinic_medicalformandattributerelation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `clinic_medicalformattribute`
--
ALTER TABLE `clinic_medicalformattribute`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `doctor_doctorclinicrelation`
--
ALTER TABLE `doctor_doctorclinicrelation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `doctor_doctoroccupation`
--
ALTER TABLE `doctor_doctoroccupation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `doctor_doctoroccupationrelation`
--
ALTER TABLE `doctor_doctoroccupationrelation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `doctor_doctorprofile`
--
ALTER TABLE `doctor_doctorprofile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `doctor_doctorqualification`
--
ALTER TABLE `doctor_doctorqualification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `doctor_doctorqualificationrelation`
--
ALTER TABLE `doctor_doctorqualificationrelation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patient_medicalformattributefilled`
--
ALTER TABLE `patient_medicalformattributefilled`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `patient_patientclinicrelation`
--
ALTER TABLE `patient_patientclinicrelation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `patient_patientdoctorrelation`
--
ALTER TABLE `patient_patientdoctorrelation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patient_patientprofile`
--
ALTER TABLE `patient_patientprofile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `business_businessadmin`
--
ALTER TABLE `business_businessadmin`
  ADD CONSTRAINT `business_businessadmin_user_id_27607a67_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `business_businessprofile`
--
ALTER TABLE `business_businessprofile`
  ADD CONSTRAINT `business_businesspro_busness_admin_id_b50d1dc5_fk_business_` FOREIGN KEY (`busness_admin_id`) REFERENCES `business_businessadmin` (`id`);

--
-- Constraints for table `clinic_clinicadmin`
--
ALTER TABLE `clinic_clinicadmin`
  ADD CONSTRAINT `clinic_clinicadmin_clinic_id_0d6b49fc_fk_clinic_clinicprofile_id` FOREIGN KEY (`clinic_id`) REFERENCES `clinic_clinicprofile` (`id`),
  ADD CONSTRAINT `clinic_clinicadmin_user_id_28057082_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `clinic_clinicprofile`
--
ALTER TABLE `clinic_clinicprofile`
  ADD CONSTRAINT `clinic_clinicprofile_business_id_24836417_fk_business_` FOREIGN KEY (`business_id`) REFERENCES `business_businessprofile` (`id`);

--
-- Constraints for table `clinic_medicalform`
--
ALTER TABLE `clinic_medicalform`
  ADD CONSTRAINT `clinic_medicalform_clinic_id_7bb9d325_fk_clinic_clinicprofile_id` FOREIGN KEY (`clinic_id`) REFERENCES `clinic_clinicprofile` (`id`);

--
-- Constraints for table `clinic_medicalformandattributerelation`
--
ALTER TABLE `clinic_medicalformandattributerelation`
  ADD CONSTRAINT `clinic_medicalforman_attribute_id_3c24e44e_fk_clinic_me` FOREIGN KEY (`attribute_id`) REFERENCES `clinic_medicalformattribute` (`id`),
  ADD CONSTRAINT `clinic_medicalforman_form_id_36e570ce_fk_clinic_me` FOREIGN KEY (`form_id`) REFERENCES `clinic_medicalform` (`id`);

--
-- Constraints for table `clinic_medicalformattribute`
--
ALTER TABLE `clinic_medicalformattribute`
  ADD CONSTRAINT `clinic_medicalformat_clinic_id_47daf98e_fk_clinic_cl` FOREIGN KEY (`clinic_id`) REFERENCES `clinic_clinicprofile` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `doctor_doctorclinicrelation`
--
ALTER TABLE `doctor_doctorclinicrelation`
  ADD CONSTRAINT `doctor_doctorclinicr_clinic_profile_id_50afcaeb_fk_clinic_cl` FOREIGN KEY (`clinic_profile_id`) REFERENCES `clinic_clinicprofile` (`id`),
  ADD CONSTRAINT `doctor_doctorclinicr_doctor_id_0674d32c_fk_doctor_do` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`);

--
-- Constraints for table `doctor_doctoroccupationrelation`
--
ALTER TABLE `doctor_doctoroccupationrelation`
  ADD CONSTRAINT `doctor_doctoroccupat_doctor_id_ac659051_fk_doctor_do` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`),
  ADD CONSTRAINT `doctor_doctoroccupat_occupation_id_e9cb0e7d_fk_doctor_do` FOREIGN KEY (`occupation_id`) REFERENCES `doctor_doctoroccupation` (`id`);

--
-- Constraints for table `doctor_doctorprofile`
--
ALTER TABLE `doctor_doctorprofile`
  ADD CONSTRAINT `doctor_doctorprofile_user_id_42aa5af1_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `doctor_doctorqualificationrelation`
--
ALTER TABLE `doctor_doctorqualificationrelation`
  ADD CONSTRAINT `doctor_doctorqualifi_doctor_id_7669c784_fk_doctor_do` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`),
  ADD CONSTRAINT `doctor_doctorqualifi_qualification_id_b514d8cb_fk_doctor_do` FOREIGN KEY (`qualification_id`) REFERENCES `doctor_doctorqualification` (`id`);

--
-- Constraints for table `patient_medicalformattributefilled`
--
ALTER TABLE `patient_medicalformattributefilled`
  ADD CONSTRAINT `patient_medicalforma_form_attribute_rel_i_2adc3b6e_fk_clinic_me` FOREIGN KEY (`form_attribute_rel_id`) REFERENCES `clinic_medicalformandattributerelation` (`id`),
  ADD CONSTRAINT `patient_medicalforma_patient_id_7569b06d_fk_patient_p` FOREIGN KEY (`patient_id`) REFERENCES `patient_patientprofile` (`id`);

--
-- Constraints for table `patient_patientclinicrelation`
--
ALTER TABLE `patient_patientclinicrelation`
  ADD CONSTRAINT `patient_patientclini_clinic_profile_id_c7d9c2fc_fk_clinic_cl` FOREIGN KEY (`clinic_profile_id`) REFERENCES `clinic_clinicprofile` (`id`),
  ADD CONSTRAINT `patient_patientclini_patient_profile_id_26cb133a_fk_patient_p` FOREIGN KEY (`patient_profile_id`) REFERENCES `patient_patientprofile` (`id`);

--
-- Constraints for table `patient_patientdoctorrelation`
--
ALTER TABLE `patient_patientdoctorrelation`
  ADD CONSTRAINT `patient_patientdocto_doctor_profile_id_9db83541_fk_doctor_do` FOREIGN KEY (`doctor_profile_id`) REFERENCES `doctor_doctorprofile` (`id`),
  ADD CONSTRAINT `patient_patientdocto_patient_profile_id_8d3b1d50_fk_patient_p` FOREIGN KEY (`patient_profile_id`) REFERENCES `patient_patientprofile` (`id`);

--
-- Constraints for table `patient_patientprofile`
--
ALTER TABLE `patient_patientprofile`
  ADD CONSTRAINT `patient_patientprofile_user_id_68de5134_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
