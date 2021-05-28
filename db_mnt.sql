-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.17-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              11.1.0.6116
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para db_mnt
CREATE DATABASE IF NOT EXISTS `db_mnt` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `db_mnt`;

-- Copiando estrutura para tabela db_mnt.available_times
DROP TABLE IF EXISTS `available_times`;
CREATE TABLE IF NOT EXISTS `available_times` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` varchar(50) NOT NULL DEFAULT '0',
  `id_default_time` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela db_mnt.available_times: 5 rows
/*!40000 ALTER TABLE `available_times` DISABLE KEYS */;
INSERT INTO `available_times` (`id`, `id_user`, `id_default_time`) VALUES
	(1, '3', '1'),
	(2, '3', '2'),
	(3, '3', '3'),
	(4, '3', '8'),
	(5, '3', '9');
/*!40000 ALTER TABLE `available_times` ENABLE KEYS */;

-- Copiando estrutura para tabela db_mnt.cancellations
DROP TABLE IF EXISTS `cancellations`;
CREATE TABLE IF NOT EXISTS `cancellations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user_client` varchar(50) NOT NULL DEFAULT '0',
  `id_lesson` varchar(50) DEFAULT '0',
  `text` varchar(10000) NOT NULL DEFAULT '0',
  `id_consultation` varchar(50) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela db_mnt.cancellations: 34 rows
/*!40000 ALTER TABLE `cancellations` DISABLE KEYS */;
INSERT INTO `cancellations` (`id`, `id_user_client`, `id_lesson`, `text`, `id_consultation`) VALUES
	(1, '14', '201', 'Dfsdfsdfs', '0'),
	(2, '1', '225', 'Qualquer um...', '0'),
	(3, '1', '218', 'Testando cancelamento', '0'),
	(4, '1', '218', 'Testando cancelamento', '0'),
	(5, '1', '218', 'Testando cancelamento', '0'),
	(6, '1', '218', 'Testando cancelamento', '0'),
	(7, '1', '227', 'Adasd', '0'),
	(8, '1', '223', '23423', '0'),
	(9, '1', '224', 'Kjh', '0'),
	(10, '1', '229', 'Asd', '0'),
	(11, '1', '222', 'Dsds', '0'),
	(12, '1', '217', '34545', '0'),
	(13, '1', '226', '1231231', '0'),
	(14, '1', '220', 'Sdssd', '0'),
	(15, '1', '230', 'Asdas', '0'),
	(16, '1', '236', 'Teste', '0'),
	(17, '1', '235', 'Teste 2', '0'),
	(18, '1', '238', '23423', '0'),
	(19, '1', '237', '123213', '0'),
	(20, '1', '239', 'Dsfsdds', '0'),
	(21, '1', '240', 'Sdfsd', '0'),
	(22, '1', '243', '213', '0'),
	(23, '1', '242', '1232', '0'),
	(24, '1', '241', '123123', '0'),
	(25, '1', '0', '12312', '5'),
	(26, '1', '0', 'Asdsds', '4'),
	(27, '1', '0', '213123swaad', '3'),
	(28, '1', '0', 'Teste', '2'),
	(29, '1', '0', '123231', '1'),
	(30, '1', '0', 'Asasd', '6'),
	(31, '1', '245', 'Gggggg', '0'),
	(32, '1', '246', 'hshahahxkjdhaix', '0'),
	(33, '1', '244', 'hshahahxksi', '0'),
	(34, '1', '247', 'hdhsha', '0');
/*!40000 ALTER TABLE `cancellations` ENABLE KEYS */;

-- Copiando estrutura para tabela db_mnt.cars
DROP TABLE IF EXISTS `cars`;
CREATE TABLE IF NOT EXISTS `cars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(200) DEFAULT '0',
  `license_plate` varchar(200) DEFAULT '0',
  `brand` varchar(200) DEFAULT '0',
  `id_user` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela db_mnt.cars: 3 rows
