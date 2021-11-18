
drop database if exists films;
create database films;
use films;
set foreign_key_checks = 0;
DROP TABLE IF EXISTS `awards`;
CREATE TABLE `awards` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
);


DROP TABLE IF EXISTS `discounts`;
CREATE TABLE `discounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `on_what_media_types_id` bigint unsigned NOT NULL,
  `percent_of_discount` tinyint DEFAULT NULL,
  `starts_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `ends_at` datetime DEFAULT NULL,
  UNIQUE KEY `id` (`id`),
  CONSTRAINT `discounts_ibfk_1` FOREIGN KEY (`on_what_media_types_id`) REFERENCES `media_types` (`id`)
);


DROP TABLE IF EXISTS `media`;
CREATE TABLE `media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `media_types_id` bigint unsigned NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `age_restriction` enum('0+','6+','12+','16+','18+') DEFAULT NULL,
  `genre` varchar(50) DEFAULT NULL,
  `time_length` int DEFAULT NULL,
  `price` decimal(10,0) DEFAULT '0',
  `year_of_release` date DEFAULT '1970-01-01',
  UNIQUE KEY `id` (`id`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`media_types_id`) REFERENCES `media_types` (`id`)
) ;

DROP TABLE IF EXISTS `media_types`;
CREATE TABLE `media_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `types` enum('Фильмы','Сериалы','Аниме','Мультфильмы') DEFAULT NULL,
  `is_for_free` tinyint(1) DEFAULT NULL,
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `unique_index` (`types`,`is_for_free`)
);


DROP TABLE IF EXISTS `media_with_awards`;

CREATE TABLE `media_with_awards` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `media_id` bigint unsigned NOT NULL,
  `award_id` bigint unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `unique_index` (`award_id`, `media_id`),
  CONSTRAINT `media_with_awards_ibfk_1` FOREIGN KEY (`award_id`) REFERENCES `awards` (`id`),
  CONSTRAINT `media_with_awards_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
);

DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `info` text,
  UNIQUE KEY `id` (`id`)
);


DROP TABLE IF EXISTS `profile`;
CREATE TABLE `profile` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `is_vip` tinyint(1) DEFAULT '0',
  `gender` enum('М','Ж') DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `money` decimal(10,0) DEFAULT '0',
  `birthday` datetime DEFAULT NULL,
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `profile_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ;


DROP TABLE IF EXISTS `rewiew`;
CREATE TABLE `rewiew` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `media_id` bigint unsigned NOT NULL,
  `info` text,
  `written_at` datetime DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  unique key `media_user` (`user_id`, `media_id`),
  CONSTRAINT `rewiew_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `rewiew_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
);


DROP TABLE IF EXISTS `user_list_of_media`;
CREATE TABLE `user_list_of_media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `profile_id` bigint unsigned NOT NULL,
  `media_id` bigint unsigned NOT NULL,
  `added_at` datetime DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  KEY `profile_id` (`profile_id`),
  unique key `media_user` (`profile_id`, `media_id`),
  CONSTRAINT `user_list_of_media_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `profile` (`id`),
  constraint `user_list_of_media_ibfk_2` foreign key (`media_id`) references `media` (`id`)
);


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `surname` varchar(40) NOT NULL,
  `login` varchar(50) NOT NULL,
  `password_hash` varchar(100) NOT NULL,
  `phone` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `login` (`login`),
  UNIQUE KEY `phone` (`phone`)
) ;
