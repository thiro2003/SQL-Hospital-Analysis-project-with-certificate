create database Hospital;
use Hospital;
-- checking the data imported 
select * from hospital_data;
-- changing table name
alter table hospital_data rename to hospital;
-- checking renamed table
select * from hospital;
-- changing column names
alter table hospital rename column `ï»¿Hospital Name` to   Hospital_Name;
alter table hospital rename column `Doctors Count` to   Doctors_Count;
alter table hospital rename column `Patients Count` to   Patients_Count;
alter table hospital rename column `Admission Date` to   Admission_Date;
alter table hospital rename column `Discharge Date` to   Discharge_Date;
alter table hospital rename column `Medical Expenses` to   Medical_Expenses;
-- checking changed column name
select * from hospital; 
-- checking data types
desc hospital;
-- changing   Admission Date and Discharge Date datatype text to date types
set sql_safe_updates=0;
update hospital set  Admission_Date = str_to_date(Admission_Date,'%d-%m-%Y');
alter table hospital modify column Admission_Date date;
update hospital set  Discharge_Date = str_to_date(Discharge_Date,'%d-%m-%Y');
alter table hospital modify column  Discharge_Date date;
-- alter table hospital modify column Discharge_Date date;
-- 1. Total Number of Patients 
--  Write an SQL query to find the total number of patients across all hospitals. 
select sum(Patients_Count) from hospital; -- 9347

-- 2. Average Number of Doctors per Hospital  
-- Retrieve the average count of doctors available in each hospital. 
select round(avg(Doctors_Count),2) from hospital; -- 26.71

-- 3. Top 3 Departments with the Highest Number of Patients 
-- Find the top 3 hospital departments that have the highest number of patients.
select Department,sum(Patients_Count) from hospital group by Department order by sum(Patients_Count) desc limit 3; -- Urology	1766 ,Neurology	1229 ,ENT	1064

-- 4. Hospital with the Maximum Medical Expenses 
--  Identify the hospital that recorded the highest medical expenses.  
select Hospital_Name, sum(Medical_Expenses) from hospital group by Hospital_Name order by sum(Medical_Expenses)  desc limit 1; -- Healing Touch	352178.06

-- 5. Daily Average Medical Expenses 
-- Calculate the average medical expenses per day for each hospital.
alter table hospital add column Day_Count int ;
update hospital set Day_Count= datediff(Discharge_Date,Admission_Date);
select * from hospital;
desc hospital;
select Hospital_Name,Medical_Expenses,Day_Count, round(Medical_Expenses/nullif(Day_Count,0),2) as Average_Medical_Expense_Per_Day from  hospital;

-- 6. Longest Hospital Stay 
-- o Find the patient with the longest stay by calculating the difference between 
-- Discharge Date and Admission Date.

select Hospital_Name,max(Day_Count) from hospital Group by Hospital_Name; -- Wellness Clinic	14


-- 7. Total Patients Treated Per City 
-- Count the total number of patients treated in each city. 

select * from hospital;
select Location, sum(round(Patients_Count/nullif(Day_Count,0),0)) as Patient_Treated_Per_Day from hospital group by Location order by sum(Patients_Count/nullif(Day_Count,0)) desc;


-- 8. Average Length of Stay Per Department 
-- Calculate the average number of days patients spend in each department.

select Department,round(avg(Day_Count),2) from hospital group by Department; 



-- 9. Identify the Department with the Lowest Number of Patients 
-- Find the department with the least number of patients. 
select Department,min(Day_Count) as minimum_Patients from hospital group by Department order by min(Day_Count) desc limit 1;


-- 10. Monthly Medical Expenses Report 
-- • Group the data by month and calculate the total medical expenses for each month.

select month(Discharge_Date) as `Month`,round(sum(Medical_Expenses),2) from hospital group by month(Discharge_Date); 