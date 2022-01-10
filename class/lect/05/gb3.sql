select state, candidate,  
		min(year) as year,
		sum(candidatevotes) as votes_for_candiate,
		sum(totalvotes) total_votes, 
	from vote_by_county as t1
	where t1.year = 2020
	group by t1.state, t1.candidate      
	having sum(t1.candidatevotes) = (
		select max(t3.state_total) as max_state_total 
		from (
			select candidate, sum(t2.candidatevotes) as state_total
			from vote_by_county as t2
			where t2.year = 2020
			  and t2.state = t1.state
			group by candidate
		) as t3
	)
	order by 3, 1, 2, 4 desc
;
