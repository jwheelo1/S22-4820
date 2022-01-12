  1:      select t1.candidate, t1.state, t1.county_name
  2:         from vote_by_county as t1
  3:         where t1.year = 2020
  4:           and t1.candidatevotes = (
  5:                 select max(t2.candidatevotes) as max_votes
  6:                 from vote_by_county as t2
  7:                 where t2.state = t1.state
  8:                   and t2.county_name = t1.county_name
  9:             )
 10: ;
