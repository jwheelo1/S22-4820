  1: select name
  2:     from marketing_data as t1
  3:         join do_not_call_list as t2 on ( t1.phone_no = t2.phone_no)
  4: ;
