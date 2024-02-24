-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 27, 2023 at 04:38 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mca_stud_man`
--

-- --------------------------------------------------------

--
-- Table structure for table `class_time_table`
--

CREATE TABLE `class_time_table` (
  `id` int(6) NOT NULL,
  `day` varchar(10) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `time_start` time NOT NULL,
  `time_end` time NOT NULL,
  `branch` varchar(10) NOT NULL,
  `semester` int(2) NOT NULL,
  `venue` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `class_time_table`
--

INSERT INTO `class_time_table` (`id`, `day`, `subject_id`, `time_start`, `time_end`, `branch`, `semester`, `venue`) VALUES
(2, 'friday', 1, '09:10:00', '09:10:00', 'mca', 1, 'class-1'),
(3, 'thursday', 7, '09:10:00', '09:10:00', 'mca', 1, 'class-2'),
(6, 'friday', 4, '09:10:00', '09:10:00', 'mca', 1, 'class-6');

-- --------------------------------------------------------

--
-- Table structure for table `course_details`
--

CREATE TABLE `course_details` (
  `sid` int(11) NOT NULL,
  `subject_name` varchar(100) NOT NULL,
  `subject_code` varchar(20) NOT NULL,
  `semester` int(5) NOT NULL,
  `branch` varchar(20) NOT NULL,
  `subject_type` varchar(10) NOT NULL,
  `subject_external_marks` int(3) NOT NULL,
  `subject_internal_marks` int(3) NOT NULL,
  `active` varchar(5) NOT NULL,
  `faculty_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_details`
--

INSERT INTO `course_details` (`sid`, `subject_name`, `subject_code`, `semester`, `branch`, `subject_type`, `subject_external_marks`, `subject_internal_marks`, `active`, `faculty_id`) VALUES
(1, 'Enterprise Computing  using Java EE', 'CA863', 1, 'mca', 'theory', 70, 30, 'yes', 'FID001'),
(2, 'Programming with  .NET Architecture', 'CA864', 1, 'mca', 'theory', 70, 30, 'yes', 'FID015'),
(3, 'Enterprise Computing  using Java EE', 'CA863', 1, 'mca', 'practical', 70, 30, 'yes', 'FID001'),
(4, 'Programming with  .NET Architecture', 'CA864', 1, 'mca', 'practical', 70, 30, 'yes', 'FID015'),
(5, 'NoSQL Database ', 'CA865', 1, 'mca', 'theory', 70, 30, 'yes', 'FID012'),
(6, 'NoSQL Database ', 'CA865', 1, 'mca', 'practical', 70, 30, 'yes', 'FID012'),
(7, 'Academic Speaking  and Presentation  Skills', 'HS105.02 C', 1, 'mca', 'practical', 70, 30, 'yes', 'FID004'),
(8, 'Cloud Computing', 'CA859', 1, 'mca', 'theory', 70, 30, 'yes', 'FID008'),
(9, 'Software Quality  Assurance ', 'CA870', 2, 'mca', 'theory', 70, 30, 'yes', 'FID006'),
(10, 'Software Quality  Assurance ', 'CA870', 2, 'mca', 'practical', 70, 30, 'yes', 'FID006'),
(11, 'Advanced Mobile  Programming ', 'CA871', 2, 'mca', 'theory', 70, 30, 'yes', 'FID017'),
(12, 'Advanced Mobile  Programming', 'CA871', 2, 'mca', 'practical', 70, 30, 'yes', NULL),
(13, 'Software  Engineering with  Agile and DevOps', 'CA872', 2, 'mca', 'theory', 70, 30, 'yes', NULL),
(14, 'Academic Writing', 'HS106.02 C', 2, 'mca', 'practical', 70, 30, 'yes', NULL),
(15, 'HTTP Web Service for Enterprise Application', 'CA869', 2, 'mca', 'theory', 70, 30, 'yes', 'FID007'),
(16, 'HTTP Web Service for Enterprise Application', 'CA869', 2, 'mca', 'practical', 70, 30, 'yes', 'FID024'),
(17, 'Advanced Web  Designing', 'CA938', 3, 'mca', 'theory', 70, 30, 'yes', NULL),
(18, 'Advanced Web  Designing', 'CA938', 3, 'mca', 'practical', 70, 30, 'yes', NULL),
(19, 'Green Computing', 'CA940', 3, 'mca', 'practical', 70, 30, 'yes', 'FID001'),
(20, 'Data Analytics', 'CA936', 3, 'mca', 'theory', 70, 30, 'yes', NULL),
(21, 'Data Analytics', 'CA936', 3, 'mca', 'practical', 70, 30, 'yes', NULL),
(22, 'Internet of Things', 'CA937', 3, 'mca', 'theory', 70, 30, 'yes', NULL),
(23, 'Internet of Things', 'CA937', 3, 'mca', 'practical', 70, 30, 'yes', NULL),
(24, 'Mini Project ', 'CA939', 3, 'mca', 'practical', 300, 100, 'yes', NULL),
(25, 'Advanced Java ', 'MS124', 1, 'mscit', 'theory', 70, 30, 'yes', NULL),
(26, 'Advanced Java ', 'MS124', 1, 'mscit', 'practical', 70, 30, 'yes', NULL),
(27, 'Web Development  using .NET', 'MS125', 1, 'mscit', 'theory', 70, 30, 'yes', NULL),
(28, 'Web Development  using .NET', 'MS125', 1, 'mscit', 'practical', 70, 30, 'yes', NULL),
(29, 'Advanced Database  Administration', 'MS126', 1, 'mscit', 'theory', 70, 30, 'yes', NULL),
(30, 'Advanced Database  Administration', 'MS126', 1, 'mscit', 'practical', 70, 30, 'yes', NULL),
(31, 'Academic Speaking  and Presentation  Skills', 'HS105.02 C', 1, 'mscit', 'practical', 70, 30, 'yes', NULL),
(32, 'Cloud Computing Essentials', 'MS120', 1, 'mscit', 'theory', 70, 30, 'yes', NULL),
(33, 'Web Development  Using Open Source', 'MS227', 2, 'mscit', 'theory', 70, 30, 'yes', NULL),
(34, 'Web Development  Using Open Source', 'MS227', 2, 'mscit', 'practical', 70, 30, 'yes', NULL),
(35, 'Advanced Mobile  Application  Development', 'MS228', 2, 'mscit', 'theory', 70, 30, 'yes', NULL),
(36, 'Advanced Mobile  Application  Development', 'MS228', 2, 'mscit', 'practical', 70, 30, 'yes', NULL),
(37, 'Modern Software  Engineering', 'MS229', 2, 'mscit', 'theory', 70, 30, 'yes', NULL),
(38, 'Academic Writing ', 'HS106.02 C', 2, 'mscit', 'practical', 70, 30, 'yes', NULL),
(39, 'HTTP Web Service for Enterprise Application', 'MS226', 2, 'mscit', 'theory', 70, 30, 'yes', NULL),
(40, 'HTTP Web Service for Enterprise Application', 'MS226', 2, 'mscit', 'practical', 70, 30, 'yes', NULL),
(41, 'Software Quality  Assurance and Testing', 'MS332', 3, 'mscit', 'theory', 70, 30, 'yes', NULL),
(42, 'Software Quality  Assurance and Testing', 'MS332', 3, 'mscit', 'practical', 70, 30, 'yes', NULL),
(43, 'Mini Project ', 'MS333', 3, 'mscit', 'practical', 300, 100, 'yes', 'FID001'),
(44, 'Environmental Sciences', 'CL144.03 C', 3, 'mscit', 'practical', 70, 30, 'yes', NULL),
(45, 'IOT enabling Technologies', 'MS330', 3, 'mscit', 'theory', 70, 30, 'yes', NULL),
(46, 'IOT enabling Technologies', 'MS330', 3, 'mscit', 'practical', 70, 30, 'yes', NULL),
(47, 'Advanced web designing', 'MS331', 3, 'mscit', 'theory', 70, 30, 'yes', NULL),
(48, 'Advanced web designing', 'MS331', 3, 'mscit', 'practical', 70, 30, 'yes', NULL),
(49, 'Introduction to  Programming', 'CA413', 1, 'bscit', 'theory', 70, 30, 'yes', NULL),
(50, 'Introduction to  Programming', 'CA413', 1, 'bscit', 'practical', 70, 30, 'yes', NULL),
(51, 'Information  Technology and  Digital  Electronics', 'CA414', 1, 'bscit', 'theory', 70, 30, 'yes', NULL),
(52, 'Fundamentals of  Database  Management System', 'CA415', 1, 'bscit', 'theory', 70, 30, 'yes', NULL),
(53, 'Fundamentals of  Database  Management System', 'CA415', 1, 'bscit', 'practical', 70, 30, 'yes', NULL),
(54, 'Foundation  Course on  Chemistry and  Biology', 'FS102C', 1, 'bscit', 'practical', 70, 30, 'yes', NULL),
(55, 'Communicative  English', 'HS101.02C', 1, 'bscit', 'practical', 70, 30, 'yes', NULL),
(56, 'Fundamentals of Business Organization', 'CA411', 1, 'bscit', 'theory', 70, 30, 'yes', NULL),
(57, 'Information Technology in Business', 'CA412', 1, 'bscit', 'theory', 70, 30, 'yes', NULL),
(58, 'Managerial Economics', 'CA416', 2, 'bscit', 'theory', 70, 30, 'yes', NULL),
(59, 'Business Models for e-Commerce', 'CA417', 2, 'bscit', 'theory', 70, 30, 'yes', NULL),
(60, 'Fundamental of  Commerce and business  processes', 'CA418', 2, 'bscit', 'theory', 70, 30, 'yes', NULL),
(61, 'Introduction to Object  Oriented Programming', 'CA419', 2, 'bscit', 'theory', 70, 30, 'yes', NULL),
(62, 'Introduction to Object  Oriented Programming', 'CA419', 2, 'bscit', 'practical', 70, 30, 'yes', NULL),
(63, 'Fundamentals of  Operating Systems', 'CA420', 2, 'bscit', 'theory', 70, 30, 'yes', NULL),
(64, 'Fundamentals of  Operating Systems', 'CA420', 2, 'bscit', 'practical', 70, 30, 'yes', NULL),
(65, 'Foundation Course on  Mathematics and  Physics', 'FS101C', 2, 'bscit', 'practical', 50, 50, 'yes', NULL),
(66, 'Liberal Arts', 'HS201.02C210.02C', 2, 'bscit', 'practical', 70, 30, 'yes', NULL),
(67, 'Introduction to Data Warehouse', 'CA514', 3, 'bscit', 'theory', 70, 30, 'yes', NULL),
(68, 'Numerical Methods', 'CA515', 3, 'bscit', 'theory', 70, 30, 'yes', NULL),
(69, 'System Analysis and Design', 'CA516', 3, 'bscit', 'theory', 70, 30, 'yes', NULL),
(70, 'Introduction to Data  Structures', 'CA517', 3, 'bscit', 'theory', 70, 30, 'yes', NULL),
(71, 'Introduction to Data  Structures', 'CA517', 3, 'bscit', 'practical', 70, 30, 'yes', NULL),
(72, 'Programming the Internet', 'CA518', 3, 'bscit', 'theory', 70, 30, 'yes', NULL),
(73, 'Programming the Internet', 'CA518', 3, 'bscit', 'practical', 70, 30, 'yes', NULL),
(74, 'Creativity, Problem Solving  and Innovation', 'HS121.02C', 3, 'bscit', 'practical', 70, 30, 'yes', NULL),
(75, 'Environmental Sciences ', 'CL144.02C', 3, 'bscit', 'practical', 70, 30, 'yes', NULL),
(76, 'Introduction to Internet of Things', 'CA519', 4, 'bscit', 'practical', 70, 30, 'yes', NULL),
(77, 'Fundamentals of Multimedia', 'CA520', 4, 'bscit', 'practical', 70, 30, 'yes', NULL),
(78, 'Fundamentals of  Visual Programming', 'CA521', 4, 'bscit', 'theory', 70, 30, 'yes', NULL),
(79, 'Fundamentals of  Visual Programming', 'CA521', 4, 'bscit', 'practical', 70, 30, 'yes', NULL),
(80, 'Multi-paradigm  programming  language', 'CA522', 4, 'bscit', 'practical', 70, 30, 'yes', NULL),
(81, 'Database  Administration', 'CA523', 4, 'bscit', 'theory', 70, 30, 'yes', NULL),
(82, 'Database  Administration', 'CA523', 4, 'bscit', 'practical', 70, 30, 'yes', NULL),
(83, 'Data Communication  and Networks', 'CA524', 4, 'bscit', 'theory', 70, 30, 'yes', NULL),
(84, 'Human Values and  Professional Ethics', 'HS111.02C', 4, 'bscit', 'practical', 70, 30, 'yes', NULL),
(85, 'Advanced Internet of Things', 'CA616', 5, 'bscit', 'theory', 70, 30, 'yes', NULL),
(86, 'Advanced Internet of Things', 'CA616', 5, 'bscit', 'practical', 70, 30, 'yes', NULL),
(87, 'Introduction to Game Development', 'CA617', 5, 'bscit', 'theory', 70, 30, 'yes', NULL),
(88, 'Introduction to Game Development', 'CA617', 5, 'bscit', 'practical', 70, 30, 'yes', NULL),
(89, 'Programming with  JAVA', 'CA618', 5, 'bscit', 'theory', 70, 30, 'yes', NULL),
(90, 'Programming with  JAVA', 'CA618', 5, 'bscit', 'practical', 70, 30, 'yes', NULL),
(91, 'Data Science', 'CA619', 5, 'bscit', 'theory', 70, 30, 'yes', NULL),
(92, 'Data Science', 'CA619', 5, 'bscit', 'practical', 70, 30, 'yes', NULL),
(93, 'Object Oriented  Analysis and Design', 'CA620', 5, 'bscit', 'theory', 70, 30, 'yes', NULL),
(94, 'Communication and  Soft skills ', 'HS131.02C', 5, 'bscit', 'practical', 70, 30, 'yes', NULL),
(95, 'Basics of Mobile  Applications', 'CA621', 6, 'bscit', 'theory', 70, 30, 'yes', NULL),
(96, 'Basics of Mobile  Applications', 'CA621', 6, 'bscit', 'practical', 70, 30, 'yes', NULL),
(97, 'Software Testing', 'CA622', 6, 'bscit', 'practical', 70, 30, 'yes', NULL),
(112, 'Flutter', 'CA985', 1, 'bca', 'practical', 70, 30, 'yes', 'FID030'),
(113, 'programming with c', 'ca-123', 1, 'bca', 'theory', 70, 30, 'yes', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `faculty_id` varchar(50) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `middle_name` varchar(20) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `qualification` varchar(20) NOT NULL,
  `gender` varchar(6) NOT NULL,
  `dob` date DEFAULT NULL,
  `email` varchar(25) NOT NULL,
  `contact` bigint(10) NOT NULL,
  `address` varchar(100) NOT NULL,
  `city` varchar(20) NOT NULL,
  `state` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `faculty_type` varchar(20) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`faculty_id`, `first_name`, `middle_name`, `last_name`, `qualification`, `gender`, `dob`, `email`, `contact`, `address`, `city`, `state`, `password`, `faculty_type`) VALUES
('FID001', 'Dr.', 'Mittal', 'Desai', 'Ph.D. , MCA', 'female', '2001-12-23', 'mittaldesai@gmail.com', 1234567890, 'Changa', 'Ananand', 'Gujarat', '231201', ''),
('FID0010', 'Tushar', '', 'Mehta', 'MCA , (Ph.D Pursuing', 'male', '2001-12-23', 'Tushar@gmail.com', 1234567890, 'changa', 'Nadiad', 'Gujarat', '231201', ''),
('FID002', 'Dr.', 'Sanskruti ', 'Patel', 'Ph.D. ', 'female', '2001-12-23', 'Sanskrutipatel@gmail.com', 1234567890, 'Changa', 'Ananad', 'Gujarat', '231201', ''),
('FID003', 'Dr.', 'Jaimin', 'Undavia', 'Ph.D.', 'male', '2001-12-23', 'Jaimin@gmail.com', 1234567890, 'Changa', 'Ananand', 'Gujarat', '231201', ''),
('FID004', 'Dr.', 'Dharmendra', 'Patel', 'Ph.D.', 'male', '2001-12-23', 'Patel@gmail.com', 1234567890, 'Changa', 'Nadiad', 'Gujarat', '231201', ''),
('FID005', 'Dr.', 'Abhilash', 'Shukla', 'Ph.D.', 'male', '2001-12-23', 'Shukla@gmail.com', 1234567890, 'Changa', 'Nadiad', 'Gujarat', '231201', ''),
('FID006', 'Arpit', '', 'Trivedi', 'MCA , (PhD Pursuing)', 'male', '2001-12-23', 'Arpit@gmail.com', 1234567890, 'changa', 'Ananand', 'gujarat', '231201', ''),
('FID007', 'Mubina', 'S', 'Malik', 'MCA , (PhD Pursuing)', 'female', '2001-12-23', 'mubina@gmail.com', 1234567890, 'changa', 'Nadiad', 'gujarat', '231201', ''),
('FID008', 'Dr. KanuBhai', 'K', 'patel', 'Ph.D.', 'male', '2001-12-23', 'kanu@gmail.com', 1234567890, 'chnaga', 'Nadiad', 'gujarar', '231201', ''),
('FID009', 'Dhatri', '', 'Raval', 'MCA , (PhD Pursuing)', 'female', '2001-12-23', 'Dharti@gmail.com', 1234567890, 'changa', 'Nadiad', 'gujarat', '231201', ''),
('FID011', 'Hardik', 'I', 'patel', 'MCA , (Ph.D Pursuing', 'male', '2001-12-23', 'Hardik@gmail.com', 1234567890, 'changa', 'Nadiad', 'gujarat', '231201', ''),
('FID012', 'Dr.', 'Nilay', 'Vaidya', 'Ph.D.', 'male', '2001-12-23', 'Nilay@gmail.com', 1234567890, 'changa', 'Nadiad', 'gujarat', '231201', ''),
('FID013', 'Krishna', '', 'Kant', 'MCA , (Ph.D Pursuing', 'male', '2001-12-23', 'Krishna@gmail.com', 1234567890, 'changa', 'Nadiad', 'Gujarat', '231201', ''),
('FID014', 'Dr.', 'Shailesh', 'Kant', 'Ph.D.', 'male', '2001-12-23', 'Shailesh@gmail.com', 1234567890, 'chnaga', 'Nadiad', 'gujarat', '231201', ''),
('FID015', 'Dip', '', 'patel', 'MCA , (Ph.D Pursuing', 'male', '2001-12-23', 'Dip@gmail.com', 12345678, 'chang', 'Nadiad', 'gujarat', '231201', ''),
('FID016', 'Bhargav', '', 'Vyas', 'MCA , (Ph.D Pursuing', 'male', '2001-12-23', 'Bhargav@gmail.com', 1234567890, 'changa', 'Nadiad', 'gujarat', '231201', ''),
('FID017', 'Dr.', 'Sohil', 'Pandya', 'Ph.D.', 'male', '2001-12-23', 'Sohil@gmail.com', 1234567890, 'changa', 'Nadiad', 'gujarat', '231201', ''),
('FID018', 'Mohitsinh', '', 'Parmar', 'M.Sc. in Information', 'male', '2001-12-23', 'Mohit@gmail.com', 1234567890, 'changa', 'Nadiad', 'gujarat', '231201', ''),
('FID019', 'Hema', '', 'patel', 'MCA', 'female', '2001-12-23', 'Hema@gmail.com', 1234567890, 'changa', 'Nadiad', 'gujarat', '231201', ''),
('FID020', 'Dr.', 'Arpan', 'Rawal', 'Ph.D.', 'male', '2001-12-23', 'Arpan@gmail.com', 1234567890, 'chanag', 'Nadiad', 'gujarat', '231201', ''),
('FID021', 'Dr.', 'Ankit', 'Faldu', 'Ph.D.', 'male', '2001-12-23', 'Ankit@gmail.com', 1234567890, 'changa', 'Nadiad', 'gujarat', '231201', ''),
('FID022', 'Dr. Amisha', 'H.', 'Shingala', 'Ph.D.', 'female', '2001-12-23', 'Amisha@gmail.com', 1234567890, 'changa', 'Nadiad', 'gujarat', '231201', ''),
('FID023', 'Dr. Hardik', 'B.', 'Pandit', 'Ph.D.', 'male', '2001-12-23', 'Hardikpandit@gmail.com', 1234567890, 'changa', 'Nadiad', 'gujarart', '231201', ''),
('FID024', 'Kritika', '', 'pandey', 'MCA', 'female', '2001-12-23', 'kritika@gmail.com', 1234567890, 'chnaga', 'Nadiad', 'anand', '231201', ''),
('FID025', 'NikiKumar', '', 'Bachani', 'MCA', 'male', '2001-12-23', 'nikki@gmail.com', 1234567890, 'changa', 'Nadiad', 'gujarat', '231201', ''),
('FID026', 'd', '', 'd', 'mca', 'male', '2000-12-23', 'd@g', 9649046905, 'qwefa', 'waefsgtrv', 'fvgbhjnk', '231200', ''),
('FID027', 'd', '', 'j', 'mca', 'male', '2005-12-23', '100dj@g', 9649046905, 'eejfnkskrg', 'ksng', ',skngs', '231205', ''),
('FID028', 'd', '', 'j', 'mca', 'male', '2000-12-23', '100D@g', 9649046905, 'jawvfsebhnsdjfns', 'mjdsnfkjn', 'ksmndfknds', '231200', ''),
('FID029', 'd', '', 'd', 'mca', 'male', '2090-12-23', '100@gmail.com', 9649046905, 'njmk', 'hbjkn', 'bjn', '231290', ''),
('FID030', 'henil', '', 'dhola', 'mca', 'male', '2001-12-23', 'henil@gmail.com', 964904690, 'dkjsgjb', 'hjbj', 'bhjjh', '231201', ''),
('FID031', 'krish', 'kumar', 'patel', 'MSCIt', 'female', '2023-11-21', 'patelkrish1904@gmail.com', 1234567890, 'bharuch', 'vagra', 'gujarat', '211123', '');

-- --------------------------------------------------------

--
-- Table structure for table `notices`
--

CREATE TABLE `notices` (
  `id` int(6) NOT NULL,
  `notice_title` varchar(30) NOT NULL,
  `notice_text` varchar(200) NOT NULL,
  `notice_img` varchar(100) NOT NULL,
  `student_branch` varchar(10) NOT NULL,
  `notice_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notices`
--

INSERT INTO `notices` (`id`, `notice_title`, `notice_text`, `notice_img`, `student_branch`, `notice_date`) VALUES
(1, 'Vrund\'s', 'Vrund\'s Celebration is completed on the 12/10/2023 So Prepared for Mini Project Viva on the 16/10/2023', 'image/notice/mca/navratri.png', 'mca', '2023-10-15'),
(2, 'about mini project', 'hello  everryb ', 'image/notice/mca/navratri123.png', 'mca', '2023-10-15'),
(3, 'Mini Project External Exam', 'Mini Project External Exam on the 24 Nov so prepared for viva', 'image/notice/mca/notcieexternal.jpeg', 'mca', '2023-10-15'),
(4, 'Mini Project External ', 'mini project ', 'image/notice/mca/js logo.png', 'mca', '2023-10-16'),
(5, 'hello', 'yvhbjkmlbhunjkml,', 'image/notice/mca/java logo.png', 'mca', '2023-10-16'),
(6, 'nice to all ', 'java is very good you know all of you', 'image/notice/mca/java logo.png', 'mca', '2023-10-17'),
(7, 'Mini Project External Viva ', 'Prepared with your Mini project for exteernal viava on 24th nov.', 'image/notice/mca/bootstrap logo.png', 'mca', '2023-10-17'),
(8, 'hello', 'hello everyone', 'image/notice/mca/918290908936_status_8e643991ee8541d7bd088c8b9ccd1821.jpg', 'mca', '2023-11-23'),
(9, 'external', 'nice to prepare all', 'image/notice/bscit/12marksheet-1(3527985299651667).jpg', 'bscit', '2023-11-23'),
(10, 'hii', 'jhiijij', 'image/notice/bscit/10marksheet-1(3527990816720052).jpg', 'bscit', '2023-11-23'),
(11, 'The King of Mevad', 'hello.. \r\nbrother you want to go to Mevad?\r\nif you yes then call me\r\n\r\nURGENET MAIL', 'image/notice/bca/IMG_20220307_121223.jpg', 'bca', '2023-11-23');

-- --------------------------------------------------------

--
-- Table structure for table `pre_student_register`
--

CREATE TABLE `pre_student_register` (
  `student_id` varchar(15) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(25) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `gender` varchar(6) NOT NULL,
  `branch` varchar(10) NOT NULL,
  `email` varchar(30) NOT NULL,
  `contact_no` varchar(12) NOT NULL,
  `dob` date NOT NULL,
  `city` varchar(20) NOT NULL,
  `state` varchar(20) NOT NULL,
  `address` text NOT NULL,
  `password` varchar(10) NOT NULL,
  `registered_year` year(4) NOT NULL,
  `current_semester` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pre_student_register`
