-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Feb 14, 2023 at 03:54 AM
-- Server version: 10.6.5-MariaDB
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `seanmad`
--
CREATE DATABASE IF NOT EXISTS `seanmad` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `seanmad`;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `categoryId` int(11) NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(255) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`categoryId`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`categoryId`, `categoryName`, `userId`) VALUES
(1, 'Business', NULL),
(2, 'Productivity', NULL),
(3, 'Time', NULL),
(16, 'category1', 17),
(17, 'cat', 21);

-- --------------------------------------------------------

--
-- Table structure for table `colors`
--

DROP TABLE IF EXISTS `colors`;
CREATE TABLE IF NOT EXISTS `colors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `color` varchar(2000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `colors`
--

INSERT INTO `colors` (`id`, `color`) VALUES
(1, '0xFFFF5252'),
(2, '0xFF448AFF'),
(3, '0xFF7C4DFF'),
(4, '0xFFFFAB40'),
(5, '0xFFB2FF59'),
(6, '0xFF40C4FF'),
(7, '0xFF526DFE'),
(8, '0xFF18FFFF'),
(9, '0xFF64FFDA'),
(10, '0xFFEEFF41');

-- --------------------------------------------------------

--
-- Table structure for table `icons`
--

DROP TABLE IF EXISTS `icons`;
CREATE TABLE IF NOT EXISTS `icons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `icon` varchar(2000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `icons`
--

INSERT INTO `icons` (`id`, `icon`) VALUES
(1, '0xe559'),
(2, '0xe7a9'),
(3, '0xf037'),
(4, '0xe5e5'),
(5, '0xe666'),
(6, '0xe618'),
(7, '0xe87e'),
(8, '0xea7c'),
(9, '0xe14a'),
(10, '0xe78f'),
(11, '0xe79d'),
(12, '0xe7c2'),
(13, '0xe7cc'),
(14, '0xe5dc'),
(15, '0xe827');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
CREATE TABLE IF NOT EXISTS `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(2000) NOT NULL,
  `iscompleted` tinyint(1) NOT NULL DEFAULT 0,
  `listid` int(11) NOT NULL,
  `position` varchar(2000) DEFAULT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `url` varchar(2000) DEFAULT NULL,
  `isfavourite` tinyint(1) NOT NULL DEFAULT 0,
  `isarchive` tinyint(1) NOT NULL DEFAULT 0,
  `priorityid` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=113 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `name`, `iscompleted`, `listid`, `position`, `description`, `url`, `isfavourite`, `isarchive`, `priorityid`) VALUES
(112, 'item3', 0, 65, '1', '', '', 0, 0, 1),
(111, 'item4', 1, 65, '0', '', '', 0, 0, 1),
(102, 'item5', 0, 61, '1', '', '', 1, 0, 1),
(101, 'item2', 0, 61, NULL, '', '', 0, 1, 1),
(100, 'item1', 1, 61, NULL, '', '', 0, 0, 1),
(110, 'item', 0, 65, '2', '', '', 1, 0, 3),
(106, 'item4', 0, 61, '0', '', '', 0, 0, 1),
(107, 'item3', 0, 63, '1', '', '', 1, 0, 2),
(108, 'item5', 0, 63, '2', '', '', 0, 0, 1),
(109, 'item6', 0, 63, '0', '', '', 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `priority`
--

DROP TABLE IF EXISTS `priority`;
CREATE TABLE IF NOT EXISTS `priority` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(2000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `priority`
--

INSERT INTO `priority` (`id`, `name`) VALUES
(1, 'None'),
(2, 'Low'),
(3, 'Medium'),
(4, 'High');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(2000) NOT NULL,
  `password` varchar(2000) NOT NULL,
  `username` varchar(2000) NOT NULL,
  `image` varchar(2000) NOT NULL DEFAULT 'default.png',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `username`, `image`) VALUES
(21, 'sean@gmail.com', '123', 'sean', 'image_picker3594707872417406751.gif');

-- --------------------------------------------------------

--
-- Table structure for table `userslist`
--

DROP TABLE IF EXISTS `userslist`;
CREATE TABLE IF NOT EXISTS `userslist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `listname` varchar(2000) NOT NULL,
  `colorid` int(11) NOT NULL,
  `iconid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `categoryid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userslist`
--

INSERT INTO `userslist` (`id`, `listname`, `colorid`, `iconid`, `userid`, `categoryid`) VALUES
(61, 'Item', 3, 5, 21, 2),
(63, 'list1', 8, 3, 21, 3),
(65, 'list1', 2, 2, 21, 17);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
