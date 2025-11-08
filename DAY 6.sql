-- ----------------------------------------------DAY 6-----------------------------------------------------------------------------------
   -- practise questions
   -- 1.Count the number of patients by each service.
   SELECT service, count(patient_id) as Total_no_of_patients 
   FROM patients
   GROUP BY service;
   -- 2. Calculate the average age of patients grouped by service.
    SELECT service, round(avg(age),0) as Avg_age_of_patients 
   FROM patients
   GROUP BY service;
   -- 3. Find the total number of staff members per role.
   SELECT role, count(staff_id) as Total_no_of_staff 
   FROM staff
   GROUP BY role;
   
   -- DAY 6 challenge
   --  For each hospital service, calculate the total number of patients admitted, total patients refused, and the admission rate (percentage of requests that were admitted). Order by admission rate descending.
   SELECT service, sum(patients_admitted) AS Tot_patients_admitted,
          sum(patients_refused) AS Tot_patients_refused,
          ROUND((sum(patients_admitted)/sum(patients_request))*100,2) AS admission_rate
	FROM services_weekly
    GROUP BY service
    ORDER BY admission_rate DESC;