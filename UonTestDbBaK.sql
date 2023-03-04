--DROP DATABASE IF EXISTS SCSRM
--go
--Create DATABASE SCSRM
--go
--use master
Use SCSRM



--Drop TABLE Staff
--Drop TABLE Student
--Drop TABLE Member
--Drop TABLE Moveable
--Drop TABLE Immoveable
--Drop TABLE AllResource
--Drop TABLE Category
--Drop TABLE ResourceLocation
--Drop TABLE Privilege
--Drop TABLE CourseOfferings
--DROP TABLE Loan
--Drop TABLE Reservation
--Drop TABLE Acquisition
--Drop TABLE Enroll
--Drop TABLE CoursePrivileges

--Assignment 3 Script

--Member Table
CREATE TABLE Member (
    MemberID            VARCHAR(20) NOT NULL,                                       
    MemName             VARCHAR(20) NOT NULL,
    MemNumber           VARCHAR(20) NOT NULL,
    CourseCode          VARCHAR(20) NOT NULL,
    ContactDetail       VARCHAR(20) NOT NULL,
    PaymentDetail       VARCHAR(20) NOT NULL,
    MemStatus           VARCHAR(8) DEFAULT 'Active' CHECK (MemStatus IN ('Active', 'Inactive')) NOT NULL,
    PRIMARY KEY (MemberID)
);

--Student Table
CREATE TABLE Student (
    MemberID          VARCHAR(20) NOT NULL,
	Points            INT,
    StudentAddress    VARCHAR(20) NOT NULL,
	PRIMARY KEY (MemberID)
);

--Staff Table
CREATE TABLE Staff (
    MemberID          VARCHAR(20) NOT NULL, 
    StaffAddress      VARCHAR(20) NOT NULL,
    Position          VARCHAR(20),
    StaffStatus       VARCHAR(8) DEFAULT 'active' CHECK (StaffStatus IN ('active', 'Inactive')) NOT NULL,
	PRIMARY KEY (MemberID)
);

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

--Movable resource table
CREATE TABLE Moveable (
    ResourceID            VARCHAR(10) NOT NULL,
    MoValue               VARCHAR(15) NOT NULL,
	PRIMARY KEY (ResourceID),
	FOREIGN KEY (ResourceID) REFERENCES AllResource(ResourceID)
            ON UPDATE CASCADE ON DELETE NO ACTION
	);

--Immovable resource table
CREATE TABLE Immoveable (
    ResourceID          VARCHAR(10) NOT NULL,
    RoomNumber          VARCHAR(20) NOT NULL,
    Capacity            INT NOT NULL,
	PRIMARY KEY (ResourceID),
	FOREIGN KEY (resourceID) REFERENCES AllResource(resourceID) 
            ON UPDATE CASCADE ON DELETE NO ACTION
);

--Category Table
CREATE TABLE Category (
    categoryID          INT NOT NULL,
	CategoryName        VARCHAR(20),
    Descriptions        VARCHAR(50),
	PRIMARY KEY (categoryID),
	);

--Location Table
CREATE TABLE ResourceLocation  (
    locationID          INT NOT NULL,
	Room                VARCHAR(20),
	building            VARCHAR(20),
	campus              VARCHAR(20),
	PRIMARY KEY (locationID),
	);

--Privilege table
CREATE TABLE Privilege (
    PrivilegeID         VARCHAR(20) NOT NULL,
	MemberID			VARCHAR(20) NOT NULL,
    PrivilegeDescription         VARCHAR(100) NOT NULL,
    MaxAmount           INT NOT NULL,
    MaxPeriod           VARCHAR(20) NOT NULL,
    PRIMARY KEY (PrivilegeID),
);

--Course Offerings table
CREATE TABLE CourseOfferings (
    OfferingID          VARCHAR(20) NOT NULL,
    yearOffered         VARCHAR(30) NOT NULL,
    semesterOffered     INT NOT NULL,
    BeginDate           VARCHAR(30) NOT NULL,
    EndDate             VARCHAR(30) NOT NULL,
    PRIMARY KEY (OfferingID),
);

