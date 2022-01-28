--                                Table "public.election_2020"
--    Column    |  Type   | Collation | Nullable |                  Default                  
-- -------------+---------+-----------+----------+-------------------------------------------
--  id          | integer |           | not null | nextval('election_2020_id_seq'::regclass)
--  state       | text    |           |          | 
--  county_name | text    |           |          | 
--  winner      | text    |           |          | 
-- Indexes:
--     "election_2020_pkey" PRIMARY KEY, btree (id)
-- 

\COPY election_2020 ( state, county_name, winner ) TO 'election_2020_data.csv' DELIMITER ',' NULL AS 'NAULL' CSV;

