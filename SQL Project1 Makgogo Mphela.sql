-- 1) Create a database
create database Sports_Complex;

-- use this database Sports_Complex
use Sports_Complex;

-- Create the members table
CREATE TABLE members (
    ID INT NOT NULL,
    PASSWORD VARCHAR(255) NOT NULL,
    EMAIL VARCHAR(255) UNIQUE NOT NULL,
    MEMBER_SINCE DATE NOT NULL,
    PAYMENT_DUE DATE,
    PRIMARY KEY (ID)
);
INSERT INTO members (ID, PASSWORD, EMAIL, MEMBER_SINCE, PAYMENT_DUE) VALUES
(1111, 'makgogo1', 'makgogo@gmail.com', '2023-01-01', '2023-02-01'),
(2222, 'sipho2', 'sipho@gmail.com', '2023-01-15', '2023-02-15'),
(3333, 'thabo3', 'thabo@gmail.com', '2023-02-01', '2023-03-01'),
(4444, 'bonolo4', 'bonolo@gmail.com', '2023-02-15', '2023-03-15'),
(5555, 'scott5', 'scott@gmail.com', '2023-03-01', '2023-04-01'),
(6666, 'jonn6', 'jonn@gmail.com', '2023-03-15', '2023-04-15'),
(7777, 'phuti7', 'phuti@gmail.com', '2023-04-01', '2023-05-01'),
(8888, 'juli8', 'julia@gmail.com', '2023-04-15', '2023-05-15'),
(9999, 'karabo9', 'karabo@gmail.com', '2023-05-01', '2023-06-01'),
(1010, 'victor10', 'victor@gmail.com', '2023-05-15', '2023-06-15'),
(1011, 'mike11', 'mike@gmail.com', '2023-06-01', '2023-07-01'),
(1022, 'mpho22', 'mpho@gmail.com', '2023-06-15', '2023-07-15');
select * from members;

-- Create the pending_terminations table
CREATE TABLE pending_terminations (
    ID INT NOT NULL,
    EMAIL VARCHAR(255) NOT NULL,
    REQUEST_DATE DATE NOT NULL,
    PAYMENT_DUE DATE,
    PRIMARY KEY (ID),
    FOREIGN KEY (ID) REFERENCES members(ID)
);
INSERT INTO pending_terminations (ID, EMAIL, REQUEST_DATE, PAYMENT_DUE) VALUES
(1111, 'makgogo@gmail.com', '2023-01-01', '2023-02-01'),
(2222, 'sipho@gmail.com', '2023-01-15', '2023-02-15'),
(3333, 'thabo@gmail.com', '2023-02-01', '2023-03-01'),
(4444, 'bonolo@gmail.com', '2023-02-15', '2023-03-15'),
(5555, 'scott@gmail.com', '2023-03-01', '2023-04-01'),
(6666, 'jonn@gmail.com', '2023-03-15', '2023-04-15'),
(7777, 'phuti@gmail.com', '2023-04-01', '2023-05-01'),
(8888, 'julia@gmail.com', '2023-04-15', '2023-05-15'),
(9999, 'karabo@gmail.com', '2023-05-01', '2023-06-01'),
(1010, 'victor@gmail.com', '2023-05-15', '2023-06-15'),
(1011, 'mike@gmail.com', '2023-06-01', '2023-07-01'),
(1022, 'mpho@gmail.com', '2023-06-15', '2023-07-15');
select * from pending_terminations;

-- Create the rooms table
CREATE TABLE rooms (
    ID VARCHAR(5) NOT NULL,
    ROOM_TYPE VARCHAR(255) NOT NULL,
    PRICE DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (ID)
);
INSERT INTO rooms (ID, ROOM_TYPE, PRICE) VALUES
('AR1', 'Archery_Range', 100.00),
('BC1', 'Badminton_Courts', 300.00),
('AR2', 'Archery_Range', 100.00),
('MF1', 'Multipurpose_Fields', 500.00),
('MF2', 'Multipurpose_Fields', 500.00),
('TC1', 'Tennis_Courts', 150.00),
('TC2 ','Tennis_Courts', 150.00),
('TC3', 'Tennis_Courts', 150.00),
('BC2', 'Badminton_Courts', 300.00),
('BC3', 'Badminton_Courts', 350.00),
('MF3', 'Multipurpose_Fields', 500.00),
('AR3', 'Archery_Range', 1000.00);
select * from rooms;

-- Create the bookings table
CREATE TABLE bookings (
    Bookings_ID INT NOT NULL ,
    ROOM_ID VARCHAR(5) NOT NULL,
    BOOKED_DATE DATE NOT NULL,
    BOOKED_TIME TIME NOT NULL,
    MEMBER_ID INT NOT NULL,
    DATE_OF_BOOKING DATE NOT NULL,
    PAYMENT_STATUS VARCHAR(255) NOT NULL,
    PRIMARY KEY (Bookings_ID));
