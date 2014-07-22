-- phpMyAdmin SQL Dump
-- version 4.1.14.1
-- http://www.phpmyadmin.net
--
-- Client :  db2657.1and1.fr
-- Généré le :  Lun 21 Juillet 2014 à 11:32
-- Version du serveur :  5.1.73-log
-- Version de PHP :  5.4.4-14+deb7u12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `db362233246`
--

-- --------------------------------------------------------

--
-- Structure de la table `aaa_jooblix_group`
--

CREATE TABLE IF NOT EXISTS `aaa_jooblix_group` (
  `groupId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` varchar(10) NOT NULL,
  `color` varchar(6) NOT NULL,
  PRIMARY KEY (`groupId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `aaa_jooblix_group`
--

INSERT INTO `aaa_jooblix_group` (`groupId`, `name`, `type`, `color`) VALUES
(1, 'NF26', 'course', 'ff0000'),
(2, 'NF28', 'course', '00ff00');

-- --------------------------------------------------------

--
-- Structure de la table `aaa_jooblix_task`
--

CREATE TABLE IF NOT EXISTS `aaa_jooblix_task` (
  `taskId` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `heure` time NOT NULL,
  PRIMARY KEY (`taskId`),
  KEY `groupId` (`groupId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Contenu de la table `aaa_jooblix_task`
--

INSERT INTO `aaa_jooblix_task` (`taskId`, `groupId`, `name`, `date`, `heure`) VALUES
(1, 1, 'Homework 1', '2014-07-22', '11:29:41'),
(4, 1, 'Homework 2', '2014-07-23', '11:31:06'),
(5, 1, 'Homework 3', '2014-07-25', '11:31:06'),
(8, 2, 'Projet 1', '2014-08-06', '11:31:50'),
(9, 2, 'Projet 2', '2014-10-31', '11:31:50');

-- --------------------------------------------------------

--
-- Structure de la table `aaa_jooblix_tokens`
--

CREATE TABLE IF NOT EXISTS `aaa_jooblix_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) NOT NULL,
  `token` varchar(64) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Contenu de la table `aaa_jooblix_tokens`
--

INSERT INTO `aaa_jooblix_tokens` (`id`, `uid`, `token`, `date`) VALUES
(11, '', 'c7a46310b8f239b85b268b478afef80e8bbe69ccb6f7efd4a756764aaae130ae', '2014-07-20 09:04:28'),
(12, 'B6EC6C1C-4C43-405A-8003-1A1E10185925', '4f10c3c8e2d9e45b99c67b2c6578d7e7184be3404f489da954596067b8b70dac', '2014-07-20 13:29:55'),
(13, '9DDDBEA2-53B6-46FA-BDEE-4F6BA94DF166', '', '2014-07-21 11:07:56'),
(14, '98BA10F2-BC88-4E6B-8516-1D61C3813007', '4f10c3c8e2d9e45b99c67b2c6578d7e7184be3404f489da954596067b8b70dac', '2014-07-21 11:10:28');

-- --------------------------------------------------------

--
-- Structure de la table `aaa_jooblix_user_group`
--

CREATE TABLE IF NOT EXISTS `aaa_jooblix_user_group` (
  `tokenId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  PRIMARY KEY (`tokenId`,`groupId`),
  KEY `groupId` (`groupId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `aaa_jooblix_task`
--
ALTER TABLE `aaa_jooblix_task`
  ADD CONSTRAINT `aaa_jooblix_task_ibfk_1` FOREIGN KEY (`groupId`) REFERENCES `aaa_jooblix_group` (`groupId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `aaa_jooblix_user_group`
--
ALTER TABLE `aaa_jooblix_user_group`
  ADD CONSTRAINT `aaa_jooblix_user_group_ibfk_2` FOREIGN KEY (`groupId`) REFERENCES `aaa_jooblix_group` (`groupId`),
  ADD CONSTRAINT `aaa_jooblix_user_group_ibfk_1` FOREIGN KEY (`tokenId`) REFERENCES `aaa_jooblix_tokens` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
