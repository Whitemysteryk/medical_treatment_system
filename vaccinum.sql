/*
 Navicat Premium Data Transfer

 Source Server         : mysql5.7
 Source Server Type    : MySQL
 Source Server Version : 50734
 Source Host           : localhost:3306
 Source Schema         : vaccinum

 Target Server Type    : MySQL
 Target Server Version : 50734
 File Encoding         : 65001

 Date: 21/10/2023 09:53:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for appointment
-- ----------------------------
DROP TABLE IF EXISTS `appointment`;
CREATE TABLE `appointment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `vaccine_id` int(11) NULL DEFAULT NULL COMMENT '疫苗id',
  `doctor_id` int(11) NULL DEFAULT NULL COMMENT '护士id',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接种地址',
  `app_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '预约接种时间',
  `injected_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '实际接种时间',
  `status` int(11) NULL DEFAULT 0 COMMENT '接种状态',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '预约记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of appointment
-- ----------------------------
INSERT INTO `appointment` VALUES (2, 3, 7, 6, '北京大学第一医院一楼', '2023-08-07 17:22:21', '2023-08-07 17:22:21', 1, '2023-08-07 17:22:21');
INSERT INTO `appointment` VALUES (3, 1, 7, 5, '北京大学第一医院一楼', '2023-08-07 19:16:52', '2023-08-07 19:16:52', 1, '2023-08-07 19:16:52');
INSERT INTO `appointment` VALUES (6, 3, 5, 5, '北京大学第一医院一楼', '2023-08-09 09:08:27', '2023-08-09 09:08:27', 1, '2023-08-09 09:08:27');
INSERT INTO `appointment` VALUES (7, 1, 5, 6, '北京大学第一医院一楼', '2023-08-09 09:08:15', '2023-08-09 09:08:15', 1, '2023-08-09 09:08:15');
INSERT INTO `appointment` VALUES (8, 1, 5, 6, '北京大学第一医院一楼', '2023-08-30 13:10:13', '2023-08-30 13:10:13', 1, '2023-08-30 13:10:13');
INSERT INTO `appointment` VALUES (9, 5, 8, 6, '中国医院', '2023-08-15 14:21:00', '2023-08-15 14:21:00', 0, '2023-08-15 14:21:00');
INSERT INTO `appointment` VALUES (10, 2, 7, 6, '北京大学第一医院一楼', '2023-09-15 21:00:47', '2023-09-15 21:00:47', 1, '2023-09-15 21:00:47');
INSERT INTO `appointment` VALUES (11, 2, 4, 6, '中国医院', '2023-08-17 11:13:41', '2023-08-17 11:13:41', 1, '2023-08-17 11:13:41');
INSERT INTO `appointment` VALUES (12, 2, 3, 6, '广州医科大学3栋', '2023-08-17 11:25:13', '2023-08-17 11:25:13', 1, '2023-08-17 11:25:13');
INSERT INTO `appointment` VALUES (19, 2, 1, NULL, '北京大学第一医院一楼', '2023-08-17 11:33:50', NULL, 0, '2023-09-16 09:32:49');
INSERT INTO `appointment` VALUES (20, 2, 7, NULL, '北京大学第一医院一楼', '2023-08-10 17:07:36', NULL, 0, '2023-09-23 08:55:25');

-- ----------------------------
-- Table structure for appointment_vaccine
-- ----------------------------
DROP TABLE IF EXISTS `appointment_vaccine`;
CREATE TABLE `appointment_vaccine`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vaccine_id` int(11) NULL DEFAULT NULL COMMENT '疫苗id',
  `nums` int(11) NULL DEFAULT NULL COMMENT '可接种数量',
  `apped_nums` int(11) NULL DEFAULT NULL COMMENT '已预约数量',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接种地址',
  `app_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '预约接种时间',
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '可预约疫苗列表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of appointment_vaccine
-- ----------------------------
INSERT INTO `appointment_vaccine` VALUES (1, 5, 100, 14, '北京大学第一医院一楼', '2023-08-07 19:18:40', '2023-08-07 19:18:40');
INSERT INTO `appointment_vaccine` VALUES (2, 3, 220, 3, '北京大学第一医院一楼', '2023-08-17 11:33:49', '2023-08-17 11:33:49');
INSERT INTO `appointment_vaccine` VALUES (3, 7, 200, 15, '北京大学第一医院一楼', '2023-08-10 17:07:36', '2023-08-10 17:07:36');
INSERT INTO `appointment_vaccine` VALUES (4, 4, 100, 21, '中国医院', '2023-08-10 17:08:30', '2023-08-10 17:08:30');
INSERT INTO `appointment_vaccine` VALUES (5, 8, 200, 13, '中国医院', '2023-08-09 09:20:26', '2023-08-09 09:20:26');
INSERT INTO `appointment_vaccine` VALUES (7, 1, 11, 2, '北京大学第一医院一楼', '2023-08-17 11:33:50', '2023-08-17 11:33:50');

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '部门编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `remark` varchar(555) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `status` int(11) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '科室' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, '内科', '内科科室', 1);
INSERT INTO `department` VALUES (2, '外科', '外科手术', 1);
INSERT INTO `department` VALUES (3, '妇科', '妇科', 1);
INSERT INTO `department` VALUES (4, '精神科', '精神科手术', 1);
INSERT INTO `department` VALUES (5, '脑科', '脑科', 1);
INSERT INTO `department` VALUES (6, '儿科', '儿科专业', 1);
INSERT INTO `department` VALUES (23, '急诊科', '急诊手术', 1);

-- ----------------------------
-- Table structure for doctor
-- ----------------------------
DROP TABLE IF EXISTS `doctor`;
CREATE TABLE `doctor`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `host_id` int(11) NOT NULL COMMENT '所属医院-编号',
  `school` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '毕业院校',
  `major` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '专业',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机号码-11位',
  `wait_nums` int(11) NULL DEFAULT 0 COMMENT '等待接诊-医生、等待接种-护士',
  `department_id` int(11) NOT NULL COMMENT '科室-编号',
  `role` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'doctor' COMMENT '角色',
  `status` int(11) NULL DEFAULT 1 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `phone`(`phone`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '医生' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of doctor
-- ----------------------------
INSERT INTO `doctor` VALUES (1, '邓先平', '123', 'wangzai.jpg', 1, '深圳医科大学', '内科手术', '12345641603', 2, 1, 'doctor', 1);
INSERT INTO `doctor` VALUES (2, '郭先进', '123', 'wangzai.jpg', 2, '深圳医科大学', '外科手术', '12345645603', 3, 2, 'doctor', 1);
INSERT INTO `doctor` VALUES (3, '张小四', '123456', 'xiaoxiaoguai.jpg', 3, '中山大学医科大学', '外科手术', '12348745120', 4, 2, 'doctor', 1);
INSERT INTO `doctor` VALUES (5, '秦风', '123', 'xiaoxin.jpg', 4, '中山大学医科大学', '妇科专业', 'sdf', 4, 2, 'nurse', 1);
INSERT INTO `doctor` VALUES (6, '甄一样', '123', 'a3461b9f-fd81-4ad3-adb9-ed09b1844906.jpg', 10, '中国大学', '妇科专业', '12345678909', 995, 3, 'nurse', 1);
INSERT INTO `doctor` VALUES (10, '甄爱国', '111111', '47f1d34d-621d-40f4-aa94-308e6df98e9c.jpg', 1, '中山大学医科大学', '外科手术', '15632323211', 2, 6, 'doctor', 1);
INSERT INTO `doctor` VALUES (11, '王振华', '111111', '47f1d34d-621d-40f4-aa94-308e6df98e9c.jpg', 1, '中山大学医科大学', '外科手术', '13512363652', 2, 4, 'nurse', 1);
INSERT INTO `doctor` VALUES (12, '钱腾飞', '111111', '47f1d34d-621d-40f4-aa94-308e6df98e9c.jpg', 7, '中山大学医科大学', '外科手术', '13522003311', 1, 2, 'doctor', 1);
INSERT INTO `doctor` VALUES (13, '李小花', '111111', '47f1d34d-621d-40f4-aa94-308e6df98e9c.jpg', 10, '中山大学医科大学', '外科手术', '13212032145', 1, 2, 'doctor', 1);
INSERT INTO `doctor` VALUES (14, '张大牙', '122', 'xiaoxiaoguai.jpg', 5, '中山大学医科大学', '外科手术', '111', 11, 1, 'doctor', 1);
INSERT INTO `doctor` VALUES (16, '王金五', '123', 'xiaoxiaoguai.jpg', 1, '中山大学医科大学', '妇科专业', '123', 4, 1, 'doctor', 1);

-- ----------------------------
-- Table structure for hospital
-- ----------------------------
DROP TABLE IF EXISTS `hospital`;
CREATE TABLE `hospital`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '医院编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地址',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系方式',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '信息',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `status` int(11) NULL DEFAULT 1 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '医院' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hospital
-- ----------------------------
INSERT INTO `hospital` VALUES (1, '北京大学第一医院', '北京市西城区西什库大街8号', '010-83572211', '历 史 基 调：厚积淀耕耘一百载，新时代筑梦三十年1', '2023-02-22 15:33:01', 1);
INSERT INTO `hospital` VALUES (2, '南京军区南京总医院', '中国江苏省南京市玄武区中山东路305号', '010-83572212', '中国人民解放军东部战区总医院始建于1929年，前身为国民政府中央医院，是一所历史悠久、医教研协调发展的大型现代化综合性医院。', '2023-02-21 15:33:15', 1);
INSERT INTO `hospital` VALUES (3, '上海瑞金医院', '上海市黄浦区瑞金二路197号。', '010-83572213', '上海交通大学医学院附属瑞金医院成立于1907年，是三级甲等医院。2019年11月10日，复旦版《2018年度中国医院排行榜》发布，上海交通大学医学院附属瑞金医院位居第4', '2023-02-21 15:33:18', 1);
INSERT INTO `hospital` VALUES (4, '解放军总医院', '北京市海淀区复兴路28号', '010-835722124', '中国人民解放军总医院前身是中国协和医学院第二临床学院，1953年10月，总后方勤务部卫生部决定将“中国协和医学院第二临床学院”改为“军委直属机关医院”', '2023-02-21 15:33:21', 1);
INSERT INTO `hospital` VALUES (5, '复旦大学附属华山医院', '上海市静安区乌鲁木齐中路12号/闵行区金光路958号', '010-835722125', '占地近50亩，始建于1907年，是一所集医、教、研于一体的三级综合性医院，是上海市医保定点单位。', '2023-02-21 15:33:24', 1);
INSERT INTO `hospital` VALUES (6, '北京协和医院', '北京市西城区大木仓胡同41号', '010-835722126', '北京协和医院在中国乃至世界享有盛名。医院成立于1921年。北京协和医院是中国最早承担外宾医疗任务的单位，医院专门设立外宾和高干门诊部', '2023-02-21 15:33:27', 1);
INSERT INTO `hospital` VALUES (7, '南方医科大学南方医院', '广州市广州大道北1838号', '010-835722129', '南方医院创建于1941年，2004年8月随第一军医大学整体移交广东省，是南方医科大学（原第一军医大学）第一附属医院、第一临床医学院，是一所集医疗、教学、科研和预防保健为一体的大型综合性三级甲等医院', '2023-02-21 15:33:34', 1);
INSERT INTO `hospital` VALUES (8, '第二军医大学长征医院', '上海市黄浦区凤阳路415号', '010-835722127', '2017年11月1日，上海长征医院获得“2017年度全国改善医疗服务最具示范案例”的医院', '2023-02-21 15:33:38', 1);
INSERT INTO `hospital` VALUES (9, '四川大学华西医院', '四川省成都市武侯区国学巷37号', '010-835722128', '四川大学华西医院在2015年公布的中国公立医院社会贡献度排行榜上总分位列全国第一，在复旦大学中国最佳专科声誉和最佳医院排行榜上，连续五年名列全国第二', '2023-04-21 17:06:23', 1);
INSERT INTO `hospital` VALUES (10, '中国医院', '四川省成都市武侯区国学巷37号', '021-2314562', '中国医院真的是太有实力了。', '2023-07-29 15:54:49', 1);

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager`  (
  `id` int(11) NOT NULL COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号-3个字母+4个数字',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `create_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `status` int(11) NULL DEFAULT 1 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager` VALUES (1000, 'root1001', '123', 'spaiderman.jpg', '2023-09-15 21:41:07', 0);
INSERT INTO `manager` VALUES (1001, 'root', '123', 'kaixin.jpg', '2023-08-09 16:56:44', 1);
INSERT INTO `manager` VALUES (1002, 'admin', '123', 'spaiderman.jpg', '2023-08-09 15:35:14', 1);
INSERT INTO `manager` VALUES (1003, 'boss', '123', 'huaxin.jpg', '2023-08-09 15:35:14', 1);
INSERT INTO `manager` VALUES (1004, 'admin102', '123', 'huaxin.jpg', '2023-08-31 10:42:21', 1);
INSERT INTO `manager` VALUES (1010, 'admin103', '123', '1b23e6f5-a5d1-4421-b650-0c5baf6d4537.jpg', '2023-08-31 10:42:21', 1);
INSERT INTO `manager` VALUES (1011, 'admin104', '123', '1fbada1b-81ef-4d5b-90cf-6e6072b80ba9.jpg', '2023-08-31 10:42:21', 1);
INSERT INTO `manager` VALUES (1012, 'admin105', '123', '9b8829d8-a44f-495a-8c00-d2cd83401779.jpg', '2023-08-31 10:42:21', 1);

-- ----------------------------
-- Table structure for posts
-- ----------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '问诊记录id',
  `posts_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '问诊记录内容',
  `posts_image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述图片',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `publisher` int(11) NOT NULL COMMENT '医生id',
  `registration_id` int(11) NOT NULL COMMENT '挂号帖id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '问诊记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of posts
-- ----------------------------
INSERT INTO `posts` VALUES (12, '胃胀气', '91c75dce-7453-44a2-b2e3-32e221f0f6d1.jpg', '2023-02-01 13:20:33', 3, 2);
INSERT INTO `posts` VALUES (13, '照胃镜', '91c75dce-7453-44a2-b2e3-32e221f0f6d1.jpg', '2023-02-02 14:43:06', 2, 10);
INSERT INTO `posts` VALUES (14, '高度发烧', '91c75dce-7453-44a2-b2e3-32e221f0f6d1.jpg', '2023-02-02 14:50:12', 2, 12);
INSERT INTO `posts` VALUES (21, '脚关节积液', '91c75dce-7453-44a2-b2e3-32e221f0f6d1.jpg', '2023-08-03 20:24:37', 23, 29);
INSERT INTO `posts` VALUES (24, '头痛', '91c75dce-7453-44a2-b2e3-32e221f0f6d1.jpg', '2023-08-10 19:35:56', 1, 18);
INSERT INTO `posts` VALUES (25, '开处方止疼药', 'aaaa8416-61a6-4153-b52e-95ba428e5128.jpg', '2023-08-10 19:36:16', 1, 18);
INSERT INTO `posts` VALUES (26, '腰关节错位', '9bc44b4f-7a75-49fc-b6bd-446cb1d4ecff.jpg', '2023-08-10 19:36:29', 1, 18);

-- ----------------------------
-- Table structure for registration
-- ----------------------------
DROP TABLE IF EXISTS `registration`;
CREATE TABLE `registration`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '挂号帖编号',
  `disease_type` int(11) NOT NULL COMMENT '挂号科室',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '病情描述',
  `describe_img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '病情描述的图片',
  `registration_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '挂号时间',
  `doctor_id` int(11) NOT NULL COMMENT '医生编号',
  `user_id` int(11) NOT NULL COMMENT '用户-编号',
  `status` int(2) NULL DEFAULT 0 COMMENT '挂号帖-状态-0待接诊-1已接诊-2完成',
  `book_time` timestamp NULL DEFAULT NULL COMMENT '预约时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '挂号帖' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of registration
-- ----------------------------
INSERT INTO `registration` VALUES (2, 2, '右手局部骨折', '015d710c-fc8f-4576-b801-2ef9945cbb02.jpg', '2022-03-06 09:48:51', 2, 2, 1, NULL);
INSERT INTO `registration` VALUES (10, 1, '胃抽筋', '015d710c-fc8f-4576-b801-2ef9945cbb02.jpg', '2022-04-17 00:39:10', 2, 1, 1, NULL);
INSERT INTO `registration` VALUES (12, 2, '胃抽筋', '015d710c-fc8f-4576-b801-2ef9945cbb02.jpg', '2023-01-28 14:04:58', 2, 1, 1, NULL);
INSERT INTO `registration` VALUES (13, 2, '胃抽筋', '015d710c-fc8f-4576-b801-2ef9945cbb02.jpg', '2023-01-28 14:45:49', 3, 1, 2, NULL);
INSERT INTO `registration` VALUES (18, 1, '头很痛', '015d710c-fc8f-4576-b801-2ef9945cbb02.jpg', '2023-08-10 14:47:36', 1, 1, 1, '2023-08-10 12:00:00');
INSERT INTO `registration` VALUES (19, 2, '脚很痛', '015d710c-fc8f-4576-b801-2ef9945cbb02.jpg', '2023-08-10 17:07:01', 3, 3, 0, '2023-08-10 12:00:00');
INSERT INTO `registration` VALUES (20, 4, '头很痛', '015d710c-fc8f-4576-b801-2ef9945cbb02.jpg', '2023-08-10 17:08:25', 11, 9, 0, '2023-08-10 12:00:00');
INSERT INTO `registration` VALUES (21, 6, '头很痛', '015d710c-fc8f-4576-b801-2ef9945cbb02.jpg', '2023-08-10 19:34:04', 10, 10, 0, '2023-08-10 12:00:00');
INSERT INTO `registration` VALUES (22, 2, 'sdfds', '015d710c-fc8f-4576-b801-2ef9945cbb02.jpg', '2023-09-09 09:30:48', 3, 2, 0, '2023-09-12 12:00:00');
INSERT INTO `registration` VALUES (23, 2, '小腿骨折', '015d710c-fc8f-4576-b801-2ef9945cbb02.jpg', '2023-09-15 14:31:50', 5, 2, 0, '2023-09-15 18:00:00');
INSERT INTO `registration` VALUES (24, 1, '发烧', NULL, '2023-09-22 15:59:19', 1, 2, 0, '2023-09-23 12:00:00');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '患者编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `sex` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '男' COMMENT '性别',
  `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `codeId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '身份证-18位',
  `phone` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机号码-11位',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '家庭住址',
  `qrcode` int(1) NULL DEFAULT NULL COMMENT '通行二维码-1绿码-2黄码-3红码',
  `status` int(11) NULL DEFAULT 1 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `phone`(`phone`) USING BTREE,
  UNIQUE INDEX `codeId`(`codeId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '患者用户' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '张三', '男', 38, '1', 'kaixin.jpg', '44553322492359741', '1', '广州', 1, 1);
INSERT INTO `user` VALUES (2, '张小四', '男', 26, '123', 'xiaoxin.jpg', '4567981846165165', '12345678909', '广州天河又一城', 3, 1);
INSERT INTO `user` VALUES (3, '李平', '男', 34, '123', 'huaxin.jpg', '44553322492359744', '12345645602', '前横路169号盛辉国际1708', 3, 1);
INSERT INTO `user` VALUES (4, '王五', '男', 19, '123456', 'tianxin.jpg', '1234865798651', '12345678919', '广州', 1, 1);
INSERT INTO `user` VALUES (8, '张小五', '男', 25, '123', 'duolaameng.jpg', '45679818461651651', '12345618909', '广州天河又一城', 2, 1);
INSERT INTO `user` VALUES (9, '李一', '女', 34, '123', 'huaxin.jpg', '445533224923519744', '123451645602', '前横路169号盛辉国际1708', 3, 1);
INSERT INTO `user` VALUES (10, '孙六', '女', 19, '123456', 'spaiderman.jpg', '12348657918651', '123456178919', '广州', 1, 1);
INSERT INTO `user` VALUES (11, '甄一', '男', 19, '123456', 'wangzai.jpg', '12348657986511', '18345678919', '广州', 1, 1);
INSERT INTO `user` VALUES (12, 'sss', '男', NULL, 'sss', NULL, 'sfsdfs465498651', '465137894651328', NULL, 1, 1);
INSERT INTO `user` VALUES (13, 'zhangsan', '男', 15, 'abc', '', 'sdfs44563124563', '18345678923', 'sdfsdfsdf', 1, 1);
INSERT INTO `user` VALUES (15, 'sdfsdf', '男', 23, '123', '', 'sdfs445631245644', '18345678924', 'sdfsdf', 1, 1);

-- ----------------------------
-- Table structure for vaccine
-- ----------------------------
DROP TABLE IF EXISTS `vaccine`;
CREATE TABLE `vaccine`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '疫苗名称',
  `type_id` int(11) NULL DEFAULT NULL COMMENT '疫苗种类',
  `function` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '作用',
  `target` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '目标人群',
  `adverse_reaction` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '不良反应',
  `producer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `produce_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '生产时间',
  `status` int(11) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '疫苗' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vaccine
-- ----------------------------
INSERT INTO `vaccine` VALUES (1, '百白破疫苗', 1, '百白破疫苗用于预防白喉、破伤风和百日咳。', '儿童', '局部可出现红肿、疼痛、发痒或有低热、疲倦头痛等。一般不需特殊处理即自行消退。偶见过敏性皮疹、血管性水肿。无菌性化脓。多系注射过浅或疫苗未摇匀，硬结不能吸收而形成注射部位化脓。若全身反应较重，应及时到医院进行诊治。', '百克生物', '2023-08-04 16:48:02', 1);
INSERT INTO `vaccine` VALUES (3, 'MMRS疫苗', 3, '主要是预防麻疹（Measles）、腮腺炎（Mumps）和风疹（Rubella）疫苗，这三种疫苗通常以联合疫苗的形式给予。它们都属于亚单位疫苗，含有相应病毒的表面抗原。', '儿童', '注射部位会出现红、热、痛等情况，要对症治疗，必要的时候可以给予冷敷等缓解局部的症状。有可能会出现发烧，孩子发烧以38℃体温为主，一般来说给予物理降温，如果高烧体温超过38.5℃可以口服退热药物。\r\n有可能会出现胃肠道反应，如恶心、呕吐、食欲差、腹痛等，给予对症治疗即可。', '长生生物', '2023-09-15 21:01:27', 1);
INSERT INTO `vaccine` VALUES (4, '猩红热疫苗', 1, '猩红热疫苗用于预防侵袭性流行性嗜血杆菌感染（Haemophilus influenzae type b）。它是亡（死）疫苗，含有灭活的病原体多糖或多糖蛋白结合物。', '成人', '皮肤的瘙痒，或者是皮肤红肿的情况发生。', '成都生物制品研究所', '2023-08-04 16:48:02', 1);
INSERT INTO `vaccine` VALUES (5, '水痘疫苗', 2, '水痘疫苗用于预防水痘和带状疱疹（Herpes zoster）。它属于活减疫苗，含有削弱的水痘病毒株。', '1岁以上水痘易感人群。', '水痘减毒活疫苗安全性良好，大部分不良反应较轻微，严重不良反应少见。常见的不良反应为接种部位红肿、疼痛以及发热，偶尔会发生过敏反应，故建议接种疫苗后在接种机构留观30分钟后离开。\n', '科兴(大连)疫苗技术', '2023-08-08 16:32:58', 1);
INSERT INTO `vaccine` VALUES (6, 'HPV疫苗', 3, '人乳头瘤病毒（Human Papillomavirus）疫苗，用于预防引起宫颈癌和其他癌症的HPV感染。HPV疫苗属于亚单位疫苗，含有HPV的表面抗原。', '9-14岁未发生性行为的女孩，15岁以上女性为次要人群', '常见的不良反应为接种部位红肿、疼痛以及发热，另外还包括头痛、恶心、乏力、晕厥等，偶尔会发生过敏反应。\n', 'MSD默沙东默沙东', '2023-09-15 21:01:27', 1);
INSERT INTO `vaccine` VALUES (7, '狂犬疫苗', 1, '狂犬病疫苗是一种预防狂犬病的疫苗。狂犬病是一种由狂犬病病毒引起的急性传染病，临床大多表现为特异性恐水、恐风、咽肌痉挛、进行性瘫痪等症状，目前为止尚无法治愈，一旦发病，其病死率几乎高达\n100%。\n', '所有易感人群', '接种人用狂犬病疫苗后，可能会出现注射部位红肿、疼痛、发痒、硬结等局部症状，以及低烧、乏力、头晕、头疼、关节痛、肌肉痛、恶心呕吐、腹痛等全身症状，通常可自行缓解，不必过于担心。过敏、血管神经性水肿和神经系统疾病等严重不良反应很少发生。\n', '康华生物', '2023-08-04 16:48:02', 1);
INSERT INTO `vaccine` VALUES (8, '流感疫苗', 1, '流感疫苗是一种通过人工的手段将流感病毒的毒力弱化或消除后制成的生物制品。这种生物制品致病力很弱，但可被人体识别并产生特殊免疫作用，而这种免疫作用会持续一段时间，当机体再次接触流感病毒时，可迅速识别并激活免疫反应，抑制和清除流感病毒，从而起到预防流感的作用。', '年龄>=6个月的人群', '注射部位疼痛和暂时的发热反应，喷皇式流感疫苗常见皇塞和流涕但通常都会自行消失，不用过度担心。', '莱茵生物', '2023-08-04 16:48:02', 1);

-- ----------------------------
-- Table structure for vaccine_type
-- ----------------------------
DROP TABLE IF EXISTS `vaccine_type`;
CREATE TABLE `vaccine_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '疫苗种类',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '疫苗种类描述',
  `status` int(11) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '疫苗分类' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vaccine_type
-- ----------------------------
INSERT INTO `vaccine_type` VALUES (1, '灭活疫苗', '灭活疫苗使受种者产生以体液免疫为主的免疫反应，它产生的抗体有中和、清除病原微生物及其产生的毒素作用，对细胞外感染的病原微生物有较好的保护效果。灭活疫苗对病毒、细胞内寄生的细菌和寄生虫的保护效果较差或无效。', 0);
INSERT INTO `vaccine_type` VALUES (2, '活减疫苗', '指用人工的方法使病原体减毒或从自然界筛选某病原体的无毒株或微毒株所制成的活微生物制剂，有时称减毒活疫苗，如卡介苗，甲型肝炎疫苗。', 1);
INSERT INTO `vaccine_type` VALUES (3, '亚单位疫苗', '通过化学分解或有控制性的蛋白质水解方法，提取细菌、病毒的特殊蛋白质结构，筛选出的具有免疫活性的片段制成的疫苗。亚单位疫苗是将致病菌主要的保护性免疫原存在的组分制成的疫苗，也叫组分疫苗。', 1);
INSERT INTO `vaccine_type` VALUES (5, 'ceshi', 'aabb', 1);
INSERT INTO `vaccine_type` VALUES (6, 'aaa', 'bbb', 1);

-- ----------------------------
-- View structure for doctor_view
-- ----------------------------
DROP VIEW IF EXISTS `doctor_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `doctor_view` AS select `d`.`id` AS `id`,`d`.`name` AS `name`,`d`.`password` AS `password`,`d`.`image` AS `image`,`d`.`host_id` AS `host_id`,`d`.`school` AS `school`,`d`.`major` AS `major`,`d`.`phone` AS `phone`,`d`.`wait_nums` AS `wait_nums`,`d`.`department_id` AS `department_id`,`d`.`role` AS `role`,`d`.`status` AS `status`,`de`.`name` AS `department_name`,`ho`.`name` AS `hospital_name` from ((`doctor` `d` join `department` `de`) join `hospital` `ho` on(((`d`.`department_id` = `de`.`id`) and (`d`.`host_id` = `ho`.`id`))));

-- ----------------------------
-- View structure for registration_view
-- ----------------------------
DROP VIEW IF EXISTS `registration_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `registration_view` AS select `re`.`id` AS `id`,`re`.`disease_type` AS `disease_type`,`re`.`description` AS `description`,`re`.`describe_img` AS `describe_img`,`re`.`registration_time` AS `registration_time`,`re`.`doctor_id` AS `doctor_id`,`re`.`user_id` AS `user_id`,`re`.`status` AS `status`,`re`.`book_time` AS `book_time`,`de`.`name` AS `deptName`,`do`.`name` AS `docName`,`do`.`status` AS `docStatus`,`user`.`name` AS `userName` from (((`registration` `re` join `department` `de`) join `doctor` `do`) join `user` on(((`re`.`user_id` = `user`.`id`) and (`re`.`disease_type` = `de`.`id`) and (`re`.`doctor_id` = `do`.`id`))));

-- ----------------------------
-- View structure for vaccine_record_view
-- ----------------------------
DROP VIEW IF EXISTS `vaccine_record_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vaccine_record_view` AS select `a`.`id` AS `id`,`a`.`user_id` AS `user_id`,`a`.`vaccine_id` AS `vaccine_id`,`a`.`doctor_id` AS `doctor_id`,`a`.`address` AS `address`,`a`.`app_date` AS `app_date`,`a`.`injected_time` AS `injected_time`,`a`.`status` AS `status`,`a`.`create_time` AS `create_time`,`v`.`name` AS `v_name`,`u`.`name` AS `username`,`d`.`name` AS `docName` from (((`appointment` `a` left join `vaccine` `v` on((`a`.`vaccine_id` = `v`.`id`))) left join `user` `u` on((`a`.`user_id` = `u`.`id`))) left join `doctor` `d` on((`a`.`doctor_id` = `d`.`id`)));

-- ----------------------------
-- View structure for vaccine_view
-- ----------------------------
DROP VIEW IF EXISTS `vaccine_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vaccine_view` AS select `a`.`id` AS `id`,`a`.`vaccine_id` AS `vaccine_id`,`a`.`nums` AS `nums`,`a`.`apped_nums` AS `apped_nums`,`a`.`address` AS `address`,`a`.`app_date` AS `app_date`,`a`.`create_time` AS `create_time`,`v`.`name` AS `vaccine_name`,`v`.`function` AS `function`,`v`.`target` AS `target`,`v`.`adverse_reaction` AS `adverse_reaction`,`v`.`producer` AS `producer`,`v`.`status` AS `status`,`v`.`produce_time` AS `produce_time`,`v`.`type_id` AS `type_id`,`t`.`name` AS `type_name`,`t`.`remark` AS `remark` from ((`appointment_vaccine` `a` join `vaccine` `v`) join `vaccine_type` `t` on(((`a`.`vaccine_id` = `v`.`id`) and (`v`.`type_id` = `t`.`id`) and (`v`.`status` = 1))));

SET FOREIGN_KEY_CHECKS = 1;
