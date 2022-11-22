--DEV: Pannha Oudom Munint, L2, Jr SWE
--DROP DATABASE IF EXISTS SCSRM
--Create DATABASE SCSRM
--Create DATABASE master
--TST use SCSRM, UDT and QA use master
--Use master 
--Use SCSRM




-- Please Do it 2 times to drop all tables
DROP TABLE CoursePrivileges
DROP TABLE Enroll
DROP TABLE Acquisition
DROP TABLE Reservation
DROP TABLE Loan
DROP TABLE CourseOfferings
DROP TABLE Privilege
DROP TABLE ResourceLocation
DROP TABLE Category
DROP TABLE Immoveable
DROP TABLE Moveable
DROP TABLE AllResource
DROP TABLE Staff
DROP TABLE Student
DROP TABLE Member
go

--DB table Script
--Member Table
CREATE TABLE Member (
    MemberID            VARCHAR(20) NOT NULL,                                       
    MemName             VARCHAR(20) NOT NULL,
    MemNumber           VARCHAR(20) NOT NULL,
    CourseCode          VARCHAR(20) NOT NULL,
    ContactDetail       VARCHAR(20) NOT NULL,	--Member Email only
    PaymentDetail       VARCHAR(20) NOT NULL,
    MemStatus           VARCHAR(8) DEFAULT 'Active' CHECK (MemStatus IN ('Active', 'Inactive')) NOT NULL,
    PRIMARY KEY (MemberID)
);
go
--Student Table
CREATE TABLE Student (
    MemberID          VARCHAR(20) NOT NULL,
    Points            INT NULL,				--Demerit Points
    StudentAddress    VARCHAR(20) NOT NULL,
	PRIMARY KEY (MemberID),
	FOREIGN KEY (MemberID) References Member(MemberID)
			ON UPDATE CASCADE ON DELETE NO ACTION
);
go
--Staff Table
CREATE TABLE Staff (
    MemberID          VARCHAR(20) NOT NULL, 
    StaffAddress      VARCHAR(20) NOT NULL,
    Position          VARCHAR(20) NULL,			-- Admin Position
    StaffStatus       VARCHAR(8) DEFAULT 'active' CHECK (StaffStatus IN ('active', 'Inactive')) NOT NULL,
	PRIMARY KEY (MemberID),
	FOREIGN KEY (MemberID) References Member(MemberID)
			ON UPDATE CASCADE ON DELETE NO ACTION
);
go
--Resource Table
CREATE TABLE AllResource (
    ResourceID         VARCHAR(10) NOT NULL,
    ReName             VARCHAR(50) NOT NULL,
    ReNumber           CHAR(20) NOT NULL,
    Model              VARCHAR(20) NOT NULL,
    Brand              VARCHAR(20) NOT NULL,
	ReStatus           VARCHAR(20) DEFAULT 'available' CHECK (ReStatus IN ('available', 'unavailable', 'occupied', 'damaged'))NOT NULL,
	PRIMARY KEY (ResourceID)
);
go
--Movable resource table
CREATE TABLE Moveable (
    ResourceID            VARCHAR(10) NOT NULL,
    MoValue               VARCHAR(15) NOT NULL,
	PRIMARY KEY (ResourceID),
	FOREIGN KEY (ResourceID) REFERENCES AllResource(ResourceID)
            ON UPDATE CASCADE ON DELETE NO ACTION
	);
go
--Immovable resource table
CREATE TABLE Immoveable (
    ResourceID          VARCHAR(10) NOT NULL,
    RoomNumber          VARCHAR(20) NOT NULL,
    Capacity            INT NOT NULL,
	PRIMARY KEY (ResourceID),
	FOREIGN KEY (resourceID) REFERENCES AllResource(resourceID) 
            ON UPDATE CASCADE ON DELETE NO ACTION
);
go
--Category Table
CREATE TABLE Category (
    categoryID          INT NOT NULL,
    CategoryName        VARCHAR(20) NOT NULL,
    Descriptions        VARCHAR(50) NOT NULL
	PRIMARY KEY (categoryID),
	);
go
--Location Table
CREATE TABLE ResourceLocation  (
    locationID          INT NOT NULL,
    Room                VARCHAR(20) NOT NULL,
    building            VARCHAR(20) NOT NULL,
    campus              VARCHAR(20) NOT NULL
	PRIMARY KEY (locationID),
	);
