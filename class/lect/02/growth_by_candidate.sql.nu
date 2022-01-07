  1: 
  2: -- Calculate growth in counties by Presidental Candidate
  3: 
  4: drop table if exists election_2020 ;
  5: create table election_2020 (
  6:     id           serial primary key,
  7:     county_name  text,
  8:     state        text,
  9:     winner       text -- either 'Joseph R Biden Jr' or 'Donald...'
 10: );
 11: 
 12: insert into election_2020 ( county_name, state, winner )
 13:     select t1.state, t1.county_name, 'Joseph R Biden Jr'
 14:     from vote_by_county as t1
 15:     where t1.year = 2020
 16:         and t1.candidate = 'Joseph R Biden Jr'
 17:         and t1.candidatevotes = (
 18:             select max(t2.candidatevotes) as max_votes
 19:             from vote_by_county as t2
 20:             where t2.state = t1.state
 21:               and t2.county_name = t1.county_name
 22:         )
 23: ;
 24: insert into election_2020 ( county_name, state, winner )
 25:     select t1.state, t1.county_name, 'Donald J Trump'
 26:     from vote_by_county as t1
 27:     where t1.year = 2020
 28:         and t1.candidate = 'Donald J Trump'
 29:         and t1.candidatevotes = (
 30:             select max(t2.candidatevotes) as max_votes
 31:             from vote_by_county as t2
 32:             where t2.state = t1.state
 33:               and t2.county_name = t1.county_name
 34:         )
 35: ;
 36: 
 37: -- from: ./CAGGP9/rpt_wy.sql
 38: -- create table per_county_gdp_growth (
 39: --     id                serial primary key,
 40: --     all_data_id       int,
 41: --     county_name       text,
 42: --     state_code        text,
 43: --     from_gdp          int,
 44: --     to_gdp            int,
 45: --     growth_amt        int,
 46: --     growth_pct        float,        -- pct implies multiped by 100.0
 47: --     from_year         int default 2010,
 48: --     to_year           int default 2020
 49: -- );
 50: 
 51: alter table per_county_gdp_growth add state text ;
 52: update per_county_gdp_growth as t1
 53:     set state = (
 54:         select t2.state_name  -- note the really bad table name, "state_name"
 55:                               -- is the long State, "Wyoming" for example.
 56:         from us_state_code as t2    
 57:         where t2.state = t1.state_code  -- note "state" is the 2 letter code.
 58:                                         -- "WY" for example.
 59:     )
 60: ;
 61: 
 62: with t4 as (
 63:     select t3.winner
 64:         , t3.sum_growth
 65:         , t3.sum_from_gdp
 66:     from (
 67:         select 
 68:                 t2.winner,
 69:                 sum(t1.growth_amt) as sum_growth,
 70:                 sum(t1.from_gdp) as sum_from_gdp
 71:             from per_county_gdp_growth as t1
 72:                 join election_2020 as t2 on (
 73:                             t1.state = t2.state 
 74:                         and t1.county_name = t2.county_name
 75:                     )
 76:             group by t2.winner
 77:         ) as t3
 78: )
 79: select t4.winner,
 80:   lpad(round((t4.sum_growth::float/(select sum(t4.sum_growth::float) from t4))::numeric
 81:         * 100,2)::text||'%',13,' ') pct_of_growth
 82:   from t4
 83: ;
