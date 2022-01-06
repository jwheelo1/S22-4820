
-- TODO Create FKs on tables to parent
create index per_county_gdp_2010_p1 on per_county_gdp_2010 ( all_data_id );
create index per_county_gdp_2020_p1 on per_county_gdp_2020 ( all_data_id );

drop table if exists per_county_gdp_growth ;
create table per_county_gdp_growth (
	id					serial primary key,
	all_data_id			int,
	county_name			text,
	state_code			text,
	from_gdp			int,
	to_gdp				int,
	growth_amt			int,
	growth_pct			float,		-- pct implies multiped by 100.0
	from_year			int default 2010,
	to_year				int default 2020
);

-- TODO Create FKs on tables to parent
create index per_county_gdp_growth_p1 on per_county_gdp_growth ( all_data_id );


delete from per_county_gdp_2010 ;
insert into per_county_gdp_2010 (
	all_data_id,
	county_name,
	state_code,
	gdp
) select id,
	county_name,
	state_code,
	yr_2010
	from per_county_gdp
;

delete from per_county_gdp_2020 ;
insert into per_county_gdp_2020 (
	all_data_id,
	county_name,
	state_code,
	gdp
) select id,
	county_name,
	state_code,
	yr_2020
	from per_county_gdp
;





insert into per_county_gdp_growth (
	all_data_id,
	county_name,
	state_code,
	from_gdp,
	growth_amt,
	growth_pct
) select 
	all_data_id,
	county_name,
	state_code,
	gdp,
	0,
	0
	from per_county_gdp_2010 
;

update per_county_gdp_growth  as t1
	set to_gdp = (
		select min(gdp)
		from per_county_gdp_2020 as t2
		where t2.all_data_id = t1.all_data_id
	)
;

update per_county_gdp_growth  
	set growth_amt = to_gdp - from_gdp 
;

update per_county_gdp_growth  
	set growth_pct = ( growth_amt::float / from_gdp::float ) * 100.0
	where growth_amt <> 0
;

