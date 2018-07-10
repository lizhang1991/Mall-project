/*
Navicat MySQL Data Transfer

Source Server         : 192.168.43.184
Source Server Version : 50722
Source Host           : 192.168.43.184:3306
Source Database       : mydb

Target Server Type    : MYSQL
Target Server Version : 50722
File Encoding         : 65001

Date: 2018-06-05 11:47:40
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can add user', '2', 'add_user');
INSERT INTO `auth_permission` VALUES ('5', 'Can change user', '2', 'change_user');
INSERT INTO `auth_permission` VALUES ('6', 'Can delete user', '2', 'delete_user');
INSERT INTO `auth_permission` VALUES ('7', 'Can add permission', '3', 'add_permission');
INSERT INTO `auth_permission` VALUES ('8', 'Can change permission', '3', 'change_permission');
INSERT INTO `auth_permission` VALUES ('9', 'Can delete permission', '3', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('10', 'Can add group', '4', 'add_group');
INSERT INTO `auth_permission` VALUES ('11', 'Can change group', '4', 'change_group');
INSERT INTO `auth_permission` VALUES ('12', 'Can delete group', '4', 'delete_group');
INSERT INTO `auth_permission` VALUES ('13', 'Can add content type', '5', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('14', 'Can change content type', '5', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete content type', '5', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('16', 'Can add session', '6', 'add_session');
INSERT INTO `auth_permission` VALUES ('17', 'Can change session', '6', 'change_session');
INSERT INTO `auth_permission` VALUES ('18', 'Can delete session', '6', 'delete_session');
INSERT INTO `auth_permission` VALUES ('19', 'Can add users', '7', 'add_users');
INSERT INTO `auth_permission` VALUES ('20', 'Can change users', '7', 'change_users');
INSERT INTO `auth_permission` VALUES ('21', 'Can delete users', '7', 'delete_users');
INSERT INTO `auth_permission` VALUES ('22', 'Can add types', '8', 'add_types');
INSERT INTO `auth_permission` VALUES ('23', 'Can change types', '8', 'change_types');
INSERT INTO `auth_permission` VALUES ('24', 'Can delete types', '8', 'delete_types');
INSERT INTO `auth_permission` VALUES ('25', 'Can add goods', '9', 'add_goods');
INSERT INTO `auth_permission` VALUES ('26', 'Can change goods', '9', 'change_goods');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete goods', '9', 'delete_goods');
INSERT INTO `auth_permission` VALUES ('28', 'Can add order info', '10', 'add_orderinfo');
INSERT INTO `auth_permission` VALUES ('29', 'Can change order info', '10', 'change_orderinfo');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete order info', '10', 'delete_orderinfo');
INSERT INTO `auth_permission` VALUES ('31', 'Can add order', '11', 'add_order');
INSERT INTO `auth_permission` VALUES ('32', 'Can change order', '11', 'change_order');
INSERT INTO `auth_permission` VALUES ('33', 'Can delete order', '11', 'delete_order');
INSERT INTO `auth_permission` VALUES ('34', 'Can add address', '12', 'add_address');
INSERT INTO `auth_permission` VALUES ('35', 'Can change address', '12', 'change_address');
INSERT INTO `auth_permission` VALUES ('36', 'Can delete address', '12', 'delete_address');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('4', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'user');
INSERT INTO `django_content_type` VALUES ('5', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('12', 'myadmin', 'address');
INSERT INTO `django_content_type` VALUES ('9', 'myadmin', 'goods');
INSERT INTO `django_content_type` VALUES ('11', 'myadmin', 'order');
INSERT INTO `django_content_type` VALUES ('10', 'myadmin', 'orderinfo');
INSERT INTO `django_content_type` VALUES ('8', 'myadmin', 'types');
INSERT INTO `django_content_type` VALUES ('7', 'myadmin', 'users');
INSERT INTO `django_content_type` VALUES ('6', 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2018-05-17 20:50:24.371137');
INSERT INTO `django_migrations` VALUES ('2', 'auth', '0001_initial', '2018-05-17 20:50:25.208047');
INSERT INTO `django_migrations` VALUES ('3', 'admin', '0001_initial', '2018-05-17 20:50:25.376743');
INSERT INTO `django_migrations` VALUES ('4', 'admin', '0002_logentry_remove_auto_add', '2018-05-17 20:50:25.399279');
INSERT INTO `django_migrations` VALUES ('5', 'contenttypes', '0002_remove_content_type_name', '2018-05-17 20:50:25.492642');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0002_alter_permission_name_max_length', '2018-05-17 20:50:25.566709');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0003_alter_user_email_max_length', '2018-05-17 20:50:25.676297');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0004_alter_user_username_opts', '2018-05-17 20:50:25.689388');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0005_alter_user_last_login_null', '2018-05-17 20:50:25.763396');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0006_require_contenttypes_0002', '2018-05-17 20:50:25.767983');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0007_alter_validators_add_error_messages', '2018-05-17 20:50:25.785644');
INSERT INTO `django_migrations` VALUES ('12', 'auth', '0008_alter_user_username_max_length', '2018-05-17 20:50:25.866241');
INSERT INTO `django_migrations` VALUES ('13', 'myadmin', '0001_initial', '2018-05-17 20:50:25.960993');
INSERT INTO `django_migrations` VALUES ('14', 'sessions', '0001_initial', '2018-05-17 20:50:26.034906');
INSERT INTO `django_migrations` VALUES ('15', 'myadmin', '0002_types', '2018-05-21 06:18:30.245191');
INSERT INTO `django_migrations` VALUES ('16', 'myadmin', '0003_goods', '2018-05-22 03:01:50.892731');
INSERT INTO `django_migrations` VALUES ('17', 'myadmin', '0004_auto_20180525_0811', '2018-05-25 08:11:33.975291');
INSERT INTO `django_migrations` VALUES ('18', 'myadmin', '0005_address_order_orderinfo', '2018-05-28 14:26:10.633770');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('0n4tekji26ejsgencphxk11sc1lbmlh8', 'MjZjYmRiZjcwNTQ3YWUyYTQzZGY2MWFjY2YwZjkxYWVmNjI3ZjcyMzp7InZlcmlmeWNvZGUiOiIyNzk4IiwiQWRtaW5Vc2VyIjp7Im5hbWUiOiIxMTEiLCJwaWMiOiIvc3RhdGljL3BpY3MvZGVmYXVsdC9kZWZhdWx0LmpwZyJ9LCJvcmRlciI6e30sImNhcnQiOnt9fQ==', '2018-06-14 01:57:30.089578');
INSERT INTO `django_session` VALUES ('3pu7ieda5rtj7fmc06q67k9h2m8ypn9u', 'NzIxYjBmOGJiZDRhNmUxMjBmZTRlYWVlZWYxNzgxYTM0MzlmNDJmYTp7IlZpcFVzZXIiOnsidWlkIjo4ODYsIm5hbWUiOiIyMjIiLCJwaWMiOiIvc3RhdGljL3BpY3MvZGVmYXVsdC9kZWZhdWx0LmpwZyJ9LCJjYXJ0Ijp7fSwidmVyaWZ5Y29kZSI6Ijk1NDMiLCJBZG1pblVzZXIiOnsibmFtZSI6IjExMSIsInBpYyI6Ii9zdGF0aWMvcGljcy8xNTI3NjgxNDg2LjMxMDcwMTg2ODk5My5qcGcifSwib3JkZXIiOnt9fQ==', '2018-06-14 03:30:39.446359');
INSERT INTO `django_session` VALUES ('85hfq7hh8h67g6suwxwibp2opjbzkken', 'ZTBiNTQwMTI5NDVlMmJhZTQxMmRiNzg3MmVhZGE1ZDI3ODNlOWJkZDp7InZlcmlmeWNvZGUiOiI0Njc4Iiwib3JkZXIiOnsiMSI6eyJ0aXRsZSI6Ilx1NWMwZlx1OWVjNFx1NGViYVx1NjU3MFx1NjM2ZVx1N2ViZiIsImlkIjoxLCJwcmljZSI6Ijc5LjAwIiwicGljIjoiL3N0YXRpYy9nb29kc3BpY3MvMTUyNzIwNjMwOC42NTIwNzc3Mjc3MTMucG5nIiwibnVtIjoxfX0sImNhcnQiOnsiMSI6eyJ0aXRsZSI6Ilx1NWMwZlx1OWVjNFx1NGViYVx1NjU3MFx1NjM2ZVx1N2ViZiIsImlkIjoxLCJwcmljZSI6Ijc5LjAwIiwicGljIjoiL3N0YXRpYy9nb29kc3BpY3MvMTUyNzIwNjMwOC42NTIwNzc3Mjc3MTMucG5nIiwibnVtIjoxfX0sIkFkbWluVXNlciI6eyJuYW1lIjoiMTExIiwicGljIjoiL3N0YXRpYy9waWNzLzE1Mjc2ODE0ODYuMzEwNzAxODY4OTkzLmpwZyJ9LCJWaXBVc2VyIjp7Im5hbWUiOiIyMjIiLCJwaWMiOiIiLCJ1aWQiOjg4Nn19', '2018-06-14 02:40:49.624686');
INSERT INTO `django_session` VALUES ('gb4e7onoi0xar2yl8kzfvok88ecj8q66', 'MmU5OTgyMzliNzc2ZTM2ZGRiYmIxODRmMmU0YmY3OTExNWE4NzhmMTp7InZlcmlmeWNvZGUiOiIxMjc0IiwiVmlwVXNlciI6eyJ1aWQiOjEsInBpYyI6Ii9zdGF0aWMvcGljcy9kZWZhdWx0L2RlZmF1bHQuanBnIiwibmFtZSI6IjExMSJ9LCJjYXJ0Ijp7IjEiOnsicGljIjoiL3N0YXRpYy9nb29kc3BpY3MvMTUyNzIwNjMwOC42NTIwNzc3Mjc3MTMucG5nIiwibnVtIjoxLCJpZCI6MSwicHJpY2UiOiI3OS4wMCIsInRpdGxlIjoiXHU1YzBmXHU5ZWM0XHU0ZWJhXHU2NTcwXHU2MzZlXHU3ZWJmIn19LCJvcmRlciI6e319', '2018-06-12 05:23:42.465471');
INSERT INTO `django_session` VALUES ('jgtog16qzykz7qb1ibpei0col4as8sol', 'NjQxNzIxYzFiYzBiNTU0MTNmZjZkZTEyYTE0MzM4YmM2ZDc4NWMzYzp7IkFkbWluVXNlciI6eyJuYW1lIjoiMTExIiwicGljIjoiL3N0YXRpYy9waWNzL2RlZmF1bHQvZGVmYXVsdC5qcGcifSwiY2FydCI6eyIzIjp7InRpdGxlIjoicHI5IiwiaWQiOjMsIm51bSI6MiwicGljIjoiL3N0YXRpYy9nb29kc3BpY3MvMTUyNzIwNjUwNS4xOTUwMTI2MjY3NzYuanBnIiwicHJpY2UiOiIyOTk5LjAwIn0sIjEiOnsidGl0bGUiOiJcdTVjMGZcdTllYzRcdTRlYmFcdTY1NzBcdTYzNmVcdTdlYmYiLCJpZCI6MSwibnVtIjoxLCJwaWMiOiIvc3RhdGljL2dvb2RzcGljcy8xNTI3MjA2MzA4LjY1MjA3NzcyNzcxMy5wbmciLCJwcmljZSI6Ijc5LjAwIn19LCJ2ZXJpZnljb2RlIjoiNTc2NyIsIm9yZGVyIjp7fSwiVmlwVXNlciI6eyJ1aWQiOjEsIm5hbWUiOiIxMTEiLCJwaWMiOiIvc3RhdGljL3BpY3MvZGVmYXVsdC9kZWZhdWx0LmpwZyJ9fQ==', '2018-06-12 02:36:51.106484');
INSERT INTO `django_session` VALUES ('oxtvnrr6n4mudful9fizeqfpvqvz8av7', 'ZjJiYTdlMDVlY2I4NzI0N2Q0M2M1YWRlYmI3YTc3MjYxZTJiZTU3MTp7IlZpcFVzZXIiOnsicGljIjoiL3N0YXRpYy9waWNzL2RlZmF1bHQvZGVmYXVsdC5qcGciLCJ1aWQiOjEsIm5hbWUiOiIxMTEifSwidmVyaWZ5Y29kZSI6Ijc4NTMifQ==', '2018-06-12 05:24:58.621922');
INSERT INTO `django_session` VALUES ('oyiy1sr2hzi0uka9ukuwybv8f6trltb1', 'ZTA3MDMxNzAxMWFkZTFhZmEwZDdhYjcwZjNjNWY2MGFkNTVlMGFmMzp7ImNhcnQiOnt9LCJBZG1pblVzZXIiOnsibmFtZSI6IjExMSIsInBpYyI6Ii9zdGF0aWMvcGljcy8xNTI3NzQwNDcwLjk5ODExMjcxODExMC5wbmcifSwiVmlwVXNlciI6eyJ1aWQiOjEsIm5hbWUiOiIxMTEiLCJwaWMiOiIvc3RhdGljL3BpY3MvZGVmYXVsdC9kZWZhdWx0LmpwZyJ9LCJ2ZXJpZnljb2RlIjoiMTYyOCIsIm9yZGVyIjp7fX0=', '2018-06-14 07:06:21.142322');
INSERT INTO `django_session` VALUES ('unqeitw1zwlvs0441s3d3f4gmx389p7x', 'ZTUwZTYyNGFkODU4MzUwOGRkMTAyNDcwNGJhZjNjY2EwMDQxMWUyNzp7IkFkbWluVXNlciI6eyJuYW1lIjoiMTExMSIsInBpYyI6Ii9zdGF0aWMvcGljcy9kZWZhdWx0L2RlZmF1bHQuanBnIn0sImNhcnQiOnsiMSI6eyJudW0iOjEsImlkIjoxLCJwcmljZSI6Ijc5LjAwIiwidGl0bGUiOiJcdTVjMGZcdTllYzRcdTRlYmFcdTY1NzBcdTYzNmVcdTdlYmYiLCJwaWMiOiIvc3RhdGljL2dvb2RzcGljcy8xNTI3MjA2MzA4LjY1MjA3NzcyNzcxMy5wbmcifX0sInZlcmlmeWNvZGUiOiI4Nzk1IiwiVmlwVXNlciI6eyJ1aWQiOjEsIm5hbWUiOiIxMTExIiwicGljIjoiL3N0YXRpYy9waWNzL2RlZmF1bHQvZGVmYXVsdC5qcGcifX0=', '2018-06-13 05:16:56.733625');
INSERT INTO `django_session` VALUES ('whi9xdbh2miymltdquletsuifhdsmd7r', 'NDYzNjhiYmFlMTY2NDZlZTlkY2FhOTkyYjJiMTQ3MWUzNjU3NjZiMTp7IlZpcFVzZXIiOnsidWlkIjoxLCJuYW1lIjoiMTExIiwicGljIjoiL3N0YXRpYy9waWNzLzE1Mjc3MzYyOTUuNzM0NzYxNTMwNDI4LmpwZyJ9LCJ2ZXJpZnljb2RlIjoiODExNCJ9', '2018-06-14 03:35:02.618965');
INSERT INTO `django_session` VALUES ('wj08exq5gus7jrgfsp0z0rvwya0cmhyr', 'YjBjNDFlMmM3ZmY1YWQ4NWI0NDU2MjNiNjk0Nzk4MWUzNzI5OWY5ZTp7IlZpcFVzZXIiOnsicGljIjoiL3N0YXRpYy9waWNzL2RlZmF1bHQvZGVmYXVsdC5qcGciLCJuYW1lIjoiMTExMSIsInVpZCI6MX0sIm9yZGVyIjp7fSwiY2FydCI6e30sInZlcmlmeWNvZGUiOiI3NjU4In0=', '2018-06-12 12:06:58.079687');
INSERT INTO `django_session` VALUES ('zo64byoh1qtahe2ur0vwaxta3akpnoj1', 'NWRjZWViMDgwYjllNTQwNzYyNzJjNDcwYmYwYTJmNjMzMGU4M2FjMTp7IkFkbWluVXNlciI6eyJwaWMiOiIvc3RhdGljL3BpY3MvZGVmYXVsdC9kZWZhdWx0LmpwZyIsIm5hbWUiOiIxMTEifSwidmVyaWZ5Y29kZSI6Ijg4NDgifQ==', '2018-06-15 01:52:10.752197');

-- ----------------------------
-- Table structure for myadmin_address
-- ----------------------------
DROP TABLE IF EXISTS `myadmin_address`;
CREATE TABLE `myadmin_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aname` varchar(20) NOT NULL,
  `aads` varchar(255) NOT NULL,
  `aphone` varchar(11) NOT NULL,
  `status` int(11) NOT NULL,
  `uid_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myadmin_address_uid_id_79af8acf_fk_myadmin_users_id` (`uid_id`),
  CONSTRAINT `myadmin_address_uid_id_79af8acf_fk_myadmin_users_id` FOREIGN KEY (`uid_id`) REFERENCES `myadmin_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myadmin_address
-- ----------------------------
INSERT INTO `myadmin_address` VALUES ('1', '15555', '北京市昌平区育荣教育园区', '12345678', '0', '1');
INSERT INTO `myadmin_address` VALUES ('2', '222', '柔柔弱弱', '12343', '0', '1');
INSERT INTO `myadmin_address` VALUES ('3', '222', '北京市昌平区', '123456', '0', '1');
INSERT INTO `myadmin_address` VALUES ('4', '222', '222', '1222', '0', '1');
INSERT INTO `myadmin_address` VALUES ('5', '111', '333', '222', '0', '1');
INSERT INTO `myadmin_address` VALUES ('7', 'zhangsan', '北京市朝阳区', '1123445355', '0', '1');
INSERT INTO `myadmin_address` VALUES ('8', '222222', '2222222', '222222', '0', '1');
INSERT INTO `myadmin_address` VALUES ('9', '222', '北京市海淀区', '123456', '0', '886');
INSERT INTO `myadmin_address` VALUES ('10', '222', '北京市昌平区育荣教育园区', '3222', '0', '886');
INSERT INTO `myadmin_address` VALUES ('11', '222', '北京市朝阳区', '123456', '0', '886');
INSERT INTO `myadmin_address` VALUES ('12', '111', '北京市海淀区', '123456', '0', '1');
INSERT INTO `myadmin_address` VALUES ('13', '444', '嘎嘎嘎', '333', '0', '1');

-- ----------------------------
-- Table structure for myadmin_goods
-- ----------------------------
DROP TABLE IF EXISTS `myadmin_goods`;
CREATE TABLE `myadmin_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `storage` int(11) NOT NULL,
  `pic` varchar(50) NOT NULL,
  `info` longtext NOT NULL,
  `num` int(11) NOT NULL,
  `clicknum` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `addtime` datetime(6) NOT NULL,
  `typeid_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myadmin_goods_typeid_id_a0810d57_fk_myadmin_types_id` (`typeid_id`),
  CONSTRAINT `myadmin_goods_typeid_id_a0810d57_fk_myadmin_types_id` FOREIGN KEY (`typeid_id`) REFERENCES `myadmin_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myadmin_goods
-- ----------------------------
INSERT INTO `myadmin_goods` VALUES ('1', '小黄人数据线', '79.00', '963327', '/static/goodspics/1527765512.433028567500.png', '<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;小黄人usb数据线&nbsp;&nbsp;</p><p><img src=\"/static/media/article/20180524/20180524235826825.png\" title=\"20180524/20180524235826825.png\" alt=\"20180524/20180524235826825.png\"/></p>', '10', '0', '1', '2018-05-24 23:58:28.661034', '12');
INSERT INTO `myadmin_goods` VALUES ('2', '魔音耳机', '99.00', '100', '/static/goodspics/1527768405.485798829376.png', '<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;魔音耳机&nbsp; 听音乐更顺畅</p><p><img src=\"/static/media/article/20180525/20180525000023778.png\" title=\"20180525/20180525000023778.png\" alt=\"20180525/20180525000023778.png\"/></p>', '0', '0', '1', '2018-05-25 00:00:26.400850', '1');
INSERT INTO `myadmin_goods` VALUES ('3', 'pr9', '2999.00', '995', '/static/goodspics/1527206505.195012626776.jpg', '<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pr9手机</p><p><img src=\"/static/media/article/20180525/20180525000142078.jpg\" title=\"20180525/20180525000142078.jpg\" alt=\"20180525/20180525000142078.jpg\"/>&nbsp; &nbsp; &nbsp;&nbsp;</p>', '5', '0', '2', '2018-05-25 00:01:45.201003', '7');
INSERT INTO `myadmin_goods` VALUES ('4', '魅蓝A5', '1999.00', '99', '/static/goodspics/1527206738.343869717807.jpg', '<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;魅蓝A5</p><p><img src=\"/static/media/article/20180525/20180525000532533.png\" title=\"20180525/20180525000532533.png\" alt=\"20180525/20180525000532533.png\"/>&nbsp; &nbsp;&nbsp;</p>', '1', '0', '1', '2018-05-25 00:05:38.350389', '7');
INSERT INTO `myadmin_goods` VALUES ('5', '魅蓝1', '3000.00', '100', '/static/goodspics/1527504653.131537468165.jpg', '<p>&nbsp; 魅蓝1手机</p><p><br/></p>', '0', '0', '1', '2018-05-28 10:50:53.158291', '7');
INSERT INTO `myadmin_goods` VALUES ('6', '小航人移动电源', '9000.00', '100', '/static/goodspics/1527811818.797631374222.png', '<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;小黄人&nbsp; &nbsp; &nbsp;&nbsp;</p>', '0', '0', '1', '2018-05-31 02:29:10.411301', '13');
INSERT INTO `myadmin_goods` VALUES ('7', '智能', '111.00', '111', '/static/pics/1527768533.928282571306.png', '<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;请输入商品详情内容\r\n &nbsp; &nbsp; &nbsp; &nbsp;</p>', '0', '0', '1', '2018-05-31 12:08:56.767738', '11');
INSERT INTO `myadmin_goods` VALUES ('8', '智能手环', '111.00', '122', '/static/pics/1527768731.795018456944.png', '<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;请输入商品详情内容\r\n &nbsp; &nbsp; &nbsp; &nbsp;</p>', '0', '0', '1', '2018-05-31 12:12:14.752732', '4');
INSERT INTO `myadmin_goods` VALUES ('9', '魅族2', '2000.00', '100', '/static/pics/1527768873.084365165265.jpg', '<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;请输入商品详情内容\r\n &nbsp; &nbsp; &nbsp; &nbsp;</p>', '0', '0', '1', '2018-05-31 12:14:35.702643', '8');
INSERT INTO `myadmin_goods` VALUES ('10', '魅蓝3', '2000.00', '100', '/static/pics/1527812127.537625880068.jpg', '<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;请输入商品详情内容\r\n &nbsp; &nbsp; &nbsp; &nbsp;</p>', '0', '0', '1', '2018-06-01 00:15:29.626969', '7');

-- ----------------------------
-- Table structure for myadmin_order
-- ----------------------------
DROP TABLE IF EXISTS `myadmin_order`;
CREATE TABLE `myadmin_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `totalprice` double NOT NULL,
  `totalnum` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `addtime` datetime(6) NOT NULL,
  `address_id` int(11) NOT NULL,
  `uid_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myadmin_order_address_id_8f2ad596_fk_myadmin_address_id` (`address_id`),
  KEY `myadmin_order_uid_id_bcf75806_fk_myadmin_users_id` (`uid_id`),
  CONSTRAINT `myadmin_order_address_id_8f2ad596_fk_myadmin_address_id` FOREIGN KEY (`address_id`) REFERENCES `myadmin_address` (`id`),
  CONSTRAINT `myadmin_order_uid_id_bcf75806_fk_myadmin_users_id` FOREIGN KEY (`uid_id`) REFERENCES `myadmin_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myadmin_order
-- ----------------------------
INSERT INTO `myadmin_order` VALUES ('1', '5998', '2', '2', '2018-05-29 00:36:07.032886', '1', '1');
INSERT INTO `myadmin_order` VALUES ('2', '79', '1', '1', '2018-05-29 00:45:43.296075', '1', '1');
INSERT INTO `myadmin_order` VALUES ('3', '1999', '1', '3', '2018-05-29 05:55:44.161021', '1', '1');
INSERT INTO `myadmin_order` VALUES ('4', '2999', '1', '1', '2018-05-29 09:22:35.837863', '1', '1');
INSERT INTO `myadmin_order` VALUES ('6', '3078', '2', '1', '2018-05-29 12:06:58.045341', '2', '1');
INSERT INTO `myadmin_order` VALUES ('7', '79', '1', '1', '2018-05-30 12:03:21.877385', '7', '1');
INSERT INTO `myadmin_order` VALUES ('8', '0', '0', '1', '2018-05-30 12:04:19.511595', '8', '1');
INSERT INTO `myadmin_order` VALUES ('9', '79', '1', '1', '2018-05-31 02:35:51.513295', '9', '886');
INSERT INTO `myadmin_order` VALUES ('10', '2999', '1', '1', '2018-05-31 03:30:06.102607', '10', '886');
INSERT INTO `myadmin_order` VALUES ('11', '474', '6', '1', '2018-05-31 07:05:28.931223', '1', '1');

-- ----------------------------
-- Table structure for myadmin_orderinfo
-- ----------------------------
DROP TABLE IF EXISTS `myadmin_orderinfo`;
CREATE TABLE `myadmin_orderinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num` int(11) NOT NULL,
  `price` double NOT NULL,
  `gid_id` int(11) NOT NULL,
  `orderid_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myadmin_orderinfo_gid_id_6d844ef9_fk_myadmin_goods_id` (`gid_id`),
  KEY `myadmin_orderinfo_orderid_id_9e3ed2c9_fk_myadmin_order_id` (`orderid_id`),
  CONSTRAINT `myadmin_orderinfo_gid_id_6d844ef9_fk_myadmin_goods_id` FOREIGN KEY (`gid_id`) REFERENCES `myadmin_goods` (`id`),
  CONSTRAINT `myadmin_orderinfo_orderid_id_9e3ed2c9_fk_myadmin_order_id` FOREIGN KEY (`orderid_id`) REFERENCES `myadmin_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myadmin_orderinfo
-- ----------------------------
INSERT INTO `myadmin_orderinfo` VALUES ('1', '2', '2999', '3', '1');
INSERT INTO `myadmin_orderinfo` VALUES ('2', '1', '79', '1', '2');
INSERT INTO `myadmin_orderinfo` VALUES ('3', '1', '1999', '4', '3');
INSERT INTO `myadmin_orderinfo` VALUES ('4', '1', '2999', '3', '4');
INSERT INTO `myadmin_orderinfo` VALUES ('5', '1', '2999', '3', '6');
INSERT INTO `myadmin_orderinfo` VALUES ('6', '1', '79', '1', '6');
INSERT INTO `myadmin_orderinfo` VALUES ('7', '1', '79', '1', '7');
INSERT INTO `myadmin_orderinfo` VALUES ('8', '1', '79', '1', '9');
INSERT INTO `myadmin_orderinfo` VALUES ('9', '1', '2999', '3', '10');
INSERT INTO `myadmin_orderinfo` VALUES ('10', '6', '79', '1', '11');

-- ----------------------------
-- Table structure for myadmin_types
-- ----------------------------
DROP TABLE IF EXISTS `myadmin_types`;
CREATE TABLE `myadmin_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `pid` int(11) NOT NULL,
  `path` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myadmin_types
-- ----------------------------
INSERT INTO `myadmin_types` VALUES ('1', '手机配件/移动电源', '0', '0，');
INSERT INTO `myadmin_types` VALUES ('2', '数码影音', '0', '0，');
INSERT INTO `myadmin_types` VALUES ('3', '游戏设备', '0', '0，');
INSERT INTO `myadmin_types` VALUES ('4', '智能设备', '0', '0,');
INSERT INTO `myadmin_types` VALUES ('5', '智能穿戴', '0', '0，');
INSERT INTO `myadmin_types` VALUES ('6', '手机', '0', '0,');
INSERT INTO `myadmin_types` VALUES ('7', '魅蓝手机', '6', '0,6,');
INSERT INTO `myadmin_types` VALUES ('8', '魅族手机', '6', '0,6,');
INSERT INTO `myadmin_types` VALUES ('10', '智能娱乐', '4', '0,4,');
INSERT INTO `myadmin_types` VALUES ('11', '智能厨房', '4', '0,4,');
INSERT INTO `myadmin_types` VALUES ('12', '数据线', '1', '0,1,');
INSERT INTO `myadmin_types` VALUES ('13', '移动电源', '1', '0,1,');
INSERT INTO `myadmin_types` VALUES ('15', '日日日', '10', '0,4,10,');

-- ----------------------------
-- Table structure for myadmin_users
-- ----------------------------
DROP TABLE IF EXISTS `myadmin_users`;
CREATE TABLE `myadmin_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(77) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `addtime` datetime(6) NOT NULL,
  `picurl` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=895 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myadmin_users
-- ----------------------------
INSERT INTO `myadmin_users` VALUES ('1', '111', 'pbkdf2_sha256$36000$NCar8I4r0EuZ$XTvW1T0RNqBLq+w4FVpZ1NL/vO6ETD8xvvomRNtckxQ=', 'zs@qq.com', '123', '男', '21', '2', '2018-05-18 09:08:58.000000', '/static/pics/default/default.jpg');
INSERT INTO `myadmin_users` VALUES ('2', '齐桓公', 'pbkdf2_sha256$36000$7CrFqkOJ6yyH$jzOEhXMrmsq97M5fBtEVouVsnMeu65pc46HGjKsHI4M=', 'zs@qq.com', '13701383017', '男', '22', '3', '2018-05-18 09:08:58.000000', '/static/pics/1527680723.269842911915.png');
INSERT INTO `myadmin_users` VALUES ('3', '狐突', 'pbkdf2_sha256$36000$7CrFqkOJ6yyH$jzOEhXMrmsq97M5fBtEVouVsnMeu65pc46HGjKsHI4M=', 'zs@qq.com', '13701383017', '男', '22', '0', '2018-05-18 09:08:58.000000', '/static/pics/1527768354.99511755547.jpg');
INSERT INTO `myadmin_users` VALUES ('4', '狐偃', 'pbkdf2_sha256$36000$7CrFqkOJ6yyH$jzOEhXMrmsq97M5fBtEVouVsnMeu65pc46HGjKsHI4M=', 'zs@qq.com', '13701383017', '男', '22', '0', '2018-05-18 09:08:58.000000', '/static/pics/default/default.jpg');
INSERT INTO `myadmin_users` VALUES ('5', '狐毛', 'pbkdf2_sha256$36000$7CrFqkOJ6yyH$jzOEhXMrmsq97M5fBtEVouVsnMeu65pc46HGjKsHI4M=', 'zs@qq.com', '13701383017', '男', '22', '0', '2018-05-18 09:08:58.000000', '/static/pics/default/default.jpg');
INSERT INTO `myadmin_users` VALUES ('6', '介子推', 'pbkdf2_sha256$36000$7CrFqkOJ6yyH$jzOEhXMrmsq97M5fBtEVouVsnMeu65pc46HGjKsHI4M=', 'zs@qq.com', '13701383017', '男', '22', '0', '2018-05-18 09:08:58.000000', '/static/pics/default/default.jpg');
INSERT INTO `myadmin_users` VALUES ('7', '里克', 'pbkdf2_sha256$36000$7CrFqkOJ6yyH$jzOEhXMrmsq97M5fBtEVouVsnMeu65pc46HGjKsHI4M=', 'zs@qq.com', '13701383017', '男', '22', '0', '2018-05-18 09:08:58.000000', '/static/pics/default/default.jpg');
INSERT INTO `myadmin_users` VALUES ('886', '222', 'pbkdf2_sha256$36000$uBEdz3SICUby$rNXhHuHOBTYOtbrigApfTwn/oAfTeWqZg3uc0wpudYo=', '222@qq', '1234567', '女', '22', '3', '2018-05-31 02:11:41.228154', '/static/pics/default/default.jpg');
INSERT INTO `myadmin_users` VALUES ('888', '222', 'pbkdf2_sha256$36000$7HOpPPS5MoB4$asOWo1hlzeATPEE6983qa4vZoEn8j7o2fPrLJA4Fz0I=', '222@qq', '123456', '男', '22', '2', '2018-05-31 02:26:41.584266', '/static/pics/1527733639.377135329696.png');
INSERT INTO `myadmin_users` VALUES ('889', '李四', 'pbkdf2_sha256$36000$X2VvRMA0mJk1$8OD+KMB9f+QodplnzIOCUygU00XIoUbnt6yo252Io3I=', '123@qq.com', '123456', '女', '12', '0', '2018-05-31 05:25:34.168628', '/static/pics/1527744331.365512897652.jpg');
INSERT INTO `myadmin_users` VALUES ('890', '333', 'pbkdf2_sha256$36000$3pkbLA1RGBL4$f3YSc9S2Q9IPtwHDzbV9TyUcQQQiBaKaCvzb9TzVMBE=', '111@qq.com', '123456', '男', '22', '0', '2018-05-31 06:51:46.443418', '');
INSERT INTO `myadmin_users` VALUES ('891', '444', 'pbkdf2_sha256$36000$Tac35gboYfLh$U/JTKTfqD8MlSM5/0EBIVhUoXd7Q1fT/4rpgv7PajaE=', null, null, null, null, '0', '2018-05-31 07:04:10.761875', '/static/pics/default/default.jpg');
INSERT INTO `myadmin_users` VALUES ('892', '555', 'pbkdf2_sha256$36000$47H4oKXnuKmZ$FqvP+ppJor0Zk2TwebRZUtub5DgA9qc9CaJVvahlu/A=', null, null, null, null, '0', '2018-05-31 11:15:11.657061', '/static/pics/default/default.jpg');
INSERT INTO `myadmin_users` VALUES ('893', '666', 'pbkdf2_sha256$36000$zcykRuJnrrnY$JxRead2447bvnzuira9doDv4E05YLiJNri9folpYGSY=', null, null, null, null, '0', '2018-05-31 11:17:26.821724', '/static/pics/default/default.jpg');
INSERT INTO `myadmin_users` VALUES ('894', '888', 'pbkdf2_sha256$36000$BAdrC8Iv7cC4$HucDJi9ZQVmcD7+jA/7QuwSe1Q8BYrdZidpQa3YglFA=', '111@qq.com', '123456', '女', '22', '0', '2018-05-31 12:07:41.519912', '/static/pics/1527768438.92323123534.png');
