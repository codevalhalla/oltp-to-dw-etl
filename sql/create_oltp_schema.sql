-- ==========================================
-- CREATE_OLTP_SCHEMA.SQL
-- OLTP Schema for Store Data
-- ==========================================

-- 1. Create OLTP user
CREATE USER oltp IDENTIFIED BY oracle;

-- 2. Grant necessary privileges
GRANT CONNECT, RESOURCE TO oltp;
GRANT UNLIMITED TABLESPACE TO oltp;

-- 3. Connect as OLTP user
-- (if running separately in SQL*Plus or SQL Developer)
-- CONNECT oltp/oracle@orcl;

-- 4. Create tables

-- COUNTRY table
CREATE TABLE country (
    country_id   NUMBER(10) NOT NULL PRIMARY KEY,
    country_name VARCHAR2(35)
);

-- STATE table
CREATE TABLE state (
    state_id    NUMBER(10) NOT NULL PRIMARY KEY,
    state_name  VARCHAR2(35),
    country_id  NUMBER(10),
    CONSTRAINT fk_country FOREIGN KEY (country_id)
        REFERENCES country(country_id)
);

-- CITY table
CREATE TABLE city (
    city_id    NUMBER(10) NOT NULL PRIMARY KEY,
    city_name  VARCHAR2(35),
    state_id   NUMBER(10),
    CONSTRAINT fk_state FOREIGN KEY (state_id)
        REFERENCES state(state_id)
);

-- STORE table
CREATE TABLE store (
    store_id       NUMBER(10) NOT NULL PRIMARY KEY,
    store_name     VARCHAR2(35),
    city_id        NUMBER(10),
    phone          VARCHAR2(35),
    store_manager  VARCHAR2(35),
    CONSTRAINT fk_city FOREIGN KEY (city_id)
        REFERENCES city(city_id)
);

-- 5. Create sequences

CREATE SEQUENCE country_seq MINVALUE 500 MAXVALUE 599 START WITH 500 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE state_seq   MINVALUE 100 MAXVALUE 200 START WITH 100 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE city_seq    MINVALUE 1001 MAXVALUE 2000 START WITH 1001 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE store_seq   MINVALUE 1 MAXVALUE 50 START WITH 1 INCREMENT BY 1 CACHE 10;

-- 6. Optional: Commit changes
COMMIT;

