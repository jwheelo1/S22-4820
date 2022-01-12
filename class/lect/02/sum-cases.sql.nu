  1:         select 
  2:                 t2.winner,
  3:                 sum(t1.cases) as sum_cases,
  4:                 sum(t1.deaths) as sum_deaths
  5:             from us_counties_sars_cov_2 as t1
  6:                 join election_2020 as t2 on (
  7:                             t1.state = t2.state 
  8:                         and t1.county = t2.county_name
  9:                     )
 10:             group by t2.winner
 11: ;
