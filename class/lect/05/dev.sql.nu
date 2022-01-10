  1: 
  2:         select sum(t2.candidatevotes) 
  3:         from vote_by_county as t2
  4:         where t2.year = 2020
  5:           and t2.state = 'Wyoming'
  6:         ;
  7: 
  8:         select candidate, sum(t2.candidatevotes) 
  9:         from vote_by_county as t2
 10:         where t2.year = 2020
 11:           and t2.state = 'Wyoming'
 12:         group by candidate
 13:         ;
 14: 
 15:         select max(t3.state_total) as max_state_total 
 16:         from (
 17:             select candidate, sum(t2.candidatevotes) as state_total
 18:             from vote_by_county as t2
 19:             where t2.year = 2020
 20:               and t2.state = 'Wyoming'
 21:             group by candidate
 22:         ) as t3
 23:         ;
