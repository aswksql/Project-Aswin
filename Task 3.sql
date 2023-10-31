-- 1. Create the 'events management' database
CREATE DATABASE events_management;

-- Create the 'events' table
CREATE TABLE events (
    event_id SERIAL PRIMARY KEY,
    event_name TEXT NOT NULL,
    event_date DATE NOT NULL,
    event_location TEXT,
    event_description TEXT
);


-- Create the 'attendees' table
CREATE TABLE attendees (
    attendee_id SERIAL PRIMARY KEY,
    attendee_name TEXT NOT NULL,
    attendee_phone NUMERIC NOT NULL,
    attendee_email VARCHAR(255),
    attendee_city TEXT 
);

-- Create the 'registrations' table with foreign key constraints
CREATE TABLE registrations (
    registration_id SERIAL PRIMARY KEY,
	event_id SERIAL Not Null, 
    attendee_id SERIAL Not Null, 
    FOREIGN KEY (event_id) REFERENCES events(event_id),
    FOREIGN KEY (attendee_id) REFERENCES attendees(attendee_id),
    registration_date DATE Not Null, 
    registration_amount NUMERIC(10, 2) Not Null
);

-- 2. Data Creation

-- Insert sample values into the 'events' table
INSERT INTO events (event_id ,event_name, event_date, event_location, event_description)
VALUES
    (1,'Cultural Festival', '2023-10-25', 'Chennai', 'An annual cultural extravaganza in Chennai.'),
    (2,'Tech Conference', '2023-11-15', 'Coimbatore', 'A tech conference focusing on emerging technologies.'),
    (3,'Art Exhibition', '2023-12-05', 'Madurai', 'Showcasing the best of Tamil Nadu artistry.');

-- Insert sample values into the 'attendees' table
INSERT INTO attendees (attendee_id, attendee_name, attendee_phone, attendee_email, attendee_city)
VALUES
    (1,'Saranya', 9876543210,'saranya@example.com', 'Chennai'),
    (2,'Rajesh', 9876543211, 'rajesh@example.com', 'Coimbatore'),
    (3,'Meena', 9876543212,'meena@example.com', 'Madurai');

-- Insert sample values into the 'registration' table
INSERT INTO registrations (registration_id, event_id, attendee_id, registration_date, registration_amount)
VALUES
    (1,1, 1, '2023-10-20', 1500.00),
    (2,2, 2, '2023-11-10', 2000.00),
    (3,3, 3, '2023-11-30', 1000.00),
    (4,1, 2, '2023-10-23', 1500.00),
    (5,2, 3, '2023-11-12', 2000.00);

--3. Manage Event Details

-- a. Query to insert a new event
INSERT INTO events (event_id,event_name, event_date, event_location, event_description)
VALUES (4,'Sample Event', '2023-10-20', 'Chennai', 'This is a test event');

-- b. Query to update event information
UPDATE events
SET event_name = 'Updated Event Name'
WHERE event_id = 4;

-- c. Query to delete an event
DELETE FROM events
WHERE event_id = 4;

4. Manage, Track attendees and Handle Events

-- a. Insert new values into the 'attendees' table
INSERT INTO attendees (attendee_id, attendee_name, attendee_phone, attendee_email, attendee_city)
VALUES
    (7,'Ram', 9816543211,'Ram@example.com', 'Chennai');

-- b. Insert new values into the 'registration' table
INSERT INTO registrations (registration_id, event_id, attendee_id, registration_date, registration_amount)
VALUES
    (6,2,3, '2023-11-20', 5300.00);

-- 5. Query to retrieve event information
SELECT * FROM events;

-- Query to generate an attendee list
SELECT * FROM attendees;

-- Query to calculate event attendance statistics
SELECT events.event_id, event_name, COUNT(registrations.registration_id) AS total_attendees
FROM events
LEFT JOIN registrations ON events.event_id = registrations.event_id
GROUP BY events.event_id, event_name
ORDER BY total_attendees DESC;