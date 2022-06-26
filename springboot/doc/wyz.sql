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
  `first` timestamp NULL DEFAULT NULL,
  `second` timestamp NULL DEFAULT NULL,
  `third` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `deadline` */

insert  into `deadline`(`id`,`first`,`second`,`third`) values 
(1,'2022-06-28 18:10:19','2022-06-30 18:10:31','2022-07-01 17:10:34');

/*Table structure for table `intention` */

DROP TABLE IF EXISTS `intention`;

CREATE TABLE `intention` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `teacher_id` int DEFAULT NULL,
  `sequence` int DEFAULT NULL COMMENT '志愿顺序',
  PRIMARY KEY (`id`),
  KEY `sequence` (`sequence`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `intention` */

insert  into `intention`(`id`,`student_id`,`teacher_id`,`sequence`) values 
(16,2,101,5),
(17,2,102,2),
(18,2,103,1),
(19,2,104,3),
(20,5,100,1),
(21,5,101,3),
(22,5,104,4),
(23,5,112,2),
(24,7,103,2),
(25,7,104,1),
(26,2,114,4);

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `id` int NOT NULL,
  `gpa` decimal(10,2) unsigned DEFAULT NULL COMMENT '绩点',
  `introduction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '自我介绍',
  `teacher_id` int DEFAULT '0' COMMENT '导师id',
  PRIMARY KEY (`id`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `student` */

insert  into `student`(`id`,`gpa`,`introduction`,`teacher_id`) values 
(2,'3.28','我是一个热情开朗的女生，随和，自信，乐于助人，有责任心。',100),
(3,'4.10','我是个有想象力的人，对什么都很好奇。',100),
(4,'4.35','我求知欲较强，尤其喜欢历史、文学、人文地理等学科。',101),
(5,'3.87','我深深迷恋古人所说的读万卷书，行万里路。因此我一爱看书，二爱旅行。',101),
(6,'3.57','我对生活充满希望，因为我始终相信只要自己不放弃，我的这一生一定会活得有意义的。',101),
(7,'4.03','我的生活非常充实，我学习很努力，其中多次拿了学校的奖学金。',102),
(8,'4.00','大学不但让我学会了如何思考，学习的方法，还让我看到了实践的重要性。',102),
(9,'3.88','我的一大特长爱好是设计，我积极地参加各种活动和设计大赛，曾在科技文化节中荣获节徽设计大赛二等奖。',103),
(10,'2.67','我努力提升自我素质，全面锻炼自己，扎实完成自己的学习任务。',103),
(11,'3.66','我经过自己的不懈努力连续三年获得校\"二等\"学习奖学金，\"优秀学生干部\"，\"优秀大学生\"等荣誉。',103),
(12,'2.94','我坚信兴趣是最好的老师，不管今后在学业或科研上遇到什么困难，都要想尽办法克服。',103),
(13,'3.45','我希望通过专业系统的学习，能够用自己所学的知识去解决实际问题，做出好成绩。',103),
(14,'3.56','我已对我的学习做好了规划，我已经让自己做好了全面的准备。',103),
(15,'3.22','我的大学生活让我学到了很多，很多的实践让我从从各个方面提高了自己。',104),
(16,'2.45','我热爱计算机，希望未来能在计算机领域有所成就。',105),
(17,'3.64','我现在是卓越教师班的学生，希望未来能成为一名卓越的老师，一直为此努力。',105),
(18,'3.69','支教是我的梦想，我从高中开始就不放过每一个能接触支教的机会，未来我一定要去支教。',105),
(19,'3.78','敲代码对我来说是件快乐的事，我闲着没事就会去看看代码。',106),
(20,'3.26','我善于交际，善于管理，现任本班班长和团学负责人，有一定的组织能力。',106);

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
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `sys_user` */

insert  into `sys_user`(`id`,`username`,`password`,`nickname`,`email`,`phone`,`address`,`create_time`,`avatar_url`,`role`) values 
(1,'admin','admin','管理员','admin@qq.com','8208208820','北京','2022-04-29 00:20:23',NULL,'ROLE_ADMIN'),
(2,'王慧','123','王慧','9104390@qq.com','15469387569','北京','2022-04-29 12:09:45',NULL,'学生'),
(3,'黄文宇','123','黄文宇','934859@qq.com','15893750387','浙江省杭州市','2022-04-29 12:11:08','cccccc','学生'),
(4,'吴彦祖','123','吴彦祖','12948928135@163.com','13346523780','上海','2022-06-18 03:00:00',NULL,'学生'),
(5,'张伟','123','张伟','124474663@qq.com','13522557890','中山','2022-06-18 03:06:50',NULL,'学生'),
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
(100,'闻立鹏','123','闻立鹏','6327456732@163.com','13749372625','浙江省杭州市','2022-06-21 15:56:30',NULL,'老师'),
(101,'郑强','123','郑强','237492716@qq.com','18294728402','杭州市','2022-06-22 00:45:10',NULL,'老师'),
(102,'朱勇','123','朱勇','2735482917@qq.com','17294728201','浙江省杭州市','2022-06-22 00:45:43',NULL,'老师'),
(103,'沈斌','123','沈斌','2762364829@163.com','17392746292','浙江省绍兴市','2022-06-22 00:46:04',NULL,'老师'),
(104,'冯涛','123','冯涛','28374629274@163.com','17392746284','浙江省台州市','2022-06-22 00:46:13',NULL,'老师'),
(105,'朱晓芸','123','朱晓芸','27352846274@163.com','18292745274','浙江省温州市','2022-06-22 00:46:24',NULL,'老师'),
(106,'金小刚','123','金小刚','1635382936@qq.com','18392745299','上海市','2022-06-22 00:46:33',NULL,'老师'),
(107,'何利力','123','何利力','1735777377@qq.com','12749927264','浙江省宁波市','2022-06-22 00:46:40',NULL,'老师'),
(108,'孔繁胜','123','孔繁胜','3628346282@qq.com','18392733378','浙江省嘉兴市','2022-06-22 00:46:46',NULL,'老师'),
(109,'林兰芬','123','林兰芬','27362828468@qq.com','17329936252','北京市','2022-06-22 00:46:53',NULL,'老师'),
(110,'唐敏','123','唐敏','2378292647@163.com','16283937266','广州','2022-06-22 00:47:06',NULL,'老师'),
(111,'魏宝刚','123','魏宝刚','3846284628@163.com','17382628322','重庆市','2022-06-23 14:32:12',NULL,'老师'),
(112,'吴春明','123','吴春明','27462743976@163.com','18293847389','四川省成都市','2022-06-23 14:32:14',NULL,'老师'),
(113,'徐从富','123','徐从富','28299383777@qq.com','18393028372','南京市','2022-06-23 14:32:15',NULL,'老师'),
(114,'杨小虎','123','杨小虎','163823654735@qq.com','17349927777','浙江省杭州市','2022-06-23 14:32:16',NULL,'老师');

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
(100,'讲师',2,'人品正直，热爱学习','于2008年取得英国计算机科学博士学位，发表多篇期刊和会议文章。现指导多名研究生从事计算机科学、教育技术学和神经科学等方面的教学和研究工作。'),
(101,'副教授',3,'负责任，擅长计算机知识','已入选浙江省高校中青年学科带头人、浙江省151人才工程和浙江工业大学青年英才支持计划。'),
(102,'讲师',2,'有进取心，乐于助人，有管理能力','致力于特殊教育信息化和职业教育信息化，重点开展职业院校智慧教育和孤独症儿童早期干预研究。'),
(103,'教授',6,'在计算机领域有所成就，可以潜下心来敲代码','在国内权威期刊发表学术论文，研究成果获得浙江省科学技术进步奖和浙江省高校科研成果奖。'),
(104,'教授',1,'有组织能力','主持浙江省高校课堂教学改革项目1项，承担6门教育技术学专业本科生和研究生骨干课程的教学任务。'),
(105,'教授',3,'有想象力，有求知欲','主持1项省教科规划课题、参编教材1本，2011年获浙江省委省政府颁发的“优秀科技特派员”称号。'),
(106,'副教授',4,'有一定的承受能力，有耐心，热爱祖国','连续四届参加校青年教师教学技能比赛，获校优秀奖、院一等奖、二等奖、三等奖各1次。'),
(107,'副教授',5,'动手能力强，有与人合作的能力','曾获浙江工业大学校级优秀教师，浙江工业大学第五届青年教师讲课比赛暨现代教学技能比赛十佳教师。'),
(108,'副教授',2,'表达能力、英语能力高，过英语四六级','在《Journal of Multimedia》等国内外重要学术刊物和国际会议上发表论文10余篇。'),
(109,'副教授',3,'有批判精神和挑战精神','参与完成国家863计划“基于视频素材分析与融合的虚拟场景生成技术与系统”等项目。'),
(110,'教授',3,'愿意从事项目开发，可以完成提供的项目','参加工作以来，指导学生参加各级各类技能竞赛，多次获奖；本人也积极参加各类技能比赛和论文评选。'),
(111,'教授',4,'有扎实基础的专业知识，踏踏实实学习','指导学生第九届浙江省电子商务大赛新网商争霸赛一二三等奖，获2014年杭州市中等职业学校信息化教学大赛一等奖。'),
(112,'副教授',5,'有“带着问题学习”的能力，建立起自己的独特见解','研究方向：进化计算和数据挖掘。参与国家自然科学基金项目3项、浙江省自然科学基金项目3项。'),
(113,'讲师',3,'沟通表达能力卓越，对未来有明确的规划','以第一作者身份发表学术论文共8篇，其中，国际SCI期刊论文4篇，国内一级期刊论文3篇。'),
(114,'副教授',5,'勤奋好学，乐于探索新知识，敢于争取所想要的一切，不怕失败','主要研究方向有：计算机教育应用；智能信息处理；数字化媒体与技术。');

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
