/*
Five Data Modification Queries
involve a complex feature, e.g. inserting the result of a query, updating several tuples at once, or deleting a set of tuples that is more than one but less-than all the tuples in a relation. 
*/
\echo 'Modification Queries'

-- Updating Several Tuples --
\echo '1. Fixing GPA''s' 
UPDATE student
SET gpa = 4.00
WHERE gpa > 4.00;

-- Updating Several Tuples: switches the sex of anyone with a first name longer than 5 letters --
\echo '2. switching sex for first names longer than 5' 
UPDATE student 
SET sex = CASE 
		WHEN sex = 'M' THEN 'F'
		ELSE 'M'
	END
WHERE length(firstname) > 5;

-- Update Tuples based on a Query --
\echo '3. everyone with a gpa less than 4.0 is now a chemistry major (no offense)'
UPDATE studies
	SET subjectname = 'chemistry'
WHERE email in (SELECT email FROM student WHERE gpa < 4.0);

-- Deleting Tuples: deletes all hobbies that are not liked by anyone--
\echo '4. deletes all hobbies that no one participates in' 
DELETE FROM hobby WHERE hobbyname NOT IN (SELECT hobbyname from participates);

-- Deleting Tuples: deletes all jobs that are not dream jobs or are not current jobs --
\echo '5. deletes all jobs that no one has or aspires for' 
DELETE FROM job WHERE jobid NOT IN ((SELECT dreamjob FROM student) UNION (SELECT jobid FROM employedby));

-- Inserting the result of a query --
\echo '6. everyone with the first name starting with j is hired at job 6'
INSERT INTO employedby
SELECT email, jobid FROM student, job 
WHERE LEFT(email, 1) = 'j' AND jobid = 6;

-- Update Salary --
\echo '7. add 500000 to every salary in the technology industry'
UPDATE job 
	SET salary = job.salary + 500000
WHERE industry = 'technology';


