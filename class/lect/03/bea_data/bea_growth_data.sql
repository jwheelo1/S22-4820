
-- \COPY bea_growth_data ( state, county_name, dollars_2018, dollars_2019, dollars_2020, rank_in_state_2020, pct_change_2019, pct_change_2020, rank_in_state_2020_b ) FROM 'clean-data.csv' DELIMITER ',' NULL AS '(NA)' CSV;

drop table if exists bea_growth_data;
create table bea_growth_data (
	id serial not null primary key,
	state text not null,
	county_name text not null,
	dollars_2018 int,
	dollars_2019 int,
	dollars_2020 int,
	rank_in_state_2020 int,
	pct_change_2019 float,
	pct_change_2020 float,
	rank_in_state_2020_b int
);
