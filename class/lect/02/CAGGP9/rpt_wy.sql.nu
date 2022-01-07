  1: 
  2: -- create table per_county_gdp_growth (
  3: --     id                    serial primary key,
  4: --     all_data_id            int,
  5: --     county_name            text,
  6: --     state_code            text,
  7: --     from_gdp            int,
  8: --     to_gdp                int,
  9: --     growth_amt            int,
 10: --     growth_pct            float,        -- pct implies multiped by 100.0
 11: --     from_year            int default 2010,
 12: --     to_year                int default 2020
 13: -- );
 14: 
 15: select state_code, county_name, from_gdp, to_gdp, growth_amt, round(growth_pct::numeric,2) as growth_pct
 16:     from per_county_gdp_growth 
 17:     where state_code = 'WY'
 18: ;
