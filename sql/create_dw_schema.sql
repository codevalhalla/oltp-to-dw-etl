-- ==========================================
-- CREATE DW_SCHEMA.SQL
-- Data Warehouse Schema for Store Dimension
-- ==========================================

-- 1. Create DW user
CREATE USER dw_database IDENTIFIED BY oracle;

-- 2. Grant necessary privileges
GRANT CONNECT, RESOURCE TO dw_database;
GRANT UNLIMITED TABLESPACE TO dw_database;

-- 3. Connect as DW user
-- (if running separately in SQL*Plus or SQL Developer)
-- CONNECT dw_database/oracle@orcl;

-- 4. Create store_dimension table
CREATE TABLE store_dimension (
    store_id       NUMBER(10) NOT NULL PRIMARY KEY,
    store_name     VARCHAR2(35),
    phone          VARCHAR2(35),
    store_manager  VARCHAR2(35),
    city_name      VARCHAR2(35),
    state_name     VARCHAR2(35),
    country_name   VARCHAR2(35)
);

-- Optional: Commit changes
COMMIT;

-- 5. Optional: Create logging tables for ETL
CREATE TABLE log_updated (
    store_id       NUMBER(10),
    store_name_oltp    VARCHAR2(35),
    phone_oltp         VARCHAR2(35),
    store_manager_oltp VARCHAR2(35),
    city_name_oltp     VARCHAR2(35),
    state_name_oltp    VARCHAR2(35),
    country_name_oltp  VARCHAR2(35),
    store_name_previous    VARCHAR2(35),
    phone_previous         VARCHAR2(35),
    store_manager_previous VARCHAR2(35),
    city_name_previous     VARCHAR2(35),
    state_name_previous    VARCHAR2(35),
    country_name_previous  VARCHAR2(35),
    Timestamp         VARCHAR2(50)
);

CREATE TABLE log_inserted (
    store_id       NUMBER(10),
    store_name     VARCHAR2(35),
    phone          VARCHAR2(35),
    store_manager  VARCHAR2(35),
    city_name      VARCHAR2(35),
    state_name     VARCHAR2(35),
    country_name   VARCHAR2(35),
    Timestamp      VARCHAR2(50)
);

COMMIT;

