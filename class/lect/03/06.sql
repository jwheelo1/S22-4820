select t1.id, t1.year + 10 as "x", t1.state||', '||t1.county_name as "Location"
    from vote_by_county  as t1
    order by 3 asc
;