go
--Privilege table
CREATE TABLE Privilege (
    PrivilegeID         VARCHAR(20) NOT NULL,
    MemberID			VARCHAR(20) NOT NULL,
    PrivilegeDescription         VARCHAR(100) NOT NULL,
    MaxAmount           INT NOT NULL,					--Max Amount of resource allowed to be borrowed
    MaxPeriod           VARCHAR(20) NOT NULL,			--Max period of resources allowed to be borrowed
    PRIMARY KEY (PrivilegeID),
);
go
--Course Offerings table
CREATE TABLE CourseOfferings (
    OfferingID          VARCHAR(20) NOT NULL,
    yearOffered         VARCHAR(30) NOT NULL,
    semesterOffered     INT NOT NULL,
    BeginDate           VARCHAR(30) NOT NULL,
    EndDate             VARCHAR(30) NOT NULL,
    PRIMARY KEY (OfferingID),
);
go
--Loan table
CREATE TABLE Loan (
    LoanID              VARCHAR(20) NOT NULL,
    DueDate             DATE NULL,
	MoModel				VARCHAR(20) NOT NULL,	--Moveable Model
    PRIMARY KEY (LoanID),
);
go
--Reservation table
 CREATE TABLE Reservation (
     ReservationID        VARCHAR(20) NOT NULL,
     ResourceID           VARCHAR(10) NOT NULL,
     ReservationDateTime            DATETIME NOT NULL,
     PRIMARY KEY (ReservationID),
     Foreign Key (resourceID) references AllResource (resourceID)
               ON UPDATE CASCADE ON DELETE NO ACTION
 );
go
--Acquisition table
 CREATE TABLE Acquisition (
     AcquisitionID          VARCHAR(20) NOT NULL,
	 MemberID				VARCHAR(20) NOT NULL,
     Itemname               VARCHAR(20) NOT NULL ,
     model                  VARCHAR(30) NOT NULL,
     brand                  VARCHAR(20) NOT NULL,
     Itemdescription        VARCHAR(100) NOT NULL,
     urgency                VARCHAR(20) DEFAULT 'Not Urgent' CHECK (urgency IN ('Urgent','Not Urgent')) NOT NULL,
     ItemStatus             VARCHAR(20) DEFAULT 'available' CHECK (ItemStatus IN ('available', 'Delivered', 'Pending Delivery', 'Processing'))NOT NULL,
     vendorCode             VARCHAR(20) NOT NULL,
     price                  INT NOT NULL,
     PRIMARY KEY (MemberID, AcquisitionID),
	 FOREIGN KEY (MemberID) references Member(MemberID)
			 ON UPDATE CASCADE ON DELETE NO ACTION,	
 );
go
 --Enrollment Table
 CREATE TABLE Enroll (
     EnrollmentID			VARCHAR(10) NOT NULL,
     MemberID              VARCHAR(20) NOT NULL,
     OfferingID          VARCHAR(20) NOT NULL,
     PRIMARY KEY (OfferingID, EnrollmentID),
     Foreign Key (OfferingID) references CourseOfferings(OfferingID)
             ON UPDATE CASCADE ON DELETE NO ACTION,
 );
go
 --Course Privilege Table
CREATE TABLE CoursePrivileges (
     CoursePrivilegesID		VARCHAR(10) NOT NULL,
     OfferingID             VARCHAR(20) NOT NULL,
     PrivilegeID            VARCHAR(20) NOT NULL,
     PRIMARY KEY (PrivilegeID, OfferingID),
     Foreign Key (PrivilegeID) references Privilege(PrivilegeID)
             ON UPDATE CASCADE ON DELETE NO ACTION
 );

go

--Data Input	
--Member Table
--Contect details is email instead of Phone numner
INSERT INTO Member VALUES 
('M001', 'Anthony J','3313933','CMNS2005','3313933@gmail.com','MasterCard','active'),
('M003', 'Tyson F','3324552','INFT1201','3324552@gmail.com','American Express','active'),
('M005', 'Romero Y','3113245','DESN1104','3313245@uon.edu.au','ANZ Royal','active'),
('M010', 'George SP','3123452','COMP2050','GSP@uon.edu.au','MasterCard','inactive'),
('MS012', 'Michael B','3313944','FCOM205','BispingM@gmail.com','Amercian Express','active'),
('MS011', 'Tony F','3313190','FCOM101','Furguson@gmail.com','Amercian Express','active'),
('MS014', 'Chael S','3128001','FBUS104','Sonnen@gmail.com','MasterCard','active')
go	
	--Student Table
