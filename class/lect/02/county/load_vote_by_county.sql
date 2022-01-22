delete from vote_by_county;
\COPY vote_by_county ( year, state_uc, state_po, county_name_uc, county_fips, office, candidate_uc, party, candidatevotes, totalvotes, version, vote_mode ) FROM 'countypres_2000-2020.csv' DELIMITER ',' NULL AS 'NA' CSV HEADER;
