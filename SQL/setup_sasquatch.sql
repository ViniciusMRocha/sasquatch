-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;
create database if not exists SasquatchDB;

use SasquatchDB;

drop table if exists tbl_AllData;
drop table if exists tbl_series;
drop table if exists tbl_demographics;
drop table if exists tbl_item;
drop table if exists tbl_subcategory;
drop table if exists tbl_category;
drop table if exists tbl_characteristics;
drop table if exists tbl_process;
drop table if exists tbl_footnote;
drop table if exists tbl_seasonal;

-- ************************************** `seasonal`

CREATE TABLE `tbl_seasonal`
(
 `seasonal`      varchar(3) NOT NULL ,
 `seasonal_text` varchar(100) NOT NULL ,
PRIMARY KEY (`seasonal`)
);

-- ************************************** `footnote`

CREATE TABLE `tbl_footnote`
(
 `footnote_code` varchar(45) NOT NULL ,
 `footnote_text` varchar(256) NOT NULL ,
PRIMARY KEY (`footnote_code`)
);

-- ************************************** `process`

CREATE TABLE `tbl_process`
(
 `process_code`  varchar(3) NOT NULL ,
 `process_text`  varchar(45) NOT NULL ,
 `display_level` int NOT NULL ,
 `selectable`    char(1) NOT NULL ,
 `sort_seqence`  int NOT NULL ,
PRIMARY KEY (`process_code`)
);

-- ************************************** `characteristics`

CREATE TABLE `tbl_characteristics`
(
 `demographics_code`    varchar(45) NOT NULL ,
 `characteristics_code` varchar(45) NOT NULL ,
 `characteristics_text` varchar(256) NOT NULL ,
 `display_level`        int NOT NULL ,
 `selectable`           char(1) NOT NULL ,
 `sort_seqence`         int NOT NULL ,
PRIMARY KEY (`demographics_code`, `characteristics_code`)
);

-- ************************************** `category`

CREATE TABLE `tbl_category`
(
 `category_code` varchar(45) NOT NULL ,
 `category_text` varchar(45) NOT NULL ,
 `display_level` varchar(45) NOT NULL ,
 `selectable`    char(1) NOT NULL ,
 `sort_seqence`  int ,
PRIMARY KEY (`category_code`)
);

-- ************************************** `subcategory`

CREATE TABLE `tbl_subcategory`
(
 `subcategory_code` varchar(45) NOT NULL ,
 `category_code`    varchar(45) NOT NULL ,
 `subcategory_text` varchar(100) NOT NULL ,
 `display_level`    int NOT NULL ,
 `selectable`       char(1) NOT NULL ,
 `sort_seqence`     int ,
PRIMARY KEY (`subcategory_code`, `category_code`),
KEY `fkIdx_53` (`category_code`),
CONSTRAINT `FK_53` FOREIGN KEY `fkIdx_53` (`category_code`) REFERENCES `tbl_category` (`category_code`)
);

-- ************************************** `item`

CREATE TABLE `tbl_item`
(
 `subcategory_code` varchar(45) NOT NULL ,
 `category_code`    varchar(45) NOT NULL ,
 `item_code`        varchar(45) NOT NULL ,
 `item_text`        varchar(100) NOT NULL ,
 `display_level`    int NOT NULL ,
 `selectable`       char(1) NOT NULL ,
 `sort_seqence`     int NOT NULL ,
PRIMARY KEY (`subcategory_code`, `category_code`),
KEY `fkIdx_62` (`subcategory_code`, `category_code`),
CONSTRAINT `FK_62` FOREIGN KEY `fkIdx_62` (`subcategory_code`, `category_code`) REFERENCES `tbl_subcategory` (`subcategory_code`, `category_code`)
);

-- ************************************** `demographics`

CREATE TABLE `tbl_demographics`
(
 `demographics_code`    varchar(45) NOT NULL ,
 `characteristics_code` varchar(45) NOT NULL ,
 `demographics_text`    varchar(45) NOT NULL ,
 `display_level`        int NOT NULL ,
 `selectable`           char(1) NOT NULL ,
 `sort_seqence`         int NOT NULL ,
PRIMARY KEY (`demographics_code`),
KEY `fkIdx_90` (`demographics_code`, `characteristics_code`),
CONSTRAINT `FK_90` FOREIGN KEY `fkIdx_90` (`demographics_code`, `characteristics_code`) REFERENCES `tbl_characteristics` (`demographics_code`, `characteristics_code`)
);

-- ************************************** `series`

CREATE TABLE `tbl_series`
(
 `series_id`       		varchar(45) NOT NULL ,
 `seasonal`             varchar(3) NOT NULL ,
 `category_code`        varchar(45) NOT NULL ,
 `item_code`            varchar(45) NOT NULL ,
 `demographics_code`    varchar(45) NOT NULL ,
 `characteristics_code` varchar(45) NOT NULL ,
 `process_code`         varchar(3) NOT NULL ,
 `series_title`         varchar(256) NOT NULL ,
 `footnote_code`        varchar(45) NOT NULL ,
 `begin_year`           int NOT NULL ,
 `begin_period`         varchar(45) NOT NULL ,
 `end_year`             int NOT NULL ,
 `end_period`           varchar(45) NOT NULL ,
 `series_id_year`       varchar(45) NOT NULL ,
PRIMARY KEY (`series_id`),
KEY `fkIdx_106` (`footnote_code`),
CONSTRAINT `FK_106` FOREIGN KEY `fkIdx_106` (`footnote_code`) REFERENCES `tbl_footnote` (`footnote_code`),
KEY `fkIdx_113` (`process_code`),
CONSTRAINT `FK_113` FOREIGN KEY `fkIdx_113` (`process_code`) REFERENCES `tbl_process` (`process_code`),
KEY `fkIdx_126` (`seasonal`),
CONSTRAINT `FK_126` FOREIGN KEY `fkIdx_126` (`seasonal`) REFERENCES `tbl_seasonal` (`seasonal`),
KEY `fkIdx_38` (`category_code`),
CONSTRAINT `FK_38` FOREIGN KEY `fkIdx_38` (`category_code`) REFERENCES `tbl_category` (`category_code`),
KEY `fkIdx_80` (`demographics_code`, `characteristics_code`),
CONSTRAINT `FK_80` FOREIGN KEY `fkIdx_80` (`demographics_code`, `characteristics_code`) REFERENCES `tbl_characteristics` (`demographics_code`, `characteristics_code`)
);

-- ************************************** `tbl_AllData`

CREATE TABLE `tbl_AllData`
(
 `series_id`      varchar(45) NOT NULL ,
 `year`           int NOT NULL ,
 `period`         varchar(45) NOT NULL ,
 `value`          int NOT NULL ,
 `footnote_code`  varchar(45) NOT NULL ,
 `series_id_year` varchar(45) NOT NULL ,
PRIMARY KEY (`series_id_year`),
KEY `fkIdx_20` (`series_id`),
CONSTRAINT `FK_20` FOREIGN KEY `fkIdx_20` (`series_id`) REFERENCES `tbl_series` (`series_id`)
);
