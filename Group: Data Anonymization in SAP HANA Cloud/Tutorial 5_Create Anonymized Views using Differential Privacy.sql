--Tutorial 5: Create Anonymized Views using Differential Privacy

--1. Create an anonymized view using Differential Privacy (STEP 5: Run an example scenario)
CREATE VIEW "SALARYANON_DP" ("id", "start_year", "salary")
AS SELECT "id", "start_year", "salary" FROM "ANON_SAMPLE"
WITH ANONYMIZATION (ALGORITHM 'DIFFERENTIAL_PRIVACY' PARAMETERS ''
COLUMN "id" PARAMETERS '{"is_sequence":true}'
COLUMN "salary" PARAMETERS '{"is_sensitive":true, "epsilon" : 0.5, "sensitivity": 100000}');

--2. Refresh anonymized view
REFRESH VIEW "SALARYANON_DP" ANONYMIZATION;

--3. Query the new anonymized view
SELECT * FROM SALARYANON_DP;

--4. Compare queries on anonymized view and original table; Anonymized view result
select "start_year", AVG("salary") from "SALARYANON_DP" group by "start_year" order by "start_year";

--5. Compare queries on anonymized view and original table; Original table result
select "start_year", AVG("salary") from "ANON_SAMPLE" group by "start_year" order by "start_year";
