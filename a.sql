/*
Five Queries
Several of the queries should use something interesting. e.g. queries over more than one relation or subqueries
*/
\echo '1. What dream job is most common in students who study a certain subject'
SELECT maxer.subjectname, dreamjob FROM 
(
	SELECT subjectname, dreamjob, count(dreamjob) FROM 
	(
		SELECT subjectname, role AS dreamjob FROM studies 
		INNER JOIN 
		(
			SELECT email, role FROM student 
			INNER JOIN 
			job ON job.jobid = student.dreamjob
		) AS dreams ON dreams.email = studies.email
	) AS subDream GROUP BY subjectname, dreamjob
) AS counter 
INNER JOIN 
(
	SELECT subjectname, max(count) from 
	(
		SELECT subjectname, dreamjob, count(dreamjob) FROM 
		(
			SELECT subjectname, role AS dreamjob from studies 
			INNER JOIN 
			(
				SELECT email, role from student 
				INNER JOIN 
				job ON job.jobid = student.dreamjob
			) AS dreams ON dreams.email = studies.email
		) AS subDream GROUP BY subjectname, dreamjob
	) as counter GROUP BY subjectname
) AS maxer ON counter.count = maxer.max AND counter.subjectname=maxer.subjectname LIMIT 10;


\echo '2. What Hobbies do students working in a certain job have'
SELECT role, hobbyname from 
(
	SELECT email, role FROM employedBy 
	INNER JOIN job on job.jobid = employedBy.jobid
) as email_job INNER JOIN 
(
	SELECT * from participates
) as hobbies ON hobbies.email = email_job.email LIMIT 10;


\echo '3. The average dream salary for each area of study'
SELECT subjectname, AVG(salary) AS avg_dream_salary FROM 
(
	SELECT subjectname, salary FROM 
	(
		SELECT email, salary FROM student INNER JOIN job on job.jobid = student.dreamJob
	) as email_salary INNER JOIN studies ON studies.email = email_salary.email
) as sal GROUP BY subjectname LIMIT 10;

\echo '4. The average dream salary for each sex'
SELECT sex, AVG(salary) AS avg_dream_salary FROM 
(
	SELECT sex, email, salary FROM student
	INNER JOIN
	job ON job.jobid = student.dreamjob
) as email_salary GROUP BY sex LIMIT 10;

\echo '5. The Average Current Salary for each area of Study'
SELECT subjectname, AVG(gpa) FROM 
(
	SELECT subjectname, gpa FROM student
	INNER JOIN
	studies ON
	studies.email = student.email
) AS individual_gpa GROUP BY subjectname LIMIT 10;	

