/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 10.4.27-MariaDB : Database - kartarmart
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`kartarmart` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `kartarmart`;

/*Table structure for table `banners` */

DROP TABLE IF EXISTS `banners`;

CREATE TABLE `banners` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `photo` varchar(191) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `banners_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `banners` */

insert  into `banners`(`id`,`title`,`slug`,`photo`,`description`,`status`,`created_at`,`updated_at`) values 
(5,'Indomie Diskon besar Besarann','indomie-diskon-besar-besarann','/storage/photos/1/Banner/banner indomie.jpg','<p>Buruan beliii</p>','active','2023-11-13 12:43:17','2023-11-13 12:43:17'),
(7,'Diskonn','diskonn','/storage/photos/1/Banner/banner diskon.jpg','<p>Diskon 50% bagi yang beruntung</p>','active','2023-11-13 12:44:18','2023-11-13 12:44:18');

/*Table structure for table `brands` */

DROP TABLE IF EXISTS `brands`;

CREATE TABLE `brands` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `brands_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `brands` */

insert  into `brands`(`id`,`title`,`slug`,`status`,`created_at`,`updated_at`) values 
(1,'Indofood','indofood','active','2023-11-11 01:56:21','2023-11-11 01:56:21'),
(2,'Nestle','nestle','active','2023-11-13 12:47:51','2023-11-13 12:47:51'),
(3,'Antibiotic','antibiotic','active','2023-11-23 09:26:11','2023-11-23 09:26:11');

/*Table structure for table `carts` */

DROP TABLE IF EXISTS `carts`;

