-- -------------------------------------------------------DAY 15--------------------------------------------------------------------------
-- Practice Questions:
-- 1. Join patients, staff, and staff_schedule to show patient service and staff availability.
SELECT 
    p.patient_id,
    p.name AS patient_name,
    p.service AS patient_service,

    s.staff_id,
    s.staff_name,
    s.service AS staff_service,
    ss.week,
    ss.present AS staff_available
FROM patients p
LEFT JOIN staff s 
    ON p.service = s.service         
LEFT JOIN staff_schedule ss
    ON s.staff_name = ss.staff_name       
ORDER BY p.patient_id, s.staff_id, ss.week;
-- 2. Combine services_weekly with staff and staff_schedule for comprehensive service analysis.
SELECT DISTINCT 
    w.week, 
    w.service, 
    s.staff_id, 
    s.staff_name, 
    s.role,
    CASE 
        WHEN ss.present = 1 THEN 'Yes' 
        ELSE 'No' 
    END AS availability, 
    w.staff_morale
FROM services_weekly w
RIGHT JOIN staff s
    ON w.service = s.service
JOIN staff_schedule ss
    ON w.week = ss.week AND s.staff_name = ss.staff_name
ORDER BY w.week, s.staff_name;
-- 3.Create a multi-table report showing patient admissions with staff information.
SELECT DISTINCT 
    p.name AS patient_name, 
    p.age, 
    w.event, 
    w.service, 
    p.arrival_date AS admitted_on,
    DATEDIFF(p.departure_date, p.arrival_date) AS days_stayed, 
    s.staff_name AS assigned_staffs, 
    s.role,
    CASE 
        WHEN s.present = 1 THEN 'Yes' 
        ELSE 'No' 
    END AS staff_availability
FROM patients p
JOIN services_weekly w
    ON w.service = p.service AND WEEK(p.arrival_date, 1) = w.week
JOIN staff_schedule s
    ON w.week = s.week AND s.service = w.service AND WEEK(p.arrival_date, 1) = s.week
ORDER BY admitted_on;

-- DAY15 challenge
-- Create a comprehensive service analysis report for week 20 showing: service name, total patients admitted that week, total patients refused, average patient satisfaction, count of staff assigned to service, and count of staff present that week. 
-- Order by patients admitted descending.

SELECT 
    sw.service AS service_name, 
    MAX(patients_admitted) AS total_patients_admitted,
    MAX(patients_refused) AS total_patients_refused,
	ROUND(AVG(patients_satisfaction),2)AS avg_patient_satisfaction,
    COUNT(DISTINCT ss.staff_id) AS staff_assigned,
    SUM(ss.present) AS staff_present_week20
FROM services_weekly sw
LEFT JOIN staff_schedule ss
    ON sw.service = ss.service AND sw.week=ss.week
   WHERE  ss.week = 20 
GROUP BY sw.service
ORDER BY total_patients_admitted DESC;