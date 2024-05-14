Create database health;
use health;
select * from `health care`;

-- kpi1
-- Number of Patients across various summaries

SELECT SUM(Number_of_patients_included_in_the_transfusion_summary) AS `Number of Patients in Transfusion Summary`,
 SUM(Number_of_patients_in_hypercalcemia_summary) AS `Number of Patients in Hypercalcemia Summary`, 
 SUM(Number_of_patients_in_Serum_phosphorus_summary) AS `Number of Patients in Serum Phosphorus Summary`,
 sum(Number_of_patients_included_in_hospitalization_summary) AS `Number of Patients in Hospitalization Summary`,
 sum(Number_of_Patients_included_in_survival_summary) AS `Number of Patients in Survival Summary`,
 sum(Number_of_Patients_included_in_fistula_summary) AS `Number of Patients in Fistula Summary`,
 sum(Number_of_patient_in_long_term_catheter_summary) AS `Number of Patients in Long Term Catheter Summary`,
 sum(Number_of_patients_in_nPCR_summary ) AS `Number of Patients in nPCR Summary` 
FROM `health care`;

-- kpi2
-- profit vs non-profit stats..
SELECT Chain_Organization,
  sum(CASE WHEN Profit_or_Non_Profit = "profit" THEN 1 ELSE 0 END) AS `Total Profit`, 
  sum(CASE WHEN Profit_or_Non_Profit= "non-profit" THEN 1 ELSE 0 END) AS `Total Non-Profit`,
  count(*) as total_records
FROM `health care` group by chain_organization order by `Total Profit` desc;


-- kpi3
-- Chain Organizations w.r.t. Total Performance Score as No Score

SELECT Chain_Organization, AVG(Total_Performance_Score) AS `Average Total Performance Score`
FROM `health care` group by Chain_Organization order by `Average Total Performance Score` desc;


-- kpi4
-- # of_Dialysis_Stations stats..
select Chain_Organization, count(Number_of_Dialysis_Stations) as `Number of Dialysis Stations` from `health care` group by Chain_Organization 
order by `Number of Dialysis Stations` desc;


-- kpi5
-- Number of Category Text  - As Expected

create table kpi5 (`Category` varchar(50),`Number of Patients` int(20));

INSERT INTO kpi5 (`Category`, `Number of Patients`)
SELECT 'transfusion' AS `Category`, COUNT(Patient_Transfusion_category_text) AS `Number of Patients`
FROM `health care`
WHERE Patient_Transfusion_category_text = 'As Expected';

INSERT INTO kpi5 (`Category`, `Number of Patients`)
SELECT 'survival' AS `Category`, COUNT(Patient_Survival_Category_Text) AS `Number of Patients`
FROM `health care`
WHERE Patient_Survival_Category_Text = 'As Expected';

INSERT INTO kpi5 (`Category`, `Number of Patients`)
SELECT 'hospitalization' AS `Category`, COUNT(Patient_hospitalization_category_text) AS `Number of Patients`
FROM `health care`
WHERE Patient_hospitalization_category_text= 'As Expected';

INSERT INTO kpi5 (`Category`, `Number of Patients`)
SELECT 'infection' AS `Category`, COUNT(Patient_Infection_category_text) AS `Number of Patients`
FROM `health care`
WHERE Patient_Infection_category_text= 'As Expected';

INSERT INTO kpi5 (`Category`, `Number of Patients`)
SELECT 'fitsula' AS `Category`, COUNT(Fistula_Category_Text) AS `Number of Patients`
FROM `health care`
WHERE Fistula_Category_Text= 'As Expected';

INSERT INTO kpi5 (`Category`, `Number of Patients`)
SELECT 'PPPW' AS `Category`, COUNT(PPPW_category_text) AS `Number of Patients`
FROM `health care`
WHERE PPPW_category_text= 'As Expected';

INSERT INTO kpi5 (`Category`, `Number of Patients`)
SELECT 'SWR' AS `Category`, COUNT(SWR_category_text) AS `Number of Patients`
FROM `health care`
WHERE SWR_category_text= 'As Expected';

select * from kpi5 ORDER BY `Number of Patients` desc;



-- kpi6
-- Average Payment Reduction Rate

SELECT Ownership_as_of_December_31_2018, AVG(PY2020_Payment_Reduction_Percentage) AS `Average Payment Reduction Rate`
FROM `health care` group by Ownership_as_of_December_31_2018 order by `Average Payment Reduction Rate` desc;
