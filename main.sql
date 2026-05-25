/*
 Navicat Premium Dump SQL

 Source Server         : Resources
 Source Server Type    : SQLite
 Source Server Version : 3045000 (3.45.0)
 Source Schema         : main

 Target Server Type    : SQLite
 Target Server Version : 3045000 (3.45.0)
 File Encoding         : 65001

 Date: 18/05/2026 09:02:47
*/

PRAGMA foreign_keys = false;

-- ----------------------------
-- Table structure for Levels
-- ----------------------------
DROP TABLE IF EXISTS "Levels";
CREATE TABLE "Levels" (
  "LevelCode" TEXT NOT NULL,
  "Name" TEXT,
  PRIMARY KEY ("LevelCode")
);

-- ----------------------------
-- Records of Levels
-- ----------------------------
INSERT INTO "Levels" VALUES ('Y9', 'Year 9');
INSERT INTO "Levels" VALUES ('Y10', 'Year 10');
INSERT INTO "Levels" VALUES ('L1', 'Level 1');
INSERT INTO "Levels" VALUES ('L2', 'Level 2');
INSERT INTO "Levels" VALUES ('L3', 'Level 3');

-- ----------------------------
-- Table structure for Resources
-- ----------------------------
CREATE TABLE IF NOT EXISTS "Resources" (
  "ResourceID" INTEGER NOT NULL,
  "ResourceName" TEXT NOT NULL,
  "SubjectCode" TEXT,
  "Creator" TEXT NOT NULL,
  "Level" TEXT,
  PRIMARY KEY ("ResourceID"),
  CONSTRAINT "FK_Creator" FOREIGN KEY ("Creator") REFERENCES "Teachers" ("TeacherCode") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT "FK_Subject" FOREIGN KEY ("SubjectCode") REFERENCES "Subjects" ("SubjectCode") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT "FK_Level" FOREIGN KEY ("Level") REFERENCES "Levels" ("LevelCode") ON DELETE CASCADE ON UPDATE CASCADE
);

-- ----------------------------
-- Records of Resources
-- ----------------------------

-- ----------------------------
-- Table structure for Subjects
-- ----------------------------
CREATE TABLE IF NOT EXISTS "Subjects" (
  "SubjectCode" text NOT NULL,
  "Name" TEXT,
  PRIMARY KEY ("SubjectCode")
);

-- ----------------------------
-- Records of Subjects
-- ----------------------------
INSERT OR IGNORE INTO "Subjects" VALUES ('MDS', 'Media Studies');
INSERT OR IGNORE INTO "Subjects" VALUES ('COM', 'Computer Studies');
INSERT OR IGNORE INTO "Subjects" VALUES ('PEO', 'Outdoor Education');

-- ----------------------------
-- Table structure for TeacherTypes
-- ----------------------------
DROP TABLE IF EXISTS "TeacherTypes";
CREATE TABLE "TeacherTypes" (
  "Priority" INTEGER NOT NULL,
  "TypeCode" text NOT NULL,
  "TypeName" TEXT,
  "HideSignUp" INTEGER,
  PRIMARY KEY ("TypeCode")
);

-- ----------------------------
-- Records of TeacherTypes
-- ----------------------------
INSERT INTO "TeacherTypes" VALUES (0, 'ADMIN', 'Website Admin', 1);
INSERT INTO "TeacherTypes" VALUES (1, 'PR', 'Principal', 0);
INSERT INTO "TeacherTypes" VALUES (2, 'DP', 'Deputy Principal', 0);
INSERT INTO "TeacherTypes" VALUES (3, 'MANAGER', 'Resource Manager', 0);
INSERT INTO "TeacherTypes" VALUES (4, 'HOF', 'Head Of Faculty', 0);
INSERT INTO "TeacherTypes" VALUES (5, 'HOD', 'Head Of Department', 0);
INSERT INTO "TeacherTypes" VALUES (6, 'T', 'Teacher', 0);
INSERT INTO "TeacherTypes" VALUES (7, 'TA', 'Teacher Aide', 0);
INSERT INTO "TeacherTypes" VALUES (8, 'JA', 'Janitor', 1);
INSERT INTO "TeacherTypes" VALUES (9, 'BL', 'Boss Lady', 1);

-- ----------------------------
-- Table structure for Teachers
-- ----------------------------
CREATE TABLE IF NOT EXISTS "Teachers" (
  "TeacherCode" text NOT NULL,
  "FirstName" TEXT NOT NULL,
  "LastName" TEXT NOT NULL,
  "TeacherType" TEXT NOT NULL,
  "Password" TEXT NOT NULL,
  PRIMARY KEY ("TeacherCode"),
  CONSTRAINT "FK_TeacherType" FOREIGN KEY ("TeacherType") REFERENCES "TeacherTypes" ("TypeCode") ON DELETE SET NULL ON UPDATE CASCADE
);


PRAGMA foreign_keys = true;
