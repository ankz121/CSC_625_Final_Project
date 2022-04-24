USE College_Database;  
GO  

CREATE OR ALTER PROCEDURE StudentLoginCmd
    @StudentID varchar(255),   
    @Passcode varchar(255)   
WITH ENCRYPTION
AS   
	SELECT COUNT(*) 
	FROM StudentLogin 
	WHERE StudentID = @StudentID AND Passcode = @Passcode  
	RETURN
GO  

CREATE OR ALTER PROCEDURE FacultyLoginCmd   
    @FacultyID varchar(255),   
    @Passcode varchar(255)   
WITH ENCRYPTION
AS   
	SELECT COUNT(*) 
	FROM FacultyLogin 
	WHERE FacultyID = @FacultyID AND Passcode = @Passcode
	RETURN
GO  

CREATE OR ALTER PROCEDURE FacultyCourses   
    @FacultyID varchar(255)
WITH ENCRYPTION
AS   
	SELECT Faculty_Course.CourseID, Course.CourseTime, Course.CourseLoc
	FROM Faculty_Course
	INNER JOIN Course ON Faculty_Course.CourseID=Course.CourseID
	WHERE Faculty_Course.FacultyID = @FacultyID
	RETURN
GO  

CREATE OR ALTER PROCEDURE StudentCourses
    @StudentID varchar(255)
WITH ENCRYPTION
AS   
	SELECT Student_Course.CourseID, Course.CourseTime, Course.CourseLoc
	FROM Student_Course
	INNER JOIN Course ON Student_Course.CourseID = Course.CourseID
	WHERE Student_Course.StudentID = @StudentID
	RETURN
GO  

CREATE OR ALTER PROCEDURE CourseInfo
    @CourseID varchar(255)
WITH ENCRYPTION
AS   
	SELECT Course.CourseID AS 'Course ID', 
	Course.CourseName AS 'Name', 
	Course.CourseTime AS 'Time', 
	Course.CourseLoc AS 'Location', 
	Faculty.LastName AS 'Instructor', 
	Faculty.Email AS 'Instructor Email'
	FROM Course
	INNER JOIN Faculty_Course
	ON Course.CourseID = Faculty_Course.CourseID
	INNER JOIN Faculty
	ON Faculty.FacultyID = Faculty_Course.FacultyID
	WHERE Course.CourseID = @CourseID
GO  

CREATE OR ALTER PROCEDURE CourseEnrolled
    @CourseID varchar(255)
WITH ENCRYPTION
AS   
	SELECT 
	Student.FirstName AS 'First',
	Student.LastName AS 'Last',
	Student.StudentID AS 'ID',
	Student.Email AS 'Email'
	FROM Student
	INNER JOIN Student_Course
	ON Student_Course.StudentID = Student.StudentID
	WHERE Student_Course.CourseID = @CourseID
GO  

CREATE OR ALTER PROCEDURE DropCourse
	@CourseID varchar(255)
WITH ENCRYPTION
AS
	DELETE 
	FROM 
	Student_Course 
	WHERE 
	Student_Course.CourseID = @CourseID
GO

CREATE OR ALTER PROCEDURE nameSelect
	@StudentID varchar(255)
WITH ENCRYPTION
AS
	SELECT 
	CONCAT(FirstName, ' ',LastName) 
	AS Name 
	FROM Student 
	Where StudentID = @StudentID
	RETURN
GO

CREATE OR ALTER PROCEDURE facutlySelect
	@FacultyID varchar(255)
WITH ENCRYPTION
AS
	SELECT 
	CONCAT(FirstName, ' ',LastName) 
	AS Name 
	FROM Faculty 
	Where FacultyID = @FacultyID
	RETURN
GO


CREATE OR ALTER PROCEDURE insertIntoCourse 
	@StudentID varchar(255), @CourseID varchar(255)
WITH ENCRYPTION
AS
	INSERT INTO Student_Course (StudentID, CourseID) VALUES (@StudentID, @CourseID)
GO

CREATE OR ALTER PROCEDURE AvailableCourses
	@StudentID varchar(255)
