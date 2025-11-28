-- ----------------------------------------------------DAY 20----------------------------------------------------------------------------
-- practice questions
-- 1.Calculate running total of patients admitted by week for each service.
SELECT
    service,
    week,
    patients_admitted,
    SUM(patients_admitted) OVER (
        PARTITION BY service
        ORDER BY week
    ) AS cumulative_admissions
FROM services_weekly
ORDER BY service, week;
-- 2.Find the moving average of patient satisfaction over 4-week periods.
SELECT
    service,
    week,
    patients_satisfaction,
    ROUND(AVG(patients_satisfaction) OVER (
        PARTITION BY service
        ORDER BY week
        ROWS BETWEEN 3 PRECEDING AND CURRENT ROW    ), 2) AS moving_avg_4week
FROM services_weekly
ORDER BY service, week;
-- 3. Show cumulative patient refusals by week across all services.
SELECT
    week,
    SUM(patients_refused) AS total_refused,
    SUM(SUM(patients_refused)) OVER (
        ORDER BY week
    ) AS cumulative_refusal
FROM services_weekly
GROUP BY week
ORDER BY week;

-- DAY 20 challenge
/* Create a trend analysis showing for each service and week: week number, patients_admitted, running total of patients admitted 
(cumulative), 3-week moving average of patient satisfaction (current week and 2 prior weeks), and the difference between current week 
admissions and the service average. Filter for weeks 10-20 only. */
SELECT
    service,
    week,
    patients_admitted,
    SUM(patients_admitted) OVER (
        PARTITION BY service
        ORDER BY week
    ) AS cumulative_admissions,
    patients_satisfaction,
    ROUND(AVG(patients_satisfaction) OVER (
        PARTITION BY service
        ORDER BY week
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW    ), 2) AS moving_avg_3week,
	ROUND(AVG(patients_admitted) OVER (PARTITION BY service),2) AS service_avg,
    patients_admitted - ROUND(AVG(patients_admitted) OVER (PARTITION BY service),2) AS diff_from_avg
FROM services_weekly
WHERE week between 10 AND 20
ORDER BY service, week;