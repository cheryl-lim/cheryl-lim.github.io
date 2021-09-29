USE capstone2;

SELECT year, degree_of_injury, SUM(no_of_injuries) AS total_no_of_injuries
FROM injury
WHERE year BETWEEN 2017 AND 2018
GROUP BY year, degree_of_injury;

--year, industry
SELECT a.year, b.industry_description, SUM(a.no_of_injuries) AS total_no_of_injuries
FROM injury a
JOIN industry b
ON a.industry_id = b.industry_id
GROUP BY a.year, b.industry_description
ORDER BY SUM(a.no_of_injuries) DESC;

--section A
--calculate workplace injury rate per 100,000 workers
--industry = 'Manufacturing'
SELECT year, degree_of_injury, SUM(no_of_injuries) AS total_no_of_injuries
FROM injury
WHERE industry_id LIKE 'C%'
GROUP BY year, degree_of_injury;

SELECT year, SUM(no_of_cases) AS total_no_of_cases
FROM occupational_disease
WHERE industry_id LIKE 'C%'
GROUP BY year;

--section B
--industry = 'Manufacturing'
--year, sub_industry
SELECT a.year, a.industry_id, b.industry_sub_description, SUM(a.no_of_injuries) AS total_no_of_injuries
FROM injury a
JOIN industry b
ON a.industry_id = b.industry_id
WHERE a.industry_id LIKE 'C%'
GROUP BY a.year, a.industry_id, b.industry_sub_description
ORDER BY SUM(a.no_of_injuries) DESC;

--industry_id = 'C24', sub_industry = 'Metalworking'
--year, incident_type
SELECT a.incident_type_id, c.incident_type_description, SUM(a.no_of_injuries) AS total_no_of_injuries
FROM injury a
JOIN incident_type c
ON a.incident_type_id = c.incident_type_id
WHERE a.industry_id = 'C24'
GROUP BY a.incident_type_id, c.incident_type_description
ORDER BY SUM(a.no_of_injuries) DESC;

SELECT a.year, a.incident_type_id, c.incident_type_description, SUM(a.no_of_injuries) AS total_no_of_injuries
FROM injury a
JOIN incident_type c
ON a.incident_type_id = c.incident_type_id
WHERE a.industry_id = 'C24'
AND a.year = 2018
GROUP BY a.year, a.incident_type_id, c.incident_type_description
ORDER BY SUM(a.no_of_injuries) DESC;

SELECT a.year, a.degree_of_injury, a.incident_type_id, c.incident_type_description, SUM(a.no_of_injuries) AS total_no_of_injuries
FROM injury a
JOIN incident_type c
ON a.incident_type_id = c.incident_type_id
WHERE a.industry_id = 'C24'
AND c.incident_type_id IN (123, 101, 121, 114)
GROUP BY a.year, a.degree_of_injury, a.incident_type_id, c.incident_type_description
ORDER BY SUM(a.no_of_injuries) DESC;

SELECT a.degree_of_injury, a.incident_type_id, c.incident_type_description, SUM(a.no_of_injuries) AS total_no_of_injuries
FROM injury a
JOIN incident_type c
ON a.incident_type_id = c.incident_type_id
WHERE a.industry_id = 'C24'
GROUP BY a.degree_of_injury, a.incident_type_id, c.incident_type_description
ORDER BY SUM(a.no_of_injuries) DESC;

--123 'Struck by Moving Objects'=243, 101 'Caught in/betw Objects', 121 'Struck by Falling Objects', 114 'Fall - Slips, Trips & Falls'
--year, incident_agent, incident_agent_sub_type
SELECT a.incident_agent_id, d.incident_agent_description, d.incident_agent_sub_description,
SUM(a.no_of_injuries) AS total_no_of_injuries
FROM injury a
JOIN incident_type c
ON a.incident_type_id = c.incident_type_id
JOIN incident_agent d
ON a.incident_agent_id = d.incident_agent_id
WHERE a.industry_id = 'C24'
AND a.incident_type_id = 123
GROUP BY a.incident_agent_id, d.incident_agent_description, d.incident_agent_sub_description
ORDER BY SUM(a.no_of_injuries) DESC;

SELECT a.year, a.incident_agent_id, d.incident_agent_description, d.incident_agent_sub_description,
SUM(a.no_of_injuries) AS total_no_of_injuries
FROM injury a
JOIN incident_type c
ON a.incident_type_id = c.incident_type_id
JOIN incident_agent d
ON a.incident_agent_id = d.incident_agent_id
WHERE a.industry_id = 'C24'
AND a.incident_type_id = 123
GROUP BY a.year, a.incident_agent_id, d.incident_agent_description, d.incident_agent_sub_description
ORDER BY SUM(a.no_of_injuries) DESC;

SELECT a.incident_agent_id, d.incident_agent_description, d.incident_agent_sub_description,
SUM(a.no_of_injuries) AS total_no_of_injuries
FROM injury a
JOIN incident_type c
ON a.incident_type_id = c.incident_type_id
JOIN incident_agent d
ON a.incident_agent_id = d.incident_agent_id
WHERE a.industry_id = 'C24'
GROUP BY a.incident_agent_id, d.incident_agent_description, d.incident_agent_sub_description
ORDER BY SUM(a.no_of_injuries) DESC;

--breakdown by degree_of_injury
SELECT a.year, a.degree_of_injury, a.incident_agent_id, d.incident_agent_description, d.incident_agent_sub_description,
SUM(a.no_of_injuries) AS total_no_of_injuries
FROM injury a
JOIN incident_type c
ON a.incident_type_id = c.incident_type_id
JOIN incident_agent d
ON a.incident_agent_id = d.incident_agent_id
WHERE a.industry_id = 'C24'
AND a.incident_type_id = 123
AND a.incident_agent_id = 243
GROUP BY a.year, a.degree_of_injury, a.incident_agent_id, d.incident_agent_description, d.incident_agent_sub_description
ORDER BY SUM(a.no_of_injuries) DESC;

SELECT e.od_type_id, f.od_type_description, SUM(e.no_of_cases) AS total_no_of_injuries
FROM occupational_disease e
JOIN od_type f
ON e.od_type_id = f.od_type_id
WHERE e.industry_id = 'C24'
GROUP BY e.od_type_id, f.od_type_description
ORDER BY SUM(e.no_of_cases) DESC;

SELECT e.year, e.od_type_id, f.od_type_description, SUM(e.no_of_cases) AS total_no_of_injuries
FROM occupational_disease e
JOIN od_type f
ON e.od_type_id = f.od_type_id
WHERE e.industry_id = 'C24'
AND e.year = 2018
GROUP BY e.year, e.od_type_id, f.od_type_description
ORDER BY SUM(e.no_of_cases) DESC;