WITH ENCRYPTION
AS
	SELECT CourseID
	FROM Course
	WHERE CourseID NOT IN (
		SELECT CourseID
		FROM Student_Course
		WHERE StudentID = @StudentID);
	RETURN
GO


CREATE OR ALTER PROCEDURE ViewAllCourses
WITH ENCRYPTION
AS
	SELECT Course.CourseID AS 'Course ID', 
		Course.CourseName AS 'Name', 
		Course.CourseTime AS 'Time', 
		Course.CourseLoc AS 'Location', 
		Faculty.LastName AS 'Instructor', 
		Faculty.Email AS 'Instructor Email'
		FROM Course
		INNER JOIN Faculty_Course
		ON Course.CourseID = Faculty_Course.CourseID
		INNER JOIN Faculty
		ON Faculty.FacultyID = Faculty_Course.FacultyID
GO

CREATE OR ALTER PROCEDURE AdminLoginCmd   
    @Username varchar(255),   
    @Passcode varchar(255)   
WITH ENCRYPTION
AS   
	SELECT COUNT(*) 
	FROM AdminLogin 
	WHERE Username = @Username AND Passcode = @Passcode
	RETURN
GO  

CREATE OR ALTER PROCEDURE AddCourse 
    @CourseID varchar(6),   
    @CourseName varchar(255), 
    @CourseDesc varchar(255), 
    @CourseTime varchar(255), 
    @CourseLoc varchar(255)
WITH ENCRYPTION
AS   
	INSERT INTO Course (CourseID, CourseName, CourseDesc, CourseTime, CourseLoc) VALUES
	(@CourseID, @CourseName, @CourseDesc, @CourseTime, @CourseLoc)
GO  

CREATE OR ALTER PROCEDURE AllCourses
WITH ENCRYPTION
AS   
	Select CourseID from Course
GO  

CREATE OR ALTER PROCEDURE DeleteCourse
@CourseID varchar(6)
WITH ENCRYPTION
AS   
	DELETE FROM Course WHERE CourseID = @CourseID
GO  

CREATE OR ALTER PROCEDURE AddStudent
	@StudentID int,
    @LastName varchar(255),
    @FirstName varchar(255),
	@DOB DATE,
	@Email  varchar(255),
	@Password varchar(255)
WITH ENCRYPTION
AS   
	INSERT INTO Student (StudentID, LastName, FirstName, DOB, Email) VALUES
	(@StudentID, @LastName, @FirstName, @DOB, @Email)
	INSERT INTO StudentLogin (StudentID, Passcode) VALUES
	(@StudentID, @Password)
GO  


CREATE OR ALTER PROCEDURE AllStudents
WITH ENCRYPTION
AS   
	Select StudentID from Student
GO  

CREATE OR ALTER PROCEDURE DeleteStudent
@StudentID int
WITH ENCRYPTION
AS   
	DELETE FROM StudentLogin WHERE StudentID = @StudentID
	DELETE FROM Student_Course WHERE StudentID = @StudentID
	DELETE FROM Student WHERE StudentID = @StudentID
GO  

CREATE OR ALTER PROCEDURE AddFaculty
	@FacultyID int,
    @LastName varchar(255),
    @FirstName varchar(255),
	@Email  varchar(255),
	@Password varchar(255)
WITH ENCRYPTION
AS   
	INSERT INTO Faculty (FacultyID, LastName, FirstName, Email) VALUES
	(@FacultyID, @LastName, @FirstName, @Email)
	INSERT INTO FacultyLogin (FacultyID, Passcode) VALUES
	(@FacultyID, @Password)
GO  

CREATE OR ALTER PROCEDURE AllFaculty
WITH ENCRYPTION
AS   
	Select FacultyID from Faculty
GO  

CREATE OR ALTER PROCEDURE DeleteFaculty
@FacultyID int
WITH ENCRYPTION
AS   
	DELETE FROM FacultyLogin WHERE FacultyID = @FacultyID
	DELETE FROM Faculty_Course WHERE FacultyID = @FacultyID
	DELETE FROM Faculty WHERE FacultyID = @FacultyID
GO  
