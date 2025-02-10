/***Question: What are the top-paying data analyst jobs?**

- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries.
- Why? Aims to highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.*/

SELECT 
    job_id,
    job_title,
    cd.name AS company_name,
    job_location,
    salary_year_avg,
    job_schedule_type,
    job_posted_date
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND job_work_from_home = TRUE
        AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10; 