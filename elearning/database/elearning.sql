-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 09, 2023 at 06:56 AM
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
-- Database: `elearning`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `course_insert_update` (IN `p_id` INT(11), IN `p_courseID` INT(11), IN `p_courseName` VARCHAR(255), IN `p_courseDescription` VARCHAR(255))   BEGIN
    DECLARE v_id INT;
    
    -- Update operation
    IF p_courseID IS NOT NULL AND p_courseName IS NOT NULL AND p_courseDescription IS NOT NULL THEN
        -- Check if the course exists
        SELECT ID INTO v_id FROM course WHERE id = p_id;
        
        IF v_id IS NOT NULL THEN
            -- Update the existing course
            UPDATE course SET course_id = p_courseID, course = p_courseName, description = p_courseDescription WHERE id = p_id;
            SELECT 'Course Updated Successfully' AS msg;
        ELSE
            SELECT 'Course ID does not exist. Use INSERT for new courses.' AS msg;
        END IF;
    END IF;
-- Insert operation
    IF p_courseID IS NOT NULL AND p_courseName IS NOT NULL AND p_courseDescription IS NOT NULL THEN
        IF v_id IS NULL THEN
            -- Insert the new course
            INSERT INTO course (id, course_id, course, description) VALUES (p_id, p_courseID, p_courseName, p_courseDescription);
            SELECT 'Course Added Successfully' AS msg;
        END IF;
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `course_proc` (IN `p_CourseID` INT(11), IN `p_CourseName` VARCHAR(255), IN `p_CourseDescription` VARCHAR(255))   BEGIN
    IF p_CourseID IS NULL THEN
        INSERT INTO course (course, description)
        VALUES (p_CourseName, p_CourseDescription);

    ELSEIF (SELECT COUNT(*) FROM course WHERE course_id = p_CourseID) > 0 THEN 
        UPDATE course
        SET course = p_CourseName, description = p_CourseDescription
        WHERE course_id = p_CourseID;

    ELSE
        DELETE FROM course
        WHERE course_id = p_CourseID;
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manageCourse` (IN `p_course` VARCHAR(255), IN `p_description` TEXT)   BEGIN
INSERT INTO course(course,description) values (p_course,p_descripTion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manageCourse_update` (IN `p_id` INT(11), IN `p_courseID` INT(11), IN `p_courseName` VARCHAR(255), IN `p_courseDescription` VARCHAR(255))   BEGIN
    DECLARE v_id INT;
    
    -- Update operation
    IF p_courseID IS NOT NULL AND p_courseName IS NOT NULL AND p_courseDescription IS NOT NULL THEN
        -- Check if the course exists
        SELECT ID INTO v_id FROM course WHERE id = p_id;
        
        IF v_id IS NOT NULL THEN
            -- Update the existing course
            UPDATE course SET course_id = p_courseID, course = p_courseName, description = p_courseDescription WHERE id = p_id;
            SELECT 'Course Updated Successfully' AS msg;
        ELSE
            SELECT 'Course ID does not exist. Use INSERT for new courses.' AS msg;
        END IF;
    END IF;
    
   END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manage_courses` (IN `p_Action` VARCHAR(255), IN `p_courseID` INT(11), IN `p_courseName` VARCHAR(255), IN `p_courseDescription ` VARCHAR(255))   BEGIN
    IF p_Action = 'INSERT' THEN
        INSERT INTO course (course, description)
        VALUES (p_CourseName, p_CourseDescription);

    ELSEIF p_Action = 'UPDATE' THEN 
        UPDATE course
        SET course = p_CourseName, description = p_CourseDescription
        WHERE course_id = p_CourseID;

    ELSEIF p_Action = 'DELETE' THEN
        DELETE FROM course
        WHERE course_id = p_CourseID;

    ELSE
        SELECT 'Invalid Action' AS Message;
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manage_department` (IN `p_Action` VARCHAR(255), IN `p_DepartmenttID` INT(11), IN `p_department` VARCHAR(255), IN `p_department_description` VARCHAR(255))   BEGIN
    IF p_Action = 'INSERT' THEN
        INSERT INTO department (department, description)
        VALUES (p_department, p_department_description);

    ELSEIF p_Action = 'UPDATE' THEN 
        UPDATE department
        SET department = p_department, description = p_department_description
        WHERE department_id = p_DepartmenttID;

    ELSEIF p_Action = 'DELETE' THEN
        DELETE FROM department
        WHERE department_id = p_DepartmenttID;

    ELSE
        SELECT 'Invalid Action' AS Message;
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manage_subjects` (IN `p_Action` VARCHAR(255), IN `p_SubjectID` INT(11), IN `p_subject_code` VARCHAR(255), IN `p_subject_description` VARCHAR(255))   BEGIN
    IF p_Action = 'INSERT' THEN
        INSERT INTO subjects (subject_code, description)
        VALUES (p_subject_code, p_subject_description);

    ELSEIF p_Action = 'UPDATE' THEN 
        UPDATE subjects
        SET subjects = p_subject_code, description = p_subject_description
        WHERE subject_id = p_SubjectID;

    ELSEIF p_Action = 'DELETE' THEN
        DELETE FROM subjects
        WHERE subject_id = p_SubjectID;

    ELSE
        SELECT 'Invalid Action' AS Message;
    END IF;
    
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `academic_year`
--

CREATE TABLE `academic_year` (
  `id` int(30) NOT NULL,
  `academic_year_id` int(11) NOT NULL,
  `sy` varchar(150) NOT NULL,
  `status` tinyint(5) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `academic_year`
--

INSERT INTO `academic_year` (`id`, `academic_year_id`, `sy`, `status`) VALUES
(1, 1, '2021-2025', 1);

-- --------------------------------------------------------

--
-- Table structure for table `backup_class`
--

CREATE TABLE `backup_class` (
  `id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `department_id` int(30) NOT NULL,
  `course_id` int(30) NOT NULL,
  `level` varchar(50) NOT NULL,
  `section` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `backup_class`
