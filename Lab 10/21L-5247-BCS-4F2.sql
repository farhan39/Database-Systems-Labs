create database lab10;
use lab10;

CREATE TABLE Student (
  roll_no INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  dept_id INT NOT NULL,
  batch INT NOT NULL,
  FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Course (
  course_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  credit_hrs INT NOT NULL,
  dept_id INT NOT NULL,
  FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Section (
  section_id INT PRIMARY KEY,
  course_id INT NOT NULL,
  capacity INT NOT NULL,
  FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE Enrolled (
  student_roll_no INT NOT NULL,
  section_id INT NOT NULL,
  PRIMARY KEY (student_roll_no, section_id),
  FOREIGN KEY (student_roll_no) REFERENCES Student(roll_no),
  FOREIGN KEY (section_id) REFERENCES Section(section_id)
);

CREATE TABLE Faculty (
  faculty_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  dept_id INT NOT NULL,
  FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Department (
  dept_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);


--Q1

CREATE TABLE Auditing (
  audit_id INT PRIMARY KEY IDENTITY(1,1),
  last_change_on DATETIME
);

CREATE TRIGGER student_trigger
ON Student
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  INSERT INTO Auditing (last_change_on)
  VALUES (GETDATE());
END;

CREATE TRIGGER department_trigger
ON Department
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  INSERT INTO Auditing (last_change_on)
  VALUES (GETDATE());
END;

CREATE TRIGGER faculty_trigger
ON Faculty
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  INSERT INTO Auditing (last_change_on)
  VALUES (GETDATE());
END;

--Q2

CREATE TRIGGER tr_AuditChanges
ON Student, Course, Section, Faculty, Department
AFTER UPDATE
AS
BEGIN
    DECLARE @table_name NVARCHAR(255);
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        IF EXISTS (SELECT * FROM inserted WHERE roll_no IS NOT NULL)
            SET @table_name = 'Student';
        ELSE IF EXISTS (SELECT * FROM inserted WHERE course_id IS NOT NULL)
            SET @table_name = 'Course';
        ELSE IF EXISTS (SELECT * FROM inserted WHERE section_id IS NOT NULL)
            SET @table_name = 'Section';
        ELSE IF EXISTS (SELECT * FROM inserted WHERE faculty_id IS NOT NULL)
            SET @table_name = 'Faculty';
        ELSE IF EXISTS (SELECT * FROM inserted WHERE dept_id IS NOT NULL)
            SET @table_name = 'Department';

        INSERT INTO Audit (audit_date, description, table_name)
        SELECT GETDATE(), 'Table ' + @table_name + ' was updated', @table_name;
    END
END;

--Q3

CREATE VIEW enrollment_view AS
SELECT Section.section_id, Course.course_id, Course.name AS course_name, Section.capacity, 
       COUNT(Enrolled.student_roll_no) AS enrolled_count, Section.capacity - COUNT(Enrolled.student_roll_no) AS seats_available
FROM Section
JOIN Course ON Section.course_id = Course.course_id
LEFT JOIN Enrolled ON Section.section_id = Enrolled.section_id
GROUP BY Section.section_id, Course.course_id, Course.name, Section.capacity;

SELECT section_id, course_name, capacity, enrolled_count, seats_available
FROM enrollment_view
WHERE course_id = 'CSCI101' AND seats_available > 0;

--Q4

CREATE PROCEDURE EnrollStudent (@student_roll_no INT, @section_id INT)
AS
BEGIN
  INSERT INTO Enrolled (student_roll_no, section_id) 
  VALUES (@student_roll_no, @section_id);
END

--Q5

CREATE OR ALTER FUNCTION prevent_department_changes()
RETURNS TRIGGER AS
BEGIN
  IF (TRIGGER_NESTLEVEL() = 1) -- check if the function was directly invoked by the trigger
  BEGIN
    IF (INSERTING OR UPDATING OR DELETING)
    BEGIN
      RAISERROR('Changes to the Department table are not allowed', 16, 1);
      RETURN NULL;
    END
  END
  RETURN NULL;
END;
GO

CREATE TRIGGER prevent_department_changes_trigger
ON department
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  SET NOCOUNT ON;
  IF (NOT EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)) -- check if it's a table-level operation
  BEGIN
    EXEC prevent_department_changes; -- invoke the function to perform the checks
  END
END;
GO

--Q6

CREATE TRIGGER ddl_check
ON DATABASE
FOR DROP_TABLE, ALTER_TABLE
AS
BEGIN
    RAISERROR ('You are not authorized to perform this operation', 16, 1)
    ROLLBACK;
END;