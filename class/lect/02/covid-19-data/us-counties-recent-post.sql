
alter table us_counties_sars_cov_2 add state_code varchar(2);

-- pull state code from us_state_code

update us_counties_sars_cov_2 as t1
	set state_code = ( select state_code
		from us_state_code as t2
		where t2.state = t1.state )
	;
