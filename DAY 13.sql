-- -----------------------------------------------------------------DAY 13-----------------------------------------------------------------------
-- Practice questions
-- 1. Join patients and staff based on their common service field (show patient and staff who work in same service).
SELECT s.service,p.name AS patients_name, GROUP_CONCAT(staff_name) as staff_name
FROM patients p JOIN staff s
on p.service=s.service
GROUP BY p.name;
-- 2. Join services_weekly with staff to show weekly service data with staff information.
SELECT sw.* , s.staff_name
FROM services_weekly sw JOIN staff s
on sw.service=s.service;
-- 3. Create a report showing patient information along with staff assigned to their service.
SELECT p.* , s.staff_name
FROM patients p JOIN staff s
on p.service=s.service;

-- DAY13 challenge
-- Create a comprehensive report showing patient_id, patient name, age, service, and the total number of staff members available in 
-- their service. Only include patients from services that have more than 5 staff members.Order by number of staff descending, then by patient name.
SELECT patient_id, name as patient_name, 
       age, p.service, COUNT(staff_name) as Staff_count
FROM patients p JOIN staff s
ON p.service = s.service
GROUP BY name
HAVING COUNT(staff_name) > 5
order by COUNT(staff_name) DESC, name;