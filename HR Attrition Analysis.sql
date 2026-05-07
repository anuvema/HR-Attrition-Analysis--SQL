-- IBM HR Analytics SQL Project
-- Objective: Analyze key factors driving employee attrition

USE Projects;
GO

-- Data check
SELECT * FROM HREmployee;

-- 1. Attrition Rate
SELECT 
COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS attrition_rate
FROM HREmployee;

-- 2. Department-wise attrition count
SELECT Department, COUNT(*) AS total_left
FROM HREmployee
WHERE Attrition = 'Yes'
GROUP BY Department
ORDER BY total_left DESC;

-- 3. Department-wise attrition rate
SELECT 
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM HREmployee
GROUP BY Department
ORDER BY attrition_rate DESC;

-- 4. Salary impact
SELECT 
    CASE 
        WHEN MonthlyIncome < 3000 THEN 'Low'
        WHEN MonthlyIncome BETWEEN 3000 AND 7000 THEN 'Medium'
        ELSE 'High'
    END AS salary_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM HREmployee
GROUP BY 
    CASE 
        WHEN MonthlyIncome < 3000 THEN 'Low'
        WHEN MonthlyIncome BETWEEN 3000 AND 7000 THEN 'Medium'
        ELSE 'High'
    END
ORDER BY attrition_rate DESC;

-- 5. Department + Salary
SELECT 
    Department,
    CASE 
        WHEN MonthlyIncome < 3000 THEN 'Low'
        WHEN MonthlyIncome BETWEEN 3000 AND 7000 THEN 'Medium'
        ELSE 'High'
    END AS salary_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM HREmployee
GROUP BY 
    Department,
    CASE 
        WHEN MonthlyIncome < 3000 THEN 'Low'
        WHEN MonthlyIncome BETWEEN 3000 AND 7000 THEN 'Medium'
        ELSE 'High'
    END
ORDER BY Department, attrition_rate DESC;

-- 6. Overtime impact
SELECT 
    CASE WHEN OverTime = 1 THEN 'Yes' ELSE 'No' END AS OverTime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM HREmployee
GROUP BY CASE WHEN OverTime = 1 THEN 'Yes' ELSE 'No' END
ORDER BY attrition_rate DESC;

--7 Relationship Satisfaction vs Attrition

SELECT 
    RelationshipSatisfaction,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM HREmployee
GROUP BY RelationshipSatisfaction
ORDER BY attrition_rate DESC;

--8 Which job roles have highest attrition?
SELECT 
    JobRole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM HREmployee
GROUP BY JobRole
ORDER BY attrition_rate DESC;
