  1: select * 
  2:     from marketing_data as t1
  3:         cross join do_not_call_list as t2 
  4: ;
