
        select sum(t2.cases)
        from us_counties_sars_cov_2 as t2    
        where t2.state = t1.state  
		  and t2.county = t1.county_name
		;
