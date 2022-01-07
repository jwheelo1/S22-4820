with t4 as (
    select t3.winner
        , t3.sum_cases
        , t3.sum_deaths
    from (
        select 
                t2.winner,
                sum(t1.cases) as sum_cases,
                sum(t1.deaths) as sum_deaths
            from us_counties_sars_cov_2 as t1
                join election_2020 as t2 on (
                            t1.state = t2.state 
                        and t1.county = t2.county_name
                    )
            group by t2.winner
        ) as t3
)
select t4.winner,
  lpad(round((t4.sum_deaths::float/(select sum(t4.sum_cases::float) from t4))::numeric
		* 100,2)::text||'%',13,' ') pct_chance_of_death
  from t4
;
