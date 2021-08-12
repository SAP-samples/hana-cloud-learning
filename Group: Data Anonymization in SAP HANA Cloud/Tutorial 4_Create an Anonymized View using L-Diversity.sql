--Tutorial 4: Create an Anonymized View using L-Diversity

--1. Create a sample table PERSONALDATA (STEP 3: Run an example scenario)
CREATE COLUMN TABLE PERSONALDATA (
  -- sequence column
  ID BIGINT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  -- identifier
  NAME NVARCHAR(10),
  -- quasi-identifiers (QIDs) (to be generalized)
  GENDER NVARCHAR(1) NOT NULL,
  CITY NVARCHAR(10) NOT NULL,
  -- sensitive data
  AGE NVARCHAR(3) NOT NULL);
  
--2. Insert data into the columns of the table
INSERT INTO PERSONALDATA VALUES ('Peter', 'm', 'Berlin', '30');
INSERT INTO PERSONALDATA VALUES ('Sigrid', 'f', 'Cologne', '31');
INSERT INTO PERSONALDATA VALUES ('François', 'm', 'Paris', '24');
INSERT INTO PERSONALDATA VALUES ('Bernhard', 'm', 'Munich', '31');
INSERT INTO PERSONALDATA VALUES ('Pierre', 'm', 'Nice', '25');
INSERT INTO PERSONALDATA VALUES ('Andrea', 'f', 'Hamburg', '32');
INSERT INTO PERSONALDATA VALUES ('Juliette', 'f', 'Marseille', '28');
INSERT INTO PERSONALDATA VALUES ('Fabienne', 'f', 'Toulouse', '28');

--3. Create an anonymized view using L-DIVERSITY
CREATE VIEW PERSONALDATA_L_ANON (ID, GENDER, LOCATION, AGE)
AS SELECT ID, GENDER, CITY AS LOCATION, AGE
FROM PERSONALDATA
WITH ANONYMIZATION (ALGORITHM 'L-DIVERSITY'
  PARAMETERS '{"k": 2, "l": 2}'
  COLUMN ID PARAMETERS '{"is_sequence": true}'
  COLUMN GENDER PARAMETERS '{"is_quasi_identifier":true, "hierarchy":{"embedded": [["f"], ["m"]]}}'
  COLUMN LOCATION PARAMETERS '{"is_quasi_identifier":true, "hierarchy":{"embedded": [["Berlin", "Germany"], ["Cologne", "Germany"], ["Paris", "France"], ["Munich", "Germany"],
["Nice", "France"], ["Hamburg", "Germany"], ["Marseille", "France"], ["Toulouse", "France"]]}}'
  COLUMN AGE PARAMETERS '{"is_sensitive":true}');

--4. Refresh anonymized view
REFRESH VIEW PERSONALDATA_L_ANON ANONYMIZATION;

--5. Query the original data
SELECT * FROM PERSONALDATA;

--6. Query the new anonymized view
SELECT * FROM PERSONALDATA_L_ANON;

--7. What if only K-ANONIMITY was used in the above example
CREATE VIEW PERSONALDATA_K_ANON (ID, GENDER, LOCATION, AGE)
AS SELECT ID, GENDER, CITY AS LOCATION, AGE
FROM PERSONALDATA
WITH ANONYMIZATION (ALGORITHM 'K-ANONYMITY'
PARAMETERS '{"k": 2}'
COLUMN ID PARAMETERS '{"is_sequence": true}'
COLUMN GENDER PARAMETERS '{"is_quasi_identifier":true, "hierarchy":{"embedded": [["f"], ["m"]]}}'
COLUMN LOCATION PARAMETERS '{"is_quasi_identifier":true, "hierarchy":{"embedded": [["Berlin", "Germany"], ["Cologne", "Germany"], ["Paris", "France"], ["Munich", "Germany"],
["Nice", "France"], ["Hamburg", "Germany"], ["Marseille", "France"], ["Toulouse", "France"]]}}');

--8. Refresh anonymized view
REFRESH VIEW PERSONALDATA_K_ANON ANONYMIZATION;

--9. Query the new anonymized view
SELECT * FROM PERSONALDATA_K_ANON;