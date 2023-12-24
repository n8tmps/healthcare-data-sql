CREATE TABLE conditions (
START DATE
,STOP DATE
,PATIENT VARCHAR(1000)
,ENCOUNTER VARCHAR(1000)
,CODE VARCHAR(1000)
,DESCRIPTION VARCHAR(200)
);

CREATE TABLE encounters (
 Id VARCHAR(100)
,START TIMESTAMP
,STOP TIMESTAMP
,PATIENT VARCHAR(100)
,ORGANIZATION VARCHAR(100)
,PROVIDER VARCHAR(100)
,PAYER VARCHAR(100)
,ENCOUNTERCLASS VARCHAR(100)
,CODE VARCHAR(100)
,DESCRIPTION VARCHAR(100)
,BASE_ENCOUNTER_COST FLOAT
,TOTAL_CLAIM_COST FLOAT
,PAYER_COVERAGE FLOAT
,REASONCODE VARCHAR(100)
--,REASONDESCRIPTION VARCHAR(100)
);

CREATE TABLE immunizations
(
 DATE TIMESTAMP
,PATIENT varchar(100)
,ENCOUNTER varchar(100)
,CODE int
,DESCRIPTION varchar(500)
--,BASE_COST float
);

CREATE TABLE patients
(
 Id VARCHAR(100)
,BIRTHDATE date
,DEATHDATE date
,SSN VARCHAR(100)
,DRIVERS VARCHAR(100)
,PASSPORT VARCHAR(100)
,PREFIX VARCHAR(100)
,FIRST VARCHAR(100)
,LAST VARCHAR(100)
,SUFFIX VARCHAR(100)
,MAIDEN VARCHAR(100)
,MARITAL VARCHAR(100)
,RACE VARCHAR(100)
,ETHNICITY VARCHAR(100)
,GENDER VARCHAR(100)
,BIRTHPLACE VARCHAR(100)
,ADDRESS VARCHAR(100)
,CITY VARCHAR(100)
,STATE VARCHAR(100)
,COUNTY VARCHAR(100)
,FIPS INT 
,ZIP INT
,LAT float
,LON float
,HEALTHCARE_EXPENSES float
,HEALTHCARE_COVERAGE float
,INCOME int
,Mrn int
);

-- name and birthdate of patient
SELECT first,
		last,
		birthdate 
FROM public.patients;

-- types of hospital encounters
select distinct encounterclass
from public.encounters;

-- return inpatient and ICU admission in 2023
select *
from public.encounters
where encounterclass = 'inpatient'
and description = 'ICU Admission'
and stop >= '2023-01-01 00:00'
and stop <= '2023-12-31 23:59'
-- and stop between '2022-01-01 00:00' and '2023-12-31 23:59';

-- return outpatient and ambulatory
select *
from public.encounters
where encounterclass in ('outpatient', 'ambulatory');

------------------------------
select description,
		count(*) as count_of_cond
from public.conditions
where description != 'Body Mass Index 30.0-30.9, adult'
group by description
having count(*) > 3000
order by count(*) desc;

-- 1. write a query that selects all patients from Boston
select * from public.patients
where city = 'Boston';

-- 2. select all patients who have been diagnosed with Chronic Kidney Disease
select * from public.conditions
where code in ('585.1', '585.2', '585.3', '585.4');

-- 3. write a query that
-- lists out # of patients per city in descending order
-- does not include Boston
-- must have at least 100 patient from that city
select city, count(*) as npatients
from public.patients
where city != 'Boston'
group by city
having count(*) >= 100
order by count(*) desc;

-- JOINS
select * from public.immunizations;

select t1.*,
		t2.first,
		t2.last,
		t2.birthdate
from public.immunizations as t1
left join public.patients as t2
on t1.patient = t2.id;