-- Insert 12 sample rows with matching ROOM_ID and MEMBER_ID values from the referenced tables
INSERT INTO bookings (Bookings_ID, ROOM_ID, BOOKED_DATE, BOOKED_TIME, MEMBER_ID, DATE_OF_BOOKING, PAYMENT_STATUS) VALUES
(1, 'AR1', '2023-01-01', '10:00:00', 1111, '2023-01-01', 'Paid'),
(2, 'BC1', '2023-01-02', '11:00:00', 2222, '2023-01-02', 'Paid'),
(3, 'AR2', '2023-01-03', '12:00:00', 3333, '2023-01-03', 'Paid'),
(4, 'MF1', '2023-01-04', '13:00:00', 4444, '2023-01-04', 'Pending'),
(5, 'MF2', '2023-01-05', '14:00:00', 5555, '2023-01-05', 'Paid'),
(6, 'TC1', '2023-01-06', '15:00:00', 6666, '2023-01-06', 'Pending'),
(7, 'TC2', '2023-01-07', '16:00:00', 7777, '2023-01-07', 'Paid'),
(8, 'TC3', '2023-01-08', '17:00:00', 8888, '2023-01-08', 'Pending'),
(9, 'BC2', '2023-01-09', '18:00:00', 9999, '2023-01-09', 'Paid'),
(10, 'BC3', '2023-01-10', '19:00:00', 1010, '2023-01-10', 'Paid'),
(11, 'MF3', '2023-01-11', '20:00:00', 1011, '2023-01-11', 'Paid'),
(12, 'AR3', '2023-01-12', '21:00:00', 1012, '2023-01-12', 'Pending');
select * from bookings;

--  Create view called member_bookings
CREATE VIEW member_bookings AS
SELECT
	b.MEMBER_ID,
    b.Bookings_ID,
    b.ROOM_ID,
    r.ROOM_TYPE,  
    b.BOOKED_DATE,
    b.BOOKED_TIME,
    r.PRICE,
    b.PAYMENT_STATUS
FROM
    bookings b
JOIN
    rooms r
ON
    b.ROOM_ID = r.ID;
select * from member_bookings;


-- Insert another member into the member table using PROCUDURE
DELIMITER $$

CREATE PROCEDURE InsertMember(
    IN member_id INT,
    IN member_password VARCHAR(255),
    IN member_email VARCHAR(255),
    IN member_since DATE,
    IN member_payment_due DATE
)
BEGIN
    INSERT INTO members VALUES (member_id, member_password, member_email, member_since, member_payment_due);
END;
$$

--  Update the 3rd person in the member table's email address to dotKay176@gmail.com
create procedure updated_email (in new_email varchar(50), in id_updated int)
begin
	update members
    set email = new_email
    where id = id_updated;
end;

delimiter;

call updated_email ( 'doKay176@gmail.com' , 3333);
CALL InsertMember(1144, 'mphoza12', 'mphoza@gmail.com', '2023-07-01', '2023-08-05');
select * from members;

-- Write a code that will only return half of members table registration data and time
SELECT  * FROM members
limit 6;
select * from members;


--  Write a code that will take only first character from bookings table room id 
--  and room type from room table then use them in condition statement to 
--    join 2 tables (Room table and Bookings table).
SELECT * FROM bookings b
JOIN rooms r ON left(b.ROOM_ID, 1) = left(r.Room_Type, 1);


-- Create the cancellation_history table
CREATE TABLE cancellation_history (
    member_id INT NOT NULL,
    booking_id INT NOT NULL,
    cancellation_date DATE NOT NULL
);
INSERT INTO cancellation_history (member_id, booking_id, cancellation_date) VALUES
(1111, 1, '2023-10-01'),  -- First cancellation
(1111, 2, '2023-10-05'),  -- Second cancellation
(1111, 3, '2023-10-07'),  -- Third cancellation (results in fine)
(1111 ,4, '2023-10-10'),  -- Fourth cancellation (fine)
(2222, 5, '2023-09-20'),  -- First cancellation
(2222, 6, '2023-09-23'),  -- Second cancellation
(222, 7, '2023-09-26'),  -- Third cancellation (results in fine)
(3333, 8, '2023-08-15'),  -- First cancellation
(3333, 9, '2023-08-20'),  -- Second cancellation
(3333, 10, '2023-08-25'),  -- Third cancellation (results in fine)
(4444, 11, '2023-07-10'),  -- First cancellation
(4444, 12, '2023-07-12');  -- Second cancellation

SELECT Member_ID, Booking_ID, Cancellation_Date,cancellation_fee
FROM cancellation_history
WHERE Member_ID = 4444 
ORDER BY Cancellation_Date DESC
LIMIT 3; 

-- Add the 'cancellation_fee' column to the 'cancellation_history' table
ALTER TABLE cancellation_history
ADD cancellation_fee INT;

-- Update the 'cancellation_fee' column based on the condition
UPDATE cancellation_history AS ch
SET ch.cancellation_fee = 
    CASE
        WHEN ch.cancellation_date IN (
            SELECT cancellation_date
            FROM (
                SELECT
                    member_id,
                    cancellation_date,
                    ROW_NUMBER() OVER (PARTITION BY member_id ORDER BY cancellation_date) AS consecutive_cancellations
                FROM
                    cancellation_history
                WHERE member_id = ch.member_id
            ) AS subquery
            WHERE subquery.consecutive_cancellations >= 3
        ) THEN 50
        ELSE 0
    END;


