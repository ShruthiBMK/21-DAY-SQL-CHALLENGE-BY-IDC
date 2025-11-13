-- --------------------------------------------------------DAY 11------------------------------------------------------------------------
-- Practice questions
-- 1. List all unique services in the patients table.
 SELECT DISTINCT service FROM patients;
 -- 2. Find all unique staff roles in the hospital.
  SELECT DISTINCT role FROM staff;
-- 3. Get distinct months from the services_weekly table.
SELECT DISTINCT month FROM services_weekly;

-- DAY 11 challenge
-- Find all unique combinations of service and event type from the services_weekly table where events are not null or none, 
-- along with the count of occurrences for each combination. Order by count descending.
SELECT service, event, COUNT(*) AS count_combination
FROM services_weekly
WHERE event IS NOT NULL AND event <> "none"
GROUP BY service, event
ORDER BY count_combination DESC;
