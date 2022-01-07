  1: 
  2: -- GeoFIPS,GeoName,Region,TableName,LineCode,IndustryClassification,Description,Unit,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020
  3: -- "56037","Sweetwater","WY",7,CAGDP9,1,"...","All industry total","Thousands of chained 2012 dollars",3853019,3383788,3473206,3518158,3736171,4307886,4586198,4695080,4629085,4423250,4311080,4172661,4152057,4033107,3918810,3819789,3718229,3582427,3677972,3278745
  4: 
  5: drop table if exists per_county_gdp ;
  6: create table per_county_gdp (
  7:     id                    serial primary key,
  8:     GeoFIPS                text,
  9:     county_name            text,
 10:     state_code            text,
 11:     Region                int,
 12:     TableName            text,
 13:     LineCode            int,
 14:     junk1                text,
 15:     Description            text,
 16:     Unit                text,
 17:     yr_2001                int,
 18:     yr_2002                int,
 19:     yr_2003                int,
 20:     yr_2004                int,
 21:     yr_2005                int,
 22:     yr_2006                int,
 23:     yr_2007                int,
 24:     yr_2008                int,
 25:     yr_2009                int,
 26:     yr_2010                int,
 27:     yr_2011                int,
 28:     yr_2012                int,
 29:     yr_2013                int,
 30:     yr_2014                int,
 31:     yr_2015                int,
 32:     yr_2016                int,
 33:     yr_2017                int,
 34:     yr_2018                int,
 35:     yr_2019                int,
 36:     yr_2020                int
 37: );
 38: 
 39: 
 40: drop table if exists per_county_gdp_2010 ;
 41: create table per_county_gdp_2010 (
 42:     id                    serial primary key,
 43:     all_data_id            int,
 44:     county_name            text,
 45:     state_code            text,
 46:     gdp                    int,
 47:     year                int default 2010
 48: );
 49: 
 50: drop table if exists per_county_gdp_2020 ;
 51: create table per_county_gdp_2020 (
 52:     id                    serial primary key,
 53:     all_data_id            int,
 54:     county_name            text,
 55:     state_code            text,
 56:     gdp                    int,
 57:     year                int default 2020
 58: );
 59: 