--

INSERT INTO `backup_class` (`id`, `class_id`, `department_id`, `course_id`, `level`, `section`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, '3', 'A', '2023-12-08 07:28:47', '2023-12-08 07:28:47'),
(2, 2, 2, 1, '3', 'B', '2023-12-08 07:28:47', '2023-12-08 07:28:47'),
(3, 3, 0, 0, '', '', '2023-12-08 07:28:47', '2023-12-08 07:28:47');

-- --------------------------------------------------------

--
-- Table structure for table `backup_course`
--

CREATE TABLE `backup_course` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `course` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `backup_course`
--

INSERT INTO `backup_course` (`id`, `course_id`, `course`, `description`, `date_added`, `date_updated`) VALUES
(1, 1, 'BSIS', 'BS INFORMATION SYSTEM', '2023-12-03 08:08:50', '2023-12-03 08:45:14'),
(2, 2, 'BSCS', 'BS COMPUTER SCIENCE', '2023-12-03 06:23:11', '2023-12-03 06:21:44'),
(3, 3, 'BSIT', 'BS INFORMATION TECHNOLOGY', '2023-12-03 06:23:11', '2023-12-03 06:22:00'),
(4, 4, 'BSEMC', 'BS ENTERTAINMENT AND MULTIMEDIA COMPUTING', '2023-12-03 06:23:11', '2023-12-03 06:22:29'),
(5, 5, 'BSE', 'BS EDUCATION MAJOR IN ENGLISHS', '2023-12-08 07:25:53', '2023-12-08 07:26:11'),
(3, 3, 'BSIT', 'BS INFORMATION TECHNOLOGY1', '2023-12-03 06:23:11', '2023-12-08 08:08:49'),
(3, 3, 'BSIT', 'BS INFORMATION TECHNOLOGY2', '2023-12-03 06:23:11', '2023-12-08 08:09:10'),
(3, 3, 'BSIT', 'BS INFORMATION TECHNOLOGY', '2023-12-03 06:23:11', '2023-12-08 08:26:28'),
(2, 2, 'BSCS', 'BS COMPUTER SCIENCED', '2023-12-03 06:23:11', '2023-12-08 12:26:52'),
(2, 2, 'BSCS', 'BS COMPUTER SCIENCES', '2023-12-03 06:23:11', '2023-12-08 12:26:58'),
(2, 2, 'BSCS', 'BS COMPUTER SCIENCE', '2023-12-03 06:23:11', '2023-12-08 15:51:59'),
(0, 0, 'TEST2', 'HELLO WORLD1', '2023-12-09 02:21:18', '2023-12-09 02:22:18');

