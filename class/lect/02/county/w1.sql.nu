  1: 
  2: -- Find the set of counties that voted for "Sleepy Joe" in 2020
  3: 
  4: select t1.state, t1.county_name
  5: from vote_by_county as t1
  6: where t1.year = 2020
  7:     and t1.candidate = 'Joseph R Biden Jr'
  8:     and t1.candidatevotes = (
  9:         select max(t2.candidatevotes) as max_votes
 10:         from vote_by_county as t2
 11:         where t2.state = t1.state
 12:           and t2.county_name = t1.county_name
 13:     )
 14:     order by state, county_name
 15:     ;
 16: 
 17: 
