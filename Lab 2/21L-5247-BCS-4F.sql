create table student
(
	Roll_Num char(8) not null,
	Name varchar(30),
	Gender varchar(6),
);

alter table student alter column Gender varchar(6) not null;
alter table student add constraint unique_roll_number unique(Roll_Num);

alter table student add Phone int unique;
alter table student add constraint Primarykey1 Primary Key (Roll_Num);

create table Attendence
(
	Roll_Num char(8) not null,
	Date_ date,
	Status_ char,
	Venue int
);

alter table Attendence alter column Status_ bit;
alter table Attendence add constraint Primarykey4 Primary Key (Roll_Num);
alter table Attendence add constraint FK_Student_Roll_Num Foreign Key (Roll_Num) References student(Roll_Num) on delete cascade on update cascade;

create table Teacher
(
	Name varchar(30),
	Designation varchar(20),
	Department varchar(30)
);

alter table Teacher alter column Name varchar(30) not null;
alter table Teacher add constraint unique_Teacher_Name unique(Name);
alter table Teacher add constraint Primarykey2 Primary Key (Name);

create table ClassVenue
(
	ID int not null,
	Building varchar(20),
	Room_Num int not null,
	Teacher varchar(30)
);

alter table ClassVenue add constraint PrimaryKey3 Primary Key (ID);
alter table Attendence alter column Roll_Num char(8) not null;
alter table ClassVenue add constraint FK_Teacher Foreign Key (Teacher) References Teacher(Name) on delete cascade on update cascade;

Insert Into [student] ([Roll_Num], [Name], [Gender], [Phone])
Values ('21L-5247', 'Farhan Bukhari', 'Male', 0314423)
Go

Insert Into [student] ([Roll_Num], [Name], [Gender], [Phone])
Values ('21L-6767', 'Akram Waheed', 'Female', 03245464)
Go

Insert Into [student] ([Roll_Num], [Name], [Gender], [Phone])
Values ('21L-6769', 'Muhammad Waleed', 'Male', 03242164)
Go

Insert Into [student] ([Roll_Num], [Name], [Gender], [Phone])
Values ('21L-6768', 'Asif Wajid', 'Male', 03245564)
Go

Insert Into [student] ([Roll_Num], [Name], [Gender], [Phone])
Values ('21L-6770', 'Ali Farhat', 'Male', 03245514)
Go

Insert Into [student] ([Roll_Num], [Name], [Gender], [Phone])
Values ('21L-6771', 'Subhan Majid', 'Male', 03242564)
Go

Insert Into [student] ([Roll_Num], [Name], [Gender], [Phone])
Values ('21L-6772', 'Abdul Manan', 'Male', 03245364)
Go

Insert Into [student] ([Roll_Num], [Name], [Gender], [Phone])
Values ('16L-2334', 'Abdul Hanan', 'Male', 03241369)
Go

Insert Into [Attendence] ([Roll_Num], [Status_], [Date_], [Venue])
Values ('21L-6772', '1', 21-5-21, '21')
Go

Insert Into [Attendence] ([Roll_Num], [Status_], [Date_], [Venue])
Values ('21L-6770', '1', 21-5-20, '19')
Go

Insert Into [Attendence] ([Roll_Num], [Status_], [Date_], [Venue])
Values ('21L-6769', '1', 9-8-21, '12')
Go

Insert Into [Attendence] ([Roll_Num], [Status_], [Date_], [Venue])
Values ('16L-2334', '0', 11-5-20, '16')
Go

Insert Into [Teacher] ([Name], [Designation], [Department])
Values ('Samin Iftikhar', 'Head Of Department', 'Computer Science')
Go

Insert Into [Teacher] ([Name], [Designation], [Department])
Values ('Sarim Baig', 'Assistant Professor', 'Computer Science')
Go

Insert Into [Teacher] ([Name], [Designation], [Department])
Values ('Bismillah Jan', 'Lecturer', 'Civil Engineering')
Go

Insert Into [Teacher] ([Name], [Designation], [Department])
Values ('Kashif Zafar', 'Professor', 'Electrical Engineering')
Go

Insert Into [ClassVenue] ([ID], [Building], [Room_Num], [Teacher])
Values ('1', 'CS', 2, 'Sarim Baig')
Go

Insert Into [ClassVenue] ([ID], [Building], [Room_Num], [Teacher])
Values ('2', 'Civil', 7, 'Bismillah Jan')
Go

alter table student drop constraint UQ__student__5C7E359E803C28D6; --before removing any column, delete its constraints.
alter table student drop column phone;
alter table student add warningCount int;

Insert Into [student] ([Roll_Num], [Name], [Gender], [warningCount])
Values ('16L-2334', 'Fozan Shahid', 'Male', 3.2);	-- valid query
Go

Insert Into [Attendence] ([Roll_Num], [Status_], [Date_], [Venue])
Values ('16L-2334', '1', 11-5-20, '16')
Go

Insert Into [ClassVenue] ([ID], [Building], [Room_Num], [Teacher])
Values (3, 'CS', 5, 'Ali')	--invalid as Teacher named 'Ali' does not exist in Teacher table, and Teacher name from teacher table is a foreign key in ClassVenue.
Go

Insert Into [ClassVenue] ([ID], [Building], [Room_Num], [Teacher])
Values (3, 'CS', 5, 'Samin Iftikhar') --made valid by adding an available teacher from teacher table.
Go

update Teacher
set Name = 'Dr. Kashif Zafar'
where Name = 'Kashif Zafar'

delete from student
where Roll_Num = '16L-2334'	--deletes the student with this roll number and any of its references(Foreign Key) in other tables.

delete from student
where Roll_Num = '21L-6767';

delete from student
where Roll_Num = '21L-6769';

delete from Attendence
where Roll_Num = '16L-2334' AND Status_ = 0;

alter table Teacher add constraint uq_Teacher_Name unique(Name);
alter table student add constraint check_gender_male check (Gender = 'Male' OR Gender = 'Female');

--alter table student drop constraint check_gender_male;

alter table Attendence add constraint check_Status check(Status_ = 0 OR Status_ = 1);

select * from student;
select * from Attendence;
select * from ClassVenue;
select * from Teacher;