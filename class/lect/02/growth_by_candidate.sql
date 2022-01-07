
-- Calculate growth in counties by Presidental Candidate

drop table if exists election_2020 ;
create table election_2020 (
    id           serial primary key,
    county_name  text,
    state        text,
    winner       text -- either 'Joseph R Biden Jr' or 'Donald...'
);

insert into election_2020 ( county_name, state, winner )
    select t1.state, t1.county_name, 'Joseph R Biden Jr'
    from vote_by_county as t1
    where t1.year = 2020
        and t1.candidate = 'Joseph R Biden Jr'
        and t1.candidatevotes = (
            select max(t2.candidatevotes) as max_votes
            from vote_by_county as t2
            where t2.state = t1.state
              and t2.county_name = t1.county_name
        )
;
insert into election_2020 ( county_name, state, winner )
    select t1.state, t1.county_name, 'Donald J Trump'
    from vote_by_county as t1
    where t1.year = 2020
        and t1.candidate = 'Donald J Trump'
        and t1.candidatevotes = (
            select max(t2.candidatevotes) as max_votes
            from vote_by_county as t2
            where t2.state = t1.state
              and t2.county_name = t1.county_name
        )
;

-- from: ./CAGGP9/rpt_wy.sql
-- create table per_county_gdp_growth (
--     id                serial primary key,
--     all_data_id       int,
--     county_name       text,
--     state_code        text,
--     from_gdp          int,
--     to_gdp            int,
--     growth_amt        int,
--     growth_pct        float,        -- pct implies multiped by 100.0
--     from_year         int default 2010,
--     to_year           int default 2020
-- );

alter table per_county_gdp_growth add state text ;
update per_county_gdp_growth as t1
    set state = (
        select t2.state_name  -- note the really bad table name, "state_name"
                              -- is the long State, "Wyoming" for example.
        from us_state_code as t2    
        where t2.state = t1.state_code  -- note "state" is the 2 letter code.
                                        -- "WY" for example.
    )
;

with t4 as (
    select t3.winner
        , t3.sum_growth
        , t3.sum_from_gdp
    from (
        select 
                t2.winner,
                sum(t1.growth_amt) as sum_growth,
                sum(t1.from_gdp) as sum_from_gdp
            from per_county_gdp_growth as t1
                join election_2020 as t2 on (
                            t1.state = t2.state 
                        and t1.county_name = t2.county_name
                    )
            group by t2.winner
        ) as t3
)
select t4.winner,
  lpad(round((t4.sum_growth::float/(select sum(t4.sum_growth::float) from t4))::numeric
		* 100,2)::text||'%',13,' ') pct_of_growth
  from t4
;
