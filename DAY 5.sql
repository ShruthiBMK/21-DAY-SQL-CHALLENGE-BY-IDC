  -- ------------------------------------------------------DAY 5--------------------------------------------------------------------------
  -- Practise questions
  -- 1.Count the total number of patients in the hospital.
   SELECT count(patient_id) AS total_no_of_patients FROM patients;
   -- 2. Calculate the average satisfaction score of all patients.
   SELECT avg(satisfaction) AS avg_satisfaction_score FROM patients;
   -- 3. Find the minimum and maximum age of patients.
   SELECT max(age) AS max_age, min(age) AS min_age FROM patients;
   -- DAY 5 challenge
   -- Calculate the total number of patients admitted, total patients refused, and the average patient satisfaction across all services and weeks. Round the average satisfaction to 2 decimal places.
   SELECT SUM(patients_admitted) AS tot_no_of_patients_admitted, 
   SUM(patients_refused) AS tot_no_of_patients_refused,
   ROUND(AVG(patients_satisfaction),2) AS avg_patient_satisfaction 
   FROM services_weekly;