--Loan table
CREATE TABLE Loan (
    LoanID              VARCHAR(20) NOT NULL,
    DueDate             VARCHAR(20),
    PRIMARY KEY (LoanID),
);

--Reservation table
 CREATE TABLE Reservation (
     ReservationID        VARCHAR(20) NOT NULL,
     ResourceID           VARCHAR(10) NOT NULL,
     ReservationDateTime            DATETIME NOT NULL,
     PRIMARY KEY (ReservationID),
     Foreign Key (resourceID) references AllResource (resourceID)
               ON UPDATE CASCADE ON DELETE NO ACTION
 );

--Acquisition table
 CREATE TABLE Acquisition (
     AcquisitionID          VARCHAR(20) NOT NULL,
     Itemname               VARCHAR(20) NOT NULL ,
     model                  VARCHAR(30) NOT NULL,
     brand                  VARCHAR(20) NOT NULL,
     Itemdescription        VARCHAR(100) NOT NULL,
     urgency                VARCHAR(20) DEFAULT 'Not Urgent' CHECK (urgency IN ('Urgent','Not Urgent')) NOT NULL,
     ItemStatus             VARCHAR(20) DEFAULT 'available' CHECK (ItemStatus IN ('available', 'Delivered', 'Pending Delivery', 'Processing'))NOT NULL,
     vendorCode             VARCHAR(20) NOT NULL,
     price                  INT NOT NULL,
     PRIMARY KEY (AcquisitionID),

 );

 --Enrollment Table
 CREATE TABLE Enroll (
	 EnrollmentID			VARCHAR(10) NOT NULL,
     MemberID              VARCHAR(20) NOT NULL,
     OfferingID          VARCHAR(20) NOT NULL,
     PRIMARY KEY (MemberID, EnrollmentID),
     Foreign Key (MemberID) references Member(MemberID)
             ON UPDATE CASCADE ON DELETE NO ACTION,
 );

 --Course Privilege Table
CREATE TABLE CoursePrivileges (
	 CoursePrivilegesID		VARCHAR(10) NOT NULL,
     OfferingID             VARCHAR(20) NOT NULL,
     PrivilegeID            VARCHAR(20) NOT NULL,
     PRIMARY KEY (PrivilegeID, OfferingID),
     Foreign Key (OfferingID) references CourseOfferings(OfferingID)
             ON UPDATE CASCADE ON DELETE NO ACTION,
 );

	
	--Data Input
	
--Member Table
INSERT INTO Member VALUES 
('M001', 'Anthony J','3313933','CMNS2005','3313933@gmail.com','MasterCard','active'),
('M003', 'Tyson F','3324552','INFT1201','3324552@gmail.com','American Express','active'),
('M005', 'Romero Y','3113245','DESN1104','3313245@uon.edu.au','ANZ Royal','active'),
('M010', 'George SP','3123452','COMP2050','GSP@uon.edu.au','MasterCard','inactive'),
('MS012', 'Michael B','3313944','FCOM205','BispingM@gmail.com','Amercian Express','active'),
('MS011', 'Tony F','3313190','FCOM101','Furguson@gmail.com','Amercian Express','active'),
('MS014', 'Chael S','3128001','FBUS104','Sonnen@gmail.com','MasterCard','active')
	
	--Student Table
INSERT INTO Student VALUES
('M001','30','3/141 University Dr'),
('M003','80','151 Mount Hutton'),
('M005','10','3/141 University Dr'),
('M010','80','41st Cameron Park')

--Staff Table
INSERT INTO Staff VALUES
('MS012', '2/141 University Dr', 'Admin', 'Active'),
('MS011', '515st Mount hutton', 'Admin', 'Active'),
('MS014', 'GPNSWst DC', 'Admin', 'Active')

