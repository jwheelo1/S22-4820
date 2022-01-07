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
;
