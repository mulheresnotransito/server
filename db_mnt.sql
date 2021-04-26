# ************************************************************
# Sequel Pro SQL dump
# Versão 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.32)
# Base de Dados: db_mnt
# Tempo de Geração: 2021-04-26 20:24:18 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump da tabela available_times
# ------------------------------------------------------------

DROP TABLE IF EXISTS `available_times`;

CREATE TABLE `available_times` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` varchar(50) NOT NULL DEFAULT '0',
  `id_default_time` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `available_times` WRITE;
/*!40000 ALTER TABLE `available_times` DISABLE KEYS */;

INSERT INTO `available_times` (`id`, `id_user`, `id_default_time`)
VALUES
	(1,'3','1'),
	(2,'3','2'),
	(3,'3','3'),
	(4,'3','8'),
	(5,'3','9');

/*!40000 ALTER TABLE `available_times` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela cars
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cars`;

CREATE TABLE `cars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(200) DEFAULT '0',
  `license_plate` varchar(200) DEFAULT '0',
  `brand` varchar(200) DEFAULT '0',
  `id_user` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `cars` WRITE;
/*!40000 ALTER TABLE `cars` DISABLE KEYS */;

INSERT INTO `cars` (`id`, `model`, `license_plate`, `brand`, `id_user`)
VALUES
	(1,'HB20','AAA-2020','Hyundai',3),
	(2,'Onix','AAA-1234','Chevrolet',9);

/*!40000 ALTER TABLE `cars` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela consultations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `consultations`;

CREATE TABLE `consultations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(1000) DEFAULT NULL,
  `id_user_client` int(11) NOT NULL,
  `id_user_psychologist` int(11) NOT NULL,
  `date` varchar(100) NOT NULL,
  `updated_at` varchar(100) NOT NULL,
  `status` varchar(50) NOT NULL,
  `id_default_time` varchar(11) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `consultations` WRITE;
/*!40000 ALTER TABLE `consultations` DISABLE KEYS */;

INSERT INTO `consultations` (`id`, `description`, `id_user_client`, `id_user_psychologist`, `date`, `updated_at`, `status`, `id_default_time`)
VALUES
	(1,'description test...',1,2,'15/04/2021','','canceled','1'),
	(2,'Consulta 02',1,2,'15/04/2021','','confirmed','2'),
	(3,'description test...',1,2,'15/04/2021','','scheduled','3'),
	(4,'consultation test',8,2,'15/04/2021','10/02/2021','scheduled','4'),
	(5,'consultation test 2',8,2,'15/04/2021','10/02/2021','scheduled','5');

/*!40000 ALTER TABLE `consultations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela credits
# ------------------------------------------------------------

DROP TABLE IF EXISTS `credits`;

CREATE TABLE `credits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user_client` int(11) NOT NULL,
  `credit_classes` int(100) NOT NULL,
  `credit_consultations` int(100) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

LOCK TABLES `credits` WRITE;
/*!40000 ALTER TABLE `credits` DISABLE KEYS */;

INSERT INTO `credits` (`id`, `id_user_client`, `credit_classes`, `credit_consultations`)
VALUES
	(1,1,3,5);

/*!40000 ALTER TABLE `credits` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela default_times
# ------------------------------------------------------------

DROP TABLE IF EXISTS `default_times`;

CREATE TABLE `default_times` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `initial_hour` varchar(50) NOT NULL DEFAULT '0',
  `end_hour` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `default_times` WRITE;
/*!40000 ALTER TABLE `default_times` DISABLE KEYS */;

INSERT INTO `default_times` (`id`, `initial_hour`, `end_hour`)
VALUES
	(1,'07:00','07:50'),
	(2,'07:50','08:40'),
	(3,'08:40','09:30'),
	(4,'09:30','10:20'),
	(5,'10:20','11:10'),
	(7,'11:10','12:00'),
	(8,'12:00','12:50'),
	(9,'12:50','13:40'),
	(10,'13:40','14:30'),
	(11,'14:30','15:20'),
	(12,'15:20','16:10'),
	(6,'16:10','17:00'),
	(23,'17:00','17:50'),
	(24,'17:50','18:40');

/*!40000 ALTER TABLE `default_times` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela feedbacks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `feedbacks`;

CREATE TABLE `feedbacks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user_from` varchar(50) NOT NULL DEFAULT '0',
  `id_user_to` varchar(50) NOT NULL DEFAULT '0',
  `text` varchar(10000) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump da tabela lessons
# ------------------------------------------------------------

DROP TABLE IF EXISTS `lessons`;

CREATE TABLE `lessons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(1000) DEFAULT NULL,
  `id_user_client` int(11) NOT NULL,
  `id_user_driver` int(11) NOT NULL,
  `date` varchar(100) NOT NULL,
  `status` varchar(50) NOT NULL,
  `updated_at` varchar(100) NOT NULL,
  `starting_point` varchar(1000) NOT NULL,
  `id_default_time` varchar(11) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `lessons` WRITE;
/*!40000 ALTER TABLE `lessons` DISABLE KEYS */;

