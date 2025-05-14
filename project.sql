CREATE TABLE cheese_production (
    Year INTEGER,
    Period TEXT,
    Geo_Level TEXT,
    State_ANSI INTEGER,
    Commodity_ID INTEGER,
    Domain TEXT,
    Value INTEGER
);

CREATE TABLE cheese_clean AS
SELECT "Year", "Period", "Geo_Level", "State_ANSI", "Commodity_ID", "Domain", "Value"
FROM cheese_production
WHERE Value IS NOT NULL;


CREATE TABLE honey_production (
    Year INTEGER,
    Geo_Level TEXT,
    State_ANSI INTEGER,
    Commodity_ID INTEGER,
    Value INTEGER
);

CREATE TABLE honey_clean AS
SELECT "Year", "Geo_Level", "State_ANSI", "Commodity_ID", "Value"
FROM honey_production
WHERE Value IS NOT NULL;


CREATE TABLE milk_production (
    Year INTEGER,
    Period TEXT,
    Geo_Level TEXT,
    State_ANSI INTEGER,
    Commodity_ID INTEGER,
    Domain TEXT,
    Value INTEGER
);

CREATE TABLE milk_clean AS
SELECT "Year", "Period", "Geo_Level", "State_ANSI", "Commodity_ID", "Domain","Value"
FROM milk_production
WHERE Value IS NOT NULL;

CREATE TABLE coffee_production (
    Year INTEGER,
    Period TEXT,
    Geo_Level TEXT,
    State_ANSI INTEGER,
    Commodity_ID INTEGER,
    Value INTEGER
);

CREATE TABLE coffee_clean AS
SELECT "Year", "Period", "Geo_Level", "State_ANSI", "Commodity_ID","Value"
FROM coffee_production
WHERE Value IS NOT NULL;


CREATE TABLE egg_production (
    Year INTEGER,
    Period TEXT,
    Geo_Level TEXT,
    State_ANSI INTEGER,
    Commodity_ID INTEGER,
    Value INTEGER
);

CREATE TABLE egg_clean AS
SELECT "Year", "Period", "Geo_Level", "State_ANSI", "Commodity_ID","Value"
FROM egg_production
WHERE Value IS NOT NULL;

CREATE TABLE state_lookup (
    State TEXT,
    State_ANSI INTEGER
);

CREATE TABLE state_clean AS
SELECT "State", "State_ANSI"
FROM state_lookup
WHERE State IS NOT NULL;


CREATE TABLE yogurt_production (
    Year INTEGER,
    Period TEXT,
    Geo_Level TEXT,
    State_ANSI INTEGER,
    Commodity_ID INTEGER,
    Domain TEXT,
    Value INTEGER
);

CREATE TABLE yogurt_clean AS
SELECT "Year", "Period", "Geo_Level", "State_ANSI", "Commodity_ID","Domain","Value"
FROM yogurt_production
WHERE Value IS NOT NULL;


UPDATE cheese_clean SET value = REPLACE(value, ',', '');
UPDATE honey_clean SET value = REPLACE(value, ',', '');
UPDATE milk_clean SET value = REPLACE(value, ',', '');
UPDATE coffee_clean SET value = REPLACE(value, ',', '');
UPDATE egg_clean SET value = REPLACE(value, ',', '');
UPDATE yogurt_clean SET value = REPLACE(value, ',', '');

###################################################

SELECT SUM(Value)
FROM milk_clean
WHERE YEAR = 2023

###################################################

SELECT *
FROM coffee_clean
WHERE YEAR = 2015

###################################################

SELECT AVG(Value)
FROM honey_clean
WHERE YEAR = 2022

###################################################

SELECT * 
FROM state_clean
WHERE State = 'IOWA'

###################################################
SELECT MAX(Value)
FROM yogurt_clean
WHERE YEAR = 2022

###################################################

SELECT *
FROM state_clean s JOIN honey_clean h ON s.State_ANSI = h.State_ANSI
JOIN milk_clean m ON s.State_ANSI = m.State_ANSI
WHERE h.YEAR = 2022 AND m.YEAR = 2022;

###################################################

SELECT 
  CASE 
    WHEN EXISTS (
      SELECT 1 FROM honey_clean WHERE State_ANSI = 35 AND Year = 2022
    )
    AND EXISTS (
      SELECT 1 FROM milk_clean WHERE State_ANSI = 35 AND Year = 2022
    )
    THEN 'Yes'
    ELSE 'No'
  END AS ProducedBothHoneyAndMilk;

###################################################

SELECT 'State 35' AS State,
       COUNT(DISTINCT source) AS ProductsIn2022
FROM (
    SELECT 'honey' AS source FROM honey_clean WHERE State_ANSI = 35 AND Year = 2022
    UNION
    SELECT 'milk' AS source FROM milk_clean WHERE State_ANSI = 35 AND Year = 2022
);

###################################################

SELECT SUM(y.Value)
FROM yogurt_clean y
WHERE y.YEAR = 2022 AND y.State_ANSI IN (SELECT DISTINCT c.State_ANSI
										 FROM cheese_clean c
										 WHERE c.YEAR = 2022)

###################################################
###################################################

SELECT SUM(Value)
FROM milk_clean
WHERE YEAR = 2023

###################################################
# 2
SELECT COUNT(*)
FROM cheese_clean
WHERE YEAR = 2023 AND Period = 'APR' AND CAST(Value AS INTEGER) > 100000000

###################################################

SELECT *
FROM coffee_clean
WHERE YEAR = 2011

###################################################

SELECT AVG(Value)
FROM honey_clean
WHERE YEAR = 2022

###################################################
# 5
SELECT *
FROM state_clean
WHERE State = 'FLORIDA'

###################################################

SELECT *
FROM state_clean s LEFT JOIN cheese_clean c ON s.State_ANSI = c.State_ANSI
AND c.YEAR = 2023 AND c.Period = 'APR' AND s.State = 'NEW JERSEY'
ORDER BY s.State

###################################################

SELECT SUM(y.Value)
FROM yogurt_clean y
WHERE y.YEAR = 2022 AND y.State_ANSI IN (SELECT DISTINCT c.State_ANSI
										 FROM cheese_clean c
										 WHERE c.YEAR = 2023)

###################################################
# 8
SELECT COUNT(*)
FROM state_clean s LEFT JOIN milk_clean m ON s.State_ANSI = m.State_ANSI AND m.YEAR = 2023
WHERE m.State_ANSI IS NULL

###################################################

SELECT *
FROM state_clean s LEFT JOIN cheese_clean c ON s.State_ANSI = c.State_ANSI AND c.YEAR = 2023 AND c.Period = 'APR'
WHERE c.State_ANSI IS NULL

###################################################

SELECT AVG(c.Value)
FROM coffee_clean c
WHERE c.YEAR IN (SELECT h.YEAR
				 FROM honey_clean h
				 GROUP BY h.Year
				 HAVING SUM(h.Value) > 100000)

###################################################