/*!40000 ALTER TABLE `cars` DISABLE KEYS */;
INSERT INTO `cars` (`id`, `model`, `license_plate`, `brand`, `id_user`) VALUES
	(1, 'HB20', 'AAA-2020', 'Hyundai', 3),
	(2, 'Onix', 'AAA-1234', 'Chevrolet', 9),
	(3, 'Onix Plus', 'BBB-1234', 'Chevrolet', 8);
/*!40000 ALTER TABLE `cars` ENABLE KEYS */;

-- Copiando estrutura para tabela db_mnt.consultations
DROP TABLE IF EXISTS `consultations`;
CREATE TABLE IF NOT EXISTS `consultations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(1000) DEFAULT NULL,
  `id_user_client` int(11) NOT NULL,
  `id_user_psychologist` int(11) NOT NULL,
  `date` varchar(100) NOT NULL,
  `updated_at` varchar(100) NOT NULL,
  `status` varchar(50) NOT NULL,
  `id_default_time` varchar(11) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela db_mnt.consultations: 6 rows
/*!40000 ALTER TABLE `consultations` DISABLE KEYS */;
INSERT INTO `consultations` (`id`, `description`, `id_user_client`, `id_user_psychologist`, `date`, `updated_at`, `status`, `id_default_time`) VALUES
	(1, 'description test...', 1, 2, '15/05/2021', 'Thu May 06 2021 10:57:17 GMT-0300 (Horário Padrão de Brasília)', 'canceled', '1'),
	(2, 'Consulta 02', 1, 2, '15/05/2021', 'Thu May 06 2021 10:53:48 GMT-0300 (Horário Padrão de Brasília)', 'canceled', '2'),
	(3, 'description test...', 1, 2, '15/05/2021', 'Thu May 06 2021 10:32:40 GMT-0300 (Horário Padrão de Brasília)', 'canceled', '3'),
	(4, 'consultation test', 1, 2, '15/05/2021', 'Thu May 06 2021 10:32:21 GMT-0300 (Horário Padrão de Brasília)', 'canceled', '4'),
	(5, 'consultation test 2', 1, 2, '15/05/2021', 'Thu May 06 2021 10:31:51 GMT-0300 (Horário Padrão de Brasília)', 'canceled', '5'),
	(6, 'consultation test 2', 1, 2, '15/05/2021', 'Thu May 06 2021 14:34:06 GMT-0300 (Horário Padrão de Brasília)', 'canceled', '6');
/*!40000 ALTER TABLE `consultations` ENABLE KEYS */;

-- Copiando estrutura para tabela db_mnt.credits
DROP TABLE IF EXISTS `credits`;
CREATE TABLE IF NOT EXISTS `credits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user_client` int(11) NOT NULL,
  `credit_classes` int(100) NOT NULL,
  `credit_consultations` int(100) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela db_mnt.credits: 1 rows
/*!40000 ALTER TABLE `credits` DISABLE KEYS */;
INSERT INTO `credits` (`id`, `id_user_client`, `credit_classes`, `credit_consultations`) VALUES
	(1, 1, 3, 5);
/*!40000 ALTER TABLE `credits` ENABLE KEYS */;

-- Copiando estrutura para tabela db_mnt.default_times
DROP TABLE IF EXISTS `default_times`;
CREATE TABLE IF NOT EXISTS `default_times` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `initial_hour` varchar(50) NOT NULL DEFAULT '0',
  `end_hour` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela db_mnt.default_times: 14 rows
/*!40000 ALTER TABLE `default_times` DISABLE KEYS */;
INSERT INTO `default_times` (`id`, `initial_hour`, `end_hour`) VALUES
	(1, '07:00', '07:50'),
	(2, '07:50', '08:40'),
	(3, '08:40', '09:30'),
	(4, '09:30', '10:20'),
	(5, '10:20', '11:10'),
	(7, '11:10', '12:00'),
	(8, '12:00', '12:50'),
	(9, '12:50', '13:40'),
	(10, '13:40', '14:30'),
	(11, '14:30', '15:20'),
	(12, '15:20', '16:10'),
	(6, '16:10', '17:00'),
	(23, '17:00', '17:50'),
	(24, '17:50', '18:40');
/*!40000 ALTER TABLE `default_times` ENABLE KEYS */;

-- Copiando estrutura para tabela db_mnt.feedbacks
DROP TABLE IF EXISTS `feedbacks`;
CREATE TABLE IF NOT EXISTS `feedbacks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user_from` varchar(50) NOT NULL DEFAULT '0',
  `id_user_to` varchar(50) NOT NULL DEFAULT '0',
  `text` varchar(10000) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela db_mnt.feedbacks: 0 rows
/*!40000 ALTER TABLE `feedbacks` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedbacks` ENABLE KEYS */;

