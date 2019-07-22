/*
 Navicat Premium Data Transfer

 Source Server         : 我
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : meite_member

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 22/07/2019 22:14:40
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for meite_user
-- ----------------------------
DROP TABLE IF EXISTS `meite_user`;
CREATE TABLE `meite_user`  (
  `USER_ID` int(12) NOT NULL AUTO_INCREMENT COMMENT 'user_id',
  `MOBILE` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机号',
  `EMAIL` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮箱号',
  `PASSWORD` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `USER_NAME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `SEX` tinyint(1) NULL DEFAULT 0 COMMENT '性别  1男  2女',
  `AGE` tinyint(3) NULL DEFAULT 0 COMMENT '年龄',
  `CREATE_TIME` timestamp(0) NULL DEFAULT NULL COMMENT '注册时间',
  `IS_AVALIBLE` tinyint(1) NULL DEFAULT 1 COMMENT '是否可用 1正常  2冻结',
  `PIC_IMG` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `QQ_OPENID` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'QQ联合登陆id',
  `WX_OPENID` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '微信公众号关注id',
  PRIMARY KEY (`USER_ID`) USING BTREE,
  UNIQUE INDEX `MOBILE_UNIQUE`(`MOBILE`) USING BTREE,
  UNIQUE INDEX `EMAIL_UNIQUE`(`EMAIL`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户会员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meite_user
-- ----------------------------
INSERT INTO `meite_user` VALUES (1, '17503021990', '339591563@qq.com', 'E10ADC3949BA59ABBE56E057F20F883E', NULL, 0, 0, NULL, 1, NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
