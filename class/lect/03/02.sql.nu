  1: select id, year, state, county_name
  2:     from vote_by_county 
  3:     order by county_name, state
  4: ;
