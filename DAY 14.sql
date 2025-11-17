-- ----------------------------------------------------DAY 14-----------------------------------------------------------------------------
-- Practice questions
-- 1.Show all staff members and their schedule information (including those with no schedule entries).
SELECT s.staff_name, s.role, s.service, ss.week, ss.present
FROM staff s LEFT JOIN staff_schedule ss
ON s.staff_name = ss.staff_name;
-- 2.List all services from services_weekly and their corresponding staff (show services even if no staff assigned). 
SELECT 
    sw.service,
    s.staff_name,
    s.role
FROM services_weekly sw
LEFT JOIN staff s 
    ON sw.service = s.service;
-- 3. Display all patients and their service's weekly statistics (if available).
SELECT 
    p.name,
    sw.*
FROM patients p
RIGHT JOIN services_weekly sw
    ON p.service = sw.service;

-- DAY 14 challenge
-- Create a staff utilisation report showing all staff members (staff_id, staff_name, role, service) and the count of weeks they were present (from staff_schedule). 
-- Include staff members even if they have no schedule records. Order by weeks present descending.
SELECT s.*,  COUNT(ss.week) AS weeks_scheduled,
    SUM(COALESCE(ss.present, 0)) AS weeks_present
FROM staff s
LEFT JOIN staff_schedule ss ON s.staff_name = ss.staff_name
GROUP BY s.staff_id, s.staff_name, s.role, s.service
ORDER BY weeks_present desc;