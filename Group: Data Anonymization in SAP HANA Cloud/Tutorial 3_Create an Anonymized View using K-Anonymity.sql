--Tutorial 3: Create an Anonymized View using K-Anonymity

--1. Display the original table
SELECT * FROM ANON_SAMPLE;

--2. Understand the need for anonymization (STEP 5: Run an example scenario with sample data)
SELECT "start_year", "gender", "zipcode", "salary", count(*) as "Count" FROM "ANON_SAMPLE" 
GROUP BY "start_year", "gender", "zipcode", "salary" ORDER by "Count" ASC;

--3. Create an anonymized view using K-ANONYMITY (STEP 6: Create an anonymization view with the sample data)
CREATE VIEW "SALARYANON" ("id", "start_year", "gender", "zipcode", "salary")
AS SELECT "id", "start_year", "gender", "zipcode", "salary" FROM "ANON_SAMPLE"
WITH ANONYMIZATION (ALGORITHM 'K-ANONYMITY' PARAMETERS '{"k": 8}'
COLUMN "id" PARAMETERS '{"is_sequence":true}'
COLUMN "gender" PARAMETERS '{"is_quasi_identifier":true,"hierarchy":{"embedded":[["f"],["m"]]}}'
COLUMN "zipcode" PARAMETERS '{"is_quasi_identifier":true,"hierarchy":{"embedded":[["5004","50xx"],["5005","50xx"],["5006","50xx"],["5104","51xx"],["5105","51xx"],["5106","51xx"],["5204","52xx"],["5205","52xx"],["5206","52xx"],["6006","60xx"],["6007","60xx"],["6008","60xx"],["6106","61xx"],["6107","61xx"],["6108","61xx"],["6206","62xx"],["6207","62xx"],["6208","62xx"],["7002","70xx"],["7003","70xx"],["7004","70xx"],["7102","71xx"],["7103","71xx"],["7104","71xx"],["7202","72xx"],["7203","72xx"],["7204","72xx"]]}}'
COLUMN "start_year" PARAMETERS '{"is_quasi_identifier":true,"hierarchy":{"embedded":[["1987","1986-1990","1986-1995"],["1988","1986-1990","1986-1995"],["1989","1986-1990","1986-1995"],["1990","1986-1990","1986-1995"],["1991","1991-1995","1986-1995"],["1992","1991-1995","1986-1995"],["1993","1991-1995","1986-1995"],["1994","1991-1995","1986-1995"],["1995","1991-1995","1986-1995"],["1996","1996-2000","1996-2005"],["1997","1996-2000","1996-2005"],["1998","1996-2000","1996-2005"],["1999","1996-2000","1996-2005"],["2000","1996-2000","1996-2005"],["2001","2001-2005","1996-2005"],["2002","2001-2005","1996-2005"],["2003","2001-2005","1996-2005"],["2004","2001-2005","1996-2005"],["2005","2001-2005","1996-2005"],["2006","2006-2010",">2006"],["2007","2006-2010",">2006"],["2008","2006-2010",">2006"],["2009","2006-2010",">2006"],["2010","2006-2010",">2006"],["2011","2011-2015",">2006"],["2012","2011-2015",">2006"],["2013","2011-2015",">2006"],["2014","2011-2015",">2006"],["2015","2011-2015",">2006"],["2016","2016-2020",">2006"],["2017","2016-2020",">2006"]]}}');

--4. Refresh anonymized view
REFRESH VIEW "SALARYANON" ANONYMIZATION;

--5. Query the new anonymized view
SELECT * FROM SALARYANON;

--6. Understand how anonymization improves original data in matters of data protection
SELECT "start_year", "gender", "zipcode", count(*) as "Count", MAX("salary") FROM "SALARYANON" 
GROUP BY "start_year", "gender", "zipcode" ORDER by "Count" ASC;

--7. Create a function for column zipcode (STEP 8: Create a hierarchy function that shortens numbers from right to left)
create or replace function "ZipCodeHierarchy"(value varchar(255), level integer)
returns outValue varchar(255)
as
charsToShow integer default 0;
begin
charsToShow := length(value) - level;
outValue := rpad(substring(value, 1, charsToShow), charsToShow+level,'*');
end;

