select state, min(year), sum(totalvotes) as state_total_votes
	from vote_by_county 
	where year = 2020
	group by state
;
