 -- --------------------------------------------DAY 7-----------------------------------------------------------
  -- practise questions
  -- 1.Find services that have admitted more than 500 patients in total.
  SELECT service, sum(patients_admitted) AS Tot_patients_admitted
	FROM services_weekly
    GROUP BY service
    HAVING Tot_patients_admitted > 500;
    -- 2. Show services where average patient satisfaction is below 75.
     SELECT service, AVG(patients_satisfaction) AS Avg_patients_satisfaction
	FROM services_weekly
    GROUP BY service
    HAVING Avg_patients_satisfaction < 75;
    -- 3. List weeks where total staff presence across all services was less than 50.
SELECT
    week,
    SUM(present) AS total_staff_present
FROM staff_schedule
GROUP BY week
HAVING SUM(present) < 50;

-- DAY 7 Challenge
-- Identify services that refused more than 100 patients in total and had an average patient satisfaction below 80. Show service name, total refused, and average satisfaction.
SELECT service, sum(patients_refused) AS tot_patients_refused,
		avg(patients_satisfaction) AS avg_satisfaction
FROM services_weekly
GROUP BY service
HAVING tot_patients_refused >100 
        AND
   avg_satisfaction< 80;   