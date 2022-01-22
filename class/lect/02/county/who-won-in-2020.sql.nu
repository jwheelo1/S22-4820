  1: 
  2: -- get a list of candiates that ran in 2020 presidential election
  3: 
  4: select distinct t1.candidate
  5:     from vote_by_county as t1
  6:     where t1.year = 2020
  7:     order by 1
  8:     ;
  9: 
