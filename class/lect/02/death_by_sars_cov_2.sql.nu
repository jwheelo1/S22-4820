  1: 
  2: -- Death from COVID-19 (sars_cov_2)
  3: 
  4: --- -- Sample Table:
  5: --- 
  6: --- -- date,county,state,fips,cases,deaths
  7: --- -- 2021-12-06,Autauga,Alabama,01001,10562,157
  8: --- -- 2021-12-06,Baldwin,Alabama,01003,38215,589
  9: --- 
 10: --- 
 11: --- drop table if exists us_counties_sars_cov_2 ;
 12: --- create table us_counties_sars_cov_2 (
 13: ---     id                    serial primary key,
 14: ---     observation_date     date,
 15: ---     county_name            text, 
 16: ---     state                 text, 
 17: ---     fips                 int default 0, 
 18: ---     cases                 int default 0, 
 19: ---     deaths                 int default 0,
 20: ---     winner                 text
 21: --- );
 22: --- 
 23: --- -- pull state code from us_state_code
 24: 
 25: 
 26: 
 27: 
 28: alter table us_counties_sars_cov_2 add state_code varchar(2);
 29: 
 30: update us_counties_sars_cov_2 as t1
 31:     set state_code = (
 32:         select t2.state  -- note the really bad table name, "state"
 33:                          -- is the satee abreviation like "WY".
 34:         from us_state_code as t2    
 35:         where t2.state_name = t1.state  -- note "state" is the long 
 36:                                         -- state name, Wyoming.
 37:     )
 38: ;
 39: 
 40: 
 41: 
 42: 
 43: 
 44: alter table us_counties_sars_cov_2 add winner text;
 45: 
 46: update us_counties_sars_cov_2 as t0
 47:     set winner = ( select t1.candidate
 48:         from vote_by_county as t1
 49:         where t1.year = 2020
 50:           and t1.candidatevotes = (
 51:                 select max(t2.candidatevotes) as max_votes
 52:                 from vote_by_county as t2
 53:                 where t2.state = t1.state
 54:                   and t2.county_name = t1.county_name
 55:             )
 56:           and t1.state = t0.state
 57:           and t1.county_name = t0.county
 58:     )
 59: ;
 60: 
 61: 
 62: 
 63: --- create table us_counties_sars_cov_2 (
 64: ---     id                    serial primary key,
 65: ---     observation_date     date,
 66: ---     county                 text, 
 67: ---     state                 text, 
 68: ---     fips                 int default 0, 
 69: ---     cases                 int default 0, 
 70: ---     deaths                 int default 0
 71: --- );
 72: 
 73: update us_counties_sars_cov_2 as t1
 74:     set cases = (
 75:         select sum(t2.cases)
 76:         from us_counties_sars_cov_2 as t2    
 77:         where t2.state = t1.state  
 78:           and t2.county = t1.county_name
 79:     )
 80:     , deaths = (
 81:         select sum(t2.deaths)
 82:         from us_state_code as t2    
 83:         where t2.state = t1.state  
 84:           and t2.county = t1.county_name
 85:     )
 86: ;
 87: 
 88: 
 89: 
 90: 
 91:         select 
 92:                 t2.winner,
 93:                 sum(t1.cases) as sum_cases,
 94:                 sum(t1.deaths) as sum_deaths
 95:             from us_counties_sars_cov_2 as t1
 96:                 join election_2020 as t2 on (
 97:                             t1.state = t2.state 
 98:                         and t1.county = t2.county_name
 99:                     )
100:             group by t2.winner
101: ;
102: 
103: with t4 as (
104:     select t3.winner
105:         , t3.sum_cases
106:         , t3.sum_deaths
107:     from (
108:         select 
109:                 t2.winner,
110:                 sum(t1.cases) as sum_cases,
111:                 sum(t1.deaths) as sum_deaths
112:             from us_counties_sars_cov_2 as t1
113:                 join election_2020 as t2 on (
114:                             t1.state = t2.state 
115:                         and t1.county = t2.county_name
116:                     )
117:             group by t2.winner
118:         ) as t3
119: )
120: select t4.winner,
121:   lpad(round((t4.sum_deaths::float/(select sum(t4.sum_cases::float) from t4))::numeric
122:         * 100,2)::text||'%',13,' ') pct_chance_of_death
123:   from t4
124: ;
