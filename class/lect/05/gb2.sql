select state, candidate,  min(year), sum(candidatevotes) as votes_for_candiate,
		sum(totalvotes) total_votes
	from vote_by_county 
	where year = 2020
	group by state, candidate      
	order by 3, 1, 2, 4 desc
;