-- Copiando estrutura para tabela db_mnt.lessons
DROP TABLE IF EXISTS `lessons`;
CREATE TABLE IF NOT EXISTS `lessons` (
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
) ENGINE=MyISAM AUTO_INCREMENT=248 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela db_mnt.lessons: 13 rows
/*!40000 ALTER TABLE `lessons` DISABLE KEYS */;
INSERT INTO `lessons` (`id`, `description`, `id_user_client`, `id_user_driver`, `date`, `status`, `updated_at`, `starting_point`, `id_default_time`) VALUES
	(235, NULL, 1, 8, '07/05/2021', 'canceled', 'Thu May 06 2021 08:41:49 GMT-0300 (Horário Padrão de Brasília)', 'undefined', '1'),
	(236, NULL, 1, 8, '07/05/2021', 'canceled', 'Thu May 06 2021 08:41:39 GMT-0300 (Horário Padrão de Brasília)', 'undefined', '2'),
	(237, NULL, 1, 3, '07/05/2021', 'canceled', 'Thu May 06 2021 08:44:20 GMT-0300 (Horário Padrão de Brasília)', 'undefined', '3'),
	(238, NULL, 1, 3, '07/05/2021', 'canceled', 'Thu May 06 2021 08:43:41 GMT-0300 (Horário Padrão de Brasília)', 'undefined', '4'),
	(239, NULL, 1, 9, '07/05/2021', 'canceled', 'Thu May 06 2021 08:45:25 GMT-0300 (Horário Padrão de Brasília)', 'undefined', '4'),
	(240, NULL, 1, 8, '07/05/2021', 'canceled', 'Thu May 06 2021 08:47:26 GMT-0300 (Horário Padrão de Brasília)', 'undefined', '4'),
	(241, NULL, 1, 3, '07/05/2021', 'canceled', 'Thu May 06 2021 08:48:04 GMT-0300 (Horário Padrão de Brasília)', 'undefined', '1'),
	(242, NULL, 1, 9, '07/05/2021', 'canceled', 'Thu May 06 2021 08:47:58 GMT-0300 (Horário Padrão de Brasília)', 'undefined', '2'),
	(243, NULL, 1, 8, '07/05/2021', 'canceled', 'Thu May 06 2021 08:47:50 GMT-0300 (Horário Padrão de Brasília)', 'undefined', '3'),
	(244, NULL, 1, 3, '07/05/2021', 'canceled', 'Thu May 06 2021 15:40:03 GMT-0300 (Horário Padrão de Brasília)', 'undefined', '2'),
	(245, NULL, 1, 9, '07/05/2021', 'canceled', 'Thu May 06 2021 15:38:07 GMT-0300 (Horário Padrão de Brasília)', 'undefined', '1'),
	(246, NULL, 1, 9, '07/05/2021', 'canceled', 'Thu May 06 2021 15:39:54 GMT-0300 (Horário Padrão de Brasília)', 'undefined', '3'),
	(247, NULL, 1, 9, '08/05/2021', 'canceled', 'Thu May 06 2021 15:40:32 GMT-0300 (Horário Padrão de Brasília)', 'undefined', '5');
/*!40000 ALTER TABLE `lessons` ENABLE KEYS */;

