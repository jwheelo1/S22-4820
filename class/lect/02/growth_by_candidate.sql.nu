  1: 
  2: -- Calculate growth in counties by Presidental Candidate
  3: 
  4: 
  5: -- -- from: ./county/what_counties_voted_for_joe.sql
  6: -- select t1.state, t1.county_name
  7: -- from vote_by_county as t1
  8: -- where t1.year = 2020
  9: --     and t1.candidate = 'Joseph R Biden Jr'
 10: --     and t1.candidatevotes = (
 11: --         select max(t2.candidatevotes) as max_votes
 12: --         from vote_by_county as t2
 13: --         where t2.state = t1.state
 14: --           and t2.county_name = t1.county_name
 15: --     )
 16: --     order by state, county_name
 17: --     ;
 18: --- 
 19: --- drop table if exists election_2020 ;
 20: --- create table election_2020 (
 21: ---      id                    serial primary key,
 22: ---      county_name            text,
 23: ---      state                text,
 24: ---     winner                text -- either 'Joseph R Biden Jr' or 'Donald J Trump'
 25: --- );
 26: --- 
 27: --- insert into election_2020 ( county_name, state, winner )
 28: ---     select t1.state, t1.county_name, 'Joseph R Biden Jr'
 29: ---     from vote_by_county as t1
 30: ---     where t1.year = 2020
 31: ---         and t1.candidate = 'Joseph R Biden Jr'
 32: ---         and t1.candidatevotes = (
 33: ---             select max(t2.candidatevotes) as max_votes
 34: ---             from vote_by_county as t2
 35: ---             where t2.state = t1.state
 36: ---               and t2.county_name = t1.county_name
 37: ---         )
 38: --- ;
 39: --- insert into election_2020 ( county_name, state, winner )
 40: ---     select t1.state, t1.county_name, 'Donald J Trump'
 41: ---     from vote_by_county as t1
 42: ---     where t1.year = 2020
 43: ---         and t1.candidate = 'Donald J Trump'
 44: ---         and t1.candidatevotes = (
 45: ---             select max(t2.candidatevotes) as max_votes
 46: ---             from vote_by_county as t2
 47: ---             where t2.state = t1.state
 48: ---               and t2.county_name = t1.county_name
 49: ---         )
 50: --- ;
 51: --- 
 52: -- -- from: ./CAGGP9/rpt_wy.sql
 53: -- create table per_county_gdp_growth (
 54: --     id                    serial primary key,
 55: --     all_data_id            int,
 56: --     county_name            text,
 57: --     state_code            text,
 58: --     from_gdp            int,
 59: --     to_gdp                int,
 60: --     growth_amt            int,
 61: --     growth_pct            float,        -- pct implies multiped by 100.0
 62: --     from_year            int default 2010,
 63: --     to_year                int default 2020
 64: -- );
 65: -- 
 66: -- select state_code, county_name, from_gdp, to_gdp, growth_amt, round(growth_pct::numeric,2) as growth_pct
 67: --     from per_county_gdp_growth 
 68: --     where state_code = 'WY'
 69: -- ;
 70: -- 
 71: -- alter table per_county_gdp_growth add state text ;
 72: -- update per_county_gdp_growth as t1
 73: --     set state = (
 74: --         select t2.state_name
 75: --         from us_state_code as t2
 76: --         where t2.state = t1.state_code
 77: --     )
 78: -- ;
 79: 
 80: 
 81: with t4 as (
 82:     select t3.winner
 83:         , t3.sum_growth
 84:         , t3.sum_from_gdp
 85:     from (
 86:         select 
 87:                 t2.winner,
 88:                 sum(t1.growth_amt) as sum_growth,
 89:                 sum(t1.from_gdp) as sum_from_gdp
 90:             from per_county_gdp_growth as t1
 91:                 join election_2020 as t2 on ( t1.state = t2.state and t1.county_name = t2.county_name )
 92:             group by t2.winner
 93:         ) as t3
 94: )
 95: select t4.winner,
 96:         lpad(round((t4.sum_growth::float/(select sum(t4.sum_growth::float) from t4))::numeric*100,2)::text||'%',13,' ') pct_of_growth
 97:     from t4
 98: ;
