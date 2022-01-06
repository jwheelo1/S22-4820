
-- Find the set of counties that voted for "Sleepy Joe" in 2020

select t1.state, t1.county_name
from vote_by_county as t1
where t1.year = 2020
	and t1.candidate = 'Joseph R Biden Jr'
	and t1.candidatevotes = (
		select max(t2.candidatevotes) as max_votes
		from vote_by_county as t2
		where t2.state = t1.state
		  and t2.county_name = t1.county_name
	)
	order by state, county_name
	;


