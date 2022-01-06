  1: 
  2: 
  3: -- date,county,state,fips,cases,deaths
  4: -- 2021-12-06,Autauga,Alabama,01001,10562,157
  5: -- 2021-12-06,Baldwin,Alabama,01003,38215,589
  6: -- 2021-12-06,Barbour,Alabama,01005,3708,80
  7: -- 2021-12-06,Bibb,Alabama,01007,4364,95
  8: -- 2021-12-06,Blount,Alabama,01009,10791,193
  9: -- 2021-12-06,Bullock,Alabama,01011,1528,45
 10: -- 2021-12-06,Butler,Alabama,01013,3445,101
 11: -- 2021-12-06,Calhoun,Alabama,01015,22636,520
 12: -- 2021-12-06,Chambers,Alabama,01017,5810,142
 13: 
 14: 
 15: drop table if exists us_countines_sars_cov_2 ;
 16: 
 17: create table us_countines_sars_cov_2 (
 18:     id                    serial primary key,
 19:     observation_date     date,
 20:     county                 text, 
 21:     state                 text, 
 22:     fips                 int default 0, 
 23:     cases                 int default 0, 
 24:     deaths                 int default 0
 25: );
 26: 
 27: -- pull state code from us_state_code
 28: 
