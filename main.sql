USE employees;
CREATE VIEW 
    department_stats AS
    (   SELECT
            REPLACE(q1.dept_name,'"','') AS dept_name,
            ROUND(q1.avg_salary,2)       AS avg_salary,
            q2.first_name                AS manager_first_name,
            q2.last_name                 AS manager_last_name,
            q2.salary                    AS manager_salary
        FROM
            (   SELECT
                    d.dept_name,
                    AVG(Salary) AS avg_salary
                FROM
                    salaries s
                LEFT JOIN
                    employees e
                ON 
                    s.emp_no = e.emp_no
                LEFT JOIN
                    dept_manager dm
                ON 
                    dm.emp_no = e.emp_no
                INNER JOIN 
                    departments d
                ON 
                    d.dept_no = dm.dept_no
                WHERE 
                    s.to_date = '9999-01-01'
                GROUP BY 
                    d.dept_name ) q1
        INNER JOIN
            (   SELECT
                    salary,
                    d.dept_name,
                    e.first_name,
                    e.last_name
                FROM
                    salaries s
                LEFT JOIN
                    employees e
                ON 
                    s.emp_no = e.emp_no
                LEFT JOIN
                    dept_manager dm
                ON 
                    dm.emp_no = e.emp_no
                INNER JOIN 
                    departments d
                ON 
                    d.dept_no = dm.dept_no
                WHERE 
                    s.to_date = '9999-01-01' 
                AND dm.to_date = '9999-01-01') q2
        ON 
            q1.dept_name = q2.dept_name
    );
    
SELECT 
    * 
FROM 
    department_stats;
    
  
