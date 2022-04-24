create database College_Database 
GO
USE College_Database
GO

CREATE TABLE Student (
    StudentID int PRIMARY KEY check (StudentID >= 0),
    LastName varchar(255) check(LastName not like '%[^A-Z]%'),
    FirstName varchar(255) check(FirstName not like '%[^A-Z]%'),
	DOB DATE,
	Email  varchar(255)
);
GO

INSERT INTO Student (StudentID, LastName, FirstName, DOB, Email) VALUES
	('1111', 'Clifford', 'Eric', '1992-12-25', 'clifforde96@lsus.edu'),
	('2222', 'McAllister', 'Connor', '1900-01-01', 'cmac@lsus.edu'),
	('3333', 'Patel', 'Ankit', '1900-01-01', 'apat@lsus.edu');
GO

CREATE TABLE Faculty (
    FacultyID int PRIMARY KEY check (FacultyID >= 0),
    LastName varchar(255) check(LastName not like '%[^A-Z]%'),
    FirstName varchar(255) check(FirstName not like '%[^A-Z]%'),
	Email  varchar(255)
);
GO

INSERT INTO Faculty (FacultyID, LastName, FirstName, Email) VALUES
	('1234', 'Chakrabarty', 'Subhajit', 'cchak@lsus.edu'),
	('2345', 'Alam', 'Tauhidal', 'talam@lsus.edu'),
	('3456', 'Watson', 'Richard', 'rwat@lsus.edu'),
	('4567', 'Cooper', 'Andy', 'acoop@lsus.edu'),
	('5678', 'Scott', 'Michael', 'mscott@lsus.edu'),
	('6789', 'Winger', 'Jeff', 'jwing@lsus.edu');
GO

CREATE TABLE StudentLogin (
    StudentID int FOREIGN KEY REFERENCES Student(StudentID) ON DELETE CASCADE check (StudentID >= 0),
	Passcode varchar(255)
	CONSTRAINT PK_StudentID PRIMARY KEY (StudentID)
);
GO

INSERT INTO StudentLogin (StudentID, Passcode) VALUES
	('1111', 'password'),
	('2222', 'password'),
	('3333', 'password');

CREATE TABLE FacultyLogin (
    FacultyID int FOREIGN KEY REFERENCES Faculty(FacultyID) ON DELETE CASCADE check (FacultyID >= 0),
	Passcode varchar(255)
	CONSTRAINT PK_FacultyID PRIMARY KEY (FacultyID)
);
GO

INSERT INTO FacultyLogin (FacultyID, Passcode) VALUES
	('1234', 'password'),
	('2345', 'password'),
	('3456', 'password'),
	('4567', 'password'),
	('5678', 'password'),
	('6789', 'password');
GO

CREATE TABLE Department (
	DepartmentID varchar(3) PRIMARY KEY check(DepartmentID not like '%[^A-Z]%'),
    FK_DeptHead int FOREIGN KEY REFERENCES Faculty(FacultyID) check (FK_DeptHead >= 0),
	DeptName varchar(255) check(DeptName not like '%[^A-Z ]%'),
	DeptLocation varchar(255) check(DeptLocation not like '%[^A-Z 0-9]%')
);
GO

INSERT INTO Department (DepartmentID, FK_DeptHead, DeptName, DeptLocation) VALUES
	('CSC', '3456', 'Computer Science', 'Tech Center'),
	('LAW', '6789', 'Law', 'Business Center'),
	('BIO', '5678', 'Biology', 'Science Building');
GO

CREATE TABLE Course(
	CourseID varchar(6) PRIMARY KEY check(CourseID not like '%[^A-Z0-9]%'),
	CourseName varchar(255) check(CourseName not like '%[^A-Z ]%'),
	CourseDesc varchar(255),
	CourseTime varchar(255),
	CourseLoc varchar(255) check(CourseLoc not like '%[^A-Z0-9]%')
)
GO

INSERT INTO Course (CourseID, CourseName, CourseDesc, CourseTime, CourseLoc) VALUES
	('BIO100', 'Intro Bio', 'Basic Bio stuff', 'MW 12-2', 'SB100'),
	('LAW100', 'Intro Law', 'Basic Law stuff', 'TR 12-2', 'BC100'),
	('CSC110', 'Intro Computers', 'Basic Computer stuff', 'MW 12-2', 'TC100'),
	('CSC120', 'Intro Programming', 'Basic Programming stuff', 'TR 12-2', 'TC100'),
	('CSC130', 'Intro Databases', 'Basic DB stuff', 'MW 3-5', 'TC200'),
	('CSC140', 'Quantum Computing', 'Get ready for some work', 'TR 3-5', 'TC200'),
	('CSC150', 'Big Data', 'Data, but its big', 'M 6-9', 'TC300'),
	('CSC160', 'Machine Learning', 'Ever seen iRobot?', 'T 6-9', 'TC300')
GO

CREATE TABLE Student_Course(
	StudentID int FOREIGN KEY REFERENCES Student(StudentID) ON DELETE CASCADE check (StudentID >= 0),
	CourseID varchar(6) FOREIGN KEY REFERENCES Course(CourseID) ON DELETE CASCADE check(CourseID not like '%[^A-Z0-9]%'),
	CONSTRAINT PK_StudentCourse PRIMARY KEY (StudentID, CourseID) 
)
GO

INSERT INTO Student_Course (StudentID, CourseID) VALUES
	('1111', 'BIO100'),
	('3333', 'BIO100'),
	('2222', 'LAW100'),
	('1111', 'CSC110'),
	('2222', 'CSC110'),
	('3333', 'CSC110'),
	('1111', 'CSC120'),
	('2222', 'CSC130'),
	('3333', 'CSC140'),
	('1111', 'CSC150'),
	('2222', 'CSC160'),
	('3333', 'CSC160');
GO

CREATE TABLE Faculty_Course(
	FacultyID int FOREIGN KEY REFERENCES Faculty(FacultyID) ON DELETE CASCADE check (FacultyID >= 0),
	CourseID varchar(6) FOREIGN KEY REFERENCES Course(CourseID) ON DELETE CASCADE check(CourseID not like '%[^A-Z0-9]%'),
	CONSTRAINT PK_CourseFaculty PRIMARY KEY (FacultyID, CourseID)
)
GO

INSERT INTO Faculty_Course (FacultyID, CourseID) VALUES
	('5678', 'BIO100'),
	('6789', 'LAW100'),
	('1234', 'CSC110'),
	('2345', 'CSC120'),
	('3456', 'CSC130'),
	('1234', 'CSC140'),
	('2345', 'CSC150'),
	('3456', 'CSC160');
GO

CREATE TABLE AdminLogin (
    Username varchar(255) check(Username not like '%[^A-Z ]%'),
	Passcode varchar(255)
);
GO

INSERT INTO AdminLogin (Username, Passcode) VALUES
	('admin', 'password');
GO