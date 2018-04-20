/*
Create Two Views
Also include a query involving each view
*/

-- VIEW ONE --
\echo 'Created View dreams'
CREATE VIEW dreams AS
SELECT email, sex, gpa, role as dreamjob, salary as dreamsalary FROM student INNER JOIN job on job.jobid = student.dreamjob;

\echo 'Running query on dreams: get average gpa of students who dream for a specific job'
SELECT dreamjob, AVG(gpa) FROM dreams GROUP BY dreamjob LIMIT 10;

-- VIEW TWO --
\echo 'Created View majors'
CREATE VIEW majors AS
SELECT student.email, gpa, subjectname as major FROM student INNER JOIN studies ON student.email=studies.email;

\echo 'Running query on majors: count how many students are in each major'
SELECT major, COUNT(email) FROM majors GROUP BY major LIMIT 10; 
