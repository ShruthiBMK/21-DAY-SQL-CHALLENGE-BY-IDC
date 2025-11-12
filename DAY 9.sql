-- ------------------------------------------------------------DAY 9------------------------------------------------------------------
-- practise questions
-- 1. Extract the year from all patient arrival dates.
SELECT name, arrival_date, year(arrival_date) AS Year_of_arrival
FROM patients;
-- 2. Calculate the length of stay for each patient (departure_date - arrival_date).
SELECT name, arrival_date, departure_date,
 DATEDIFF(departure_date, arrival_date) AS length_of_stay 
FROM patients;
-- 3. Find all patients who arrived in a specific month.
SELECT name, arrival_date, monthname(arrival_date) AS Month_of_arrival
FROM patients
WHERE monthname(arrival_date) = 'July';

-- DAY 9 challenge
-- Calculate the average length of stay (in days) for each service, showing only services where the average stay is more than 7 days. Also show the count of patients and order by average stay descending.
SELECT service, COUNT(name) as No_of_patients,
AVG(DATEDIFF(departure_date, arrival_date)) AS avg_length_of_stay 
FROM patients
GROUP BY service
HAVING avg_length_of_stay >7
ORDER BY avg_length_of_stay DESC;