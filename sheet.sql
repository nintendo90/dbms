ALTER TABLE table_name  MODIFY column_name datatype; 

ALTER TABLE Test  ADD COLUMN Phone_number VARCHAR(20) NOT NULL AFTER Name

ALTER TABLE table_name  DROP COLUMN column_name;  

SELECT emp_name, SUM(working_hours) AS "Total working hours"  
FROM employees  
GROUP BY emp_name  
HAVING SUM(working_hours) > 5; 

-- create table events(
--     id int auto_increment primary key,
--     event_name varchar(50),
--     visitor varchar(10),
--     properties JSON,
--     browser JSON
-- );

-- insert into events(event_name, visitor, properties, browser)
-- values
-- (
--     'pageview',
--     '1',
--     '{ "page": "/" }',
--     '{ "name": "Safari", "os": "Mac", "resolution": {"x": 1920, "y": 1080} }'
-- ),
-- (
--     'pageview',
--     '2',
--     '{ "page": "/contact" }',
--     '{ "name": "Firefox", "os": "Windows", "resolution": {"x": 2560, "y": 16000} }'
-- ),
-- (
--     'pageview',
--     '1',
--     '{ "page": "/products" }',
--     '{ "name": "Safari", "os": "Mac", "resolution": {"x": 1920, "y": 1080} }'
-- ),
-- (
--     'purchase',
--     '4',
--     '{ "amount": 150 }',
--     '{ "name": "Firefox", "os": "Windows", "resolution": {"x": 1280, "y": 800} }'
-- ),
-- (
--     'purchase',
--     '4',
--     '{ "amount": 500 }',
--     '{ "name": "Chrome", "os": "Windows", "resolution": {"x": 1680, "y": 1050} }'
-- );

-- select id, browser ->> '$.name' as browser
-- from events;

-- select browser ->> '$.name' as browser, count(browser)
-- from events
-- group by browser ->> '$.name' ;

-- select browser ->> '$.resolution.x' as coordinates from events order by coordinates desc;


# REPLACE --------------------------------------------------------------------------------
/*
SELECT 
	REPLACE(capital, 'A', 'AAA') AS newcol
FROM administrative_divisions;
*/

# UPPER CASE and LOWER CASE --------------------------------------------------------------
/*
SELECT CONCAT(
	'My favorite city is ', UPPER(capital)
) AS FAV_CITIES 
FROM administrative_divisions;
*/

SELECT * FROM regions
WHERE
regionName = "Absheron" OR capital = "Shaki";

SELECT * FROM regions
WHERE regionName LIKE 'a%';

SELECT * FROM regions
ORDER BY area DESC;

SELECT * FROM regions
LIMIT 2;

SELECT division_name, capital, area, population, region FROM administrative_divisions
WHERE
region IN('Yukhari-Karabakh', 'Aran')
AND 
area BETWEEN 1000.00 AND 1200.00;

SELECT COUNT(*), 
CASE
    WHEN population > 5000000 THEN 'big'
    WHEN population > 1000000 THEN 'medium'
    ELSE 'small'
END as state_size
FROM states GROUP by state_size;

ALTER TABLE passenger
ADD constraint fk_continent_id
FOREIGN KEY(continent_id) 
REFERENCES continents(continent_id)
ON UPDATE CASCADE ON DELETE RESTRICT

1) CASCADE
2) SET NULL
3) RESTRICT
4) NO ACTION
5) SET DEFAULT

# Create a table `users` with columns: `username`, `age` ---------------------------
DELIMITER $$
CREATE TRIGGER must_be_adult
    BEFORE INSERT ON users FOR EACH ROW
    BEGIN
        IF NEW.age < 18
        THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Must be an adult!';
        END IF;
    END;
$$
DELIMITER ;


# TASK: Create table `username`, `password` ------------------------------------------
# perevent user to have the same old and new passwords!
DELIMITER $$
CREATE TRIGGER must_be_different
    BEFORE UPDATE ON users FOR EACH ROW
    BEGIN
        IF NEW.password == OLD.password
        THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Your new password should be the same as the old one!';
        END IF;
    END;
$$
DELIMITER ;

CREATE TRIGGER stud_marks 
BEFORE INSERT ON Student 
FOR EACH ROW 
SET New.total = New.subj1 + New.subj2 + New.subj3, 
    New.per = New.total * 60 / 100;


# test it
insert into Student values(0, "ABCDE", 20, 20, 20, 0, 0);

DELIMITER $$
CREATE TRIGGER after_members_insert
AFTER INSERT
ON members FOR EACH ROW
BEGIN
    IF NEW.birthDate IS NULL THEN
        INSERT INTO reminders(memberId, message)
        VALUES(new.id,CONCAT('Hi ', NEW.name, ', please update your date of birth.'));
    END IF;
END$$
DELIMITER ;

