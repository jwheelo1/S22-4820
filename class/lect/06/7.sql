select name, when_added
	from marketing_data as t1
		full join do_not_call_list as t2 on ( t1.phone_no = t2.phone_no)
;
