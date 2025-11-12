-- -------------------------------------------------------DAY 10 ---------------------------------------------------------------------------
-- Practice questions
-- 1. 1. Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores.
SELECT name,
    satisfaction,
    CASE        
    WHEN satisfaction >= 80 THEN 'High'        
    WHEN satisfaction >=50 THEN 'Medium'               
    ELSE 'Low'    
    END AS satisfaction_category
FROM patients;
-- 2.  Label staff roles as 'Medical' or 'Support' based on role type.
SELECT staff_name,
    role,
    CASE        
    WHEN role = 'Doctor' THEN 'Medical'        
    WHEN role='nurse' THEN 'Support'  
    WHEN role='nursing_assistant' THEN 'Support'
    ELSE 'NA'    
    END AS role_category
FROM staff;
-- 3. Create age groups for patients (0-18, 19-40, 41-65, 65+)
SELECT name,
    age,
    CASE        
    WHEN age < 18 THEN 'Pediatric'        
    WHEN age BETWEEN 19 AND 40 THEN 'young' 
     WHEN age BETWEEN 41 AND 65 THEN 'Adult'
    ELSE 'Senior'    END AS age_group
FROM patients;

-- DAY 10 Challenge
/* Create a service performance report showing service name, total patients admitted, 
and a performance category based on the following: 'Excellent' if avg satisfaction >= 85, 'Good' if >= 75, 'Fair' if >= 65, 
otherwise 'Needs Improvement'. Order by average satisfaction descending.*/
SELECT service, SUM(patients_admitted) AS total_patients_admitted,
CASE
WHEN avg(patients_satisfaction) >=85 THEN 'Excellent' 
WHEN avg(patients_satisfaction) >=75 THEN 'Good'
WHEN avg(patients_satisfaction) >=65 THEN 'Fair'
ELSE 'Needs Improvement'
END AS performance_category
FROM services_weekly
GROUP BY service 
ORDER BY avg(patients_satisfaction) DESC;