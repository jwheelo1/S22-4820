
-- GeoFIPS,GeoName,Region,TableName,LineCode,IndustryClassification,Description,Unit,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020
-- "56037","Sweetwater","WY",7,CAGDP9,1,"...","All industry total","Thousands of chained 2012 dollars",3853019,3383788,3473206,3518158,3736171,4307886,4586198,4695080,4629085,4423250,4311080,4172661,4152057,4033107,3918810,3819789,3718229,3582427,3677972,3278745

drop table if exists per_county_gdp ;
create table per_county_gdp (
	id					serial primary key,
	GeoFIPS				text,
	county_name			text,
	state_code			text,
	Region				int,
	TableName			text,
	LineCode			int,
	junk1				text,
	Description			text,
	Unit				text,
	yr_2001				int,
	yr_2002				int,
	yr_2003				int,
	yr_2004				int,
	yr_2005				int,
	yr_2006				int,
	yr_2007				int,
	yr_2008				int,
	yr_2009				int,
	yr_2010				int,
	yr_2011				int,
	yr_2012				int,
	yr_2013				int,
	yr_2014				int,
	yr_2015				int,
	yr_2016				int,
	yr_2017				int,
	yr_2018				int,
	yr_2019				int,
	yr_2020				int
);


drop table if exists per_county_gdp_2010 ;
create table per_county_gdp_2010 (
	id					serial primary key,
	all_data_id			int,
	county_name			text,
	state_code			text,
	gdp					int,
	year				int default 2010
);

drop table if exists per_county_gdp_2020 ;
create table per_county_gdp_2020 (
	id					serial primary key,
	all_data_id			int,
	county_name			text,
	state_code			text,
	gdp					int,
	year				int default 2020
);

