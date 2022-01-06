
-- create table per_county_gdp_growth (
-- 	id					serial primary key,
-- 	all_data_id			int,
-- 	county_name			text,
-- 	state_code			text,
-- 	from_gdp			int,
-- 	to_gdp				int,
-- 	growth_amt			int,
-- 	growth_pct			float,		-- pct implies multiped by 100.0
-- 	from_year			int default 2010,
-- 	to_year				int default 2020
-- );

select state_code, county_name, from_gdp, to_gdp, growth_amt, round(growth_pct::numeric,2) as growth_pct
	from per_county_gdp_growth 
	where state_code = 'WY'
;
