select id, year + 10 as "x", state||', '||county_name as "Location"
    from vote_by_county 
    order by 3
;
