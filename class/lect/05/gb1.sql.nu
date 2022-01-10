  1: select state, min(year), sum(totalvotes) as state_total_votes
  2:     from vote_by_county 
  3:     where year = 2020
  4:     group by state
  5: ;
