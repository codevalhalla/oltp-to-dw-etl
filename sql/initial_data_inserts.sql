-- ==========================================
-- INITIAL_DATA_INSERTS.SQL
-- Sample data for OLTP schema (oltp)
-- ==========================================

-- 1. Insert countries
INSERT INTO country (country_id, country_name) VALUES (country_seq.NEXTVAL, 'India');
INSERT INTO country (country_id, country_name) VALUES (country_seq.NEXTVAL, 'Japan');

COMMIT;

-- 2. Insert states (assuming India has country_id = 500)
INSERT INTO state (state_id, state_name, country_id) VALUES (state_seq.NEXTVAL, 'Uttar Pradesh', 500);
INSERT INTO state (state_id, state_name, country_id) VALUES (state_seq.NEXTVAL, 'Karnataka', 500);
INSERT INTO state (state_id, state_name, country_id) VALUES (state_seq.NEXTVAL, 'Tamil Nadu', 500);

COMMIT;

-- 3. Insert cities
-- Assuming state_ids are 100, 101, 102 from the sequence
INSERT INTO city (city_id, city_name, state_id) VALUES (city_seq.NEXTVAL, 'Delhi', 100);
INSERT INTO city (city_id, city_name, state_id) VALUES (city_seq.NEXTVAL, 'Bangalore', 101);
INSERT INTO city (city_id, city_name, state_id) VALUES (city_seq.NEXTVAL, 'Chennai', 102);

COMMIT;

-- 4. Insert stores
-- Assuming city_ids are 1001, 1002, 1003 from the sequence
INSERT INTO store (store_id, store_name, city_id, phone, store_manager) VALUES (store_seq.NEXTVAL, 'Ibridge360', 1001, '9871647263', 'Adam');
INSERT INTO store (store_id, store_name, city_id, phone, store_manager) VALUES (store_seq.NEXTVAL, 'Vedantu', 1003, '267405893', 'Eve');
INSERT INTO store (store_id, store_name, city_id, phone, store_manager) VALUES (store_seq.NEXTVAL, 'Simplilearn', 1002, '378069645', 'Celestia');

COMMIT;

-- 5. Optional: Additional insert to test ETL upsert
INSERT INTO store (store_id, store_name, city_id, phone, store_manager) VALUES (store_seq.NEXTVAL, 'Bijus', 1001, '92785429126', 'Anand');

-- Update an existing store to test ETL updates
UPDATE store SET phone='973557349275', store_manager='Avinash' WHERE store_id=2;

COMMIT;