-- Copiando estrutura para tabela db_mnt.notices
DROP TABLE IF EXISTS `notices`;
CREATE TABLE IF NOT EXISTS `notices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(1000) NOT NULL DEFAULT '0',
  `text` longtext NOT NULL,
  `description` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela db_mnt.notices: 7 rows
/*!40000 ALTER TABLE `notices` DISABLE KEYS */;
INSERT INTO `notices` (`id`, `title`, `text`, `description`) VALUES
	(1, 'Notícia teste 1', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indust'),
	(2, 'Notícia teste 2', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indust'),
	(3, 'Notícia teste 3', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indust'),
	(4, 'Notícia teste 4', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indust'),
	(5, 'Notícia teste 5', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indust'),
	(6, 'Notícia teste 6', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the indust'),
	(7, 'Notícia teste 7', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'asdasdasdas');
/*!40000 ALTER TABLE `notices` ENABLE KEYS */;

-- Copiando estrutura para tabela db_mnt.payments
DROP TABLE IF EXISTS `payments`;
CREATE TABLE IF NOT EXISTS `payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user_client` int(11) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `value` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela db_mnt.payments: 0 rows
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;

-- Copiando estrutura para tabela db_mnt.transactions
DROP TABLE IF EXISTS `transactions`;
CREATE TABLE IF NOT EXISTS `transactions` (
  `tid` text NOT NULL,
  `status` int(2) NOT NULL,
  `authorizationCode` text NOT NULL,
  `returnCode` text NOT NULL,
  `returnMessage` text NOT NULL,
  `id_client` text NOT NULL,
  `capture` tinyint(4) NOT NULL DEFAULT 0,
  `paymentId` text NOT NULL,
  `isClassCredits` tinyint(4) DEFAULT 0,
  `isConsultationCredits` tinyint(4) DEFAULT 0,
  `buyValue` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Copiando dados para a tabela db_mnt.transactions: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` (`tid`, `status`, `authorizationCode`, `returnCode`, `returnMessage`, `id_client`, `capture`, `paymentId`, `isClassCredits`, `isConsultationCredits`, `buyValue`) VALUES
	('0528012626357', 1, '741656', '4', 'Operation Successful', '1', 1, '97bfd5c7-f59e-4933-8859-ccca2db53ca8', 0, 1, 12300),
	('0528012723232', 1, '740831', '4', 'Operation Successful', '1', 1, 'd87d33e9-dbbb-4117-8133-ce1a95a9e942', 0, 1, 12300),
	('0528013152038', 1, '519532', '4', 'Operation Successful', '1', 1, '172ba571-3dc2-45c2-8f00-46025806f5a8', 1, 0, 1200),
	('0528013212243', 1, '533626', '4', 'Operation Successful', '1', 1, '97653220-e233-417a-bcad-ecae9d636ff2', 1, 0, 1200);
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;

