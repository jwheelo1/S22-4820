  1: select state, candidate,  min(year), sum(candidatevotes) as votes_for_candiate, sum(totalvotes) total_votes
  2:     from vote_by_county 
  3:     where year = 2020
  4:     group by state, candidate      
  5:     order by 3, 1, 2, 4 desc
  6: ;
