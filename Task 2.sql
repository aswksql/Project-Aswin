-- 1. Database Setup: Create a Database for Student Database Management System
Create Database Student_database;

--  Create a table for storing student information
CREATE TABLE student_table (
    student_id INT PRIMARY KEY, 
    stu_name Text NOT NULL, 
    department Text Not Null, 
    email_id Text UNIQUE, 
    phone_no NUMERIC Not Null, 
    address TEXT, 
    date_of_birth DATE Not Null, 
    gender TEXT, 
    major TEXT, 
    GPA NUMERIC , 
    grade TEXT CHECK (grade IN ('A', 'B', 'C', 'D')) -- Student's grade (A, B, C, D)
);


-- 2. Data Entry: Insert data into the student_table
INSERT INTO student_table (student_id, stu_name, department, email_id, phone_no, address, date_of_birth, gender, major, GPA, grade)
VALUES
    (1, 'John', 'Computer Science', 'john.doe@example.com', 9876543210, '123 Main St', '1995-05-15', 'Male', 'Computer Science', 8.5, 'A'),
    (2, 'Jane', 'Mathematics', 'jane.smith@example.com', 9876543211, '456 Elm St', '1996-02-10', 'Female', 'Mathematics', 7.2, 'B'),
    (3, 'Raj', 'Electrical Engineering', 'raj.kumar@example.com', 9876543212, '789 Oak St', '1997-08-20', 'Male', 'Electrical Engineering', 4.3, 'D'),
    (4, 'Neha', 'Physics', 'neha.gupta@example.com', 9876543213, '101 Pine St', '1998-03-25', 'Female', 'Physics', 6.9, 'C'),
    (5, 'Arvind', 'Chemistry', 'arvind.patel@example.com', 9876543214, '555 Birch St', '1999-11-30', 'Male', 'Chemistry', 8.2, 'B'),
    (6, 'Sangeetha', 'Computer Science', 'sangeetha.reddy@example.com', 9876543215, '222 Cedar St', '2000-07-05', 'Female', 'Computer Science', 7.8, 'B'),
    (7, 'Prakash', 'Mathematics', 'prakash.verma@example.com', 9876543216, '333 Fir St', '2001-01-10', 'Male', 'Mathematics', 6.5, 'C'),
    (8, 'Deepa ', 'Physics', 'deepa.krishnan@example.com', 9876543217, '444 Spruce St', '2002-04-15', 'Female', 'Physics', 3.9, 'D'),
    (9, 'Harish', 'Chemistry', 'harish.sharma@example.com', 9876543218, '666 Redwood St', '2003-09-20', 'Male', 'Chemistry', 6.7, 'C'),
    (10, 'Pooja', 'Computer Science', 'pooja.singh@example.com', 9876543219, '777 Sequoia St', '2004-06-25', 'Female', 'Computer Science', 9.1, 'A');

-- 3. Retrieve All Student Information Sorted by GPA (Descending)
SELECT * FROM student_table
ORDER BY GPA DESC;

-- 4. Retrieve Information About Male Students
SELECT * FROM student_table
WHERE gender = 'Male';

-- 5. Retrieve Information About Students with GPA Less Than 5.0
SELECT * FROM student_table
where GPA < 5.0;

-- 6. Update Email and Grade of a Specific Student
UPDATE student_table
SET email_id = 'new_email@example.com', grade = 'B'
WHERE student_id = 1; -- Replace with the desired student_id.

-- 7. Retrieve Names and Ages of Students with Grade 'B'
SELECT stu_name, age(date_of_birth) AS age
FROM student_table
WHERE grade = 'B';

----------------------------------------------------------------------------------------------------------------------------------------------------
-- 8. Group Students by Department and Gender, Calculate Average GPA
SELECT department, gender, AVG(GPA) AS avg_gpa
FROM student_table
GROUP BY department, gender
Order BY department, gender;
----------------------------------------------------------------------------------------------------------------------------------------------------

-- 9. Rename the Student Table to 'student_info'
ALTER TABLE student_table RENAME TO student_info;

-- 10. Retrieve the Name of the Student with the Highest GPA
SELECT stu_name, GPA
FROM student_info
WHERE GPA = (SELECT MAX(GPA) FROM student_info);