-- --------------------------------------------------------

--
-- Table structure for table `backup_department`
--

CREATE TABLE `backup_department` (
  `id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `department` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `backup_department`
--

INSERT INTO `backup_department` (`id`, `department_id`, `department`, `description`, `date_added`, `date_updated`) VALUES
(1, 1, 'COE', 'COLLEGE OF EDUCATION', '2023-12-03 07:36:56', '2023-12-03 07:36:56'),
(2, 2, 'CSD', 'COMPUTER STUDIES DEPARTMENT\r\n', '2023-12-03 07:37:14', '2023-12-03 07:37:14');

-- --------------------------------------------------------

--
-- Table structure for table `backup_subjects`
--

CREATE TABLE `backup_subjects` (
  `id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `subject_code` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `backup_subjects`
--

INSERT INTO `backup_subjects` (`id`, `subject_id`, `subject_code`, `description`, `date_added`, `date_updated`) VALUES
(0, 0, 'CCS 001', 'TECHNICAL COMPUTER CONCEPTS', '2023-12-08 10:11:27', '2023-12-08 10:11:27'),
(1, 1, 'IS 102', 'ENTERPRISE RESOURCE PLANNING', '2023-12-02 22:11:23', '2023-12-02 22:11:23'),
(2, 2, 'IS 103', 'DATABASE SYSTEMS ENTERPRISE', '2023-12-02 22:12:04', '2023-12-02 22:12:04'),
(3, 3, 'IS 104', 'IS INNOVATIONS & NEW TECHNOLOGIES', '2023-12-02 22:12:37', '2023-12-02 22:12:37'),
(4, 4, 'IS 105', 'ENTERPRISE ARCHITECTURE\r\n', '2023-12-02 22:13:05', '2023-12-02 22:13:05'),
(5, 5, 'IS 106', 'IS MAJOR ELECTIVE 1', '2023-12-02 22:13:26', '2023-12-02 22:13:26'),
(6, 6, 'CCS 118', 'MULTIMEDIA SYSTEMS', '2023-12-02 22:13:39', '2023-12-02 22:13:39'),
(7, 7, 'RES 001', 'METHODS OF RESEARCH', '2023-12-03 00:30:13', '2023-12-03 00:30:13'),
(7, 7, 'RES 001', 'METHODS OF RESEARCHS', '2023-12-03 00:30:13', '2023-12-08 10:13:54'),
(7, 7, 'RES 001', 'METHODS OF RESEARCH', '2023-12-03 00:30:13', '2023-12-08 10:14:19');

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `department_id` int(30) NOT NULL,
  `course_id` int(30) NOT NULL,
  `level` varchar(50) NOT NULL,
  `section` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`id`, `class_id`, `department_id`, `course_id`, `level`, `section`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, '3', 'A', '2023-12-08 07:28:47', '2023-12-08 07:28:47'),
(2, 2, 2, 1, '3', 'B', '2023-12-08 07:28:47', '2023-12-08 07:28:47'),
(3, 3, 0, 0, '', '', '2023-12-08 07:28:47', '2023-12-08 07:28:47');

