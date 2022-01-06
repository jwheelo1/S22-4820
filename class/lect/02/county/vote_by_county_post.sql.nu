  1: 
  2: update vote_by_county
  3:     set state = initcap ( state_uc )
  4:     ;
  5: update vote_by_county
  6:     set county_name = initcap ( county_name_uc )
  7:     ;
  8: update vote_by_county
  9:     set candidate = initcap ( candidate_uc )
 10:     ;
 11: 
