  1: 
  2: -- Find the set of counties that voted for "Sleepy Joe" in 2020
  3: 
  4: select t1.state, t1.county_name
  5:     from vote_by_county as t1
  6:     where t1.year = 2020
  7:         and t1.candidate = 'Joseph R Biden Jr'
  8:     order by state, county_name
  9: ;
 10: 
 11: select t1.state, t1.county_name
 12:     from vote_by_county as t1
 13:     where t1.year = 2020
 14:         and t1.candidate = 'Donald J Trump'
 15:     order by state, county_name
 16: ;
 17: 
