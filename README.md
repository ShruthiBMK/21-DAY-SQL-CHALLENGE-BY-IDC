# 21-DAY-SQL-CHALLENGE-BY-IDC
## IDC 21-Day SQL Challenge

This repository contains my solutions and learnings from the IDC 21-Day SQL Challenge.
The challenge focuses on strengthening SQL fundamentals through daily problem-solving, real-world datasets, and industry-style queries.

### Objectives

- Build strong SQL query-writing skills

- Practice real-world problem-solving in SQL

- Improve hands-on experience with databases (MySQL / PostgreSQL / SQL Server)

- Prepare for data analytics interviews and case rounds

Dataset : (https://www.kaggle.com/datasets/jaderz/hospital-beds-management?resource=download)

#### Day 1 challenge
- List all unique hospital services available in the hospital.
  
SELECT DISTINCT service FROM services_weekly;

<img width="133" height="96" alt="image" src="https://github.com/user-attachments/assets/5b1b54c2-3291-4178-9a7e-1cf218280977" />

#### Day 2 Challenge
- Find all patients admitted to 'Surgery' service with a satisfaction score below 70, showing their patient_id, name, age, and satisfaction score.

  SELECT patient_id, name, age, satisfaction FROM patients

  WHERE service = 'surgery'  AND

  satisfaction < 70;

<img width="313" height="467" alt="image" src="https://github.com/user-attachments/assets/7bc1bcfd-7dbe-4e4f-90d9-5042fea581bb" />