INSERT INTO Student VALUES
('M001','30','3/141 University Dr'),
('M003','80','151 Mount Hutton'),
('M005','10','3/141 University Dr'),
('M010','80','41st Cameron Park')
go
--Staff Table
INSERT INTO Staff VALUES
('MS012', '2/141 University Dr', 'Admin', 'Active'),
('MS011', '515st Mount hutton', 'Admin', 'Active'),
('MS014', 'GPNSWst DC', 'Admin', 'Active')
go
--Resource Table
INSERT INTO AllResource VALUES
('MR001','IMAX-MSM908','908-001','MSM908','IMAX','Damaged'),
('MR004','SENNHEISER-HD800S','800-001','SHD800S','SENNHEISER','Available'),
('MR005','SENNHEISER-HD800S','800-002','SHD800S','SENNHEISER','Unavailable'),
('IR002','INTEL-XE/QUADRO Workstation','1848-001','I/Q-DELL','DELL','Occupied'),
('IR005','Media suite','380-1','MS3801','APPLE','Available'),
('IR006','Computer Lab','301-1','CTLAB01','None','Available')
go
--Movable Table
INSERT INTO Moveable VALUES ('MR001','250,000')
INSERT INTO Moveable VALUES ('MR004','2100')
INSERT INTO Moveable VALUES ('MR005','2100')
go
--Immovable Table
INSERT INTO Immoveable VALUES ('IR002','ICT3.84', 3)
INSERT INTO Immoveable VALUES ('IR005','ICT3.80', 7)
INSERT INTO Immoveable VALUES ('IR006','CT301',12)
go
--Category Table
INSERT INTO Category VALUES
('1','Headphones','SENNHEISER Headphones'),
('2','Cameras','IMAX Cameras'),
('3','Workstations',' Intel and Quadro based workstations'),
('4','Studios',' Media Suite studios')
go
--Location Table
INSERT INTO Resourcelocation VALUES
(384,'ICT3.84','ICT','Callaghan'),
(380,'ICT3.80','ICT','Callaghan'),
(409,'HS409','Hunter','Callaghan')
go
--Privilege Table
INSERT INTO Privilege VALUES
('PSTU001','M001','Student Privilege & Student level of access and clearance','2','2-48 hours'),
('PSTU002','M003','Student Privilege & Student level of access and clearance','2','2-48 hours'),
('PSTU003','M005','Student Privilege & Student level of access and clearance','2','2-48 hours'),
('PSTU004','M010','Student Privilege & Student level of access and clearance','2','2-48 hours'),
('PSTA002','MS012','Staff Privilege & Staff level of access and clearance','2','2-48 hours')
go
--Course Offering Table
INSERT INTO CourseOfferings VALUES ('CO001','2020','2','2020-07-24','2020-11-24')
INSERT INTO CourseOfferings VALUES ('CO002','2019','1','2020-02-23','2020-06-23')
INSERT INTO CourseOfferings VALUES ('CO003','2020','2','2020-07-24','2020-11-24')
INSERT INTO CourseOfferings VALUES ('CO004','2020','2','2020-07-24','2020-11-24')
INSERT INTO CourseOfferings VALUES ('SCO001','2019','2','2019-07-24','2019-11-24')

go
--Loan Table
--"MSM908" Is most loaned resource
INSERT INTO Loan VALUES ('L001','2020-11-10','MSM908')
INSERT INTO Loan VALUES ('L002','2020-11-11','MSM908')
INSERT INTO Loan VALUES ('L003','2020-11-10','SHD008S')
go
--Reservation Table
INSERT INTO Reservation VALUES ('RIR001','IR005','2020-05-01')
INSERT INTO Reservation VALUES ('RIR002','IR002','2020-06-05')
INSERT INTO Reservation VALUES ('RIR003','IR005','2020-09-19')

