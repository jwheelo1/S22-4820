  1: select name, when_added
  2:     from marketing_data as t1
  3:         full outer join do_not_call_list as t2 on ( t1.phone_no = t2.phone_no)
  4: ;
