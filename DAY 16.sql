-- ------------------------------------------------DAY 16---------------------------------------------------------------------------
-- Practice questions
-- 1. Find patients who are in services with above-average staff count.
 SELECT name as patient_name, service
FROM patients 
WHERE service IN(SELECT service FROM
staff GROUP BY service
HAVING COUNT(distinct staff_id)>
(SELECT AVG(staff_count) FROM
(SELECT COUNT(DISTINCT staff_id) as staff_count FROM staff
GROUP BY service) AS t));
-- 2. List staff who work in services that had any week with patient satisfaction below 70.

SELECT DISTINCT s.staff_name, s.service
FROM staff s
JOIN staff_schedule ss ON s.staff_name = ss.staff_name
WHERE ss.week IN (
    SELECT week
    FROM services_weekly
    WHERE patients_satisfaction < 70
)
AND s.service IN (
    SELECT service
    FROM services_weekly
    WHERE patients_satisfaction < 70
);
-- 3.Show patients from services where total admitted patients exceed 1000. 
SELECT name as patient_name, service
FROM patients 
WHERE service IN(SELECT service FROM
services_weekly GROUP BY service
HAVING SUM(patients_admitted)> 1000);

-- DAY 16 challenge
/* Find all patients who were admitted to services that had at least one week where patients were refused AND the 
average patient satisfaction for that service was below the overall hospital average satisfaction. 
Show patient_id, name, service, and their personal satisfaction score.*/
SELECT 
    p.patient_id,
    p.name,
    p.service,
    p.satisfaction
FROM patients p
WHERE 
    -- Condition 1: Service had at least one refused week
    EXISTS (
        SELECT 1
        FROM services_weekly sw1
        WHERE sw1.service = p.service
          AND sw1.patients_refused > 0
    )
    AND
    -- Condition 2: Service avg satisfaction < overall avg
    (
        SELECT AVG(sw2.patients_satisfaction)
        FROM services_weekly sw2
        WHERE sw2.service = p.service
    ) < (
        SELECT AVG(sw3.patients_satisfaction)
        FROM services_weekly sw3
    );