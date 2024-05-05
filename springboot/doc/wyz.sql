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

/*Table structure for table `deadline` */

DROP TABLE IF EXISTS `deadline`;

CREATE TABLE `deadline` (
  `id` int NOT NULL AUTO_INCREMENT,
  `start_time` datetime NOT NULL COMMENT '志愿填报开始时间',
  `end_time` datetime NOT NULL COMMENT '志愿填报结束时间',
  `is_active` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否当前激活的配置',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '时间配置描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `deadline` */

insert  into `deadline`(`id`,`start_time`,`end_time`,`is_active`,`description`) values 
(1,'2024-04-18 16:00:00','2023-04-28 07:32:10',0,'学生补充志愿时间'),
(6,'2024-04-09 08:00:00','2026-06-30 08:00:00',1,'学生填写志愿时间');

/*Table structure for table `file` */

DROP TABLE IF EXISTS `file`;

CREATE TABLE `file` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `type` varchar(64) DEFAULT NULL,
  `size` bigint DEFAULT NULL,
  `url` varchar(1024) NOT NULL,
  `md5` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `md5_UNIQUE` (`md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `file` */

/*Table structure for table `intention` */

DROP TABLE IF EXISTS `intention`;

CREATE TABLE `intention` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `teacher_id` int DEFAULT NULL,
  `sequence` int DEFAULT NULL COMMENT '志愿顺序',
  PRIMARY KEY (`id`),
  KEY `sequence` (`sequence`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `intention` */

insert  into `intention`(`id`,`student_id`,`teacher_id`,`sequence`) values 
(93,4,100,2);

/*Table structure for table `notice` */

DROP TABLE IF EXISTS `notice`;

CREATE TABLE `notice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发布时间',
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发布人',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '封面',
  `type` int DEFAULT NULL COMMENT '1-简单的公告，2富文本',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `notice` */

insert  into `notice`(`id`,`name`,`content`,`time`,`user`,`img`,`type`) values 
(14,'娃娃房','<p>啥地方的</p>','2024-04-06 21:52:56','管理员','http://localhost:9090/file/df73c877-ff9f-48f4-82b3-a7c82f224dc5.jpg',2),
(19,'娃娃房','<p>啥地方</p>','2024-04-06 21:52:56','管理员','http://localhost:9090/file/df73c877-ff9f-48f4-82b3-a7c82f224dc5.jpg',2),
(20,'娃娃房','<p>啥地方</p>','2024-04-06 21:52:56','管理员','http://localhost:9090/file/df73c877-ff9f-48f4-82b3-a7c82f224dc5.jpg',2),
(21,'娃娃房','<p>啥地方</p>','2024-04-06 21:52:56','管理员','http://localhost:9090/file/df73c877-ff9f-48f4-82b3-a7c82f224dc5.jpg',2),
(22,'娃娃房','<p>啥地方</p>','2024-04-06 21:52:56','管理员','http://localhost:9090/file/df73c877-ff9f-48f4-82b3-a7c82f224dc5.jpg',2),
(23,'娃娃房','<p>啥地方</p>','2024-04-06 21:52:56','管理员','http://localhost:9090/file/df73c877-ff9f-48f4-82b3-a7c82f224dc5.jpg',2);

/*Table structure for table `period` */

DROP TABLE IF EXISTS `period`;

CREATE TABLE `period` (
  `period_id` int NOT NULL AUTO_INCREMENT,
  `first_period` datetime NOT NULL COMMENT '第一志愿开始判断时间',
  `second_period` datetime NOT NULL COMMENT '第二志愿开始判断时间',
  `third_period` datetime NOT NULL COMMENT '第三志愿开始判断时间',
  `end_time` datetime NOT NULL COMMENT '截止时间',
  `is_active` tinyint(1) NOT NULL DEFAULT '0' COMMENT '当前记录是否激活，0为未激活，1为激活',
  `description` varchar(255) DEFAULT NULL COMMENT '时间周期配置描述',
  PRIMARY KEY (`period_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `period` */

insert  into `period`(`period_id`,`first_period`,`second_period`,`third_period`,`end_time`,`is_active`,`description`) values 
(1,'2024-04-20 08:39:31','2024-04-25 16:00:00','2024-04-29 16:00:00','2024-04-25 16:19:16',0,'老师判断截止时间'),
(2,'2024-04-17 16:00:00','2024-04-20 10:57:55','2026-04-29 16:00:00','2024-04-25 16:19:11',0,'第二志愿测试'),
(3,'2024-04-10 16:00:00','2024-04-18 16:00:00','2024-04-20 10:58:28','2024-06-30 00:20:42',1,'第三志愿测试'),
(4,'2024-04-14 16:00:00','2024-04-15 16:00:00','2024-04-16 16:00:00','2024-04-22 08:31:50',0,'截止时间测试');

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `id` int NOT NULL,
  `gpa` decimal(10,2) unsigned DEFAULT NULL COMMENT '绩点',
  `introduction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '自我介绍',
  `teacher_id` int DEFAULT '0' COMMENT '导师id',
  `clazz` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '班级',
  `major` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '专业',
  PRIMARY KEY (`id`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `student` */

insert  into `student`(`id`,`gpa`,`introduction`,`teacher_id`,`clazz`,`major`) values 
(2,'3.28','我是一个热情开朗的女生，随和，自信，乐于助人，有责任心。',100,'计师2001','计算机科学与技术'),
(3,'4.10','我是个有想象力的人，对什么都很好奇。',100,'计师2001','计算机科学与技术'),
(4,'4.35','我求知欲较强，尤其喜欢历史、文学、人文地理等学科。',105,'计师2001','计算机科学与技术'),
(5,'3.87','我深深迷恋古人所说的读万卷书，行万里路。因此我一爱看书，二爱旅行。',102,'计师2001','计算机科学与技术'),
(6,'3.57','我对生活充满希望，因为我始终相信只要自己不放弃，我的这一生一定会活得有意义的。',102,'计师2001','计算机科学与技术'),
(7,'4.03','我的生活非常充实，我学习很努力，其中多次拿了学校的奖学金。',102,'计师2001','计算机科学与技术'),
(8,'4.00','大学不但让我学会了如何思考，学习的方法，还让我看到了实践的重要性。',102,'计师2001','计算机科学与技术'),
(9,'3.88','我的一大特长爱好是设计，我积极地参加各种活动和设计大赛，曾在科技文化节中荣获节徽设计大赛二等奖。',102,'计师2001','计算机科学与技术'),
(10,'2.67','我努力提升自我素质，全面锻炼自己，扎实完成自己的学习任务。',102,'计师2001','计算机科学与技术'),
(11,'3.66','我经过自己的不懈努力连续三年获得校\"二等\"学习奖学金，\"优秀学生干部\"，\"优秀大学生\"等荣誉。',102,'计师2001','计算机科学与技术'),
(12,'2.94','我坚信兴趣是最好的老师，不管今后在学业或科研上遇到什么困难，都要想尽办法克服。',102,'计师2001','计算机科学与技术'),
(13,'3.45','我希望通过专业系统的学习，能够用自己所学的知识去解决实际问题，做出好成绩。',101,'计师2001','计算机科学与技术'),
(14,'3.56','我已对我的学习做好了规划，我已经让自己做好了全面的准备。',102,'计师2001','计算机科学与技术'),
(15,'3.22','我的大学生活让我学到了很多，很多的实践让我从从各个方面提高了自己。',102,'计师2001','计算机科学与技术'),
(16,'2.45','我热爱计算机，希望未来能在计算机领域有所成就。',103,'计师2001','计算机科学与技术'),
(17,'3.64','我现在是卓越教师班的学生，希望未来能成为一名卓越的老师，一直为此努力。',102,'计师2001','计算机科学与技术'),
(18,'3.69','支教是我的梦想，我从高中开始就不放过每一个能接触支教的机会，未来我一定要去支教。',102,'计师2001','计算机科学与技术'),
(19,'3.78','敲代码对我来说是件快乐的事，我闲着没事就会去看看代码。',103,'计师2001','计算机科学与技术'),
(20,'3.26','我善于交际，善于管理，现任本班班长和团学负责人，有一定的组织能力。',102,'计师2001','计算机科学与技术'),
(21,'3.68','作为大一新生，我目前正在计算机科学与技术专业中探索我的学术路径。我已经开始对编程基础和软件开发产生了浓厚兴趣，并计划专注于学习编程语言和数据结构。我的目标是到本科结束时，能够熟练掌握C++和Java，并参与至少一个大型编程项目。',0,'计师2001','计算机科学与技术'),
(22,'4.32','自高中以来，我对计算机的兴趣日益浓厚，特别是在软件工程方面。在本科的学习期间，我期望能够在我的导师的指导下，完成一个关于软件开发最佳实践的研究项目，并希望能够获得相关实习的机会，以便更好地准备我的职业生涯。',0,'计师2001','计算机科学与技术'),
(23,'3.92','我是一名充满梦想的大一学生，对人工智能，尤其是机器学习和自然语言处理领域保持着强烈的兴趣。在本科期间，我希望能加入实验室，并在这些领域内取得实质性的研究成果。我相信技术可以改变世界，并希望将来能在这方面做出我的贡献。',0,'计师2001','计算机科学与技术'),
(24,'4.58','计算机科学领域的复杂问题吸引了我，特别是在算法和数据库管理系统中。大学的这几年，我打算通过课程学习和参与研究项目来提高自己解决这些问题的能力，并希望在未来能在学术界或工业界做出贡献。',0,'计师2001','计算机科学与技术'),
(25,NULL,NULL,0,NULL,NULL),
(26,NULL,NULL,0,NULL,NULL),
(27,NULL,NULL,0,NULL,NULL),
(28,NULL,NULL,0,NULL,NULL),
(29,NULL,NULL,0,NULL,NULL),
(30,'4.17','作为一位渴望学习的计算机科学与技术专业学生，我对网络安全和密码学有旺盛的兴趣。今后四年，我计划参与到更多的网络安全部署项目，蓄力成为这一领域内的专家。',0,'计师2001','计算机科学与技术'),
(31,NULL,NULL,0,NULL,NULL),
(32,NULL,NULL,0,NULL,NULL),
(33,NULL,NULL,0,NULL,NULL),
(34,NULL,NULL,0,NULL,NULL),
(35,NULL,NULL,0,NULL,NULL),
(36,NULL,NULL,0,NULL,NULL),
(37,NULL,NULL,0,NULL,NULL),
(38,NULL,NULL,0,NULL,NULL),
(39,NULL,NULL,0,NULL,NULL),
(40,NULL,NULL,0,NULL,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `sys_user` */

insert  into `sys_user`(`id`,`username`,`password`,`nickname`,`email`,`phone`,`address`,`create_time`,`avatar_url`,`role`) values 
(1,'admin','admin','管理员','admin@qq.com','8208208820','北京海淀区','2022-04-29 00:20:23',NULL,'admin'),
(2,'202005720429','123','王慧','9104390@qq.com','15469387569','北京','2022-04-29 12:09:45',NULL,'学生'),
(3,'黄文宇','123','黄文宇','934859@qq.com','15893750387','浙江省杭州市','2022-04-29 12:11:08','cccccc','学生'),
(4,'吴彦祖','123','吴彦祖','12948928135@163.com','13346523780','上海','2022-06-18 03:00:00',NULL,'学生'),
(5,'张伟','123','张伟','124474663@qq.com','13522557890','中山市','2022-06-18 03:06:50',NULL,'学生'),
(6,'王芳','123','王芳','12343475@qq.com','13526793567','浙江省绍兴市','2022-06-18 05:34:55',NULL,'学生'),
(7,'李伟','123','李伟','412315782@qq.com','18834516890','江苏省南京市','2022-06-18 03:03:18',NULL,'学生'),
(8,'李娜','123456','李娜','845723458@qq.com','16472374893','浙江省台州市','2022-05-10 11:41:59',NULL,'学生'),
(9,'刘伟','123456','刘伟','71364781@qq.com','18892384992','绍兴市','2022-05-10 11:42:58',NULL,'学生'),
(10,'王丽','123456','王丽','1839278@qq.com','19209209203','青莲城','2022-05-10 11:44:37',NULL,'学生'),
(11,'李强','123','李强','19223790@163.com','12467823648','浙江省杭州市上城区','2022-05-11 08:22:30',NULL,'学生'),
(12,'刘洋','123','刘洋','278345890@qq.com','17829345901','深圳','2022-06-07 08:56:50',NULL,'学生'),
(13,'李杰','123','李杰','23514789@qq.com','17249394902','云南','2022-06-07 08:57:24',NULL,'学生'),
(14,'张艳','123','张艳','12351345@163.com','13672839406','四川','2022-06-07 11:25:22',NULL,'学生'),
(15,'刘杰','123','刘杰','12568925@qq.com','17345287639','山东','2022-06-07 11:25:57',NULL,'学生'),
(16,'李鹏','123','李鹏','275390462@qq.com','13725482024','浙江省金华市','2022-06-23 14:32:25',NULL,'学生'),
(17,'张平','123','张平','2735976290@qq.com','16359362749','安徽省合肥市','2022-06-23 14:32:26',NULL,'学生'),
(18,'张宇','123','张宇','2643875290@qq.com','13692745382','江苏省无锡市','2022-06-23 14:32:27',NULL,'学生'),
(19,'王浩','123','王浩','4372819357@qq.com','13942629324','江苏省苏州市','2022-06-23 14:32:29',NULL,'学生'),
(20,'王凯','123','王凯','2635925189@qq.com','18304735272','上海市','2022-06-23 14:32:34',NULL,'学生'),
(21,'100021','123','李明','liming21@school.com','0210000021','地址1','2024-05-02 07:49:44',NULL,'学生'),
(22,'100022','123','王艳','wangyan22@school.com','0220000022','地址2','2024-05-02 07:49:44',NULL,'学生'),
(23,'100023','123','张伟','zhangwei23@school.com','0230000023','地址3','2024-05-02 07:49:44',NULL,'学生'),
(24,'100024','123','刘强','liuqiang24@school.com','0240000024','地址4','2024-05-02 07:49:44',NULL,'学生'),
(25,'100025','123','陈芳','chenfang25@school.com','0250000025','地址5','2024-05-02 07:49:44',NULL,'学生'),
(26,'100026','123','杨洋','yangyang26@school.com','0260000026','地址6','2024-05-02 07:49:44',NULL,'学生'),
(27,'100027','123','赵静','zhaojing27@school.com','0270000027','地址7','2024-05-02 07:49:44',NULL,'学生'),
(28,'100028','123','黄旭','huangxu28@school.com','0280000028','地址8','2024-05-02 07:49:44',NULL,'学生'),
(29,'100029','123','周杰','zhoujie29@school.com','0290000029','地址9','2024-05-02 07:49:44',NULL,'学生'),
(30,'100030','123','吴磊','wulei30@school.com','0300000030','地址10','2024-05-02 07:49:44',NULL,'学生'),
(31,'100031','123','郑刚','zhenggang31@school.com','0310000031','地址11','2024-05-02 07:49:44',NULL,'学生'),
(32,'100032','123','孙悦','sunyue32@school.com','0320000032','地址12','2024-05-02 07:49:44',NULL,'学生'),
(33,'100033','123','李冬','lidong33@school.com','0330000033','地址13','2024-05-02 07:49:44',NULL,'学生'),
(34,'100034','123','许晴','xuqing34@school.com','0340000034','地址14','2024-05-02 07:49:44',NULL,'学生'),
(35,'100035','123','陈雷','chenlei35@school.com','0350000035','地址15','2024-05-02 07:49:44',NULL,'学生'),
(36,'100036','123','罗盛','luosheng36@school.com','0360000036','地址16','2024-05-02 07:49:44',NULL,'学生'),
(37,'100037','123','黄美','huangmei37@school.com','0370000037','地址17','2024-05-02 07:49:44',NULL,'学生'),
(38,'100038','123','曹磊','caolei38@school.com','0380000038','地址18','2024-05-02 07:49:44',NULL,'学生'),
(39,'100039','123','姜亮','jiangliang39@school.com','0390000039','地址19','2024-05-02 07:49:44',NULL,'学生'),
(40,'100040','123','汤淼','tangmiao40@school.com','0400000040','地址20','2024-05-02 07:49:44',NULL,'学生'),
(100,'232323','123','闻立鹏','6327456732@163.com','13749372625','浙江省杭州市','2022-06-21 15:56:30',NULL,'老师'),
(101,'郑强','123','郑强','237492716@qq.com','18294728402','杭州市','2022-06-22 00:45:10',NULL,'老师'),
(102,'朱勇','123','朱勇','2735482917@qq.com','17294728201','浙江省杭州市','2022-06-22 00:45:43',NULL,'老师'),
(103,'沈斌','123','沈斌','2762364829@163.com','17392746292','浙江省绍兴市','2022-06-22 00:46:04',NULL,'老师'),
(104,'冯涛','123','冯涛','28374629274@163.com','17392746284','浙江省台州市','2022-06-22 00:46:13',NULL,'老师'),
(105,'朱晓芸','朱晓芸','朱晓芸','27352846274@163.com','18292745274','浙江省温州市','2022-06-22 00:46:24',NULL,'老师'),
(106,'200106','123','李雪峰','lixuefeng@school.com','1500000106','教师办公室106','2024-05-02 07:54:26',NULL,'老师'),
(107,'200107','123','张小刚','zhangxiaogang@school.com','1500000107','教师办公室107','2024-05-02 07:54:26',NULL,'老师'),
(108,'200108','123','王红雷','wanghonglei@school.com','1500000108','教师办公室108','2024-05-02 07:54:26',NULL,'老师'),
(109,'200109','123','赵金花','zhaojinhua@school.com','1500000109','教师办公室109','2024-05-02 07:54:26',NULL,'老师'),
(110,'200110','123','陈思思','chensisi@school.com','1500000110','教师办公室110','2024-05-02 07:54:26',NULL,'老师'),
(111,'200111','123','吴天明','wutianming@school.com','1500000111','教师办公室111','2024-05-02 07:54:26',NULL,'老师'),
(112,'200112','123','林小川','linxiaochuan@school.com','1500000112','教师办公室112','2024-05-02 07:54:26',NULL,'老师'),
(113,'200113','123','何星云','hexingyun@school.com','1500000113','教师办公室113','2024-05-02 07:54:26',NULL,'老师'),
(114,'200114','123','苏明哲','sumingzhe@school.com','1500000114','教师办公室114','2024-05-02 07:54:26',NULL,'老师'),
(115,'200115','123','黄大翔','huangdaxiang@school.com','1500000115','教师办公室115','2024-05-02 07:54:26',NULL,'老师');

/*Table structure for table `teacher` */

DROP TABLE IF EXISTS `teacher`;

CREATE TABLE `teacher` (
  `id` int NOT NULL,
  `title` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '职称',
  `enrollment` int DEFAULT NULL COMMENT '招生人数',
  `requirement` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '要求',
  `introduction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '自我介绍',
  PRIMARY KEY (`id`),
  CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `teacher` */

insert  into `teacher`(`id`,`title`,`enrollment`,`requirement`,`introduction`) values 
(100,'讲师',2,'熟悉深度学习理论','于2008年取得英国计算机科学博士学位，发表多篇期刊和会议文章。现指导多名研究生从事计算机科学、教育技术学和神经科学等方面的教学和研究工作。'),
(101,'副教授',3,'负责任，擅长计算机知识','已入选浙江省高校中青年学科带头人、浙江省151人才工程和浙江工业大学青年英才支持计划。'),
(102,'讲师',2,'有进取心，乐于助人，有管理能力','致力于特殊教育信息化和职业教育信息化，重点开展职业院校智慧教育和孤独症儿童早期干预研究。'),
(103,'教授',3,'在计算机领域有所成就，可以潜下心来敲代码','在国内权威期刊发表学术论文，研究成果获得浙江省科学技术进步奖和浙江省高校科研成果奖。'),
(104,'教授',3,'有组织能力','主持浙江省高校课堂教学改革项目1项，承担6门教育技术学专业本科生和研究生骨干课程的教学任务。'),
(105,'教授',5,'有想象力，有求知欲','主持1项省教科规划课题、参编教材1本，2011年获浙江省委省政府颁发的“优秀科技特派员”称号。'),
(106,'讲师',5,'具有良好的学习习惯和团队合作精神。','我是计算机科学专业的讲师，主要研究人工智能领域，希望能培养出在此领域有所作为的研究生。'),
(107,'副教授',4,'希望学生有扎实的计算机专业基础。','拥有丰富的教学经验，长期从事教育技术学的研究和教学工作，期待与学生共同进步。'),
(108,'讲师',3,'要求学生自觉性强，有独立研究能力。','作为软件工程的专家，我在行业内有着多年的研究与应用经验，愿意指导具壮大志向的学生。'),
(109,'教授',6,'期待学生能在算法竞赛中有所表现。','作为多个重要项目的负责人，研究方向包括大数据分析与处理。我希望能引导学生走向科研前沿。'),
(110,'讲师',3,'要学生有创新思维，能够迎接挑战。','在教育技术学方面有着深厚的研究，期待招收对技术和教育同样热爱的学生。'),
(111,'教授',7,'学生需要有一定的项目开发经验。','教授多门课程，并指导了多个成功的研究项目，乐于与学生一起探索计算机视觉领域。'),
(112,'副教授',4,'学生应具备较强的逻辑思维和学术研究能力。','专注于数字学习和智慧教育研究，希望能够和冲刺顶会的学生一起进步。'),
(113,'讲师',3,'要求学生成绩优异，品学兼优。','有多篇论文发表在知名期刊，积极参与学术交流，并致力于社会计算研究。'),
(114,'教授',8,'需要学生对教育技术学有浓厚的兴趣。','我的兴趣集中在交互式学习技术，欢迎对此领域感兴趣的同学加入研究团队。'),
(115,'副教授',5,'希望招收对数据分析有深刻理解的学生。','专长于网络安全，指导多名本科生获得国家级奖项，希望引导优秀学生在这一领域深造。');

/* Trigger structure for table `student` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `ClearIntentionAfterAssignment` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `ClearIntentionAfterAssignment` AFTER UPDATE ON `student` FOR EACH ROW BEGIN
    IF NEW.teacher_id <> 0 AND OLD.teacher_id = 0 THEN
        DELETE FROM intention WHERE student_id = NEW.id;
    END IF;
END */$$


DELIMITER ;

/* Trigger structure for table `sys_user` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `add_empty_user_info` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `add_empty_user_info` AFTER INSERT ON `sys_user` FOR EACH ROW begin
if(new.role='学生')
then
insert into student(id) values(new.id);
elseif (new.role='老师')
then
insert into teacher(id) values(new.id);
end if;
end */$$


DELIMITER ;

/*!50106 set global event_scheduler = 1*/;

/* Event structure for event `fp` */

/*!50106 DROP EVENT IF EXISTS `fp`*/;

DELIMITER $$

/*!50106 CREATE DEFINER=`root`@`localhost` EVENT `fp` ON SCHEDULE AT '2022-06-27 20:47:49' ON COMPLETION PRESERVE ENABLE DO BEGIN
	    call student_assign;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `student_assign` */

/*!50003 DROP PROCEDURE IF EXISTS  `student_assign` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `student_assign`()
BEGIN
DECLARE teacherId INT;
        DECLARE studentId INT;
        DECLARE studentNum INT;
        DECLARE i INT;
        SET i=0;
        SELECT COUNT(*) INTO studentNum
        FROM student s
        WHERE s.teacher_id = 0;
        WHILE
         i < studentNum DO
            SELECT s.id INTO studentId FROM student s WHERE s.teacher_id = 0 LIMIT 1;
            SELECT t.id INTO teacherId FROM teacher t WHERE t.enrollment-(SELECT COUNT(*) FROM student WHERE teacher_id=t.id)>0 LIMIT 1;
            UPDATE student SET student.teacher_id = teacherId WHERE student.id = studentId;
            
            SET i = i + 1;
      END WHILE;
    END */$$
DELIMITER ;

/*Table structure for table `mutual_selection_result` */

DROP TABLE IF EXISTS `mutual_selection_result`;

/*!50001 DROP VIEW IF EXISTS `mutual_selection_result` */;
/*!50001 DROP TABLE IF EXISTS `mutual_selection_result` */;

/*!50001 CREATE TABLE  `mutual_selection_result`(
 `id` int ,
 `username` varchar(50) ,
 `nickname` varchar(50) ,
 `teacher_id` int 
)*/;

/*Table structure for table `result` */

DROP TABLE IF EXISTS `result`;

/*!50001 DROP VIEW IF EXISTS `result` */;
/*!50001 DROP TABLE IF EXISTS `result` */;

/*!50001 CREATE TABLE  `result`(
 `学号` varchar(50) ,
 `姓名` varchar(50) ,
 `导师姓名` varchar(50) ,
 `导师邮箱` varchar(50) 
)*/;

/*View structure for view mutual_selection_result */

/*!50001 DROP TABLE IF EXISTS `mutual_selection_result` */;
/*!50001 DROP VIEW IF EXISTS `mutual_selection_result` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mutual_selection_result` AS select `sy`.`id` AS `id`,`sy`.`username` AS `username`,`sy`.`nickname` AS `nickname`,`st`.`teacher_id` AS `teacher_id` from (`sys_user` `sy` join `student` `st` on((`sy`.`id` = `st`.`id`))) where (`sy`.`role` = '学生') */;

/*View structure for view result */

/*!50001 DROP TABLE IF EXISTS `result` */;
/*!50001 DROP VIEW IF EXISTS `result` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `result` AS select `r`.`username` AS `学号`,`r`.`nickname` AS `姓名`,`s`.`nickname` AS `导师姓名`,`s`.`email` AS `导师邮箱` from (`mutual_selection_result` `r` join `sys_user` `s`) where (`s`.`id` = `r`.`teacher_id`) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