go
--Acquisition Table
INSERT INTO Acquisition VALUES ('AMBP001','MS012','MacBook Pro 16','i9-32gb-1tb-5700m','APPLE','2020 MacBook Pro for media suite','Not urgent','Processing','MBP16-001','3500')
INSERT INTO Acquisition VALUES ('AGPU002','MS014','Nvidia Quadro A100','Quadro-A100-48gb','NVIDIA','Ampere based Quadro A-100 for CAD rendering workstations','Urgent','Pending Delivery','QA-100','3000')
INSERT INTO Acquisition VALUES ('ACPU001','MS011','AMD RYZEN 5950X','16 Cores 32 Threads at 4,9 Ghz','AMD','AMD 16core processor for workstation','Not urgent','Processing','3950X-001','1200')
go
--Enrollment ID
INSERT INTO Enroll VALUES
('ESTU001','M001','CO001'),
('ESTU002','M005','CO002'),
('ESTA001','MS011','SCO001')
go
--CoursePrivilege ID
INSERT INTO CoursePrivileges VALUES
('CPSTU001','CO001','PSTU001'),
('CPSTA001','SCO001','PSTA002'),
('CPSTU002','CO002','PSTU002')
go
--For checking if tables work
SELECT * FROM Member
SELECT * FROM Student
SELECT * FROM Staff
SELECT * FROM AllResource
SELECT * FROM Moveable
SELECT * FROM Immoveable
SELECT * FROM Category
SELECT * FROM CourseOfferings
SELECT * FROM CoursePrivileges
SELECT * FROM Privilege
SELECT * FROM Reservation
SELECT * FROM Loan
SELECT * FROM ResourceLocation
SELECT * FROM Acquisition
SELECT * FROM Enroll
go
--System Queries

--Print Student name who have enrolled and courses they enrolled in
SELECT MemName As 'Member Name',CourseCode As 'Course Enrolled' 
FROM Member
where not MemName = 'Michael B' and not MemName = 'Tony F' and not MemName = 'Chael S';
go

--Print Max amount of headphones allowed, member name and his or her code
SELECT MaxAmount As 'Max Number of speakers allowed', MemName As 'Member Name', CourseCode As 'Course'
FROM Privilege, Member
GROUP BY MemName, CourseCode, MaxAmount
ORDER BY 'Max Number of speakers allowed';
go

--Show staff member ID  and the total number of reservations and acquisition they have made.
SELECT COUNT(AcquisitionID)as 'Amount of acquisition and reservation', member.MemberID, Member.ContactDetail
FROM Acquisition, Member
Where NOT member.MemberID = 'M001' and not Member.MemberID = 'M003' and not Member.MemberID ='M005' and not Member.MemberID ='M010'
GROUP BY member.MemberID, member.ContactDetail
ORDER BY COUNT(AcquisitionID);
go

--Print the name of student who borrowed a camera and the year they did
SELECT MemName As 'Member name', MemberID, CategoryName As 'Category', Model, CURRENT_TIMESTAMP as 'Date time borrowed this year'
from Member, Category, Moveable, AllResource
where CategoryName ='Cameras' and AllResource.Model ='MSM908' and not MemberID = 'MS011' and not MemberID = 'MS014' and not MemberID = 'MS012'
Group by MemberID,MemName, CategoryName, Model;
go

--Show Most Loaned Movaeble resource This month (Business critical DO NOT PUSH TO DEV OR PROD)
SELECT TOP(1) With ties Count(*) As 'Time Loaned this month', loan.MoModel As 'Laoned Resource Model', AllResource.ReName As 'Resource Name'
FROM Loan, AllResource
WHERE Loan.MoModel = AllResource.Model and MONTH(Loan.DueDate) = MONTH( SYSDATETIME())
and YEAR(Loan.DueDate) = YEAR(SYSDATETIME())
GROUP BY MoModel, ReName
having COUNT(*) >= all
(SELECT COUNT(*) from Loan, AllResource
WHERE MoModel = ReName and MONTH(Loan.DueDate) = MONTH(SYSDATETIME())
and YEAR (Loan.DueDate) = YEAR(SYSDATETIME())
group by ResourceID)
Order by MoModel DESC
go

--Print the date, Room, and number of reservations made for the rooms
SELECT CONVERT(DATE, Reservation.ReservationDateTime) as 'Reservation date', AllResource.ReName as 'Room', COUNT(*) as 'Number of Reservation made'
FROM Reservation, ResourceLocation, AllResource
WHERE ReName =  'Media Suite' AND CONVERT(DATE, ReservationDateTime) IN ('2020-05-01', '2020-06-05', '2020-09-19')
Group by ReservationDateTime, ReName;

