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

