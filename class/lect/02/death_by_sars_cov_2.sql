
-- Death from COVID-19 (sars_cov_2)

--- -- Sample Table:
--- 
--- -- date,county,state,fips,cases,deaths
--- -- 2021-12-06,Autauga,Alabama,01001,10562,157
--- -- 2021-12-06,Baldwin,Alabama,01003,38215,589
--- 
--- 
--- drop table if exists us_counties_sars_cov_2 ;
--- create table us_counties_sars_cov_2 (
--- 	id					serial primary key,
--- 	observation_date 	date,
--- 	county_name			text, 
--- 	state 				text, 
--- 	fips 				int default 0, 
--- 	cases 				int default 0, 
--- 	deaths 				int default 0,
--- 	winner 				text
--- );
--- 
--- -- pull state code from us_state_code




alter table us_counties_sars_cov_2 add state_code varchar(2);

update us_counties_sars_cov_2 as t1
    set state_code = (
        select t2.state  -- note the really bad table name, "state"
                         -- is the satee abreviation like "WY".
        from us_state_code as t2    
        where t2.state_name = t1.state  -- note "state" is the long 
                                        -- state name, Wyoming.
    )
;





alter table us_counties_sars_cov_2 add winner text;

update us_counties_sars_cov_2 as t0
    set winner = ( select t1.candidate
		from vote_by_county as t1
		where t1.year = 2020
		  and t1.candidatevotes = (
				select max(t2.candidatevotes) as max_votes
				from vote_by_county as t2
				where t2.state = t1.state
				  and t2.county_name = t1.county_name
			)
		  and t1.state = t0.state
		  and t1.county_name = t0.county
	)
;



--- create table us_counties_sars_cov_2 (
--- 	id					serial primary key,
--- 	observation_date 	date,
--- 	county 				text, 
--- 	state 				text, 
--- 	fips 				int default 0, 
--- 	cases 				int default 0, 
--- 	deaths 				int default 0
--- );

update us_counties_sars_cov_2 as t1
    set cases = (
        select sum(t2.cases)
        from us_counties_sars_cov_2 as t2    
        where t2.state = t1.state  
		  and t2.county = t1.county_name
    )
    , deaths = (
        select sum(t2.deaths)
        from us_state_code as t2    
        where t2.state = t1.state  
		  and t2.county = t1.county_name
	)
;




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
