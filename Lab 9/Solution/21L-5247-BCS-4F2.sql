create database lab9;
use lab9;

create table Students
(	
	RollNo varchar(7) primary key,
	Name varchar(30),
	WarningCount int,
	Department varchar(15)
)
GO

INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'1', N'Ali', 0, N'CS')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'2', N'Bilal', 0, N'CS')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'3', N'Ayesha', 0, N'CS')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'4', N'Ahmed', 0, N'CS')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'5', N'Sara', 0, N'EE')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'6', N'Salman', 1, N'EE')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'7', N'Zainab', 2, N'CS')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'8', N'Danial', 1, N'CS')

create table Courses
(
	CourseID int primary key,
	CourseName varchar(40),
	PrerequiteCourseID int,
	CreditHours int
) 

INSERT [dbo].[Courses] ([CourseID], [CourseName], [PrerequiteCourseID],CreditHours) VALUES (10, N'Database Systems', 20, 3)
INSERT [dbo].[Courses] ([CourseID], [CourseName], [PrerequiteCourseID],CreditHours) VALUES (20, N'Data Structures', 30,3)
INSERT [dbo].[Courses] ([CourseID], [CourseName], [PrerequiteCourseID],CreditHours) VALUES (30, N'Programing', NULL,3)
INSERT [dbo].[Courses] ([CourseID], [CourseName], [PrerequiteCourseID],CreditHours) VALUES (40, N'Basic Electronics', NULL,3)

Create table Instructors 
(
	InstructorID int Primary key,
	Name varchar(30),
	Department varchar(7) ,
)

INSERT [dbo].[Instructors] ([InstructorID], [Name], [Department]) VALUES (100, N'Ishaq Raza', N'CS')
INSERT [dbo].[Instructors] ([InstructorID], [Name], [Department]) VALUES (200, N'Zareen Alamgir', N'CS')
INSERT [dbo].[Instructors] ([InstructorID], [Name], [Department]) VALUES (300, N'Saima Zafar', N'EE')

Create table Semester
(
	Semester varchar(15) Primary key,
	[Status] varchar(10),
)

INSERT [dbo].[Semester] ([Semester], [Status]) VALUES (N'Fall2016', N'Complete')
INSERT [dbo].[Semester] ([Semester], [Status]) VALUES (N'Spring2016', N'Complete')
INSERT [dbo].[Semester] ([Semester], [Status]) VALUES (N'Spring2017', N'InProgress')
INSERT [dbo].[Semester] ([Semester], [Status]) VALUES (N'Summer2016', N'Cancelled')

Create table Courses_Semester
(
	InstructorID int Foreign key References Instructors(InstructorID),
	CourseID int Foreign key References Courses(CourseID),
	Semester varchar(15) Foreign key References Semester(Semester), 
	Section varchar(1) ,
	AvailableSeats int,
	Department varchar(2)
)

INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (200, 10, N'Spring2017', N'D', 45, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (200, 10, N'Spring2017', N'C', 0, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (100, 10, N'Spring2017', N'A', 6, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (300, 40, N'Spring2017', N'A', 6, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (300, 40, N'Spring2016', N'A', 6, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (200, 10, N'Spring2016', N'A', 0, N'CS')

create table Registration
(
	Semester varchar(15) Foreign key References Semester(Semester),
	RollNumber  varchar(7) Foreign key References Students(RollNo),
	CourseID int Foreign key References Courses(CourseID), 
	Section varchar(1),
	GPA float
)

INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Fall2016', N'1', 20, N'A', 3.3)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Fall2016', N'2', 20, N'B', 4)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Spring2016', N'1', 30, N'A', 1.0)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Fall2016', N'6', 40, N'D',0.0)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Spring2017', N'6', 40, N'D',1)

Create table ChallanForm
(
	Semester varchar(15) Foreign key References Semester(Semester),
	RollNumber  varchar(7) Foreign key References Students(RollNo),
	TotalDues int,
	[Status] varchar(10)
)

INSERT [dbo].[ChallanForm] ([Semester], [RollNumber], [TotalDues], [Status]) VALUES (N'Fall2016', N'1', 100000, N'Paid')
INSERT [dbo].[ChallanForm] ([Semester], [RollNumber], [TotalDues], [Status]) VALUES (N'Fall2016', N'2', 13333, N'Paid')
INSERT [dbo].[ChallanForm] ([Semester], [RollNumber], [TotalDues], [Status]) VALUES (N'Fall2016', N'3', 5000, N'Paid')
INSERT [dbo].[ChallanForm] ([Semester], [RollNumber], [TotalDues], [Status]) VALUES (N'Fall2016', N'4', 20000, N'Pending')


select * from Students
select * from Courses
select * from Instructors
select * from Registration
select * from Semester
select * from Courses_Semester
select * from ChallanForm

--Q1
create trigger del_student
on Students
instead of delete
as
begin
		print('You don’t have the permission to delete the student')
end

--Q2
create trigger ins_course
on Courses
instead of insert
as
begin
		print('You don’t have the permission to Insert a new Course')
end

--Q3
CREATE TABLE Notify (
    StudentID varchar(7) FOREIGN KEY REFERENCES Students(RollNo),
    NotificationString varchar(255)
)

CREATE TRIGGER tr_notify_registration
ON Registration
AFTER INSERT
AS
BEGIN
    DECLARE @Semester varchar(15)
    DECLARE @RollNumber varchar(7)
    DECLARE @CourseID int
    DECLARE @PrereqCourseID int
    DECLARE @SeatsAvailable int
    DECLARE @NotificationString varchar(100)

    SELECT @Semester = inserted.Semester, @RollNumber = inserted.RollNumber, @CourseID = inserted.CourseID
    FROM inserted

    SELECT @PrereqCourseID = PrerequiteCourseID
    FROM Courses
    WHERE CourseID = @CourseID

    SELECT @SeatsAvailable = (SELECT COUNT(*) FROM Registration WHERE Semester = @Semester AND CourseID = @CourseID)

    IF (@PrereqCourseID IS NOT NULL AND NOT EXISTS(SELECT * FROM Registration WHERE RollNumber = @RollNumber AND CourseID = @PrereqCourseID))
    BEGIN
        SET @NotificationString = 'Registration for Course ' + CAST(@CourseID AS varchar(10)) + ' in Semester ' + @Semester + ' was unsuccessful. Prerequisite course not passed.'
    END
    ELSE IF (@SeatsAvailable >= 10)
    BEGIN
        SET @NotificationString = 'Registration for Course ' + CAST(@CourseID AS varchar(10)) + ' in Semester ' + @Semester + ' was successful.'
    END
    ELSE
    BEGIN
        SET @NotificationString = 'Registration for Course ' + CAST(@CourseID AS varchar(10)) + ' in Semester ' + @Semester + ' was unsuccessful. No seats available.'
    END

    INSERT INTO Notify VALUES (@RollNumber, @NotificationString)
END

--create trigger notify_student
--on Registration
--instead of insert
--as
--begin
--		declare @var1 int;
		
--		select @var1 = R.RollNumber 
--		from Registration R 
--		join Courses_Semester CS ON R.CourseID = CS.CourseID AND CS.AvailableSeats > 0
--		join Courses C ON CS.CourseID = C.CourseID AND 


--end

--Q4
CREATE TRIGGER trg_before_insert_registration
ON Registration
FOR INSERT
AS
BEGIN
    -- Check if the inserted student has fee charges due
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN Students s ON i.RollNumber = s.RollNo
        WHERE s.WarningCount > 0
    )
    BEGIN
        -- Get the total fee charges due for the inserted student
        DECLARE @totalDues INT;
        SELECT @totalDues = TotalDues
        FROM ChallanForm
        WHERE RollNumber IN (
            SELECT RollNumber
            FROM inserted
        );

        -- Check if the total fee charges due is greater than $20,000
        IF @totalDues > 20000
        BEGIN
            -- Rollback the insert operation
            ROLLBACK;
            -- Print an error message
            PRINT 'Error: Student has more than $20,000 fee charges due. Enrollment not allowed.';
        END;
    END;
END;

--Q5
CREATE TRIGGER trg_before_delete_courses_semester
ON Courses_Semester
FOR DELETE
AS
BEGIN
    -- Check if the available seats are less than 10
    IF EXISTS (
        SELECT 1
        FROM deleted
        WHERE AvailableSeats < 10
    )
    BEGIN
        -- Print 'not possible'
        PRINT 'not possible';
        -- Rollback the delete operation
        ROLLBACK;
    END
    ELSE
    BEGIN
        -- Print 'Successfully deleted'
        PRINT 'Successfully deleted';
    END
END;

--Q6
CREATE TRIGGER trg_prevent_modifications_or_dropping_instructors
ON DATABASE
FOR ALTER_TABLE, DROP_TABLE
AS
BEGIN
    ROLLBACK;
    -- Print an error message
    PRINT 'Error: Modifying or dropping the Instructors table is not allowed.';
END;