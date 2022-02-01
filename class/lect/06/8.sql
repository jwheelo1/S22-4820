select t1.phone_no
	from marketing_data as t1
except 
	select t2.phone_no
	from do_not_call_list as t2
;