--Resource Table
INSERT INTO AllResource VALUES
('MR001','IMAX-MSM908','908-001','MSM908','IMAX','Damaged'),
('MR004','SENNHEISER-HD800S','800-001','SHD800S','SENNHEISER','Available'),
('MR005','SENNHEISER-HD800S','800-002','SHD800S','SENNHEISER','Unavailable'),
('IR002','INTEL-XE/QUADRO Workstation','1848-001','I/Q-DELL','DELL','Occupied'),
('IR005','Media suite','380-1','MS3801','APPLE','Available'),
('IR006','Computer Lab','301-1','CTLAB01','None','Available')

--Movable Table
INSERT INTO Moveable VALUES ('MR001','250,000')
INSERT INTO Moveable VALUES ('MR004','2100')
INSERT INTO Moveable VALUES ('MR005','2100')

--Immovable Table
INSERT INTO Immoveable VALUES ('IR002','ICT3.84', 3)
INSERT INTO Immoveable VALUES ('IR005','ICT3.80', 7)
INSERT INTO Immoveable VALUES ('IR006','CT301',12)

--Category Table
INSERT INTO Category VALUES
('1','Headphones','SENNHEISER Headphones'),
('2','Cameras','IMAX Cameras'),
('3','Workstations',' Intel and Quadro based workstations'),
('4','Studios',' Media Suite studios')

--Location Table
INSERT INTO Resourcelocation VALUES
(384,'ICT3.84','ICT','Callaghan'),
(380,'ICT3.80','ICT','Callaghan'),
(409,'HS409','Hunter','Callaghan')

--Privilege Table
INSERT INTO Privilege VALUES
('PSTU001','M001','Student Privilege & Student level of access and clearance','2','2-48 hours'),
('PSTU002','M003','Student Privilege & Student level of access and clearance','2','2-48 hours'),
('PSTU003','M005','Student Privilege & Student level of access and clearance','2','2-48 hours'),
('PSTU004','M010','Student Privilege & Student level of access and clearance','2','2-48 hours'),
('PSTA002','MS012','Staff Privilege & Staff level of access and clearance','∞','2-48 hours')

--Course Offering Table
INSERT INTO CourseOfferings VALUES ('CO001','2020','2','2020-07-24','2020-11-24')
INSERT INTO CourseOfferings VALUES ('CO002','2019','1','2020-02-23','2020-06-23')
INSERT INTO CourseOfferings VALUES ('CO003','2020','2','2020-07-24','2020-11-24')
INSERT INTO CourseOfferings VALUES ('CO004','2020','2','2020-07-24','2020-11-24')
INSERT INTO CourseOfferings VALUES ('SCO001','2019','2','2019-07-24','2019-11-24')


--Loan Table
INSERT INTO Loan VALUES ('L001','2020-29-10')
INSERT INTO Loan VALUES ('L002','2020-2-11')
INSERT INTO Loan VALUES ('L003','2020-31-10')

--Reservation Table
INSERT INTO Reservation VALUES ('RIR001','IR005','2020-10-28')
INSERT INTO Reservation VALUES ('RIR002','IR002','2020-11-29')
INSERT INTO Reservation VALUES ('RIR003','IR005','2020-11-12')


--Acquisition Table
INSERT INTO Acquisition VALUES ('AMBP001','MacBook Pro 16','i9-32gb-1tb-5700m','APPLE','2020 MacBook Pro for media suite','Not urgent','Processing','MBP16-001','3500')
INSERT INTO Acquisition VALUES ('AGPU002','Nvidia Quadro A100','Quadro-A100-48gb','NVIDIA','Ampere based Quadro A-100 for CAD rendering workstations','Urgent','Pending Delivery','QA-100','3000')
INSERT INTO Acquisition VALUES ('ACPU001','AMD RYZEN 5950X','16 Cores 32 Threads at 4,9 Ghz','AMD','AMD 16core processor for workstation','Not urgent','Processing','3950X-001','1200')

--Enrollment ID
--CoursePrivilege ID

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
