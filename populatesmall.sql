/*
Insert some tuples into our database.  This data is not necessarily real, but it reflects data that is possible
*/
-- student --
INSERT INTO student VALUES ('James', 'Solum', 'M', 'jsolum@westmont.edu', '3.8', 1), ('Jacob', 'Ochs', 'M', 'jochs@westmont.edu', '4.0', 1), ('Caleb', 'Armacost', 'M', 'carmacost@westmont.edu', '3.9', 3), ('Natelli', 'Cripe', 'F', 'ncripe@westmont.edu', '4.3', 4), ('Jason', 'Watts', 'M', 'jwatts@westmont.edu', '2.3', 5), ('Cooper', 'Sheard', 'M', 'csheard@westmont.edu', 3.2, 2);

-- job --
INSERT INTO job (role, salary, industry) VALUES ('software engineer', '90000', 'technology'), ('professor', '70000', 'education'), ('intern', '30000', 'information technology'), ('videographer', '20000', 'film'), ('architect', '110000', 'construction'), ('worse job ever', '1', 'worst');

-- hobbies -- 
INSERT INTO hobby VALUES ('coding'), ('surfing'), ('snorkeling'), ('writing'), ('rock climbing'), ('martial arts'), ('cooking');

-- subject -- 
INSERT INTO subject VALUES ('computer science'), ('mathematics'), ('chemistry'), ('communications'), ('kinesiology'), ('psychology'); 

-- class --
INSERT INTO class VALUES ('databases','4', 'computer science'), ('senior seminar', '4', 'computer science'), ('chem lab 1', '2', 'chemistry'), ('messages meaning and culture', '4', 'communications'), ('modern algebra', '4', 'mathematics');

-- employedBy --
INSERT INTO employedBy VALUES ('jsolum@westmont.edu', 3), ('jochs@westmont.edu', 3), ('ncripe@westmont.edu', 5), ('jwatts@westmont.edu', 3), ('csheard@westmont.edu', 5);

-- participates --
INSERT INTO participates VALUES ('jsolum@westmont.edu', 'surfing'), ('jsolum@westmont.edu', 'coding'), ('jochs@westmont.edu', 'rock climbing'), ('ncripe@westmont.edu', 'rock climbing'), ('jwatts@westmont.edu', 'snorkeling'), ('csheard@westmont.edu', 'cooking');

-- studies --
INSERT INTO studies VALUES ('jsolum@westmont.edu', 'computer science'), ('jochs@westmont.edu', 'computer science'), ('ncripe@westmont.edu', 'mathematics'), ('carmacost@westmont.edu', 'chemistry'), ('jwatts@westmont.edu', 'computer science'), ('csheard@westmont.edu', 'mathematics');

-- takes --
INSERT INTO takes VALUES ('jsolum@westmont.edu', 'databases'), ('jsolum@westmont.edu', 'senior seminar'), ('jochs@westmont.edu', 'databases'), ('carmacost@westmont.edu', 'databases'), ('ncripe@westmont.edu', 'modern algebra'), ('csheard@westmont.edu', 'chem lab 1');
