  1: select id, year + 10 as "x", state||', '||county_name as "Location"
  2:     from vote_by_county 
  3:     order by 3
  4: ;
