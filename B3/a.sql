-- MySQL dump 10.13  Distrib 5.7.13, for Linux (x86_64)
--
-- Host: localhost    Database: myblog_development
-- ------------------------------------------------------
-- Server version	5.7.13-0ubuntu0.16.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'aa','aaa','2016-08-18 16:16:30','2016-08-18 16:16:30'),(2,'aa','aaa','2016-08-18 16:19:43','2016-08-18 16:19:43'),(3,'admin','admin','2016-08-24 05:36:31','2016-08-24 05:36:31');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ar_internal_metadata`
--

DROP TABLE IF EXISTS `ar_internal_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ar_internal_metadata`
--

LOCK TABLES `ar_internal_metadata` WRITE;
/*!40000 ALTER TABLE `ar_internal_metadata` DISABLE KEYS */;
INSERT INTO `ar_internal_metadata` VALUES ('environment','development','2016-08-16 06:48:56','2016-08-16 06:48:56');
/*!40000 ALTER TABLE `ar_internal_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'编程','2016-08-22 01:11:27','2016-08-22 01:11:27'),(2,'经济','2016-08-22 01:12:19','2016-08-22 01:12:19'),(3,'人生','2016-08-22 01:13:06','2016-08-22 01:13:06'),(4,'哲学','2016-08-22 01:18:01','2016-08-22 01:18:01');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories_posts`
--

DROP TABLE IF EXISTS `categories_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories_posts` (
  `post_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  KEY `index_categories_posts_on_post_id` (`post_id`),
  KEY `index_categories_posts_on_category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories_posts`
--