--

INSERT INTO `pre_student_register` (`student_id`, `first_name`, `middle_name`, `last_name`, `gender`, `branch`, `email`, `contact_no`, `dob`, `city`, `state`, `address`, `password`, `registered_year`, `current_semester`) VALUES
('23BCA001', 'HENIL', 'B', 'DHOLA', 'male', 'BCA', 'kaushalbodara0505@gmail.com', '7874755790', '2003-07-03', 'surat', 'gujarat', 'varachha, surat', '123', '2023', 1),
('23BSCIT001', 'krish', 'kumar', 'patel', 'male', 'BSCIT', 'patelkrish1904@gmail.com', '9081310429', '2000-12-23', 'vagra', 'gujarat', 'bharuch', '1234', '2023', 1),
('23MCA001', 'Divya', 'Kumar', 'jain', 'male', 'MCA', '22mca019@charusat.edu.in', '1234567890', '2001-12-23', 'Dungarpur', 'Rajasthan', 'Dungarpur, Rajasthan', '5000', '2023', 1),
('23MCA002', 'd', 'j', 'j', 'male', 'MCA', 'mr.divyajain90@gmail.com', '9649046905', '2050-12-23', 'Dungarpur', 'Rajasthan', 'Dungarpur, Rajasthan', '123', '2023', 1),
('23MSCIT001', 'Kumar', 'Divya', 'Jain', 'male', 'MSCIT', 'divyajain90@gmail.com', '9081310429', '2000-12-23', 'Anand', 'Gujarat', 'chanag', '123456', '2023', 1),
('23MSCIT002', 'Nishant', 'Kumar', 'jain', 'male', 'MSCIT', 'nishantjain7413@gmail.com', '1234567890', '1999-10-14', 'Dungarpur', 'Rajasthan', 'mowai', '500', '2023', 1),
('23MSCIT003', 'd', 'k', 'jain', 'male', 'MSCIT', 'jain@gmail.com', '1234567890', '2000-12-23', 'lmk', 'km', ',kml', '500', '2023', 1);

