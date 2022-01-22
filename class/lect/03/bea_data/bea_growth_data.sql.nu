  1: 
  2: -- \COPY bea_growth_data ( state, county_name, dollars_2018, dollars_2019, dollars_2020, rank_in_state_2020, pct_change_2019, pct_change_2020, rank_in_state_2020_b ) FROM 'clean-data.csv' DELIMITER ',' NULL AS '(NA)' CSV;
  3: 
  4: drop table if exists bea_growth_data;
  5: create table bea_growth_data (
  6:     id serial not null primary key,
  7:     state text not null,
  8:     county_name text not null,
  9:     dollars_2018 int,        -- per capita personal income
 10:     dollars_2019 int,        -- per capita personal income
 11:     dollars_2020 int,        -- per capita personal income
 12:     rank_in_state_2020 int,
 13:     pct_change_2019 float,
 14:     pct_change_2020 float,
 15:     rank_in_state_2020_b int
 16: );
 17: 
