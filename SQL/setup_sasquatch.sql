-- ************************* Setup Sasquatch Database ******************;
-- *********************************************************************;

drop table tbl_AllData;
drop table tbl_series;
drop table tbl_demographics;
drop table tbl_item;
drop table tbl_subcategory;
drop table tbl_category;
drop table tbl_characteristics;
drop table tbl_process;
drop table tbl_footnote;
drop table tbl_seasonal;

-- ************************************** seasonal

CREATE TABLE tbl_seasonal
(
    seasonal varchar2 (3) PRIMARY KEY,
    seasonal_text varchar2 (100)
);

-- ************************************** footnote

CREATE TABLE tbl_footnote
(
    footnote_code varchar2 (45) PRIMARY KEY ,
    footnote_text varchar2 (256)
);

-- ************************************** process

CREATE TABLE tbl_process
(
    process_code varchar2 (3) PRIMARY KEY,
    process_text varchar2 (45) ,
    display_level int ,
    selectable char (1) ,
    sort_seqence int
);

-- ************************************** characteristics

CREATE TABLE tbl_characteristics
(
    demographics_code varchar2 (45) ,
    characteristics_code varchar2 (45) ,
    characteristics_text varchar2 (256) ,
    display_level int ,
    selectable char (1) ,
    sort_seqence int,
    PRIMARY KEY (demographics_code,characteristics_code)
);

-- ************************************** category

CREATE TABLE tbl_category
(
    category_code varchar2(45) PRIMARY KEY,
    category_text varchar2 (45) ,
    display_level varchar2 (45) ,
    selectable char (1) ,
    sort_seqence int
);

-- ************************************** subcategory

CREATE TABLE tbl_subcategory
(
    subcategory_code varchar2 (45) ,
    category_code varchar2 (45) CONSTRAINT fk_category_code_1 REFERENCES tbl_category(category_code) ,
    subcategory_text varchar2 (100) ,
    display_level int ,
    selectable char (1) ,
    sort_seqence int,
    PRIMARY KEY (subcategory_code, category_code)
);

-- ************************************** item

CREATE TABLE tbl_item
(
    subcategory_code varchar2 (45) CONSTRAINT fk_subcategory_code_1 REFERENCES tbl_subcategory(subcategory_code) ,
    category_code varchar2 (45) CONSTRAINT fk_category_code_2 REFERENCES tbl_category(category_code) ,
    item_code varchar2 (45) ,
    item_text varchar2 (100) ,
    display_level int ,
    selectable char (1) ,
    sort_seqence int,
    PRIMARY KEY (subcategory_code, category_code)
);

-- ************************************** demographics

CREATE TABLE tbl_demographics
(
    demographics_code varchar2 (45) PRIMARY KEY,
    characteristics_code varchar2 (45) ,
    demographics_text varchar2 (45) ,
    display_level int ,
    selectable char (1) ,
    sort_seqence int

    --             KEY fkIdx_90
    --             (demographics_code, characteristics_code),
    -- CONSTRAINT FK_90 FOREIGN KEY fkIdx_90
    --             (demographics_code, characteristics_code) REFERENCES tbl_characteristics
    --             (demographics_code, characteristics_code)
);

-- ************************************** series

CREATE TABLE tbl_series
(
    series_id varchar2 (45) PRIMARY KEY,
    seasonal varchar2 (3) CONSTRAINT fk_seasonal REFERENCES tbl_seasonal(seasonal),
    category_code varchar2 (45) CONSTRAINT fk_category_code_3 REFERENCES tbl_category(category_code),
    item_code varchar2 (45) CONSTRAINT fk_item_code REFERENCES tbl_item(item_code),
    demographics_code varchar2 (45) CONSTRAINT fk_demographics_code REFERENCES tbl_demographics(demographics_code),
    characteristics_code varchar2 (45) CONSTRAINT fk_characteristics_code REFERENCES tbl_characteristics(characteristics_code),
    process_code varchar2 (3) CONSTRAINT fk_process_code REFERENCES tbl_process (process_code),
    series_title varchar2 (256) ,
    footnote_code varchar2 (45) CONSTRAINT fk_footnote_code REFERENCES tbl_footnote(footnote_code),
    begin_year int ,
    begin_period varchar2 (45) ,
    end_year int ,
    end_period varchar2 (45) ,
    series_id_year varchar2 (45)
);

-- ************************************** tbl_AllData

CREATE TABLE tbl_AllData
(
    series_id varchar2 (45) CONSTRAINT fk_series_id REFERENCES tbl_series(series_id),
    year int ,
    period varchar2 (45) ,
    value int ,
    footnote_code varchar2 (45) ,
    series_id_year varchar2    (45) PRIMARY KEY
);