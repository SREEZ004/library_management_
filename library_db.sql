-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 09, 2023 at 07:09 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `library_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(25, 'Can add book_category', 7, 'add_book_category'),
(26, 'Can change book_category', 7, 'change_book_category'),
(27, 'Can delete book_category', 7, 'delete_book_category'),
(28, 'Can view book_category', 7, 'view_book_category'),
(29, 'Can add login', 8, 'add_login'),
(30, 'Can change login', 8, 'change_login'),
(31, 'Can delete login', 8, 'delete_login'),
(32, 'Can view login', 8, 'view_login'),
(33, 'Can add member_register', 9, 'add_member_register'),
(34, 'Can change member_register', 9, 'change_member_register'),
(35, 'Can delete member_register', 9, 'delete_member_register'),
(36, 'Can view member_register', 9, 'view_member_register'),
(37, 'Can add book_details', 10, 'add_book_details'),
(38, 'Can change book_details', 10, 'change_book_details'),
(39, 'Can delete book_details', 10, 'delete_book_details'),
(40, 'Can view book_details', 10, 'view_book_details'),
(41, 'Can add subscription', 11, 'add_subscription'),
(42, 'Can change subscription', 11, 'change_subscription'),
(43, 'Can delete subscription', 11, 'delete_subscription'),
(44, 'Can view subscription', 11, 'view_subscription'),
(45, 'Can add borrowed_book', 12, 'add_borrowed_book'),
(46, 'Can change borrowed_book', 12, 'change_borrowed_book'),
(47, 'Can delete borrowed_book', 12, 'delete_borrowed_book'),
(48, 'Can view borrowed_book', 12, 'view_borrowed_book'),
(49, 'Can add book_reservation', 13, 'add_book_reservation'),
(50, 'Can change book_reservation', 13, 'change_book_reservation'),
(51, 'Can delete book_reservation', 13, 'delete_book_reservation'),
(52, 'Can view book_reservation', 13, 'view_book_reservation'),
(53, 'Can add book_donation', 14, 'add_book_donation'),
(54, 'Can change book_donation', 14, 'change_book_donation'),
(55, 'Can delete book_donation', 14, 'delete_book_donation'),
(56, 'Can view book_donation', 14, 'view_book_donation'),
(57, 'Can add feedback', 15, 'add_feedback'),
(58, 'Can change feedback', 15, 'change_feedback'),
(59, 'Can delete feedback', 15, 'delete_feedback'),
(60, 'Can view feedback', 15, 'view_feedback'),
(61, 'Can add dues', 16, 'add_dues'),
(62, 'Can change dues', 16, 'change_dues'),
(63, 'Can delete dues', 16, 'delete_dues'),
(64, 'Can view dues', 16, 'view_dues'),
(65, 'Can add news', 17, 'add_news'),
(66, 'Can change news', 17, 'change_news'),
(67, 'Can delete news', 17, 'delete_news'),
(68, 'Can view news', 17, 'view_news');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(7, 'Library_App', 'book_category'),
(10, 'Library_App', 'book_details'),
(14, 'Library_App', 'book_donation'),
(13, 'Library_App', 'book_reservation'),
(12, 'Library_App', 'borrowed_book'),
(16, 'Library_App', 'dues'),
(15, 'Library_App', 'feedback'),
(8, 'Library_App', 'login'),
(9, 'Library_App', 'member_register'),
(17, 'Library_App', 'news'),
(11, 'Library_App', 'subscription'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'Library_App', '0001_initial', '2023-08-09 16:48:37.081145'),
(2, 'Library_App', '0002_rename_publication_date_book_details_published_date', '2023-08-09 16:48:37.259641'),
(3, 'Library_App', '0003_remove_login_status', '2023-08-09 16:48:37.493309'),
(4, 'Library_App', '0004_member_register_membership_taken_date_and_more', '2023-08-09 16:48:38.193123'),
(5, 'Library_App', '0005_member_register_membership_type', '2023-08-09 16:48:38.421766'),
(6, 'Library_App', '0006_auto_20230802_1104', '2023-08-09 16:48:38.812771'),
(7, 'Library_App', '0007_subscription', '2023-08-09 16:48:39.791373'),
(8, 'Library_App', '0008_borrowed_book_book_reservation', '2023-08-09 16:48:44.387404'),
(9, 'Library_App', '0009_alter_borrowed_book_status', '2023-08-09 16:48:44.649089'),
(10, 'Library_App', '0010_book_donation_feedback', '2023-08-09 16:48:46.232421'),
(11, 'Library_App', '0011_book_reservation_status', '2023-08-09 16:48:46.480134'),
(12, 'Library_App', '0012_dues', '2023-08-09 16:48:48.651916'),
(13, 'Library_App', '0013_remove_dues_borrowed_date', '2023-08-09 16:48:48.836409'),
(14, 'Library_App', '0014_rename_bd_id_dues_bd', '2023-08-09 16:49:00.700503'),
(15, 'Library_App', '0015_news', '2023-08-09 16:49:01.203842'),
(16, 'Library_App', '0016_news_status', '2023-08-09 16:49:01.383320'),
(17, 'Library_App', '0017_auto_20230805_1612', '2023-08-09 16:49:04.102771'),
(18, 'contenttypes', '0001_initial', '2023-08-09 16:49:04.739632'),
(19, 'auth', '0001_initial', '2023-08-09 16:49:15.330296'),
(20, 'admin', '0001_initial', '2023-08-09 16:49:17.734691'),
(21, 'admin', '0002_logentry_remove_auto_add', '2023-08-09 16:49:17.937263'),
(22, 'admin', '0003_logentry_add_action_flag_choices', '2023-08-09 16:49:18.055575'),
(23, 'contenttypes', '0002_remove_content_type_name', '2023-08-09 16:49:19.575586'),
(24, 'auth', '0002_alter_permission_name_max_length', '2023-08-09 16:49:20.486486'),
(25, 'auth', '0003_alter_user_email_max_length', '2023-08-09 16:49:20.631894'),
(26, 'auth', '0004_alter_user_username_opts', '2023-08-09 16:49:20.721083'),
(27, 'auth', '0005_alter_user_last_login_null', '2023-08-09 16:49:21.620749'),
(28, 'auth', '0006_require_contenttypes_0002', '2023-08-09 16:49:21.708982'),
(29, 'auth', '0007_alter_validators_add_error_messages', '2023-08-09 16:49:21.775111'),
(30, 'auth', '0008_alter_user_username_max_length', '2023-08-09 16:49:21.936545'),
(31, 'auth', '0009_alter_user_last_name_max_length', '2023-08-09 16:49:22.125039'),
(32, 'auth', '0010_alter_group_name_max_length', '2023-08-09 16:49:22.309578'),
(33, 'auth', '0011_update_proxy_permissions', '2023-08-09 16:49:22.388742'),
(34, 'auth', '0012_alter_user_first_name_max_length', '2023-08-09 16:49:22.525103'),
(35, 'sessions', '0001_initial', '2023-08-09 16:49:23.121687');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('7dqxfn23zw4utd1ccj7esu7f42ubefvm', 'eyJsb2dfaWQiOjIsIm1lbWJlciI6MX0:1qTmcJ:F1zTjYbKFciriGiVYG-pbjTGhcrfLLO_9Hj9fFxxQUc', '2023-08-23 17:05:03.687166');

-- --------------------------------------------------------

--
-- Table structure for table `tb_book_category`
--

CREATE TABLE `tb_book_category` (
  `bc_id` int(11) NOT NULL,
  `category_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_book_category`
--

INSERT INTO `tb_book_category` (`bc_id`, `category_name`) VALUES
(1, 'Novel'),
(2, 'Comics'),
(3, 'Fantasy');

-- --------------------------------------------------------

--
-- Table structure for table `tb_book_details`
--

CREATE TABLE `tb_book_details` (
  `b_id` int(11) NOT NULL,
  `book_title` varchar(80) NOT NULL,
  `image` longtext NOT NULL,
  `author` varchar(50) NOT NULL,
  `publisher` varchar(100) NOT NULL,
  `published_date` date NOT NULL,
  `no_of_pages` int(11) NOT NULL,
  `no_of_copies` int(11) NOT NULL,
  `description` longtext NOT NULL,
  `additional_data` longtext NOT NULL,
  `c_id` int(11) DEFAULT NULL,
  `copies` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_book_details`
