DROP TRIGGER myStudentCheckTrigger on student;
DROP TABLE if exists student, job, hobby, subject, class, employedBy, participates, studies, takes CASCADE;
DROP SEQUENCE job_id_seq;
DROP FUNCTION studentCheck();
