
-- get a list of candiates that ran in 2020 presidential election

select distinct t1.candidate
	from vote_by_county as t1
	where t1.year = 2020
	order by 1
	;

