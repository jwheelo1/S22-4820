
update vote_by_county
	set state = initcap ( state_uc )
	;
update vote_by_county
	set county_name = initcap ( county_name_uc )
	;
update vote_by_county
	set candidate = initcap ( candidate_uc )
	;

