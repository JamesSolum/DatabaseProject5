-- Gpa Normalizer --
/**
* gpaLimitMax
* searches for tuples with gpa's larger than the value you pass
* makes them the max value.  
* This is helpful because it allows you to change gpa values to 
* different scales.  For example if someone was one a 5.0 scale
* it can be changed to a 4.0 scale.
* @param $1 the max gpa
* @return 1 if successful
*/
CREATE OR REPLACE FUNCTION 
	gpaLimitMax(student.gpa%TYPE) RETURNS INT AS '
DECLARE 
	currentEmail student.email%TYPE;
	c CURSOR FOR
		SELECT email FROM student WHERE gpa > $1;
BEGIN
	OPEN c;
	LOOP
		FETCH c INTO currentEmail;
		EXIT WHEN NOT FOUND;
		UPDATE student SET gpa = $1 
		WHERE email = currentEmail;
	END LOOP;
	CLOSE c;
	RETURN 1;
END;' LANGUAGE 'plpgsql';

/**
* StudentCheck
* whenever a new student is added to the database
* check to see if the added values are good. 
* This is just manually monitoring some undeclared constraints
* Firstname default is unknown
* lastname default is unknown
* let sex, gpa, and dream job be null
*/
CREATE FUNCTION
	studentCheck() RETURNS TRIGGER AS '
BEGIN
	IF new.firstname IS NULL THEN
		UPDATE student SET firstname = ''unknown''
		WHERE student.email = new.email;
	END IF;
	IF new.lastname IS NULL THEN
		UPDATE student SET lastname = ''unknown''
		WHERE student.email = new.email;
	END IF;
	RETURN new;
END;' LANGUAGE 'plpgsql';

/**
* Runs the studentCheck()
*/
CREATE TRIGGER myStudentCheckTrigger AFTER INSERT OR UPDATE ON student FOR EACH ROW EXECUTE PROCEDURE studentCheck();

