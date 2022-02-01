select name, t1.phone_no, when_added
	from marketing_data as t1
		left join do_not_call_list as t2 on ( t1.phone_no = t2.phone_no)
		where t2.phone_no is null 
;