--8. Create an anonymized view using the above funtion
CREATE VIEW "SALARYANON_ZIP" ("id", "start_year", "gender", "zipcode", "salary")
AS SELECT "id", "start_year", "gender", "zipcode", "salary" FROM "ANON_SAMPLE"
WITH ANONYMIZATION (ALGORITHM 'K-ANONYMITY' PARAMETERS '{"k": 8}'
COLUMN "id" PARAMETERS '{"is_sequence":true}'
COLUMN "gender" PARAMETERS '{"is_quasi_identifier":true,"hierarchy":{"embedded":[["f"],["m"]]}}'
COLUMN "zipcode" PARAMETERS '{"is_quasi_identifier":true,"hierarchy":{"schema":"DBADMIN", "function":"ZipCodeHierarchy", "levels":4}}'
COLUMN "start_year" PARAMETERS '{"is_quasi_identifier":true,"hierarchy":{"embedded":[["1987","1986-1990","1986-1995"],["1988","1986-1990","1986-1995"],["1989","1986-1990","1986-1995"],["1990","1986-1990","1986-1995"],["1991","1991-1995","1986-1995"],["1992","1991-1995","1986-1995"],["1993","1991-1995","1986-1995"],["1994","1991-1995","1986-1995"],["1995","1991-1995","1986-1995"],["1996","1996-2000","1996-2005"],["1997","1996-2000","1996-2005"],["1998","1996-2000","1996-2005"],["1999","1996-2000","1996-2005"],["2000","1996-2000","1996-2005"],["2001","2001-2005","1996-2005"],["2002","2001-2005","1996-2005"],["2003","2001-2005","1996-2005"],["2004","2001-2005","1996-2005"],["2005","2001-2005","1996-2005"],["2006","2006-2010",">2006"],["2007","2006-2010",">2006"],["2008","2006-2010",">2006"],["2009","2006-2010",">2006"],["2010","2006-2010",">2006"],["2011","2011-2015",">2006"],["2012","2011-2015",">2006"],["2013","2011-2015",">2006"],["2014","2011-2015",">2006"],["2015","2011-2015",">2006"],["2016","2016-2020",">2006"],["2017","2016-2020",">2006"]]}}');

--9. Refresh anonymized view
REFRESH VIEW "SALARYANON_ZIP" ANONYMIZATION;

--10. Query the new anonymized view
SELECT * FROM "SALARYANON_ZIP";

--11. Create a function for grouping values to ranges (STEP 9: Create a hierarchy function that groups values to ranges)
create or replace FUNCTION "StartyearGroupHierarchy"(value nvarchar(100), level integer)
     RETURNS outValue varchar(100)
     LANGUAGE SQLSCRIPT 
     SQL SECURITY INVOKER AS 
BEGIN 
     DECLARE start_year integer;
	start_year := TO_INTEGER(value);
	IF (level = 0) THEN
		outValue := value;
	ELSEIF (level = 1) THEN
		IF (start_year <= 1990) THEN
			outValue := '1986-1990';
		ELSEIF (start_year <= 1995) THEN
			outValue := '1991-1995';
		ELSEIF (start_year <= 2000) THEN
			outValue := '1996-2000';
		ELSEIF (start_year <= 2005) THEN
			outValue := '2001-2005';
		ELSEIF (start_year <= 2010) THEN
			outValue := '2006-2010';
		ELSEIF (start_year <= 2015) THEN
			outValue := '2011-2015';
		ELSEIF (start_year <= 2020) THEN
			outValue := '2016-2020';
		END IF;
	ELSEIF (level = 2) THEN
		IF (start_year <= 1990) THEN
			outValue := '1986-1990';
		ELSEIF (start_year <= 2000) THEN
			outValue := '1991-2000';
		ELSEIF (start_year <= 2010) THEN
			outValue := '2001-2010';
		ELSEIF (start_year <= 2020) THEN
			outValue := '>2010';
		END IF;
	ELSEIF (level = 3) THEN
		outValue := '*';
	END IF;
END;

--12. Create an anonymized view using the above funtion
CREATE VIEW "SALARYANON_SYFN" ("id", "start_year", "gender", "zipcode", "salary")
AS SELECT "id", "start_year", "gender", "zipcode", "salary" FROM "ANON_SAMPLE"
WITH ANONYMIZATION (ALGORITHM 'K-ANONYMITY' PARAMETERS '{"k": 8}'
COLUMN "id" PARAMETERS '{"is_sequence":true}'
COLUMN "gender" PARAMETERS '{"is_quasi_identifier":true,"hierarchy":{"embedded": [["f"], ["m"]]}}'
COLUMN "start_year" PARAMETERS '{"is_quasi_identifier":true,"hierarchy":{"schema":"DBADMIN", "function":"StartyearGroupHierarchy", "levels":3}}'
COLUMN "zipcode" PARAMETERS '{"is_quasi_identifier":true,"hierarchy":{"embedded":[["5004"],["5005"],["5006"],["5104"],["5105"],["5106"],["5204"],["5205"],["5206"],["6006"],["6007"],["6008"],["6106"],["6107"],["6108"],["6206"],["6207"],["6208"],["7002"],["7003"],["7004"],["7102"],["7103"],["7104"],["7202"],["7203"],["7204"]]}}');

--13. Refresh anonymized view
REFRESH VIEW "SALARYANON_SYFN" ANONYMIZATION;

--14. Query the new anonymized view
SELECT * FROM "SALARYANON_SYFN";