-- --------------------------------------------------------

--
-- Table structure for table `results`
--

CREATE TABLE `results` (
  `id` int(11) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `semester` int(6) NOT NULL,
  `exam` varchar(20) NOT NULL DEFAULT '',
  `internal_obtained_marks` int(4) NOT NULL,
  `external_obtained_marks` int(4) NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `results`
--

INSERT INTO `results` (`id`, `student_id`, `subject_id`, `semester`, `exam`, `internal_obtained_marks`, `external_obtained_marks`, `status`) VALUES
(1, '23MCA001', 1, 1, '', 30, 70, 'AA'),
(2, '23MCA001', 2, 1, '', 22, 62, 'AA'),
(3, '23MCA001', 3, 1, '', 23, 63, 'AA'),
(4, '23MCA001', 4, 1, '', 24, 64, 'AA'),
(5, '23MCA001', 5, 1, '', 30, 70, 'AA'),
(6, '23MCA001', 6, 1, '', 26, 66, 'AA'),
(7, '23MCA001', 7, 1, '', 27, 67, 'AA'),
(8, '23MCA001', 8, 1, '', 25, 69, 'AA'),
(10, '23MCA002', 1, 1, '', 25, 65, 'AA'),
(11, '23MCA002', 2, 1, '', 25, 65, 'AA'),
(12, '23MCA002', 3, 1, '', 25, 65, 'AA'),
(13, '23MCA002', 4, 1, '', 25, 65, 'AA'),
(14, '23MCA002', 5, 1, '', 25, 65, 'AA'),
(15, '23MCA002', 6, 1, '', 25, 65, 'AA'),
(16, '23MCA002', 7, 1, '', 25, 65, 'AA');

-- --------------------------------------------------------

--
-- Table structure for table `student_attendance`
--

CREATE TABLE `student_attendance` (
  `id` int(11) NOT NULL,
  `faculty_id` varchar(50) NOT NULL,
  `present_student_list` text NOT NULL,
  `class_time_table_id` int(11) NOT NULL,
  `lecture_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_attendance`
--

INSERT INTO `student_attendance` (`id`, `faculty_id`, `present_student_list`, `class_time_table_id`, `lecture_date`) VALUES
(8, 'FID003', '22mca018,23MCA003,23MCA004,23MCA009', 24, '2023-10-16'),
(9, 'FID001', '23MCA003,23MCA004,23MCA005,23MCA007,23MCA009', 24, '2023-10-16'),
(15, 'FID001', '23MCA001', 3, '2023-11-23'),
(16, 'FID001', '23MCA001', 2, '2023-11-24');

-- --------------------------------------------------------

--
-- Table structure for table `student_info`
--

CREATE TABLE `student_info` (
  `id` int(11) NOT NULL,
  `student_id` varchar(15) NOT NULL,
  `profile_pic` varchar(500) NOT NULL DEFAULT '',
  `blood_group` varchar(10) NOT NULL DEFAULT '',
  `10th_school` varchar(50) NOT NULL DEFAULT '',
  `10th_board` varchar(50) NOT NULL DEFAULT '',
  `10th_total_marks` int(11) DEFAULT NULL,
  `10th_obtained_marks` int(11) DEFAULT NULL,
  `10th_marksheet` varchar(500) NOT NULL DEFAULT '',
  `12th_stream` varchar(50) NOT NULL DEFAULT '',
  `12th_school` varchar(50) NOT NULL DEFAULT '',
  `12th_board` varchar(50) NOT NULL DEFAULT '',
  `12th_total_marks` int(11) DEFAULT NULL,
  `12th_obtained_marks` int(11) DEFAULT NULL,
  `12th_marksheet` varchar(500) NOT NULL DEFAULT '',
  `bachelor_stream` varchar(50) NOT NULL DEFAULT '',
  `bachelor_college` varchar(50) NOT NULL DEFAULT '',
  `bachelor_university` varchar(50) NOT NULL DEFAULT '',
  `bachelor_total_cgpa` int(11) DEFAULT NULL,
  `bachelor_obtained_cgpa` int(11) DEFAULT NULL,
  `bachelor_degree` varchar(500) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_info`
--

INSERT INTO `student_info` (`id`, `student_id`, `profile_pic`, `blood_group`, `10th_school`, `10th_board`, `10th_total_marks`, `10th_obtained_marks`, `10th_marksheet`, `12th_stream`, `12th_school`, `12th_board`, `12th_total_marks`, `12th_obtained_marks`, `12th_marksheet`, `bachelor_stream`, `bachelor_college`, `bachelor_university`, `bachelor_total_cgpa`, `bachelor_obtained_cgpa`, `bachelor_degree`) VALUES
(6, '23BSCIT002', '', '', '', '', 0, 0, '', '', '', '', 0, 0, '', '', '', '', 0, 0, ''),
(18, '23MSCIT002', 'image/23MSCIT002/1696162812161_divy.jpeg', 'A', '', '', 0, 0, 'image/23MSCIT002/1696162812162_divya.jpeg', '', '', '', 0, 0, 'image/23MSCIT002/1696162812162_djdj.jpg', '', '', '', 0, 0, 'image/23MSCIT002/1696162812234_jain.png'),
(23, '23MCA001', 'image/23MCA001/1697384924157_divya.jpeg', '', '', '', 0, 0, '', '', '', '', 0, 0, '', '', '', '', 0, 0, ''),
(24, '23MCA002', '', '', '', '', NULL, NULL, '', '', '', '', NULL, NULL, '', '', '', '', NULL, NULL, ''),
(25, '23BCA001', 'image/23BCA001/1700804240423_IMG_20220515_201640_957.jpg', 'B+', '', '', 0, 0, '', '', '', '', 0, 0, '', '', '', '', 0, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `user_password` varchar(20) NOT NULL,
  `user_role` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `user_id`, `user_password`, `user_role`) VALUES
(1, 'admin', 'admin123', 'admin'),
(14, '23BSCIT002', '123', 'student'),
(38, '23MSCIT002', '500', 'student'),
(54, 'FID001', '231201', 'faculty'),
(55, 'FID002', '231201', 'faculty'),
(56, 'FID003', '231201', 'faculty'),
(57, 'FID004', '231201', 'faculty'),
(58, 'FID005', '231201', 'faculty'),
(59, 'FID006', '231201', 'faculty'),
(60, 'FID007', '231201', 'faculty'),
(61, 'FID008', '231201', 'faculty'),
(62, 'FID009', '231201', 'faculty'),
(63, 'FID0010', '231201', 'faculty'),
(64, 'FID011', '231201', 'faculty'),
(65, 'FID012', '231201', 'faculty'),
(66, 'FID013', '231201', 'faculty'),
(67, 'FID014', '231201', 'faculty'),
(68, 'FID015', '231201', 'faculty'),
(69, 'FID016', '231201', 'faculty'),
(70, 'FID017', '231201', 'faculty'),
(71, 'FID018', '231201', 'faculty'),
(72, 'FID019', '231201', 'faculty'),
(73, 'FID020', '231201', 'faculty'),
(74, 'FID021', '231201', 'faculty'),
(75, 'FID022', '231201', 'faculty'),
(76, 'FID023', '231201', 'faculty'),
(77, 'FID024', '231201', 'faculty'),
(78, 'FID025', '231201', 'faculty'),
(79, '23MCA001', '5000', 'student'),
(80, 'FID026', '231200', 'faculty'),
(81, 'FID027', '231205', 'faculty'),
(82, 'FID028', '231200', 'faculty'),
(83, 'FID029', '231290', 'faculty'),
(84, '23MCA002', '100', 'student'),
(85, 'FID030', '231201', 'faculty'),
(86, '23BCA001', '123', 'student'),
(87, 'FID031', '211123', 'faculty');

-- --------------------------------------------------------

--
-- Table structure for table `user_verification`
--

CREATE TABLE `user_verification` (
  `id` int(11) NOT NULL,
  `user_email` varchar(30) NOT NULL,
  `veri_code` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_verification`
--

INSERT INTO `user_verification` (`id`, `user_email`, `veri_code`) VALUES
(7, 'jaindivya9649@gmail.com', '46340'),
(106, 'mr.divyajain90@gmail.com', '504758'),
(109, '22mca019@charusat.edu.in', '871152'),
(110, 'kaushalbodara0505@gmail.com', '468835'),
(111, '21mca002@charusat.edu.in', '898258'),
(112, '21mca002@charusat.edu.in', '694778');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `class_time_table`
--
ALTER TABLE `class_time_table`
  ADD PRIMARY KEY (`id`),
  ADD KEY `class_time_table_ibfk_1` (`subject_id`);

--
-- Indexes for table `course_details`
--
ALTER TABLE `course_details`
  ADD PRIMARY KEY (`sid`),
  ADD KEY `faculty_id` (`faculty_id`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`faculty_id`);

--
-- Indexes for table `notices`
--
ALTER TABLE `notices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pre_student_register`
--
ALTER TABLE `pre_student_register`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `results`
--
ALTER TABLE `results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `results_ibfk_1` (`subject_id`);

--
-- Indexes for table `student_attendance`
--
ALTER TABLE `student_attendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faculty_id` (`faculty_id`),
  ADD KEY `student_attendance_ibfk_1` (`class_time_table_id`);

--
-- Indexes for table `student_info`
--
ALTER TABLE `student_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`student_id`) USING BTREE;

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `user_verification`
--
ALTER TABLE `user_verification`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `class_time_table`
--
ALTER TABLE `class_time_table`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `course_details`
--
ALTER TABLE `course_details`
  MODIFY `sid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT for table `notices`
--
ALTER TABLE `notices`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `results`
--
ALTER TABLE `results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `student_attendance`
--
ALTER TABLE `student_attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `student_info`
--
ALTER TABLE `student_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `user_verification`
--
ALTER TABLE `user_verification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `class_time_table`
--
ALTER TABLE `class_time_table`
  ADD CONSTRAINT `class_time_table_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `course_details` (`sid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `course_details`
--
ALTER TABLE `course_details`
  ADD CONSTRAINT `course_details_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`);

--
-- Constraints for table `results`
--
ALTER TABLE `results`
  ADD CONSTRAINT `results_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `course_details` (`sid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `results_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `pre_student_register` (`student_id`);

--
-- Constraints for table `student_attendance`
--
ALTER TABLE `student_attendance`
  ADD CONSTRAINT `student_attendance_ibfk_1` FOREIGN KEY (`class_time_table_id`) REFERENCES `class_time_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student_info`
--
ALTER TABLE `student_info`
  ADD CONSTRAINT `student_info_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
