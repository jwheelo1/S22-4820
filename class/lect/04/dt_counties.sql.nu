  1: select t1.state, t1.county_name
  2: from vote_by_county as t1
  3: where t1.year = 2020
  4:     and t1.candidate = 'Donald J Trump'
  5:     and t1.candidatevotes = (
  6:         select max(t2.candidatevotes) as max_votes
  7:         from vote_by_county as t2
  8:         where t2.state = t1.state
  9:           and t2.county_name = t1.county_name
 10:     )
 11:     order by state, county_name
 12:     ;
