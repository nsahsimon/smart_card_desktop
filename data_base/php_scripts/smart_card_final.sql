-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 20, 2022 at 04:58 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.0.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smart_card`
--

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `doctor_id` int(11) NOT NULL,
  `doctor_name` varchar(30) NOT NULL,
  `doctor_surname` varchar(30) NOT NULL,
  `pin_code` varchar(42) DEFAULT NULL,
  `clinic` varchar(30) NOT NULL,
  `username` varchar(50) NOT NULL,
  `address` varchar(30) DEFAULT NULL,
  `homephone` varchar(30) DEFAULT NULL,
  `mobilephone` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`doctor_id`, `doctor_name`, `doctor_surname`, `pin_code`, `clinic`, `username`, `address`, `homephone`, `mobilephone`) VALUES
(1, 'Boujique', 'Lah', '*04E7422B39F07050722E96B2F09FD454A8E26ECF', 'brides clinic', 'drlah', 'Mankon, Bamenda', '67783623', '68909876');

-- --------------------------------------------------------

--
-- Table structure for table `emergency_contact`
--

CREATE TABLE `emergency_contact` (
  `contact_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `relative_name` varchar(30) DEFAULT NULL,
  `relative_surname` varchar(30) DEFAULT NULL,
  `relationship` varchar(30) DEFAULT NULL,
  `homephone` varchar(30) DEFAULT NULL,
  `mobilephone` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `emergency_contact`
--

INSERT INTO `emergency_contact` (`contact_id`, `patient_id`, `relative_name`, `relative_surname`, `relationship`, `homephone`, `mobilephone`) VALUES
(1, 1, 'Arnold', 'Djoum', 'sibling', '67843563', '68349023');

-- --------------------------------------------------------

--
-- Table structure for table `medications`
--

CREATE TABLE `medications` (
  `medication_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `medication_name` varchar(250) DEFAULT NULL,
  `dosage` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `medications`
--

INSERT INTO `medications` (`medication_id`, `patient_id`, `medication_name`, `dosage`) VALUES
(1, 1, 'quinine', '1000mg a day');

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `message_id` int(11) NOT NULL,
  `centralServerName` varchar(30) DEFAULT NULL,
  `centralServerAddress` varchar(30) DEFAULT NULL,
  `remoteDBMessage` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `patient_id` int(11) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `surname` varchar(25) NOT NULL,
  `address` varchar(25) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `pin_code` varchar(42) DEFAULT NULL,
  `homephone` varchar(25) DEFAULT NULL,
  `workphone` varchar(25) DEFAULT NULL,
  `mobilephone` varchar(25) DEFAULT NULL,
  `birth_date` date NOT NULL,
  `gender` varchar(25) DEFAULT NULL,
  `bloodtype` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`patient_id`, `first_name`, `surname`, `address`, `username`, `pin_code`, `homephone`, `workphone`, `mobilephone`, `birth_date`, `gender`, `bloodtype`) VALUES
(1, 'lah', 'evariste', 'dschang', 'evariste', '*04E7422B39F07050722E96B2F09FD454A8E26ECF', '456678', '233566', '1234456', '0000-00-00', '17/01/2006', 'O');

-- --------------------------------------------------------

--
-- Table structure for table `patient_allergy`
--

CREATE TABLE `patient_allergy` (
  `allergy_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `allergy_name` varchar(250) DEFAULT NULL,
  `allergy_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patient_allergy`
--

INSERT INTO `patient_allergy` (`allergy_id`, `patient_id`, `allergy_name`, `allergy_date`) VALUES
(1, 1, 'touch allergies', '2010-08-09');

-- --------------------------------------------------------

--
-- Table structure for table `patient_disease`
--

CREATE TABLE `patient_disease` (
  `disease_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `disease_name` varchar(50) DEFAULT NULL,
  `diagnosis_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patient_disease`
--

INSERT INTO `patient_disease` (`disease_id`, `patient_id`, `disease_name`, `diagnosis_date`) VALUES
(1, 1, 'Chicken Porks', '2022-07-12');

-- --------------------------------------------------------

--
-- Table structure for table `patient_immunization`
--

CREATE TABLE `patient_immunization` (
  `immunization_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `immunization_name` varchar(250) DEFAULT NULL,
  `immunization_date` date DEFAULT NULL,
  `dose` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patient_immunization`
--

INSERT INTO `patient_immunization` (`immunization_id`, `patient_id`, `immunization_name`, `immunization_date`, `dose`) VALUES
(1, 1, 'Polio Mealitis', '2022-05-15', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `patient_inspection`
--

CREATE TABLE `patient_inspection` (
  `inspection_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `inspection_date` date DEFAULT NULL,
  `department` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `patient_prescription`
--

CREATE TABLE `patient_prescription` (
  `prescription_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `prescription_date` date DEFAULT NULL,
  `department` varchar(250) DEFAULT NULL,
  `doctor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `patient_surgical_op`
--

CREATE TABLE `patient_surgical_op` (
  `surgical_op_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `entry_date` date DEFAULT NULL,
  `leave_date` date DEFAULT NULL,
  `opr_date` date DEFAULT NULL,
  `doctor_id` int(11) NOT NULL,
  `reference` int(11) DEFAULT NULL,
  `anamnesis` varchar(250) DEFAULT NULL,
  `result` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`doctor_id`);

--
-- Indexes for table `emergency_contact`
--
ALTER TABLE `emergency_contact`
  ADD PRIMARY KEY (`contact_id`);

--
-- Indexes for table `medications`
--
ALTER TABLE `medications`
  ADD PRIMARY KEY (`medication_id`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`message_id`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`patient_id`);

--
-- Indexes for table `patient_allergy`
--
ALTER TABLE `patient_allergy`
  ADD PRIMARY KEY (`allergy_id`);

--
-- Indexes for table `patient_disease`
--
ALTER TABLE `patient_disease`
  ADD PRIMARY KEY (`disease_id`);

--
-- Indexes for table `patient_immunization`
--
ALTER TABLE `patient_immunization`
  ADD PRIMARY KEY (`immunization_id`);

--
-- Indexes for table `patient_inspection`
--
ALTER TABLE `patient_inspection`
  ADD PRIMARY KEY (`inspection_id`);

--
-- Indexes for table `patient_prescription`
--
ALTER TABLE `patient_prescription`
  ADD PRIMARY KEY (`prescription_id`);

--
-- Indexes for table `patient_surgical_op`
--
ALTER TABLE `patient_surgical_op`
  ADD PRIMARY KEY (`surgical_op_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `doctor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `emergency_contact`
--
ALTER TABLE `emergency_contact`
  MODIFY `contact_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `medications`
--
ALTER TABLE `medications`
  MODIFY `medication_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `patient_allergy`
--
ALTER TABLE `patient_allergy`
  MODIFY `allergy_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `patient_disease`
--
ALTER TABLE `patient_disease`
  MODIFY `disease_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `patient_immunization`
--
ALTER TABLE `patient_immunization`
  MODIFY `immunization_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `patient_inspection`
--
ALTER TABLE `patient_inspection`
  MODIFY `inspection_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patient_prescription`
--
ALTER TABLE `patient_prescription`
  MODIFY `prescription_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patient_surgical_op`
--
ALTER TABLE `patient_surgical_op`
  MODIFY `surgical_op_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
