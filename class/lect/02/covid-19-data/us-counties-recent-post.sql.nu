  1: 
  2: alter table us_counties_sars_cov_2 add state_code varchar(2);
  3: 
  4: -- pull state code from us_state_code
  5: 
  6: update us_counties_sars_cov_2 as t1
  7:     set state_code = ( select state_code
  8:         from us_state_code as t2
  9:         where t2.state = t1.state )
 10:     ;
