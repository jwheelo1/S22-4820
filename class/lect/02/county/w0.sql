
-- Find the set of counties that voted for "Sleepy Joe" in 2020

select t1.state, t1.county_name
	from vote_by_county as t1
	where t1.year = 2020
		and t1.candidate = 'Joseph R Biden Jr'
	order by state, county_name
;

select t1.state, t1.county_name
	from vote_by_county as t1
	where t1.year = 2020
		and t1.candidate = 'Donald J Trump'
	order by state, county_name
;

