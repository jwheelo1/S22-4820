  1: select t1.phone_no
  2:     from marketing_data as t1
  3: except 
  4:     select t2.phone_no
  5:     from do_not_call_list as t2
  6: ;
