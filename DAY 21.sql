-- ---------------------------------------------------------DAY 21------------------------------------------------------------------------
-- Practice Questions
-- 1.Create a CTE to calculate service statistics, then query from it.
WITH staff_summary AS (
    SELECT 
        week, 
        service, 
        COUNT(staff_id) AS staff_assigned, 
        SUM(present) AS staff_present
    FROM staff_schedule
    GROUP BY week, service
)
SELECT 
    w.week, 
    w.service, 
    w.patients_admitted, 
    s.staff_assigned, 
    s.staff_present, 
    w.staff_morale
FROM services_weekly w
JOIN staff_summary s
    ON s.week = w.week AND s.service = w.service;
-- 2. Use multiple CTEs to break down a complex query into logical steps.
WITH patient_metrics AS (
    SELECT
        service,
        COUNT(*) AS total_patients,
        ROUND(AVG(age)) AS avg_age,
        ROUND(AVG(satisfaction),2) AS avg_satisfaction
    FROM patients
    GROUP BY service
),
staff_metrics AS (
    SELECT
        service,
        COUNT(*) AS total_staff
    FROM staff
    GROUP BY service
),
weekly_metrics AS (
    SELECT
        service,
        SUM(patients_admitted) AS total_admitted,
        SUM(patients_refused) AS total_refused
    FROM services_weekly
    GROUP BY service
)
SELECT
    pm.service,
    pm.total_patients,
    pm.avg_age,
    pm.avg_satisfaction,
    sm.total_staff,
    wm.total_admitted,
    wm.total_refused,
    ROUND(100.0 * wm.total_admitted /
          (wm.total_admitted + wm.total_refused), 2) AS admission_rate
FROM patient_metrics pm
LEFT JOIN staff_metrics sm ON pm.service = sm.service
LEFT JOIN weekly_metrics wm ON pm.service = wm.service
ORDER BY pm.avg_satisfaction DESC;    
-- 3.Build a CTE for staff utilization and join it with patient data.
WITH staff_utilisation AS( 
SELECT week, service, count(staff_id) AS total_staff_assigned,
SUM(present) AS staff_present , ROUND(SUM(present)*100 /count(staff_id),2) AS staff_utilised
FROM staff_schedule GROUP BY service, week)
SELECT p.*, su.total_staff_assigned, su.staff_present, su.staff_utilised
FROM patients p
LEFT JOIN staff_utilisation su
ON p.service =su.service and 
week(p.arrival_date) = su.week;

-- DAY 21 CHALLENGE
/*Create a comprehensive hospital performance dashboard using CTEs. Calculate: 1) Service-level metrics (total admissions, refusals, 
avg satisfaction), 2) Staff metrics per service (total staff, avg weeks present), 3) Patient demographics per service (avg age, count).
 Then combine all three CTEs to create a final report showing service name, all calculated metrics, and an overall performance score 
 (weighted average of admission rate and satisfaction). Order by performance score descending. */
 
 WITH patient_demographics AS (
    SELECT
        service,
        COUNT(*) AS total_patients,
        ROUND(AVG(age)) AS avg_age
    FROM patients
    GROUP BY service
),
service_level AS (
    SELECT
        service,
        SUM(patients_admitted) AS total_admitted,
        SUM(patients_refused) AS total_refused,
        ROUND(
            100.0 * SUM(patients_admitted) /
            NULLIF(SUM(patients_admitted) + SUM(patients_refused), 0),2) AS admission_rate, 
		ROUND(AVG(patients_satisfaction), 2) AS avg_patients_satisfaction
    FROM services_weekly
    GROUP BY service),
  staff_metrics AS (
    SELECT
        s.service,
        COUNT(DISTINCT s.staff_id) AS total_staff,
        ROUND(AVG(
            (SELECT COUNT(*)
             FROM staff_schedule sc
             WHERE sc.staff_name = s.staff_name
               AND sc.present = 1)
        ), 1) AS avg_weeks_present
    FROM staff s
    GROUP BY s.service
)  
SELECT
    sl.service,
    pd.total_patients,
    pd.avg_age,
    sl.avg_patients_satisfaction,
    sl.total_admitted,
    sl.total_refused,
    sl.admission_rate,
    sm.total_staff,
    sm.avg_weeks_present,

    /* Weighted overall performance score */
    ROUND(
        (0.6 * sl.admission_rate) +
        (0.4 * sl.avg_patients_satisfaction),2) AS performance_score

FROM service_level sl
LEFT JOIN patient_demographics pd ON sl.service = pd.service
LEFT JOIN staff_metrics sm ON sl.service = sm.service
ORDER BY performance_score DESC;