  1: with t4 as (
  2:     select t3.winner
  3:         , t3.sum_cases
  4:         , t3.sum_deaths
  5:     from (
  6:         select 
  7:                 t2.winner,
  8:                 sum(t1.cases) as sum_cases,
  9:                 sum(t1.deaths) as sum_deaths
 10:             from us_counties_sars_cov_2 as t1
 11:                 join election_2020 as t2 on (
 12:                             t1.state = t2.state 
 13:                         and t1.county = t2.county_name
 14:                     )
 15:             group by t2.winner
 16:         ) as t3
 17: )
 18: select t4.winner,
 19:   lpad(round((t4.sum_deaths::float/(select sum(t4.sum_cases::float) from t4))::numeric
 20:         * 100,2)::text||'%',13,' ') pct_chance_of_death
 21:   from t4
 22: ;
