  1: \COPY us_countines_sars_cov_2 ( observation_date, county, state, fips, cases, deaths ) FROM 'us-counties-recent.csv' DELIMITER ',' NULL AS '' CSV HEADER;