-- Copiando estrutura para tabela db_mnt.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `birthday` varchar(100) NOT NULL,
  `sex` varchar(100) NOT NULL,
  `language` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `is_client` tinyint(1) DEFAULT 0,
  `is_psychologist` tinyint(1) DEFAULT 0,
  `is_driver` tinyint(1) DEFAULT 0,
  `is_logged` varchar(50) DEFAULT '0',
  `classes_credits` varchar(50) DEFAULT '0',
  `consultations_credits` varchar(50) DEFAULT '0',
  `profile_photo` varchar(100) NOT NULL DEFAULT '',
  `balance` varchar(50) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela db_mnt.users: 28 rows
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `birthday`, `sex`, `language`, `country`, `is_client`, `is_psychologist`, `is_driver`, `is_logged`, `classes_credits`, `consultations_credits`, `profile_photo`, `balance`) VALUES
	(1, 'Joana', 'Maria', 'cliente@teste', '123', '07/09/1998', 'male', 'portuguese', 'brazil', 1, 0, 0, 'true', '2424', '12321', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(2, 'Marta', 'Vieira', 'psicologa@teste', '123', '01/01/1990', 'female', 'portuguese', 'brazil', 0, 1, 0, 'false', '44', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(3, 'Bianca', 'Silva', 'motorista@teste', '123', '01/01/1990', 'male', 'portuguese', 'brazil', 0, 0, 1, 'false', '2', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(8, 'teste', 'teste', 'teste', 'teste', '07/09/1998', 'male', 'portuguese', 'brazil', 1, 1, 1, 'true', '10', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(9, 'Maria', 'Saramalho', 'maria@mnt.com', '123', '01/01/1990', 'female', 'portuguese', 'brazil', 0, 0, 1, 'false', '4', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(10, 'undefined', 'undefined', 'caio@caio.com', '123', 'undefined', 'undefined', 'undefined', 'undefined', 1, 0, 0, NULL, '33', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(11, 'caio', 'caio', 'caio', '123', '07/09', 'male', 'portuguese', 'brazil', 1, 0, 0, 'true', '22', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(12, 'A', 'a', 'A', 'A', 'undefined', 'undefined', 'undefined', 'undefined', 1, 0, 0, 'true', '11', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(13, 'E', 'e', 'E', 'E', 'undefined', 'undefined', 'undefined', 'undefined', 1, 0, 0, NULL, '0', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(14, 'D', 'd', 'D', 'D', 'undefined', 'undefined', 'undefined', 'undefined', 1, 0, 0, 'true', '128', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(15, 'G', 'g', 'G', 'G', 'undefined', 'undefined', 'undefined', 'undefined', 1, 0, 0, NULL, '0', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(16, 'Gd', 'd', 'Gd', 'Gd', 'undefined', 'undefined', 'undefined', 'undefined', 1, 0, 0, NULL, '0', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(17, 'F', 'F', 'F', 'f', 'undefined', 'undefined', 'undefined', 'undefined', 1, 0, 0, 'true', '0', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(18, 'Psychologist', 'Temporary', 'F', 'f', 'undefined', 'undefined', 'undefined', 'undefined', 0, 1, 0, 'true', '0', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(19, 'Psychologist', 'Temporary', 'F', 'f', 'undefined', 'undefined', 'undefined', 'undefined', 0, 1, 0, 'true', '0', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(20, 'Psychologist', 'Temporary', 'F', 'f', 'undefined', 'undefined', 'undefined', 'undefined', 0, 1, 0, 'true', '0', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(21, 'Psychologist', 'Temporary', 'F', 'f', 'undefined', 'undefined', 'undefined', 'undefined', 0, 1, 0, 'true', '0', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(22, 'Psychologist', 'Temporary', 'F', 'f', 'undefined', 'undefined', 'undefined', 'undefined', 0, 1, 0, 'true', '0', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(23, 'Psychologist', 'Temporary', 'F', 'f', 'undefined', 'undefined', 'undefined', 'undefined', 0, 1, 0, 'true', '0', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(24, 'Psychologist', 'Temporary', 'F', 'f', 'undefined', 'undefined', 'undefined', 'undefined', 0, 1, 0, 'true', '0', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(25, 'Psychologist', 'Temporary', 'F', 'f', 'undefined', 'undefined', 'undefined', 'undefined', 0, 1, 0, 'true', '0', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(26, 'Psychologist', 'Temporary', 'F', 'f', 'undefined', 'undefined', 'undefined', 'undefined', 0, 1, 0, 'true', '0', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(27, 'Psychologist', 'Temporary', 'F', 'f', 'undefined', 'undefined', 'undefined', 'undefined', 0, 1, 0, 'true', '0', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(28, 'Psychologist', 'Temporary', 'F', 'f', 'undefined', 'undefined', 'undefined', 'undefined', 0, 1, 0, 'true', '0', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(29, 'Psychologist', 'Temporary', 'F', 'f', 'undefined', 'undefined', 'undefined', 'undefined', 0, 1, 0, 'true', '0', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(30, 'Psychologist', 'Temporary', 'F', 'f', 'undefined', 'undefined', 'undefined', 'undefined', 0, 1, 0, 'true', '0', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(31, 'Psychologist', 'Temporary', 'F', 'f', 'undefined', 'undefined', 'undefined', 'undefined', 0, 1, 0, 'true', '0', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0'),
	(32, 'Psychologist', 'Temporary', 'F', 'f', 'undefined', 'undefined', 'undefined', 'undefined', 0, 1, 0, 'true', '0', '0', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fG', '0');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