LOCK TABLES `categories_posts` WRITE;
/*!40000 ALTER TABLE `categories_posts` DISABLE KEYS */;
INSERT INTO `categories_posts` VALUES (20,1),(22,2),(26,1),(28,2),(32,1),(33,1),(35,1),(36,4),(37,3),(38,4),(39,3);
/*!40000 ALTER TABLE `categories_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (35,20,'fddfgddgdfgdfgd','1585754789@qq.com',0,'2016-08-25 11:06:43','2016-08-25 11:06:43'),(36,22,'sadasdasdsadasdasdas','1585754789@qq.com',0,'2016-08-25 11:06:56','2016-08-25 11:06:56'),(38,22,'sdadasdasdsadsadsada','1585754789@qq.com',0,'2016-08-25 11:07:11','2016-08-25 11:07:11'),(39,22,'asdadasdasdsadsa','1585754789@qq.com',0,'2016-08-25 11:07:22','2016-08-25 11:07:22'),(40,26,'dsasdadsadfdgfsddsadas','1585754789@qq.com',0,'2016-08-25 11:07:51','2016-08-25 11:07:51'),(41,26,'asdasdasdasasdwds','1585754789@qq.com',0,'2016-08-25 11:08:04','2016-08-25 11:08:04'),(42,26,'sadsdsfsvfsvvg','1585754789@qq.com',0,'2016-08-25 11:08:11','2016-08-25 11:08:11'),(43,26,'asdasdfvfvfvf','1585754789@qq.com',0,'2016-08-25 11:08:18','2016-08-25 11:08:18'),(44,37,'sadsdadsadad','1585754789@qq.com',0,'2016-08-25 11:56:47','2016-08-25 11:56:47'),(45,37,'csdcsdcdsssdf','1585754789@qq.com',0,'2016-08-25 11:57:01','2016-08-25 11:57:01'),(46,36,'dadasdasdasda','1585754789@qq.com',0,'2016-08-25 11:57:12','2016-08-25 11:57:12'),(47,36,'sccdscdscdscdscds','1585754789@qq.com',0,'2016-08-25 11:57:19','2016-08-25 11:57:19');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `admin_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (20,'sdgahdgakshgdhja','dasdagdjhagdjhsabn candkhjasihdaishd kjashdkjahskdhajkd123124124',NULL,'2016-08-23 10:08:44','2016-08-23 10:08:44'),(22,'萨达','大苏打大叔大叔大叔的安达市',NULL,'2016-08-24 00:33:35','2016-08-24 00:33:35'),(26,'mysql','1. 安装mysql\r\n2. 安装libmysql\r\n    sudo apt-get install libmysql++-dev\r\n \r\n3. 安装mysql适配器\r\n    gem install mysql2 --version=0.2.11\r\n \r\n    * warning: 与ruby on rails 整合的话, mysql2的版本要低于0.3\r\n \r\n4. 编辑database.yml\r\n    development:\r\n        adapter: mysql2\r\n        encoding: utf8\r\n        pool: 5\r\n        database: test\r\n        username: [username]\r\n        password: [password]\r\n        socket: /tmp/mysql.sock\r\n \r\n5. 编辑Gemfile\r\n    添加 gem \'mysql2\'\r\n \r\n6.\r\nsudo rake db:create -v\r\nsudo rake db:migrate\r\n\r\n新建rails框架时 rails new xxx -d mysql\r\n',NULL,'2016-08-24 00:53:31','2016-08-24 00:53:31'),(28,'经济学是使人生幸福的学问','<p>\r\n	在众多推荐书目文章中，看到这篇标题便让我眼睛放光。如若说我沉不下心来读什么经济学原理，只功利地看到“幸福”两个字，也无可厚非，正是这个词让我产生了兴趣。\r\n很有幸拜读了这篇文章，作者梁小民教授用通俗直白的语言，向我们阐述了经济学的概念，以及经济学的作用。\r\n</p>\r\n<p>\r\n	&nbsp; &nbsp; &nbsp; 经济学是什么？\r\n和作者一样，我想先从“是什么”入手，讲讲自己的见解。读完这篇文章最大的收获就是体会到身边处处是经济学，认识到经济学真的不是经济学家才能玩的玄学。为了更加了解作者，我还读了他的著作《经济学是什么》，来辅助行文。\r\n一句话概括，经济学是一门选择的学科。\r\n生活中处处存在选择，不同的选择自然会招致不同的结果，不同的选择也自然带来不同效用，有时短期效用很高的选择未必是最好的选择，这里面的学问考究起来就是经济学家的思考方式。所以存在不同的可能性，会有不同的子目标，就像离散数学中图的结构，经典的邮递员问题。在很多条路可以走的情况下，找一个出发地到目的地的最短路径。在该类问题中有一种解法叫“ 贪心策略 ”，就是将大问题化小问题，每次前进都是保证局部最优。回到经济学中的选择问题上，我们不可能有整个人生的大局观，从头到尾考虑清楚，我们每做一个选择只能知道短期结果，长期的结果还有很多很多情况。然而如果我们每次选择都是基于最短期的最优，那往往得不到最优解，这就是“贪心策略”中“贪心”的原因。所以要学习经济学，学会如何去选择，如何培养长远的目光。就算用贪心策略可也总比最短期的目标没达到最优，长期的也没达到较优的结果好很多。因为最起码我从经济学家的角度去考虑了这个问题，去分析这个选择会带来什么，去努力让得到资源更有效的利用。\r\n说到资源利用，经济学讲的是如何实现最大化目标，人们的收入，国民生产总值这些往往是人们关心的，而这不是经济学所特指的最大化。文章中也提到经济学追求的最大化目标不是一元的，而是多元的。如果为了收入，要牺牲身体健康，这就是值得思考的一个选择，不能一股脑的看向金钱。而最大化目标也并不是只有人类会想得出，这是动物的本能，甚至植物微生物。文章中作者举例野兽捕猎物，蜜蜂造蜂房都是符合最大化规范。而这几天刚好看到一个问题，“为什么水果的种子这么小，果肉却很多？”有个解释是“因为水果需要动物来传播它们的种子，就会让果实生长的更大更好吃，这是一种出于利他的行为，最终也是利己的。”似乎连植物都“懂得”这个道理呢。而这依然只是本能，只是为了求生。人类相比于动植物强在我们可以思考，人类追求最大化靠的是理性而不是本能，这种理性的思考方法催生了经济学的产生。\r\n为什么说经济学是使人幸福的学问呢？\r\n文章标题引自萧伯纳的名言：“经济学是一门使人生幸福的艺术”。\r\n幸福=效用/欲望\r\n这是在梁小民教授著作《经济学是什么》中出现的公式。从这个公式来看，当欲望既定时，效用越大越幸福；当效用既定时，欲望越小越幸福。虽然我们的欲望是无限大的，这个公式似乎失去了意义。但我们从经济学角度去研究幸福的时候，假定欲望是暂时既定的，而且这种假定也不是与现实矛盾的。我们的欲望无限性表现为满足一个欲望后产生新的欲望，所以一个阶段内，欲望是既定的，这样我们追求幸福最大化就是追求效用最大化。效用是什么？效用是人从消费某种物品中所得到的满足程度。一般来说，消费的各种物品越多，所得到的效用也越大。这样，当物品价格既定，收入越多，所能购买的物品越多，实现物品最多化就是实现了收入最大化，也就是实现了我们多元最大化的其中一元。不同的人对幸福的理解不同，可能家庭收入高会让你感到幸福，也可能收入较高或者一般但闲暇时间相对较多也会让你感到幸福。所以这里也存在一个平衡，花时间提高收入，还是花时间闲暇娱乐。没有收入娱乐也不令人满意，没有娱乐，收入又何来意义。而经济学可以帮助我们去学会分析这种问题。现在有些人群中流行“ 及时行乐 ”，即家庭选择把收入用于现在消费，而不是传统的存起来。例如未来发生通货膨胀，大量的存款降低了价值，人们就会觉得现期消费要好于未来消费。如果想要反过来，让未来消费代替现期消费，那就需要提供一些补偿，比如提高存款利率等，当利息提高的一定程度，那么人们就可能会考虑倾向未来消费，增加储蓄。当然这只是一部分因素，可能家庭还会要考虑未来的必要支出比如孩子学费等等，也会增加未来消费的占比，而这一切都是可以分析可以用经济学来思考。这就是为什么说经济学是使人幸福的学问。\r\n如何学习经济学？\r\n我想很多人并不是为了从事这个专业，所以要学习经济学来在生活中使用。因此学习的重点是学会如何从经济学角度来思考问题，经济学并不会提供解决问题的答案，生搬硬套导致经济危机的例子从来都不缺。我们能学到的就是如何思考问题，要有解决问题的思路，所以要做到边学、边思、边用。正如论语中的“学而不思则罔，思而不学则殆。”有了这种能力，便能把人生的形形色色看得一清二楚，对生活的纷纷扰扰也能保持从容。这时，便可以理解萧伯纳的那句名言：\r\n经济学是一门使人生幸福的艺术。\r\n</p>',NULL,'2016-08-24 05:17:51','2016-08-24 05:17:51'),(32,'fgdd','sdadsdasda',NULL,'2016-08-24 08:38:37','2016-08-24 08:38:37'),(33,'gjgh','色即是空shakjhdkjsahdkashdk',NULL,'2016-08-25 04:36:11','2016-08-25 04:36:11'),(35,'asdas','dadasdasdsadassdasd',NULL,'2016-08-25 11:55:07','2016-08-25 11:55:07'),(36,'ads','dasdasdsdsadsadsad',NULL,'2016-08-25 11:55:21','2016-08-25 11:55:21'),(37,'sdads','sadsadsadffdsasasdasd',NULL,'2016-08-25 11:55:40','2016-08-25 11:55:40'),(38,'adasdas','adasdasdasdasdsadsa',NULL,'2016-08-25 11:56:12','2016-08-25 11:56:12'),(39,'asdad','gfhjgjkghgthj,jhgfg',NULL,'2016-08-25 11:56:23','2016-08-25 11:56:23');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20160816022904'),('20160817130037'),('20160818145430'),('20160819083917'),('20160822002253'),('20160822015417');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-08-25 20:00:34
