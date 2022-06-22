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

/*Table structure for table `endtime` */

DROP TABLE IF EXISTS `endtime`;

CREATE TABLE `endtime` (
  `id` int NOT NULL,
  `endtime` timestamp NULL DEFAULT NULL COMMENT '截至时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `endtime` */

/*Table structure for table `intention` */

DROP TABLE IF EXISTS `intention`;

CREATE TABLE `intention` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `teacher_id` int DEFAULT NULL,
  `sequence` int DEFAULT NULL COMMENT '志愿顺序',
  PRIMARY KEY (`id`),
  KEY `sequence` (`sequence`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `intention` */

insert  into `intention`(`id`,`student_id`,`teacher_id`,`sequence`) values 
(15,2,100,1),
(16,2,101,2),
(17,2,102,3),
(18,2,103,4),
(19,2,104,5);

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
(2,'1','但我想把过去介绍给你看，四百万朵玫瑰',0),
(3,'4','都浓缩成了一句话',0),
(4,'2','我的手随时可以给你暖手\r\n\r\n讨厌的男人来纠缠你 我来扮你男友\r\n\r\n我的烟盒空了但刚好你那还有\r\n\r\n若不爱细烟你会把小店最后的利群买走',0),
(5,'4','我把所有想说的话用文字开始积累\r\n\r\n你不懂我多年伤悲是怎么望穿秋水',0),
(6,'2','每当我拉上窗帘关上房间照明的灯\r\n\r\n每当我看到凌晨五点墙上挂着的钟',0),
(7,'3','能抚慰我 拥抱吗 吻醒她',0),
(8,'4','最后的电影结束散场还不想走\r\n\r\n我了解你也了解我就等我开口\r\n\r\n干了这最后一杯 你说你不想回去\r\n\r\n又干了一杯 对面的男人觉得今晚我有戏',0),
(9,'2','每当我看到花瓣脱离花蕊慢慢枯萎',0),
(10,'3','我的时间很宝贵',0),
(11,'5','你说我们星座不相配 相处会争锋相对 在一起纯属是浪费 你的下场会很狼狈 那为什么还要相会 缘分搞错了方位 怪我放下了防备只想跟你相依相偎 一堆莫名其妙的理由来推掉我邀请 你不在我身边的时候寂寞的快要命 给你送过的礼物你从来都不会感激 就算我把月亮摘下来也不会有转机',0),
(12,'1','你看到的世界其实就是你自己的样子。',0),
(13,'5','我动了离开你的念头。不是因为你不好，也不是因为不爱了。而是你对我的态度，让我觉得你的世界并不缺我。其实我可以厚着脸皮再纠缠你，但再也没任何意义。明知道没有结果的事，苦苦纠缠，威逼利诱，相爱相杀，最后一定都不会有好结果。” 谁也不是谁的唯一',0),
(14,'2','我知道我存在 是因为你把我想象出来。我高大是因为你觉得我 高大，我干净是因为你 用好眼睛，用干净的目光看我。你的思想让我变得 智慧，在你简单的 温柔里，我也简单 而善良。但是假如你忘记我 我将无人知晓地 死去',0),
(15,'3','之崛起而读书',0),
(100,NULL,'但我想把过去介绍给你看',0);

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
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `sys_user` */

insert  into `sys_user`(`id`,`username`,`password`,`nickname`,`email`,`phone`,`address`,`create_time`,`avatar_url`,`role`) values 
(1,'admin','admin','管理员','admin@qq.com','8208208820','北京','2022-04-29 00:20:23',NULL,'ROLE_ADMIN'),
(2,'王慧','123','小王','9104390@qq.com','15469387569','北京','2022-04-29 12:09:45',NULL,'学生'),
(3,'黄文宇','123','小黄','934859@qq.com','15893750387','浙江省杭州市','2022-04-29 12:11:08','cccccc','学生'),
(4,'吴彦祖','123','吴彦祖','129489281354','14234','41234123','2022-06-18 03:00:00',NULL,'学生'),
(5,'周恩来','123','周恩来','124474663@qq.com','请问切勿','中山','2022-06-18 03:06:50',NULL,'学生'),
(6,'毛泽东','123','毛泽东','12343','12341','41234123412','2022-06-18 05:34:55',NULL,'学生'),
(7,'陈独秀','123','陈独秀','412315','123','还是发货地阿苏','2022-06-18 03:03:18',NULL,'学生'),
(8,'方向','123456','向儿','845723458@qq.com','164723748932','浙江省某某时','2022-05-10 11:41:59',NULL,'学生'),
(9,'温庭筠','123456','雯雯','71364781@qq.com','889238499','绍兴市','2022-05-10 11:42:58',NULL,'学生'),
(10,'李白','123456','诗仙','1839278@qq.com','920920920','青莲城','2022-05-10 11:44:37',NULL,'学生'),
(11,'可琛','123','珂珂','192@163.com','124678236487','浙江省杭州市上城去','2022-05-11 08:22:30',NULL,'学生'),
(12,'123','123',NULL,NULL,NULL,NULL,'2022-06-07 08:56:50',NULL,'学生'),
(13,'1234','123',NULL,NULL,NULL,NULL,'2022-06-07 08:57:24',NULL,'学生'),
(14,'2134','123','3214123','12351345','134524','5134513432人','2022-06-07 11:25:22',NULL,'学生'),
(15,'陈发','123',' FWE ','我恶法',' 网飞W',' 网飞','2022-06-07 11:25:57',NULL,'学生'),
(100,'马克思','123','马克思','6327456732','1234','1234','2022-06-21 15:56:30',NULL,'老师'),
(101,'恩格斯','123','恩格斯',NULL,NULL,NULL,'2022-06-22 00:45:10',NULL,'老师'),
(102,'道格拉斯','123','道格拉斯',NULL,NULL,NULL,'2022-06-22 00:45:43',NULL,'老师'),
(103,'马冬梅','123','马冬梅',NULL,NULL,NULL,'2022-06-22 00:46:04',NULL,'老师'),
(104,'孙红雷','123','孙红雷',NULL,NULL,NULL,'2022-06-22 00:46:13',NULL,'老师'),
(105,'陈冠希','123','陈冠希',NULL,NULL,NULL,'2022-06-22 00:46:24',NULL,'老师'),
(106,'蔡徐坤','123','蔡徐坤',NULL,NULL,NULL,'2022-06-22 00:46:33',NULL,'老师'),
(107,'宋祖儿','123','宋祖儿',NULL,NULL,NULL,'2022-06-22 00:46:40',NULL,'老师'),
(108,'王祖贤','123','王祖贤',NULL,NULL,NULL,'2022-06-22 00:46:46',NULL,'老师'),
(109,'李嘉欣','123','李嘉欣',NULL,NULL,NULL,'2022-06-22 00:46:53',NULL,'老师'),
(110,'林青霞','123','林青霞',NULL,NULL,NULL,'2022-06-22 00:47:06',NULL,'老师');

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
(100,'讲师',223749,0,'14234','但我想把过去介绍给你看'),
(101,'副教授',996,0,'为中华','之崛起而读书'),
(102,'讲师',2,0,'巴拉巴拉','自我介绍很累'),
(103,'教授',7,0,'大楚兴','陈胜王'),
(104,'教授',1,0,'虽然','她送了我'),
(105,'教授',3,0,'但是','我昨晚'),
(106,'副教授',4,0,'你要','相信我'),
(107,'副教授',5,0,'给你','买口红'),
(108,'副教授',2,0,'给你','赔罪吧'),
(109,'副教授',3,0,'几人份','的畅谈'),
(110,'教授',3,0,'到三两句','晚安');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
