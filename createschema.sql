CREATE SEQUENCE job_id_seq; --For autoincrement of jobid--
CREATE TABLE job(
	jobid integer NOT NULL DEFAULT nextval('job_id_seq') PRIMARY KEY,
	role varchar(255),
	salary decimal(19, 2), -- assume nothing will be higher than 19 digits -- 
	industry varchar(255)
);

/*
	Create the Schemas for the Student Interests and Careers Database
*/
CREATE TABLE student(
	firstname varchar(255),
	lastname varchar(255),
	sex char(1) CHECK (sex = 'M' OR sex = 'F'), -- assume only male and female --
	email varchar(255) CHECK (email like '%_@_%._%') PRIMARY KEY,
	gpa decimal(3, 2),
	dreamJob integer references job(jobid),
	CHECK (length(email) > length(lastname) + length(firstname)) -- we want school emails, which will be a combination of first and lastname-- 	
);

CREATE TABLE hobby(
	hobbyName varchar(255) PRIMARY KEY
);

CREATE TABLE subject(
	subjectName varchar(255) PRIMARY KEY
);

CREATE TABLE class(
	className varchar(255) PRIMARY KEY,
	units smallint,
	subject varchar(255)
);

CREATE TABLE employedBy(
	email varchar(255) references student(email) ON DELETE CASCADE,
	jobid integer references job(jobid),
	PRIMARY KEY (email, jobid) 
);

CREATE TABLE participates(
	email varchar(255) references student(email) ON DELETE CASCADE, 
	hobbyName varchar(255) references hobby(hobbyName),
	PRIMARY KEY (email, hobbyName)
);

CREATE TABLE studies(
	email varchar(255) references student(email) ON DELETE CASCADE,
	subjectName varchar(255) references subject(subjectName),
	PRIMARY KEY (email, subjectName)
);

CREATE TABLE takes(
	email varchar(255) references student(email) ON DELETE CASCADE,
	className varchar(255) references class(className),
	PRIMARY KEY (email, className)
);


