/*
SQLyog Ultimate v12.14 (64 bit)
MySQL - 8.0.27 : Database - wyz
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`wyz` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `wyz`;

/*Table structure for table `intention` */

DROP TABLE IF EXISTS `intention`;

CREATE TABLE `intention` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `teacher_id` int NOT NULL,
  `order` int DEFAULT NULL COMMENT '志愿顺序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `intention` */

insert  into `intention`(`id`,`student_id`,`teacher_id`,`order`) values 
(1,2,5,1),
(2,2,6,2),
(3,2,7,3),
(4,3,8,1);

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `id` int NOT NULL,
  `gpa` decimal(10,0) unsigned DEFAULT NULL COMMENT '绩点',
  `introduction` text COLLATE utf8mb4_unicode_ci COMMENT '自我介绍',
  `teacher_id` int DEFAULT '0' COMMENT '导师id',
  PRIMARY KEY (`id`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `student` */

insert  into `student`(`id`,`gpa`,`introduction`,`teacher_id`) values 
(2,'1','但我想把过去',0),
(3,'3','自我介绍很累',0),
(4,'2',NULL,0),
(5,'3','之崛起而读书',0),
(9,'4',NULL,0),
(10,'3','我的时间很宝贵',0),
(11,'5',NULL,0),
(12,'2',NULL,0),
(13,'2',NULL,0),
(14,'2',NULL,0),
(15,'2',NULL,0);

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '昵称',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地址',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `sys_user` */

insert  into `sys_user`(`id`,`username`,`password`,`nickname`,`email`,`phone`,`address`,`create_time`,`avatar_url`,`role`) values 
(1,'admin','admin','管理员','admin@qq.com','8208208820','北京','2022-04-29 00:20:23',NULL,'ROLE_ADMIN'),
(2,'王慧','123','小王','9104390@qq.com','15469387569','北京','2022-04-29 12:09:45',NULL,'学生'),
(3,'黄文宇','123','小黄','934859@qq.com','15893750387','浙江省杭州市','2022-04-29 12:11:08','cccccc','学生'),
(4,'吴彦祖','123','吴彦祖','129489281354','14234','41234123','2022-06-18 03:00:00',NULL,'学生'),
(5,'周恩来','123','周恩来','124474663@qq.com','请问切勿','中山','2022-06-18 03:06:50',NULL,'老师'),
(6,'毛泽东','123','毛泽东','12343','12341','41234123412','2022-06-18 05:34:55',NULL,'老师'),
(7,'陈独秀','123','陈独秀',NULL,NULL,NULL,'2022-06-18 03:03:18',NULL,'老师'),
(8,'方向','123456','向儿','845723458@qq.com','164723748932','浙江省某某时','2022-05-10 11:41:59',NULL,'老师'),
(9,'温庭筠','123456','雯雯','71364781@qq.com','889238499','绍兴市','2022-05-10 11:42:58',NULL,'学生'),
(10,'李白','123456','诗仙','1839278@qq.com','920920920','青莲城','2022-05-10 11:44:37',NULL,'学生'),
(11,'可琛','123','珂珂','192@163.com','124678236487','浙江省杭州市上城去','2022-05-11 08:22:30',NULL,'学生'),
(12,'123','123',NULL,NULL,NULL,NULL,'2022-06-07 08:56:50',NULL,'学生'),
(13,'1234','123',NULL,NULL,NULL,NULL,'2022-06-07 08:57:24',NULL,'学生'),
(14,'2134','123','3214123','12351345','134524','5134513432人','2022-06-07 11:25:22',NULL,'学生'),
(15,'发违法','123',' FWE ','我恶法',' 网飞W',' 网飞','2022-06-07 11:25:57',NULL,'学生');

/*Table structure for table `teacher` */

DROP TABLE IF EXISTS `teacher`;

CREATE TABLE `teacher` (
  `id` int NOT NULL,
  `title` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '职称',
  `enrollment` int DEFAULT NULL COMMENT '招生人数',
  `enrolled` int DEFAULT '0' COMMENT '已有学生人数',
  `requirement` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '要求',
  `introduction` text COLLATE utf8mb4_unicode_ci COMMENT '自我介绍',
  PRIMARY KEY (`id`),
  CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `teacher` */

insert  into `teacher`(`id`,`title`,`enrollment`,`enrolled`,`requirement`,`introduction`) values 
(5,'副教授',996,0,'为中华','之崛起而读书'),
(6,'讲师',2,0,'巴拉巴拉','自我介绍很累'),
(7,'教授',7,0,'大楚兴','陈胜王'),
(8,'教授',1,0,'虽然','她送了我');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
