WITH skills_demand AS (
    SELECT 
    sd.skills,
    COUNT(jpf.job_id) AS demand_count
    FROM job_postings_fact AS jpf
    LEFT JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
    LEFT JOIN skills_dim AS sd
        ON sjd.skill_id = sd.skill_id
    WHERE jpf.job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
    GROUP BY skills), 
skills_salary AS (
    SELECT 
    sd.skills,
    AVG(jpf.salary_year_avg) AS avg_salary
    FROM job_postings_fact AS jpf
    LEFT JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
    LEFT JOIN skills_dim AS sd
        ON sjd.skill_id = sd.skill_id
    WHERE jpf.job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
    GROUP BY sd.skills)

SELECT 
    skills_demand.skills,
    demand_count,
    avg_salary
FROM skills_demand
INNER JOIN skills_salary
ON skills_demand.skills = skills_salary.skills
WHERE demand_count > 10
ORDER BY avg_salary DESC, demand_count DESC
LIMIT 25