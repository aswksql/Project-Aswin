-- 1.) Database Creation: Create a Database for Academic Management System
CREATE Database AMS;

-- a.) Create a table for storing student information
CREATE TABLE student_info (
    stu_id INT PRIMARY KEY, 
    stu_name VARCHAR(255) Not Null, 
    dob DATE NOT NULL,
    phone_no VARCHAR(15) Not Null, ---------------------------------------------------------------------------------------------------------------
    email_id VARCHAR(255) UNIQUE,
    address VARCHAR(255)
);

-- b.) Create a table to store course information
CREATE TABLE course_info (
    course_id INT PRIMARY KEY, 
    course_name VARCHAR(255) Not Null, 
    instructor_name VARCHAR(255) Not Null
);

-- c.) Create a table to store enrollment information
CREATE TABLE enrollment_info (
    enrollment_id INT PRIMARY KEY, 
    stu_id INT Not Null, 
    course_id INT Not Null, 
    enrollment_status VARCHAR(15) NOT NULL, 
    CHECK (enrollment_status IN ('enrolled', 'not enrolled')), -- Check constraint for Enrollment status: enrolled or not enrolled
    FOREIGN KEY (stu_id) REFERENCES student_info(stu_id), -- Foreign key constraint for stu_id
    FOREIGN KEY (course_id) REFERENCES course_info(course_id) -- Foreign key constraint for course_id
);

-- 2.) Data Creation: Insert data into the student_info table
INSERT INTO student_info (stu_id, stu_name, dob, phone_no, email_id,address)
VALUES
    (1, 'Arun', '1998-04-10',  '+91 9876543210', 'arun@example.com','25 Anna Nagar, Chennai'),
    (2, 'Deepa', '1999-02-15', '+91 7890123456', 'deepa@example.com', '15 Velachery, Chennai'),
    (3, 'Karthik', '1997-07-20', '+91 8888888888', 'karthik@example.com', '32 T. Nagar, Chennai'),
    (4, 'Saranya', '1998-10-05', '+91 9876543210', 'saranya@example.com', '40 Mylapore, Chennai'),
    (5, 'Vijay', '1996-03-30', '+91 9876543210', 'vijay@example.com', '12 Adyar, Chennai');

-- Insert data into the course_info table
INSERT INTO course_info (course_id, course_name, instructor_name)
VALUES
    (101, 'Mathematics', 'Sridharan'),
    (102, 'History', 'Subramanian'),
    (103, 'Physics', 'Venkataraman'),
    (104, 'Computer Science', 'Chandrasekhar'),
    (105, 'Tamil Literature', 'Lakshmi');

-- Insert data into the enrollment_info table
INSERT INTO enrollment_info (enrollment_id, stu_id, course_id, enrollment_status)
VALUES
    (1, 1, 101, 'enrolled'),
    (2, 1, 102, 'enrolled'),
    (3, 1, 103, 'enrolled'),
    (4, 1, 104, 'enrolled'),
    (5, 1, 105, 'not enrolled'),

    (6, 2, 101, 'not enrolled'),
    (7, 2, 102, 'enrolled'),
    (8, 2, 103, 'enrolled'),
    (9, 2, 104, 'enrolled'),
    (10, 2, 105, 'not enrolled'),

    (11, 3, 101, 'not enrolled'),
    (12, 3, 102, 'not enrolled'),
    (13, 3, 103, 'not enrolled'),
    (14, 3, 104, 'enrolled'),
    (15, 3, 105, 'enrolled'),

    (16, 4, 101, 'enrolled'),
    (17, 4, 102, 'enrolled'),
    (18, 4, 103, 'not enrolled'),
    (19, 4, 104, 'enrolled'),
    (20, 4, 105, 'enrolled'),

    (21, 5, 101, 'enrolled'),
    (22, 5, 102, 'enrolled'),
    (23, 5, 103, 'not enrolled'),
    (24, 5, 104, 'not enrolled'),
    (25, 5, 105, 'enrolled');

-- 3.) Retrieve the Student Information

------------------------------------------------------------------------------------------------------------------------------------------------
-- a.) Retrieve Student Details with Student name,Contact Information and Enrollment Status
SELECT si.stu_name, si.phone_no, si.email_id,ei.course_id, ei.enrollment_status
FROM student_info si
JOIN enrollment_info ei ON si.stu_id = ei.stu_id
;
------------------------------------------------------------------------------------------------------------------------------------------------

-- b.) List of Courses in Which a Specific Student Is Enrolled
SELECT ci.course_name
FROM course_info ci
JOIN enrollment_info ei ON ci.course_id = ei.course_id
WHERE ei.stu_id = 4 and enrollment_status='enrolled'; -- Replace '4' with the desired stu_id
;

-- c.) Retrieve Course Information Including Course Name and Instructor Information
SELECT course_name, instructor_name
FROM course_info 
;

-- d.) Retrieve Course Information for a Specific Course (e.g., course_id = 101)
SELECT course_name, instructor_name
FROM course_info 
WHERE course_id = 102; -- Replace '102' with the desired course_id
;

-- e.) Retrieve Course Information for Multiple Courses (e.g., course_id = 101 and 102)
SELECT ci.course_name, ci.instructor_name
FROM course_info ci
WHERE ci.course_id IN (104, 102); -- Replace with desired course_id values
;

-- 4.) Reporting and Analytics

-- a.) Number of Students Enrolled in Each Course
SELECT ci.course_id, ci.course_name, COUNT(DISTINCT ei.stu_id) AS num_students_enrolled
FROM course_info ci
LEFT JOIN enrollment_info ei ON ci.course_id = ei.course_id
where ei.enrollment_status='enrolled'
GROUP BY ci.course_id, ci.course_name;

-- b.) List of Students Enrolled in a Specific Course
SELECT si.stu_id, si.stu_name
FROM student_info si
JOIN enrollment_info ei ON si.stu_id = ei.stu_id
WHERE ei.course_id = 103 and ei.enrollment_status='enrolled'; -- Replace '103' with the desired course_id

-- c.) Count of Enrolled Students for Each Instructor
SELECT ci.instructor_name, COUNT(DISTINCT ei.stu_id) AS num_students_enrolled
FROM course_info ci
LEFT JOIN enrollment_info ei ON ci.course_id = ei.course_id
where ei.enrollment_status='enrolled'
GROUP BY ci.instructor_name;

-- d.) List of Students Enrolled in Multiple Courses
SELECT si.stu_id, si.stu_name, COUNT(ei.course_id) AS num_courses_enrolled
FROM student_info si
JOIN enrollment_info ei ON si.stu_id = ei.stu_id
where ei.enrollment_status='enrolled'
GROUP BY si.stu_id, si.stu_name
HAVING COUNT(ei.course_id) > 1
ORDER BY COUNT(ei.course_id) Desc;

-- e.) Courses with the Highest Number of Enrolled Students
SELECT ci.course_id, ci.course_name, COUNT(DISTINCT ei.stu_id) AS num_students_enrolled
FROM course_info ci
LEFT JOIN enrollment_info ei ON ci.course_id = ei.course_id
where ei.enrollment_status='enrolled'
GROUP BY ci.course_id, ci.course_name
ORDER BY num_students_enrolled DESC;