  1: delete from bea_growth_data;
  2: \COPY bea_growth_data ( state, county_name, dollars_2018, dollars_2019, dollars_2020, rank_in_state_2020, pct_change_2019, pct_change_2020, rank_in_state_2020_b ) FROM 'clean-data.csv' DELIMITER ',' NULL AS '(NA)' CSV;