INSERT INTO `lessons` (`id`, `description`, `id_user_client`, `id_user_driver`, `date`, `status`, `updated_at`, `starting_point`, `id_default_time`)
VALUES
	(199,NULL,8,9,'15/04/2021','scheduled','Wed Apr 14 2021 18:06:52 GMT-0300 (Horário Padrão de Brasília)','rua do exemplo, esquina da luz - 4774','2'),
	(200,NULL,8,8,'15/04/2021','scheduled','Wed Apr 14 2021 18:07:11 GMT-0300 (Horário Padrão de Brasília)','rua do exemplo, esquina da luz - 4774','2'),
	(201,NULL,8,3,'15/04/2021','scheduled','Wed Apr 14 2021 18:07:21 GMT-0300 (Horário Padrão de Brasília)','rua do exemplo, esquina da luz - 4774','2');

/*!40000 ALTER TABLE `lessons` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela notices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `notices`;

CREATE TABLE `notices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(1000) NOT NULL DEFAULT '0',
  `text` longtext NOT NULL,
  `description` longtext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `notices` WRITE;
/*!40000 ALTER TABLE `notices` DISABLE KEYS */;

INSERT INTO `notices` (`id`, `title`, `text`, `description`)
VALUES
	(1,'Notícia teste 1','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indust'),
	(2,'Notícia teste 2','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indust'),
	(3,'Notícia teste 3','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indust'),
	(4,'Notícia teste 4','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indust'),
	(5,'Notícia teste 5','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indust'),
	(6,'Notícia teste 6','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indust'),
	(7,'Notícia teste 7','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','asdasdasdas');

/*!40000 ALTER TABLE `notices` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela payments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `payments`;

CREATE TABLE `payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user_client` int(11) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `value` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump da tabela users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `birthday` varchar(100) NOT NULL,
  `sex` varchar(100) NOT NULL,
  `language` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `is_client` varchar(50) DEFAULT NULL,
  `is_psychologist` varchar(50) DEFAULT NULL,
  `is_driver` varchar(50) DEFAULT NULL,
  `is_logged` varchar(50) DEFAULT NULL,
  `classes_credits` varchar(50) DEFAULT '0',
  `consultations_credits` varchar(50) DEFAULT '0',
  `profile_photo` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `birthday`, `sex`, `language`, `country`, `is_client`, `is_psychologist`, `is_driver`, `is_logged`, `classes_credits`, `consultations_credits`, `profile_photo`)
VALUES
	(1,'caio','costa','caiocostaee@gmail.com','123','07/09/1998','male','portuguese','brazil','true','false','false','false','23','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG'),
	(2,'marta','duarte','marta@mnt.com.br','123','01/01/1990','female','portuguese','brazil','false','true','false','false','44','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG'),
	(3,'lucas','silva','lucas@mnt.com','123','01/01/1990','male','portuguese','brazil','false','false','true','false','2','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG'),
	(8,'teste','teste','teste','teste','07/09/1998','male','portuguese','brazil','true','true','true','true','10','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG'),
	(9,'Maria','Saramalho','maria@mnt.com','123','01/01/1990','female','portuguese','brazil','false','false','true','false','4','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG'),
	(10,'undefined','undefined','caio@caio.com','123','undefined','undefined','undefined','undefined','undefined','undefined','undefined',NULL,'33','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG'),
	(11,'caio','caio','caio','123','07/09','male','portuguese','brazil','true','undefined','undefined','true','22','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG'),
	(12,'A','a','A','A','undefined','undefined','undefined','undefined','true','undefined','undefined','true','11','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG'),
	(13,'E','e','E','E','undefined','undefined','undefined','undefined','undefined','undefined','undefined',NULL,'0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG'),
	(14,'D','d','D','D','undefined','undefined','undefined','undefined','true','undefined','undefined','true','0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG'),
	(15,'G','g','G','G','undefined','undefined','undefined','undefined','true','undefined','undefined',NULL,'0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG'),
	(16,'Gd','d','Gd','Gd','undefined','undefined','undefined','undefined','true','undefined','undefined',NULL,'0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG'),
	(17,'F','F','F','f','undefined','undefined','undefined','undefined','true','undefined','undefined','true','0','0','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
