-- -------------------------------------------------DAY 17--------------------------------------------------------
-- Practice questions
-- 1. Show each patient with their service's average satisfaction as an additional column.
SELECT p.name AS patient_name, p.service,
(SELECT round(AVG(sw.patients_satisfaction),2) FROM services_weekly sw
WHERE p.service=sw.service) AS avg_patient_satisfaction 
FROM patients p;
-- 2. Create a derived table of service statistics and query from it.
SELECT 
    w.week, 
    w.service, 
    w.patients_admitted, 
    s.staff_assigned, 
    s.staff_present, 
    w.staff_morale
FROM services_weekly w
JOIN (
    SELECT 
        week, 
        service, 
        COUNT(staff_id) AS staff_assigned, 
        SUM(present) AS staff_present
    FROM staff_schedule
    GROUP BY week, service
) s
ON s.week = w.week AND s.service = w.service;
-- 3. Display staff with their service's total patient count as a calculated field.
SELECT  distinct s.staff_name, s.service,
(SELECT COUNT(patient_id) FROM patients p
WHERE s.service=p.service ) AS total_patient_count 
FROM staff s
ORDER BY s.staff_name;
-- DAY 17 challenge
/* Create a report showing each service with: service name, total patients admitted, the difference between 
their total admissions and the average admissions across all services, and a rank indicator ('Above Average', 
'Average', 'Below Average'). Order by total patients admitted descending.  */
 SELECT
    sw.service,
    sw.total_admission,
    round((sw.total_admission - t.avg_admission),2) AS diff,
    CASE
        WHEN sw.total_admission > t.avg_admission THEN 'Above Average'
        WHEN sw.total_admission = t.avg_admission THEN 'Average'
        ELSE 'Below Average'
    END AS rank_indicator
FROM
(
    SELECT
        service,
        SUM(patients_admitted) AS total_admission
    FROM services_weekly
    GROUP BY service
) sw
CROSS JOIN
(
    SELECT
        AVG(total_admission) AS avg_admission
    FROM
    (
        SELECT
            service,
            SUM(patients_admitted) AS total_admission
        FROM services_weekly
        GROUP BY service
    ) AS service_totals
) t;