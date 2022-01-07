  1: 
  2: -- TODO Create FKs on tables to parent
  3: create index per_county_gdp_2010_p1 on per_county_gdp_2010 ( all_data_id );
  4: create index per_county_gdp_2020_p1 on per_county_gdp_2020 ( all_data_id );
  5: 
  6: drop table if exists per_county_gdp_growth ;
  7: create table per_county_gdp_growth (
  8:     id                    serial primary key,
  9:     all_data_id            int,
 10:     county_name            text,
 11:     state_code            text,
 12:     from_gdp            int,
 13:     to_gdp                int,
 14:     growth_amt            int,
 15:     growth_pct            float,        -- pct implies multiped by 100.0
 16:     from_year            int default 2010,
 17:     to_year                int default 2020
 18: );
 19: 
 20: -- TODO Create FKs on tables to parent
 21: create index per_county_gdp_growth_p1 on per_county_gdp_growth ( all_data_id );
 22: 
 23: 
 24: delete from per_county_gdp_2010 ;
 25: insert into per_county_gdp_2010 (
 26:     all_data_id,
 27:     county_name,
 28:     state_code,
 29:     gdp
 30: ) select id,
 31:     county_name,
 32:     state_code,
 33:     yr_2010
 34:     from per_county_gdp
 35: ;
 36: 
 37: delete from per_county_gdp_2020 ;
 38: insert into per_county_gdp_2020 (
 39:     all_data_id,
 40:     county_name,
 41:     state_code,
 42:     gdp
 43: ) select id,
 44:     county_name,
 45:     state_code,
 46:     yr_2020
 47:     from per_county_gdp
 48: ;
 49: 
 50: 
 51: 
 52: 
 53: 
 54: insert into per_county_gdp_growth (
 55:     all_data_id,
 56:     county_name,
 57:     state_code,
 58:     from_gdp,
 59:     growth_amt,
 60:     growth_pct
 61: ) select 
 62:     all_data_id,
 63:     county_name,
 64:     state_code,
 65:     gdp,
 66:     0,
 67:     0
 68:     from per_county_gdp_2010 
 69: ;
 70: 
 71: update per_county_gdp_growth  as t1
 72:     set to_gdp = (
 73:         select min(gdp)
 74:         from per_county_gdp_2020 as t2
 75:         where t2.all_data_id = t1.all_data_id
 76:     )
 77: ;
 78: 
 79: update per_county_gdp_growth  
 80:     set growth_amt = to_gdp - from_gdp 
 81: ;
 82: 
 83: update per_county_gdp_growth  
 84:     set growth_pct = ( growth_amt::float / from_gdp::float ) * 100.0
 85:     where growth_amt <> 0
 86: ;
 87: 
