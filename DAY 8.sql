-- ------------------------------------------------------DAY 8--------------------------------------------------------------------------
-- practise questions
-- 1. Convert all patient names to uppercase.
SELECT UPPER(name) AS patients_name from patients;
-- 2. Find the length of each staff member's name.
SELECT staff_name, length(staff_name) as length_staffname FROM staff;
-- 3. Concatenate staff_id and staff_name with a hyphen separator.
SELECT CONCAT(staff_id,'-',staff_name) as name_with_id FROM staff;

-- DAY 8 Challenge
-- Create a patient summary that shows patient_id, full name in uppercase, service in lowercase, age category (if age >= 65 then 'Senior', if age >= 18 then 'Adult', else 'Minor'), and name length. Only show patients whose name length is greater than 10 characters.
SELECT patient_id, UPPER(name) as patient_name,
LOWER(service) AS service, 
CASE 
        WHEN age >= 65 THEN 'Senior'
        WHEN age >= 18 THEN 'Adult'
        ELSE 'Minor'
    END AS age_category, 
    LENGTH(name) AS name_length FROM patients
    WHERE  LENGTH(name)>10;