-- --------------------------------------------------------------------DAY 19----------------------------------------------------------
-- Practice questions
-- 1. Rank patients by satisfaction score within each service.
SELECT
    patient_id,
    name, service,
    satisfaction,
    DENSE_RANK() OVER (PARTITION BY service ORDER BY satisfaction DESC) AS rank_
     FROM patients;
-- 2. Assign row numbers to staff ordered by their name.
SELECT staff_id, staff_name,
ROW_NUMBER() OVER(ORDER BY staff_name) AS row_no
FROM staff;
-- 3. Rank services by total patients admitted.
SELECT
    service,
    SUM(patients_admitted) AS total_admitted,
    RANK() OVER (ORDER BY SUM(patients_admitted) DESC) AS admission_rank
FROM services_weekly
GROUP BY service;

-- DAY 19 challenge
/* For each service, rank the weeks by patient satisfaction score (highest first). Show service, week, patient_satisfaction, 
patients_admitted, and the rank. Include only the top 3 weeks per service.*/
SELECT 
    t.service,
    t.week,
    t.patients_satisfaction,
    t.patients_admitted,
    t.rn AS rank_within_service
FROM (
    SELECT 
        service,
        week,
        patients_satisfaction,
        patients_admitted,
        row_number() OVER (
            PARTITION BY service
            ORDER BY patients_satisfaction DESC
        ) AS rn
    FROM services_weekly
) AS t
WHERE t.rn <= 3
ORDER BY t.service, t.rn;