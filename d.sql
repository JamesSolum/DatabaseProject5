/*
Indexes
Create at least two useful indexes for your PDA (in addition to the indexes that postgresql creates automatically for you). 
*/

-- Query withou Indexes--

\echo 'Queries without Indexes'
\echo '1. What dream job is most common in students who study a certain subject'
BEGIN;
EXPLAIN ANALYZE SELECT maxer.subjectname, dreamjob FROM 
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
EXPLAIN ANALYZE SELECT role, hobbyname from 
(
	SELECT email, role FROM employedBy 
	INNER JOIN job on job.jobid = employedBy.jobid
) as email_job INNER JOIN 
(
	SELECT * from participates
) as hobbies ON hobbies.email = email_job.email LIMIT 10;


\echo '3. The average dream salary for each area of study'
EXPLAIN ANALYZE SELECT subjectname, AVG(salary) AS avg_dream_salary FROM 
(
	SELECT subjectname, salary FROM 
	(
		SELECT email, salary FROM student INNER JOIN job on job.jobid = student.dreamJob
	) as email_salary INNER JOIN studies ON studies.email = email_salary.email
) as sal GROUP BY subjectname LIMIT 10;

\echo '4. The average dream salary for each sex'
EXPLAIN ANALYZE SELECT sex, AVG(salary) AS avg_dream_salary FROM 
(
	SELECT sex, email, salary FROM student
	INNER JOIN
	job ON job.jobid = student.dreamjob
) as email_salary GROUP BY sex LIMIT 10;

\echo '5. The Average Current Salary for each area of Study'
EXPLAIN ANALYZE SELECT subjectname, AVG(gpa) FROM 
(
	SELECT subjectname, gpa FROM student
	INNER JOIN
	studies ON
	studies.email = student.email
) AS individual_gpa GROUP BY subjectname LIMIT 10;	


-- Automatically Created Indexes -- 
\echo 'Generating default indexes'
CREATE INDEX studentInd ON student(email);
CREATE INDEX jobInd ON job(jobid);
CREATE INDEX hobbyInd ON hobby(hobbyname);
CREATE INDEX subjectInd ON subject(subjectname);
CREATE INDEX classInd ON class(classname);
CREATE INDEX employedbyInd ON employedby(email, jobid);
CREATE INDEX participatesInd ON participates(email, hobbyname);
CREATE INDEX studiesInd ON studies(email, subjectname);
CREATE INDEX takesInd ON takes(email,classname);

\echo 'Create Indexes'
CREATE INDEX myJobInd ON job(role, salary); 
CREATE INDEX dreamInd ON student(dreamJob);

\echo 'Queries w/ Indexes'
\echo '1. What dream job is most common in students who study a certain subject'
EXPLAIN ANALYZE SELECT maxer.subjectname, dreamjob FROM 
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
EXPLAIN ANALYZE SELECT role, hobbyname from 
(
	SELECT email, role FROM employedBy 
	INNER JOIN job on job.jobid = employedBy.jobid
) as email_job INNER JOIN 
(
	SELECT * from participates
) as hobbies ON hobbies.email = email_job.email LIMIT 10;


\echo '3. The average dream salary for each area of study'
EXPLAIN ANALYZE SELECT subjectname, AVG(salary) AS avg_dream_salary FROM 
(
	SELECT subjectname, salary FROM 
	(
		SELECT email, salary FROM student INNER JOIN job on job.jobid = student.dreamJob
	) as email_salary INNER JOIN studies ON studies.email = email_salary.email
) as sal GROUP BY subjectname LIMIT 10;

\echo '4. The average dream salary for each sex'
EXPLAIN ANALYZE SELECT sex, AVG(salary) AS avg_dream_salary FROM 
(
	SELECT sex, email, salary FROM student
	INNER JOIN
	job ON job.jobid = student.dreamjob
) as email_salary GROUP BY sex LIMIT 10;

\echo '5. The Average Current Salary for each area of Study'
EXPLAIN ANALYZE SELECT subjectname, AVG(gpa) FROM 
(
	SELECT subjectname, gpa FROM student
	INNER JOIN
	studies ON
	studies.email = student.email
) AS individual_gpa GROUP BY subjectname LIMIT 10;	


\echo 'Dropping first custom index'
DROP INDEX myJobInd;
DROP INDEX dreamInd;

-- DROPPING Indexes --
\echo 'Dropping default indexes'
DROP INDEX studentInd;
DROP INDEX jobInd;
DROP INDEX hobbyInd;
DROP INDEX subjectInd;
DROP INDEX classInd;
DROP INDEX employedbyInd;
DROP INDEX participatesInd;
DROP INDEX studiesInd;
DROP INDEX takesInd;


