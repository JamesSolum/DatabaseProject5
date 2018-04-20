-- Create an extra view for the Webapp --
CREATE VIEW majordream AS
SELECT email, role as dreamjob, subjectname as major FROM
	(SELECT student.email, subjectname, dreamjob FROM
		student JOIN studies
		ON student.email = studies.email) a
	JOIN
	job ON job.jobid=dreamjob;
