

-- date,county,state,fips,cases,deaths
-- 2021-12-06,Autauga,Alabama,01001,10562,157
-- 2021-12-06,Baldwin,Alabama,01003,38215,589
-- 2021-12-06,Barbour,Alabama,01005,3708,80
-- 2021-12-06,Bibb,Alabama,01007,4364,95
-- 2021-12-06,Blount,Alabama,01009,10791,193
-- 2021-12-06,Bullock,Alabama,01011,1528,45
-- 2021-12-06,Butler,Alabama,01013,3445,101
-- 2021-12-06,Calhoun,Alabama,01015,22636,520
-- 2021-12-06,Chambers,Alabama,01017,5810,142


drop table if exists us_countines_sars_cov_2 ;

create table us_countines_sars_cov_2 (
	id					serial primary key,
	observation_date 	date,
	county 				text, 
	state 				text, 
	fips 				int default 0, 
	cases 				int default 0, 
	deaths 				int default 0
);

-- pull state code from us_state_code