CREATE TABLE `carts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) unsigned NOT NULL,
  `order_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `price` double(8,2) NOT NULL,
  `status` enum('new','progress','delivered','cancel') NOT NULL DEFAULT 'new',
  `quantity` int(11) NOT NULL,
  `amount` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carts_product_id_foreign` (`product_id`),
  KEY `carts_user_id_foreign` (`user_id`),
  KEY `carts_order_id_foreign` (`order_id`),
  CONSTRAINT `carts_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL,
  CONSTRAINT `carts_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `carts` */

insert  into `carts`(`id`,`product_id`,`order_id`,`user_id`,`price`,`status`,`quantity`,`amount`,`created_at`,`updated_at`) values 
(18,3,NULL,31,1350.00,'new',2,2700.00,'2023-11-16 07:38:46','2023-11-16 07:40:06'),
(19,1,14,32,2250.00,'new',3,6750.00,'2023-11-16 08:54:03','2023-11-16 08:55:49'),
(20,1,NULL,32,2250.00,'new',1,2250.00,'2023-11-16 08:58:07','2023-11-16 08:58:07'),
(22,4,15,31,4750.00,'new',3,14250.00,'2023-11-23 09:17:15','2023-11-23 09:19:11');

/*Table structure for table `categories` */

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `summary` text DEFAULT NULL,
  `photo` varchar(191) DEFAULT NULL,
  `is_parent` tinyint(1) NOT NULL DEFAULT 1,
  `parent_id` bigint(20) unsigned DEFAULT NULL,
  `added_by` bigint(20) unsigned DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`),
  KEY `categories_parent_id_foreign` (`parent_id`),
  KEY `categories_added_by_foreign` (`added_by`),
  CONSTRAINT `categories_added_by_foreign` FOREIGN KEY (`added_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `categories` */

insert  into `categories`(`id`,`title`,`slug`,`summary`,`photo`,`is_parent`,`parent_id`,`added_by`,`status`,`created_at`,`updated_at`) values 
(1,'Sedotan','makanan',NULL,NULL,1,NULL,NULL,'active','2023-11-11 01:28:38','2024-07-03 18:28:38'),
(2,'Minuman','minuman',NULL,NULL,1,NULL,NULL,'active','2023-11-13 12:46:35','2023-11-13 12:46:35'),
(3,'Obat-obatan','obat-obatan',NULL,NULL,1,NULL,NULL,'active','2023-11-16 09:03:38','2023-11-23 07:21:31'),
(4,'Alat Mandi','alat-mandi',NULL,NULL,1,NULL,NULL,'active','2023-11-23 09:24:52','2023-11-23 09:24:52');

/*Table structure for table `coupons` */

DROP TABLE IF EXISTS `coupons`;

CREATE TABLE `coupons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) NOT NULL,
  `type` enum('fixed','percent') NOT NULL DEFAULT 'fixed',
  `value` decimal(20,2) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `coupons_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `coupons` */

insert  into `coupons`(`id`,`code`,`type`,`value`,`status`,`created_at`,`updated_at`) values 
(1,'abc123','fixed',300.00,'active',NULL,NULL),
(2,'111111','percent',10.00,'active',NULL,NULL),
(5,'abcd','fixed',250.00,'active','2020-08-18 03:54:58','2020-08-18 03:54:58');

/*Table structure for table `failed_jobs` */

DROP TABLE IF EXISTS `failed_jobs`;

CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `failed_jobs` */

/*Table structure for table `jobs` */

DROP TABLE IF EXISTS `jobs`;

CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `jobs` */

/*Table structure for table `messages` */

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `subject` text NOT NULL,
  `email` varchar(191) NOT NULL,
  `photo` varchar(191) DEFAULT NULL,
  `phone` varchar(191) DEFAULT NULL,
  `message` longtext NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `messages` */

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`id`,`migration`,`batch`) values 
(1,'2014_10_12_000000_create_users_table',1),
(2,'2014_10_12_100000_create_password_resets_table',1),
(3,'2019_08_19_000000_create_failed_jobs_table',1),
(4,'2019_12_14_000001_create_personal_access_tokens_table',1),
(5,'2020_07_10_021010_create_brands_table',1),
(6,'2020_07_10_025334_create_banners_table',1),
(7,'2020_07_10_112147_create_categories_table',1),
(8,'2020_07_11_063857_create_products_table',1),
(9,'2020_07_12_073132_create_post_categories_table',1),
(10,'2020_07_12_073701_create_post_tags_table',1),
(11,'2020_07_12_083638_create_posts_table',1),
(12,'2020_07_13_151329_create_messages_table',1),
(13,'2020_07_14_023748_create_shippings_table',1),
(14,'2020_07_15_054356_create_orders_table',1),
(15,'2020_07_15_102626_create_carts_table',1),
(16,'2020_07_16_041623_create_notifications_table',1),
(17,'2020_07_16_053240_create_coupons_table',1),
(18,'2020_07_23_143757_create_wishlists_table',1),
(19,'2020_07_24_074930_create_product_reviews_table',1),
(20,'2020_07_24_131727_create_post_comments_table',1),
(21,'2020_08_01_143408_create_settings_table',1),
(22,'2023_06_21_164432_create_jobs_table',1);

/*Table structure for table `notifications` */

DROP TABLE IF EXISTS `notifications`;

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(191) NOT NULL,
  `notifiable_type` varchar(191) NOT NULL,
  `notifiable_id` bigint(20) unsigned NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `notifications` */

insert  into `notifications`(`id`,`type`,`notifiable_type`,`notifiable_id`,`data`,`read_at`,`created_at`,`updated_at`) values 
('416eaf95-886a-4ea4-a7e7-42b7c8fd356f','App\\Notifications\\StatusNotification','App\\User',1,'{\"title\":\"New order created\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/admin\\/order\\/16\",\"fas\":\"fa-file-alt\"}',NULL,'2023-11-24 09:45:46','2023-11-24 09:45:46'),
('4d1ce841-5a97-4ad6-80db-5cf0e6999f06','App\\Notifications\\StatusNotification','App\\User',1,'{\"title\":\"New order created\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/admin\\/order\\/12\",\"fas\":\"fa-file-alt\"}',NULL,'2023-11-15 19:23:17','2023-11-15 19:23:17'),
('65ee29c1-8788-4699-a6b0-58ca1eb93080','App\\Notifications\\StatusNotification','App\\User',1,'{\"title\":\"New Product Rating!\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/product-detail\\/indomie\",\"fas\":\"fa-star\"}',NULL,'2023-11-15 19:13:24','2023-11-15 19:13:24'),
('6974b877-a737-44fb-9e8a-4b4bba656eff','App\\Notifications\\StatusNotification','App\\User',1,'{\"title\":\"New order created\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/admin\\/order\\/13\",\"fas\":\"fa-file-alt\"}',NULL,'2023-11-16 07:40:06','2023-11-16 07:40:06'),
('6980c7ea-2194-4f56-b5e2-34d63b1698fc','App\\Notifications\\StatusNotification','App\\User',1,'{\"title\":\"New order created\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/admin\\/order\\/9\",\"fas\":\"fa-file-alt\"}',NULL,'2023-11-13 12:16:12','2023-11-13 12:16:12'),
('74178182-cc6f-4b28-8e6e-117647548759','App\\Notifications\\StatusNotification','App\\User',1,'{\"title\":\"New order created\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/admin\\/order\\/10\",\"fas\":\"fa-file-alt\"}',NULL,'2023-11-13 12:55:10','2023-11-13 12:55:10'),
('7d1d97f5-7f70-40e1-a1ef-379120f6da4d','App\\Notifications\\StatusNotification','App\\User',1,'{\"title\":\"New Product Rating!\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/product-detail\\/biskuat\",\"fas\":\"fa-star\"}',NULL,'2023-11-23 09:19:54','2023-11-23 09:19:54'),
('8425763a-4a0a-48e4-a8b8-6f2637c92f6f','App\\Notifications\\StatusNotification','App\\User',1,'{\"title\":\"New order created\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/admin\\/order\\/7\",\"fas\":\"fa-file-alt\"}','2023-11-13 12:00:37','2023-11-13 11:59:48','2023-11-13 12:00:37'),
('8aae34c4-f4a0-4f90-a142-79d40cab6352','App\\Notifications\\StatusNotification','App\\User',1,'{\"title\":\"New order created\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/admin\\/order\\/8\",\"fas\":\"fa-file-alt\"}',NULL,'2023-11-13 12:11:18','2023-11-13 12:11:18'),
('9806ef4a-d6af-480c-9b97-b1ffee0368f2','App\\Notifications\\StatusNotification','App\\User',1,'{\"title\":\"New Product Rating!\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/product-detail\\/milo\",\"fas\":\"fa-star\"}',NULL,'2023-11-16 08:51:42','2023-11-16 08:51:42'),
('b08a189f-5b1a-42ba-bed9-c135b5f2e905','App\\Notifications\\StatusNotification','App\\User',1,'{\"title\":\"New order created\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/admin\\/order\\/15\",\"fas\":\"fa-file-alt\"}',NULL,'2023-11-23 09:19:11','2023-11-23 09:19:11'),
('c4b3d4fe-b6a7-46d1-931a-b4f1b106f883','App\\Notifications\\StatusNotification','App\\User',1,'{\"title\":\"New order created\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/admin\\/order\\/14\",\"fas\":\"fa-file-alt\"}',NULL,'2023-11-16 08:55:49','2023-11-16 08:55:49'),
('c539a213-85c8-4363-818e-8a882ba78aae','App\\Notifications\\StatusNotification','App\\User',1,'{\"title\":\"New order created\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/admin\\/order\\/11\",\"fas\":\"fa-file-alt\"}',NULL,'2023-11-15 11:44:59','2023-11-15 11:44:59'),
('e939ee7a-f092-4902-8b98-63320061b7c7','App\\Notifications\\StatusNotification','App\\User',1,'{\"title\":\"New Product Rating!\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/product-detail\\/indomie\",\"fas\":\"fa-star\"}',NULL,'2023-11-15 12:08:43','2023-11-15 12:08:43'),
('fdc98d82-f736-4803-a324-3b9e2afd8e45','App\\Notifications\\StatusNotification','App\\User',1,'{\"title\":\"New order created\",\"actionURL\":\"http:\\/\\/127.0.0.1:8000\\/admin\\/order\\/6\",\"fas\":\"fa-file-alt\"}','2023-11-13 11:14:47','2023-11-13 11:14:29','2023-11-13 11:14:47');

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_number` varchar(191) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `sub_total` double(8,2) NOT NULL,
  `shipping_id` bigint(20) unsigned DEFAULT NULL,
  `coupon` double(8,2) DEFAULT NULL,
  `total_amount` double(8,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `payment_method` enum('cod','paypal') NOT NULL DEFAULT 'cod',
  `payment_status` enum('paid','unpaid') NOT NULL DEFAULT 'unpaid',
  `status` enum('new','process','delivered','cancel') NOT NULL DEFAULT 'new',
  `first_name` varchar(191) NOT NULL,
  `last_name` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `phone` varchar(191) NOT NULL,
  `country` varchar(191) NOT NULL,
  `post_code` varchar(191) DEFAULT NULL,
  `address1` text NOT NULL,
  `address2` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_order_number_unique` (`order_number`),
  KEY `orders_user_id_foreign` (`user_id`),
  KEY `orders_shipping_id_foreign` (`shipping_id`),
  CONSTRAINT `orders_shipping_id_foreign` FOREIGN KEY (`shipping_id`) REFERENCES `shippings` (`id`) ON DELETE SET NULL,
  CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `orders` */

insert  into `orders`(`id`,`order_number`,`user_id`,`sub_total`,`shipping_id`,`coupon`,`total_amount`,`quantity`,`payment_method`,`payment_status`,`status`,`first_name`,`last_name`,`email`,`phone`,`country`,`post_code`,`address1`,`address2`,`created_at`,`updated_at`) values 
(14,'ORD-MI4LMCQH3D',32,6750.00,3,NULL,6750.00,3,'cod','unpaid','delivered','Ananta','Putra','ananta@gmail.com','08883866931','ID','64195','Perum. Bumi Permata, Blok C14, Rt 11 Rw 17','Pare','2023-11-16 08:55:49','2023-11-16 09:11:32'),
(15,'ORD-RMLUAPQY5Y',31,14250.00,3,NULL,14250.00,3,'cod','unpaid','delivered','Silfiana','Rizki','silfiana@gmail.com','08883866931','ID','64195','Perum. Bumi Permata, Blok C14, Rt 11 Rw 17','Pare','2023-11-23 09:19:11','2023-11-23 09:30:18'),
(16,'ORD-PDSW6AZ4ER',NULL,2400.00,2,NULL,5400.00,1,'cod','unpaid','delivered','Frankie','Steinlie','frankie.steinlie@gmail.com','08883866931','ID','64195','Perum. Bumi Permata, Blok C14, Rt 11 Rw 17','Pare','2023-11-24 09:45:46','2023-11-24 09:46:13');

/*Table structure for table `password_resets` */

DROP TABLE IF EXISTS `password_resets`;

CREATE TABLE `password_resets` (
  `email` varchar(191) NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `password_resets` */

/*Table structure for table `personal_access_tokens` */

DROP TABLE IF EXISTS `personal_access_tokens`;

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `personal_access_tokens` */

/*Table structure for table `post_categories` */

DROP TABLE IF EXISTS `post_categories`;

CREATE TABLE `post_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `post_categories_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `post_categories` */

insert  into `post_categories`(`id`,`title`,`slug`,`status`,`created_at`,`updated_at`) values 
(1,'Travel','contrary','active','2020-08-14 08:51:03','2020-08-14 08:51:39'),
(2,'Electronics','richard','active','2020-08-14 08:51:22','2020-08-14 08:52:00'),
(3,'Cloths','cloths','active','2020-08-14 08:52:22','2020-08-14 08:52:22'),
(4,'enjoy','enjoy','active','2020-08-14 10:16:10','2020-08-14 10:16:10'),
(5,'Post Category','post-category','active','2020-08-15 13:59:04','2020-08-15 13:59:04');

/*Table structure for table `post_comments` */

DROP TABLE IF EXISTS `post_comments`;

CREATE TABLE `post_comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `post_id` bigint(20) unsigned DEFAULT NULL,
  `comment` text NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `replied_comment` text DEFAULT NULL,
  `parent_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `post_comments_user_id_foreign` (`user_id`),
  KEY `post_comments_post_id_foreign` (`post_id`),
  CONSTRAINT `post_comments_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `post_comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `post_comments` */

/*Table structure for table `post_tags` */

DROP TABLE IF EXISTS `post_tags`;

CREATE TABLE `post_tags` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `post_tags_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `post_tags` */

insert  into `post_tags`(`id`,`title`,`slug`,`status`,`created_at`,`updated_at`) values 
(1,'Enjoy','enjoy','active','2020-08-14 08:53:52','2020-08-14 08:53:52'),
(2,'2020','2020','active','2020-08-14 08:54:09','2020-08-14 08:54:09'),
(3,'Visit nepal 2020','visit-nepal-2020','active','2020-08-14 08:54:33','2020-08-14 08:54:33'),
(4,'Tag','tag','active','2020-08-15 13:59:31','2020-08-15 13:59:31');

/*Table structure for table `posts` */

DROP TABLE IF EXISTS `posts`;

CREATE TABLE `posts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `summary` text NOT NULL,
  `description` longtext DEFAULT NULL,
  `quote` text DEFAULT NULL,
  `photo` varchar(191) DEFAULT NULL,
  `tags` varchar(191) DEFAULT NULL,
  `post_cat_id` bigint(20) unsigned DEFAULT NULL,
  `post_tag_id` bigint(20) unsigned DEFAULT NULL,
  `added_by` bigint(20) unsigned DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_slug_unique` (`slug`),
  KEY `posts_post_cat_id_foreign` (`post_cat_id`),
  KEY `posts_post_tag_id_foreign` (`post_tag_id`),
  KEY `posts_added_by_foreign` (`added_by`),
  CONSTRAINT `posts_added_by_foreign` FOREIGN KEY (`added_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `posts_post_cat_id_foreign` FOREIGN KEY (`post_cat_id`) REFERENCES `post_categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `posts_post_tag_id_foreign` FOREIGN KEY (`post_tag_id`) REFERENCES `post_tags` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `posts` */

/*Table structure for table `product_reviews` */

DROP TABLE IF EXISTS `product_reviews`;

CREATE TABLE `product_reviews` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `product_id` bigint(20) unsigned DEFAULT NULL,
  `rate` tinyint(4) NOT NULL DEFAULT 0,
  `review` text DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_reviews_user_id_foreign` (`user_id`),
  KEY `product_reviews_product_id_foreign` (`product_id`),
  CONSTRAINT `product_reviews_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL,
  CONSTRAINT `product_reviews_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `product_reviews` */

insert  into `product_reviews`(`id`,`user_id`,`product_id`,`rate`,`review`,`status`,`created_at`,`updated_at`) values 
(4,30,1,5,'Emm... Nyam nyam nyam... Enak','active','2023-11-15 19:13:24','2023-11-16 08:24:43'),
(5,32,3,5,'Enak banget dehh\r\nRekomendasi banget','active','2023-11-16 08:51:41','2023-11-16 08:52:49');

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `summary` text NOT NULL,
  `description` longtext DEFAULT NULL,
  `photo` text NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 1,
  `size` varchar(191) DEFAULT 'M',
  `condition` enum('default','new','hot') NOT NULL DEFAULT 'default',
  `status` enum('active','inactive') NOT NULL DEFAULT 'inactive',
  `price` double(8,2) NOT NULL,
  `discount` double(8,2) NOT NULL,
  `is_featured` tinyint(1) NOT NULL,
  `cat_id` bigint(20) unsigned DEFAULT NULL,
  `child_cat_id` bigint(20) unsigned DEFAULT NULL,
  `brand_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_slug_unique` (`slug`),
  KEY `products_brand_id_foreign` (`brand_id`),
  KEY `products_cat_id_foreign` (`cat_id`),
  KEY `products_child_cat_id_foreign` (`child_cat_id`),
  CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE SET NULL,
  CONSTRAINT `products_cat_id_foreign` FOREIGN KEY (`cat_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `products_child_cat_id_foreign` FOREIGN KEY (`child_cat_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `products` */

insert  into `products`(`id`,`title`,`slug`,`summary`,`description`,`photo`,`stock`,`size`,`condition`,`status`,`price`,`discount`,`is_featured`,`cat_id`,`child_cat_id`,`brand_id`,`created_at`,`updated_at`) values 
(1,'Indomie','indomie','<p>Mie goreng</p>','<p>Sedap</p>','/storage/photos/1/Products/indomie.png',97,'','default','active',2500.00,10.00,1,1,NULL,1,'2023-11-11 01:51:58','2023-11-16 09:11:32'),
(3,'Milo','milo','<p>Milo Sashet 150ml</p>',NULL,'/storage/photos/1/Products/milo.jpg',100,'','hot','active',1500.00,10.00,1,2,NULL,2,'2023-11-13 12:49:04','2023-11-13 12:49:50'),
(4,'Biskuat','biskuat','<p>Biar kuat</p>','<p>Biskuat agar kuat&nbsp;</p>','/storage/photos/1/Products/biskuat.png',47,'','new','active',5000.00,5.00,1,1,NULL,1,'2023-11-16 09:05:55','2023-11-23 09:30:18'),
(5,'Paracetamol','paracetamol','<p>Obat Pusing, demam</p>','<p>Obat Pusing, demam, anjuran dokter diperlukan<br></p>','/storage/photos/1/Products/paracetamol.png',199,'','new','active',3000.00,20.00,1,3,NULL,3,'2023-11-23 09:27:56','2023-11-24 09:46:13');

/*Table structure for table `settings` */

DROP TABLE IF EXISTS `settings`;

CREATE TABLE `settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `description` longtext NOT NULL,
  `short_des` text NOT NULL,
  `logo` varchar(191) NOT NULL,
  `photo` varchar(191) NOT NULL,
  `address` varchar(191) NOT NULL,
  `phone` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `settings` */

insert  into `settings`(`id`,`description`,`short_des`,`logo`,`photo`,`address`,`phone`,`email`,`created_at`,`updated_at`) values 
(1,'<p>Ananta Putra, Ajeng Arumingsukma Agusiana, Frankie Steinlie, Rena Nazarulva Darma Sayekti, Silfiana Ika Rizki<br></p>','Kelompok 4','/storage/photos/martlogo.png','/storage/photos/1/Blog/kelngronggo.jpg','Kediri','+628883866931','kartarmart@gmail.com',NULL,'2023-11-15 19:54:56');

/*Table structure for table `shippings` */

DROP TABLE IF EXISTS `shippings`;

CREATE TABLE `shippings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(191) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `shippings` */

insert  into `shippings`(`id`,`type`,`price`,`status`,`created_at`,`updated_at`) values 
(1,'JNT',7000.00,'active','2023-11-11 01:32:16','2023-11-11 01:32:16'),
(2,'JNE',3000.00,'active','2023-11-11 01:37:35','2023-11-11 01:37:35'),
(3,'Taruna',0.00,'active','2023-11-15 19:36:37','2023-11-15 19:36:37'),
(4,'Ninja',5000.00,'active','2023-11-23 09:29:37','2023-11-23 09:29:37');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `email` varchar(191) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) DEFAULT NULL,
  `photo` varchar(191) DEFAULT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `provider` varchar(191) DEFAULT NULL,
  `provider_id` varchar(191) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`name`,`email`,`email_verified_at`,`password`,`photo`,`role`,`provider`,`provider_id`,`status`,`remember_token`,`created_at`,`updated_at`) values 
(30,'Steinlie','frankie.intern24slides@gmail.com',NULL,'$2y$10$xTuIJf.x8/HQBX8fzkqrWen7ixOX.7tB2OYjPPJz3HVAT8Lgp3.gO',NULL,'user',NULL,NULL,'active',NULL,'2023-11-11 07:31:05','2023-11-11 07:31:05'),
(31,'Silfiana','silfiana@gmail.com',NULL,'$2y$10$ONwYUJCwaJ2vkKVRaGP9T.8Qu4JVqfM.oN1VpvLLDMxk6w1xbjLjO',NULL,'user',NULL,NULL,'active',NULL,'2023-11-16 07:32:03','2023-11-16 07:32:03'),
(32,'Ananta','ananta@gmail.com',NULL,'$2y$10$0yybcVJW6ppFiY2K0QtT8eGwI9savwdvh09cwukPyydPLJucYsMKm',NULL,'user',NULL,NULL,'active',NULL,'2023-11-16 08:48:40','2023-11-16 08:48:40'),
(33,'Admin','admin@gmail.com',NULL,'$2y$10$815j.WIkHs1XibCA2oW7BODgV7uwGcIH8eTFA0Ru51JviZGtd2Vqy',NULL,'admin',NULL,NULL,'active',NULL,'2024-07-03 18:24:39','2024-07-03 18:24:39');

/*Table structure for table `wishlists` */

DROP TABLE IF EXISTS `wishlists`;

CREATE TABLE `wishlists` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) unsigned NOT NULL,
  `cart_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `price` double(8,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `amount` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wishlists_product_id_foreign` (`product_id`),
  KEY `wishlists_user_id_foreign` (`user_id`),
  KEY `wishlists_cart_id_foreign` (`cart_id`),
  CONSTRAINT `wishlists_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `wishlists_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wishlists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `wishlists` */

insert  into `wishlists`(`id`,`product_id`,`cart_id`,`user_id`,`price`,`quantity`,`amount`,`created_at`,`updated_at`) values 
(5,3,18,31,1350.00,1,1350.00,'2023-11-16 07:35:28','2023-11-16 07:38:46'),
(7,1,19,32,2250.00,1,2250.00,'2023-11-16 08:53:21','2023-11-16 08:54:03'),
(8,4,22,31,4750.00,1,4750.00,'2023-11-23 09:16:39','2023-11-23 09:17:15'),
(9,5,NULL,NULL,2400.00,1,2400.00,'2023-11-24 09:45:01','2023-11-24 09:45:15');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