--

INSERT INTO `tb_book_details` (`b_id`, `book_title`, `image`, `author`, `publisher`, `published_date`, `no_of_pages`, `no_of_copies`, `description`, `additional_data`, `c_id`, `copies`) VALUES
(1, 'My Book Cover', '/media/b1.jpg', 'Sam', 'S&C Publishers', '2015-02-04', 512, 3, 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Labore, recusandae maxime est distinctio, fugit mollitia voluptatibus voluptas debitis facilis aspernatur enim exercitationem a deserunt odio sed nulla aliquid voluptatum aperiam.', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Labore, recusandae', 1, 3),
(2, 'Harry Potter', '/media/b3.jpg', 'J. K. Rowling', 'Bloomsbury', '1997-06-26', 512, 4, 'Harry Potter is a series of seven fantasy novels written by British author J. K. Rowling. The novels chronicle the lives of a young wizard, Harry Potter, and his friends Hermione Granger and Ron Weasley, all of whom are students at Hogwarts School of Witchcraft and Wizardry. ', 'Cover artist	Thomas Taylor, Cliff Wright, Giles Greenfield, Jason Cockcroft\r\nCountry	United Kingdom\r\nLanguage	English', 3, 4),
(3, 'Tinkle ', '/media/b2.jpg', 'G.L. Mirchandani ', 'tinkle', '1980-11-14', 200, 2, 'Tinkle is an Indian weekly magazine for children in English, published from Mumbai.[1] Originally owned by the India Book House, the Tinkle brand was acquired by ACK (Amar Chitra Katha) Media in 2007.[2] The magazine contains comics, stories, puzzles, quizzes, contests and other features targeted at school children, although its readership includes many adults as well. It is published in English and syndicated in many Indian languages like Hindi, Bengali, and Malayalam.', 'Company	Tinkle\r\nCountry	India\r\nLanguage	English, Hindi, Malayalam, Assamese', 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tb_book_donation`
--

CREATE TABLE `tb_book_donation` (
  `d_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `contact_no` bigint(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `book_details` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_book_reservation`
--

CREATE TABLE `tb_book_reservation` (
  `br_id` int(11) NOT NULL,
  `reserved_date` date NOT NULL,
  `b_id` int(11) NOT NULL,
  `m_id` int(11) NOT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_borrowed_book`
--

CREATE TABLE `tb_borrowed_book` (
  `bd_id` int(11) NOT NULL,
  `borrowed_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `b_id` int(11) NOT NULL,
  `m_id` int(11) NOT NULL,
  `request_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_dues`
--

CREATE TABLE `tb_dues` (
  `d_id` int(11) NOT NULL,
  `fine` int(11) NOT NULL,
  `status` varchar(20) NOT NULL,
  `bd_id` int(11) NOT NULL,
  `m_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_feedback`
--

CREATE TABLE `tb_feedback` (
  `f_id` int(11) NOT NULL,
  `feedback_date` date NOT NULL,
  `feedback` longtext NOT NULL,
  `reply` longtext DEFAULT NULL,
  `m_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_login`
--

CREATE TABLE `tb_login` (
  `log_id` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` longtext NOT NULL,
  `role` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_login`
--

INSERT INTO `tb_login` (`log_id`, `username`, `password`, `role`) VALUES
(1, 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'master'),
(2, 'manu1212@', '97897c211861f5a0c5ddf66f2ddcb6c5f7442437c7e24bd2dd189ae784714c52', 'member');

-- --------------------------------------------------------

--
-- Table structure for table `tb_member_register`
--

CREATE TABLE `tb_member_register` (
  `m_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `contact_no` bigint(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `address` varchar(150) DEFAULT NULL,
  `membership_id` varchar(30) DEFAULT NULL,
  `log_id` int(11) NOT NULL,
  `membership_taken_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_member_register`
--

INSERT INTO `tb_member_register` (`m_id`, `name`, `contact_no`, `email`, `address`, `membership_id`, `log_id`, `membership_taken_date`) VALUES
(1, 'Manu', 7895463221, 'manu@gmail.com', 'Manu Bhavan \r\nPathanamthitta', 'Z253981', 2, '2023-08-10');

-- --------------------------------------------------------

--
-- Table structure for table `tb_news`
--

CREATE TABLE `tb_news` (
  `n_id` int(11) NOT NULL,
  `title` longtext NOT NULL,
  `description` longtext NOT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_subscription`
--

CREATE TABLE `tb_subscription` (
  `s_id` int(11) NOT NULL,
  `subscription_type` varchar(50) NOT NULL,
  `subscription_date` date NOT NULL,
  `subscription_validity` date NOT NULL,
  `amount` int(11) NOT NULL,
  `m_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Indexes for table `tb_book_category`
--
ALTER TABLE `tb_book_category`
  ADD PRIMARY KEY (`bc_id`);

--
-- Indexes for table `tb_book_details`
--
ALTER TABLE `tb_book_details`
  ADD PRIMARY KEY (`b_id`),
  ADD KEY `tb_Book_details_c_id_74401234_fk_tb_Book_category_bc_id` (`c_id`);

--
-- Indexes for table `tb_book_donation`
--
ALTER TABLE `tb_book_donation`
  ADD PRIMARY KEY (`d_id`);

--
-- Indexes for table `tb_book_reservation`
--
ALTER TABLE `tb_book_reservation`
  ADD PRIMARY KEY (`br_id`),
  ADD KEY `tb_Book_reservation_b_id_cf230b80_fk_tb_Book_details_b_id` (`b_id`),
  ADD KEY `tb_Book_reservation_m_id_7d01c4fe_fk_tb_Member_register_m_id` (`m_id`);

--
-- Indexes for table `tb_borrowed_book`
--
ALTER TABLE `tb_borrowed_book`
  ADD PRIMARY KEY (`bd_id`),
  ADD KEY `tb_Borrowed_book_b_id_76277452_fk_tb_Book_details_b_id` (`b_id`),
  ADD KEY `tb_Borrowed_book_m_id_06211c1b_fk_tb_Member_register_m_id` (`m_id`);

--
-- Indexes for table `tb_dues`
--
ALTER TABLE `tb_dues`
  ADD PRIMARY KEY (`d_id`),
  ADD KEY `tb_Dues_m_id_1a7032fb_fk_tb_Member_register_m_id` (`m_id`),
  ADD KEY `tb_Dues_bd_id_0fb0887a_fk_tb_Borrowed_book_bd_id` (`bd_id`);

--
-- Indexes for table `tb_feedback`
--
ALTER TABLE `tb_feedback`
  ADD PRIMARY KEY (`f_id`),
  ADD KEY `tb_Feedback_m_id_67910230_fk_tb_Member_register_m_id` (`m_id`);

--
-- Indexes for table `tb_login`
--
ALTER TABLE `tb_login`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `tb_member_register`
--
ALTER TABLE `tb_member_register`
  ADD PRIMARY KEY (`m_id`),
  ADD KEY `tb_Member_register_log_id_1e3c1e02_fk_tb_Login_log_id` (`log_id`);

--
-- Indexes for table `tb_news`
--
ALTER TABLE `tb_news`
  ADD PRIMARY KEY (`n_id`);

--
-- Indexes for table `tb_subscription`
--
ALTER TABLE `tb_subscription`
  ADD PRIMARY KEY (`s_id`),
  ADD KEY `tb_Subscription_m_id_b6f58ba6_fk_tb_Member_register_m_id` (`m_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `tb_book_category`
--
ALTER TABLE `tb_book_category`
  MODIFY `bc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tb_book_details`
--
ALTER TABLE `tb_book_details`
  MODIFY `b_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tb_book_donation`
--
ALTER TABLE `tb_book_donation`
  MODIFY `d_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_book_reservation`
--
ALTER TABLE `tb_book_reservation`
  MODIFY `br_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_borrowed_book`
--
ALTER TABLE `tb_borrowed_book`
  MODIFY `bd_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_dues`
--
ALTER TABLE `tb_dues`
  MODIFY `d_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_feedback`
--
ALTER TABLE `tb_feedback`
  MODIFY `f_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_login`
--
ALTER TABLE `tb_login`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tb_member_register`
--
ALTER TABLE `tb_member_register`
  MODIFY `m_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_news`
--
ALTER TABLE `tb_news`
  MODIFY `n_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_subscription`
--
ALTER TABLE `tb_subscription`
  MODIFY `s_id` int(11) NOT NULL AUTO_INCREMENT;

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
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `tb_book_details`
--
ALTER TABLE `tb_book_details`
  ADD CONSTRAINT `tb_Book_details_c_id_74401234_fk_tb_Book_category_bc_id` FOREIGN KEY (`c_id`) REFERENCES `tb_book_category` (`bc_id`);

--
-- Constraints for table `tb_book_reservation`
--
ALTER TABLE `tb_book_reservation`
  ADD CONSTRAINT `tb_Book_reservation_b_id_cf230b80_fk_tb_Book_details_b_id` FOREIGN KEY (`b_id`) REFERENCES `tb_book_details` (`b_id`),
  ADD CONSTRAINT `tb_Book_reservation_m_id_7d01c4fe_fk_tb_Member_register_m_id` FOREIGN KEY (`m_id`) REFERENCES `tb_member_register` (`m_id`);

--
-- Constraints for table `tb_borrowed_book`
--
ALTER TABLE `tb_borrowed_book`
  ADD CONSTRAINT `tb_Borrowed_book_b_id_76277452_fk_tb_Book_details_b_id` FOREIGN KEY (`b_id`) REFERENCES `tb_book_details` (`b_id`),
  ADD CONSTRAINT `tb_Borrowed_book_m_id_06211c1b_fk_tb_Member_register_m_id` FOREIGN KEY (`m_id`) REFERENCES `tb_member_register` (`m_id`);

--
-- Constraints for table `tb_dues`
--
ALTER TABLE `tb_dues`
  ADD CONSTRAINT `tb_Dues_bd_id_0fb0887a_fk_tb_Borrowed_book_bd_id` FOREIGN KEY (`bd_id`) REFERENCES `tb_borrowed_book` (`bd_id`),
  ADD CONSTRAINT `tb_Dues_m_id_1a7032fb_fk_tb_Member_register_m_id` FOREIGN KEY (`m_id`) REFERENCES `tb_member_register` (`m_id`);

--
-- Constraints for table `tb_feedback`
--
ALTER TABLE `tb_feedback`
  ADD CONSTRAINT `tb_Feedback_m_id_67910230_fk_tb_Member_register_m_id` FOREIGN KEY (`m_id`) REFERENCES `tb_member_register` (`m_id`);

--
-- Constraints for table `tb_member_register`
--
ALTER TABLE `tb_member_register`
  ADD CONSTRAINT `tb_Member_register_log_id_1e3c1e02_fk_tb_Login_log_id` FOREIGN KEY (`log_id`) REFERENCES `tb_login` (`log_id`);

--
-- Constraints for table `tb_subscription`
--
ALTER TABLE `tb_subscription`
  ADD CONSTRAINT `tb_Subscription_m_id_b6f58ba6_fk_tb_Member_register_m_id` FOREIGN KEY (`m_id`) REFERENCES `tb_member_register` (`m_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
