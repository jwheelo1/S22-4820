  1: drop table if exists marketing_data ;
  2: create table if not exists marketing_data (
  3:     name text,
  4:     amount int,
  5:     phone_no text
  6: );
  7: drop table if exists do_not_call_list ;
  8: create table if not exists do_not_call_list (
  9:     phone_no text,
 10:     when_added timestamp 
 11: );
 12: insert into marketing_data (name, amount, phone_no) values
 13:     ( 'philip', 5000, '720-209-7888')
 14:     ,('bob', 25000, '505-444-1212')
 15:     ,('mark', 200, '307-338-1212')
 16:     ,('dave', -200, '307-130-1212')
 17: ;
 18: insert into do_not_call_list ( phone_no, when_added ) values
 19:      ('505-444-1212','2021-02-04T13:14:15')
 20:     ,('505-222-1212','2020-01-03T13:14:15')
 21: ;
