
		select sum(t2.candidatevotes) 
		from vote_by_county as t2
		where t2.year = 2020
		  and t2.state = 'Wyoming'
		;

		select candidate, sum(t2.candidatevotes) 
		from vote_by_county as t2
		where t2.year = 2020
		  and t2.state = 'Wyoming'
		group by candidate
		;

		select max(t3.state_total) as max_state_total 
		from (
			select candidate, sum(t2.candidatevotes) as state_total
			from vote_by_county as t2
			where t2.year = 2020
			  and t2.state = 'Wyoming'
			group by candidate
		) as t3
		;
