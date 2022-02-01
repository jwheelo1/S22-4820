select name
	from marketing_data as t1
		inner join do_not_call_list as t2 on ( t1.phone_no = t2.phone_no)
;
