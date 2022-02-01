drop table if exists marketing_data ;
create table if not exists marketing_data (
	name text,
	amount int,
	phone_no text
);
drop table if exists do_not_call_list ;
create table if not exists do_not_call_list (
	phone_no text,
	when_added timestamp 
);
insert into marketing_data (name, amount, phone_no) values
	( 'philip', 5000, '720-209-7888')
	,('bob', 25000, '505-444-1212')
	,('mark', 200, '307-338-1212')
	,('dave', -200, '307-130-1212')
;
insert into do_not_call_list ( phone_no, when_added ) values
	 ('505-444-1212','2021-02-04T13:14:15')
	,('505-222-1212','2020-01-03T13:14:15')
;
