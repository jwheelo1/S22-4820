select t1.name
	from marketing_data as t1, do_not_call_list as t2
	where t1.phone_no = t2.phone_no
;
