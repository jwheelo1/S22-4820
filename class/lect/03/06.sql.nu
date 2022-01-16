  1: select t1.id, t1.year + 10 as "x", t1.state||', '||t1.county_name as "Location"
  2:     from vote_by_county  as t1
  3:     order by 3 asc
  4: ;
