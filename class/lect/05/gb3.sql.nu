  1: select state, candidate,  
  2:         min(year) as year,
  3:         sum(candidatevotes) as votes_for_candiate,
  4:         sum(totalvotes) total_votes, 
  5:     from vote_by_county as t1
  6:     where t1.year = 2020
  7:     group by t1.state, t1.candidate      
  8:     having sum(t1.candidatevotes) = (
  9:         select max(t3.state_total) as max_state_total 
 10:         from (
 11:             select candidate, sum(t2.candidatevotes) as state_total
 12:             from vote_by_county as t2
 13:             where t2.year = 2020
 14:               and t2.state = t1.state
 15:             group by candidate
 16:         ) as t3
 17:     )
 18:     order by 3, 1, 2, 4 desc
 19: ;