--
-- Triggers `class`
--
DELIMITER $$
CREATE TRIGGER `backup_data_class` AFTER UPDATE ON `class` FOR EACH ROW BEGIN
  INSERT INTO `class` (
    `id`, 
    `class_id`, 
    `department_id`, 
    `course_id`, 
    `level`, 
    `section`, 
    `created_at`, 
    `updated_at`
  ) VALUES (
    NEW.`class_id`, 
    NEW.`department_id`, 
    NEW.`course_id`, 
    NEW.`level`, 
    NEW.`section`, 
    NEW.`created_at`, 
    NEW.`updated_at`
  );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `class_after_update` AFTER UPDATE ON `class` FOR EACH ROW BEGIN
  INSERT INTO `backup_data_class` (
    `id`, 
    `class_id`, 
    `department_id`, 
    `course_id`, 
    `level`, 
    `section`, 
    `created_at`, 
    `updated_at`
  ) VALUES (
    NEW.`class_id`, 
    NEW.`department_id`, 
    NEW.`course_id`, 
    NEW.`level`, 
    NEW.`section`, 
    NEW.`created_at`, 
    NEW.`updated_at`
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `class_subjects`
--

CREATE TABLE `class_subjects` (
  `academic_year_id` int(30) NOT NULL,
  `class_id` int(30) NOT NULL,
  `subject_id` int(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `class_subjects`
--

INSERT INTO `class_subjects` (`academic_year_id`, `class_id`, `subject_id`) VALUES
(1, 1, 1),
(1, 1, 2),
(1, 2, 1),
(1, 2, 2),
(2, 1, 1),
(2, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `class_subjects_faculty`
--

CREATE TABLE `class_subjects_faculty` (
  `academic_year_id` int(30) NOT NULL,
  `faculty_id` varchar(50) NOT NULL,
  `class_id` int(30) NOT NULL,
  `subject_id` int(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `class_subjects_faculty`
--

INSERT INTO `class_subjects_faculty` (`academic_year_id`, `faculty_id`, `class_id`, `subject_id`) VALUES
(1, '12345', 1, 1),
(1, '12345', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `course` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`id`, `course_id`, `course`, `description`, `date_added`, `date_updated`) VALUES
(1, 1, 'BSIS', 'BS INFORMATION SYSTEM', '2023-12-03 08:08:50', '2023-12-03 08:45:14'),
(2, 2, 'BSCS', 'BS COMPUTER SCIENCE', '2023-12-03 06:23:11', '2023-12-08 15:51:59'),
(3, 3, 'BSIT', 'BS INFORMATION TECHNOLOGY', '2023-12-03 06:23:11', '2023-12-08 08:26:28'),
(4, 4, 'BSEMC', 'BS ENTERTAINMENT AND MULTIMEDIA COMPUTING', '2023-12-03 06:23:11', '2023-12-08 07:24:48'),
(5, 5, 'BSE', 'BS EDUCATION MAJOR IN ENGLISHS', '2023-12-08 07:25:53', '2023-12-08 07:26:11'),
(0, 0, 'TEST2', 'HELLO WORLD1', '2023-12-09 02:21:18', '2023-12-09 02:22:18'),
(0, 0, 'PE', 'PHYSICAL EDUCATION', '2023-12-09 02:41:57', '2023-12-09 02:41:57'),
(0, 0, 'PES', 'PHYSICAL', '2023-12-09 02:42:50', '2023-12-09 02:42:50');

--
-- Triggers `course`
--
DELIMITER $$
CREATE TRIGGER `backup_data_course` AFTER UPDATE ON `course` FOR EACH ROW INSERT INTO backup_course (id, course_id, course, description, date_added, date_updated)
VALUES (NEW.id, NEW.course_id, NEW.course, NEW.description, NEW.date_added, NEW.date_updated)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `course_uppercase` BEFORE INSERT ON `course` FOR EACH ROW BEGIN
    SET NEW.course = UPPER(NEW.course);
    SET NEW.description = UPPER(NEW.description);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `department` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`id`, `department_id`, `department`, `description`, `date_added`, `date_updated`) VALUES
(1, 1, 'COE', 'COLLEGE OF EDUCATION', '2023-12-03 07:36:56', '2023-12-03 07:36:56'),
(2, 2, 'CSD', 'COMPUTER STUDIES DEPARTMENT\r\n', '2023-12-03 07:37:14', '2023-12-03 07:37:14');

--
-- Triggers `department`
--
DELIMITER $$
CREATE TRIGGER `backup_data_department` BEFORE INSERT ON `department` FOR EACH ROW BEGIN
  INSERT INTO backup_department (id, department_id, department, description, date_added, date_updated)
  VALUES (NEW.id, NEW.department_id, NEW.department, NEW.description, NEW.date_added, NEW.date_updated);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `department_uppercase` BEFORE INSERT ON `department` FOR EACH ROW BEGIN
    SET NEW.department = UPPER(NEW.department);
    SET NEW.description = UPPER(NEW.description);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `id` int(11) NOT NULL,
  `faculty_id` varchar(50) NOT NULL,
  `department_id` int(30) NOT NULL,
  `firstname` varchar(150) NOT NULL,
  `middlename` varchar(150) NOT NULL,
  `lastname` varchar(150) NOT NULL,
  `email` varchar(250) NOT NULL,
  `contact` varchar(150) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `address` text DEFAULT NULL,
  `password` text DEFAULT NULL,
  `dob` int(11) NOT NULL,
  `avatar` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`id`, `faculty_id`, `department_id`, `firstname`, `middlename`, `lastname`, `email`, `contact`, `gender`, `address`, `password`, `dob`, `avatar`, `date_added`, `date_updated`) VALUES
(2, 'F1', 2, 'Andres', '', 'Bonifacio', 'bonifacioandres@abc.com', '09349318870', 'Male', 'Caloocan, Philippines', '3f3a08abc22c2dfa7bf283051c4b12aa', 1980, 'uploads/Favatar_2.png', '2023-12-03 06:28:10', '2023-12-03 06:28:10'),
(3, 'F2', 2, 'Gabriella', '', 'Silang', 'gabriella.silang@xyz.com', '09303150890', 'Female', 'Pasay, Philippines', '6f49357f65f8d9add180c78720eb0cb6', 1970, 'uploads/Favatar_3.png', '2023-12-03 06:35:08', '2023-12-03 06:35:08'),
(1, 'F3', 1, 'Leonor', '', 'Rivera', 'leonor@rivera.abc', '09213391313', 'Female', 'Pasig, Philippines', 'password123', 1989, 'uploads/Favatar_1.png', '2023-12-03 06:25:48', '2023-12-03 06:25:48');

-- --------------------------------------------------------

--
-- Table structure for table `lessons`
--

CREATE TABLE `lessons` (
  `id` int(30) NOT NULL,
  `academic_year_id` int(30) NOT NULL,
  `subject_id` int(30) NOT NULL,
  `faculty_id` varchar(50) NOT NULL,
  `title` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `ppt_path` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lessons`
--

INSERT INTO `lessons` (`id`, `academic_year_id`, `subject_id`, `faculty_id`, `title`, `description`, `ppt_path`, `date_added`, `date_updated`) VALUES
(1, 1, 2, '12345', 'Lesson 101 Test', '&lt;h2 style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &quot; open=&quot;&quot; sans&quot;,=&quot;&quot; arial,=&quot;&quot; sans-serif;&quot;=&quot;&quot;&gt;&lt;b&gt;Sample Heading 1&lt;/b&gt;&lt;/h2&gt;&lt;h2 style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &quot; open=&quot;&quot; sans&quot;,=&quot;&quot; arial,=&quot;&quot; sans-serif;&quot;=&quot;&quot;&gt;&lt;p style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; font-size: 14px;&quot;&gt;Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed enim ipsum, rutrum eu erat sed, lacinia hendrerit sapien. Ut viverra dapibus velit nec pellentesque. Morbi ac gravida tortor. Curabitur scelerisque nisl metus. Fusce diam dui, feugiat vel congue a, convallis pulvinar dui. Donec ut felis vel dolor vehicula tincidunt vitae id nibh. Mauris mollis leo pulvinar vehicula sagittis. Sed bibendum arcu at eros imperdiet pellentesque non non orci. Etiam accumsan pulvinar egestas. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Curabitur nec odio nec quam ultrices facilisis. Nam tempor a neque dapibus lacinia. Etiam porttitor at urna sed pellentesque. Phasellus rhoncus mi at lobortis semper. Vivamus tempus urna nec sagittis vehicula. Nam sagittis velit nec quam molestie volutpat quis et ex.&lt;/p&gt;&lt;/h2&gt;&lt;h2&gt;&lt;b&gt;Sample Heading 2&lt;/b&gt;&lt;/h2&gt;&lt;h2&gt;&lt;p style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; font-size: 14px;&quot;&gt;Sed in imperdiet nisi, non ultrices lectus. Donec auctor, ante sed vestibulum cursus, ex neque scelerisque augue, a faucibus libero lectus eu mauris. Morbi ac quam non felis malesuada lacinia vel laoreet tortor. Proin euismod risus sit amet scelerisque imperdiet. Phasellus ut neque mollis, porttitor velit a, congue libero. Ut cursus accumsan lectus, vitae congue mi pellentesque vitae. Integer pulvinar accumsan dignissim. Proin bibendum dapibus risus at accumsan. Donec a sapien sed arcu malesuada maximus. Integer eu feugiat eros.&lt;/p&gt;&lt;/h2&gt;', 'uploads/slides/lesson_1', '2023-12-03 05:51:18', '2023-12-03 05:51:18'),
(2, 1, 1, '12345', 'Sample 101', '&lt;p style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &amp;quot;Open Sans&amp;quot;, Arial, sans-serif;&quot;&gt;Aliquam dictum ante at dapibus luctus. Maecenas semper pulvinar congue. Pellentesque semper, velit eget auctor euismod, ante sem vulputate augue, ut volutpat felis lorem nec ex. Praesent non porttitor nunc, non ullamcorper est. Donec eu arcu viverra augue tristique fermentum. Duis scelerisque bibendum augue, id laoreet massa tempor eu. Vivamus nec ante est. Fusce eu lacus sapien. Sed viverra lorem nec ante consequat tempor. Quisque ligula dolor, feugiat nec ligula porttitor, fermentum lacinia augue. Morbi fringilla vitae massa vitae tempus. Etiam ut vehicula lectus. Fusce cursus dolor vel dignissim volutpat. Etiam iaculis, justo vel fermentum varius, sem turpis hendrerit nulla, eget dapibus neque urna vitae arcu.&lt;/p&gt;&lt;p style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &amp;quot;Open Sans&amp;quot;, Arial, sans-serif;&quot;&gt;Ut euismod tempor turpis, quis fringilla enim varius eget. Duis id neque blandit, vehicula purus eu, molestie dolor. Aliquam erat volutpat. Pellentesque quis dapibus elit. Curabitur ac lectus tortor. Phasellus et nibh nisl. Phasellus eu imperdiet nisi, tempor semper purus&lt;/p&gt;', 'uploads/slides/lesson_2', '2023-12-03 05:51:18', '2023-12-03 05:51:18'),
(3, 0, 0, '', 'History of Computer Science', NULL, NULL, '2023-12-03 17:07:13', '2023-12-03 17:07:13'),
(4, 0, 0, '', 'Web Development Basics', NULL, NULL, '2023-12-03 17:07:13', '2023-12-03 17:07:13'),
(5, 0, 0, '', 'Data Structures and Algorithms', NULL, NULL, '2023-12-03 17:07:13', '2023-12-03 17:07:13');

-- --------------------------------------------------------

--
-- Table structure for table `lesson_class`
--

CREATE TABLE `lesson_class` (
  `lesson_id` int(30) NOT NULL,
  `class_id` int(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lesson_class`
--

INSERT INTO `lesson_class` (`lesson_id`, `class_id`) VALUES
(1, 1),
(1, 2),
(1, 1),
(1, 2),
(1, 1),
(1, 2),
(1, 1),
(1, 2),
(1, 1),
(1, 2),
(1, 1),
(1, 2),
(1, 1),
(1, 2),
(1, 1),
(1, 2),
(1, 1),
(1, 2),
(1, 1),
(1, 2),
(2, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `student_id` varchar(50) NOT NULL,
  `firstname` varchar(150) NOT NULL,
  `middlename` varchar(150) NOT NULL,
  `lastname` varchar(150) NOT NULL,
  `email` varchar(250) NOT NULL,
  `contact` varchar(150) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `address` text DEFAULT NULL,
  `password` text DEFAULT NULL,
  `dob` int(11) NOT NULL,
  `avatar` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `student_id`, `firstname`, `middlename`, `lastname`, `email`, `contact`, `gender`, `address`, `password`, `dob`, `avatar`, `date_added`, `date_updated`) VALUES
(1, 'S2', 'Anya', '', 'Forger', 'spywars@xyz.com', '09338226692', 'Female', 'Makati, Philippines', 'password123', 1970, 'uploads/uvatar_1.jpg', '2023-12-03 11:32:13', '2023-12-03 11:31:54'),
(3, 'S3', 'Damian', '', 'Desmond', 'desmond@abc.com', '09123456894', 'Male', '', NULL, 2000, 'uploads/uvatar_3.jpg', '2023-12-03 11:38:46', '2023-12-03 11:38:14');

-- --------------------------------------------------------

--
-- Table structure for table `student_class`
--

CREATE TABLE `student_class` (
  `id` int(30) NOT NULL,
  `academic_year_id` int(30) NOT NULL,
  `student_id` int(30) NOT NULL,
  `class_id` int(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_class`
--

INSERT INTO `student_class` (`id`, `academic_year_id`, `student_id`, `class_id`) VALUES
(1, 1, 6231415, 1),
(2, 1, 0, 2);

-- --------------------------------------------------------

--
-- Stand-in structure for view `student_information`
-- (See below for the actual view)
--
CREATE TABLE `student_information` (
`student_firstname` varchar(150)
,`student_middlename` varchar(150)
,`student_lastname` varchar(150)
,`level` varchar(50)
,`section` varchar(50)
,`course` varchar(250)
,`course_description` text
);

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `subject_code` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `subject_id`, `subject_code`, `description`, `date_added`, `date_updated`) VALUES
(0, 0, 'CCS 001', 'TECHNICAL COMPUTER CONCEPTS', '2023-12-08 10:11:27', '2023-12-08 10:11:27'),
(1, 1, 'IS 102', 'ENTERPRISE RESOURCE PLANNING', '2023-12-02 22:11:23', '2023-12-02 22:11:23'),
(2, 2, 'IS 103', 'DATABASE SYSTEMS ENTERPRISE', '2023-12-02 22:12:04', '2023-12-02 22:12:04'),
(3, 3, 'IS 104', 'IS INNOVATIONS & NEW TECHNOLOGIES', '2023-12-02 22:12:37', '2023-12-02 22:12:37'),
(4, 4, 'IS 105', 'ENTERPRISE ARCHITECTURE\r\n', '2023-12-02 22:13:05', '2023-12-02 22:13:05'),
(5, 5, 'IS 106', 'IS MAJOR ELECTIVE 1', '2023-12-02 22:13:26', '2023-12-02 22:13:26'),
(6, 6, 'CCS 118', 'MULTIMEDIA SYSTEMS', '2023-12-02 22:13:39', '2023-12-02 22:13:39'),
(7, 7, 'RES 001', 'METHODS OF RESEARCH', '2023-12-03 00:30:13', '2023-12-08 10:14:19');

--
-- Triggers `subjects`
--
DELIMITER $$
CREATE TRIGGER `backup_data_subjects` AFTER UPDATE ON `subjects` FOR EACH ROW BEGIN
  INSERT INTO backup_subjects (id, subject_id, subject_code, description, date_added, date_updated)
  VALUES (NEW.id, NEW.subject_id, NEW.subject_code, NEW.description, NEW.date_added, NEW.date_updated);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `subject_uppercase` BEFORE INSERT ON `subjects` FOR EACH ROW BEGIN
    SET NEW.subject_code = UPPER(NEW.subject_code);
    SET NEW.description = UPPER(NEW.description);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `system_info`
--

CREATE TABLE `system_info` (
  `id` int(30) NOT NULL,
  `meta_field` text NOT NULL,
  `meta_value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_info`
--

INSERT INTO `system_info` (`id`, `meta_field`, `meta_value`) VALUES
(1, 'name', 'Academy LMS'),
(2, 'address', 'Philippines'),
(3, 'contact', '+1234567890'),
(4, 'email', 'info@sample.com'),
(6, 'short_name', 'ALMS'),
(9, 'logo', 'uploads/1701570840_logo.png');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(50) NOT NULL,
  `firstname` varchar(250) NOT NULL,
  `lastname` varchar(250) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `avatar` text DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `username`, `password`, `avatar`, `last_login`, `date_added`, `date_updated`) VALUES
(1, 'John', 'Smith', 'admin', '0192023a7bbd73250516f069df18b500', 'uploads/1619140500_avatar.png', NULL, '2021-01-20 06:02:37', '2023-12-03 01:31:45'),
(2, 'Sherlock', 'Holmes', 'admin2', '482c811da5d5b4bc6d497ffa98491e38', 'uploads/1701570840_uavatar2.png', NULL, '2023-12-03 01:23:55', '2023-12-03 02:34:29'),
(4, 'Hello', 'World', 'faculty1', 'password123', NULL, NULL, '2023-12-04 01:22:43', '2023-12-04 01:22:43');

-- --------------------------------------------------------

--
-- Structure for view `student_information`
--
DROP TABLE IF EXISTS `student_information`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `student_information`  AS SELECT `students`.`firstname` AS `student_firstname`, `students`.`middlename` AS `student_middlename`, `students`.`lastname` AS `student_lastname`, `class`.`level` AS `level`, `class`.`section` AS `section`, `course`.`course` AS `course`, `course`.`description` AS `course_description` FROM (((`students` join `student_class` on(`students`.`student_id` = `student_class`.`student_id`)) join `class` on(`student_class`.`class_id` = `class`.`class_id`)) join `course` on(`class`.`course_id` = `course`.`course_id`))  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `academic_year`
--
ALTER TABLE `academic_year`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD UNIQUE KEY `faculty_info` (`firstname`,`lastname`,`email`,`contact`),
  ADD KEY `middlename` (`middlename`);

--
-- Indexes for table `lessons`
--
ALTER TABLE `lessons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD UNIQUE KEY `student_infos` (`firstname`,`middlename`,`lastname`,`email`,`contact`) USING HASH;

--
-- Indexes for table `student_class`
--
ALTER TABLE `student_class`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `system_info`
--
ALTER TABLE `system_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `academic_year`
--
ALTER TABLE `academic_year`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `lessons`
--
ALTER TABLE `lessons`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `student_class`
--
ALTER TABLE `student_class`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `system_info`
--
ALTER TABLE `system_info`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `weekly_insert_subjects` ON SCHEDULE EVERY 1 WEEK STARTS '2023-12-04 01:07:13' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    INSERT INTO subjects (subject_code, description)
    VALUES ('CCS 101', 'History of Computer Scienc'),
           ('GEE 105', 'Web Development Basics'),
           ('CCS 107', 'Data Structures and Algorithms');
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
