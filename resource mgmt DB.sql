--DROP DATABASE IF EXISTS SCSRM
--Create DATABASE SCSRM
--College resource management, non confidential
use SCSRM

Drop TABLE Member
Drop TABLE Student
Drop TABLE Staff
Drop TABLE Resource
Drop TABLE Movable
Drop TABLE Immovable
Drop TABLE Catgeory
Drop TABLE Location
Drop TABLE Privilege
Drop TABLE CourseOfferings
Drop TABLE Invoice
Drop TABLE Loan
Drop TABLE Reservation
Drop TABLE Admin
Drop TABLE Acquisition

--DB main
CREATE TABLE Member (
    MemberID         VARCHAR(20) NOT NULL,
    Name             VARCHAR(20) NOT NULL,
    Number           CHAR(20) NOT NULL,
    CourseCode       CHAR(20) NOT NULL,
    Contact Detail   VARCHAR(20) NOT NULL,
    Payment Detail   VARCHAR(20) NOT NULL,
    Status           VARCHAR(8) DEFAULT 'active' CHECK (Status IN ('active', 'expire')) NOT NULL,
    PRIMARY KEY (MemberID)
)

CREATE TABLE Student (
    MemberID          VARCHAR(20) NOT NULL,
    StudentID         VARCHAR(20) NOT NULL,
    Address           VARCHAR(20) NOT NULL,
    PRIMARY KEY (StudentID)
    FOREIGN KEY (MemberID) references Member (MemberID)
            On Update Cascade On Delete NO ACTION
)

CREATE TABLE Staff (
    StaffID           VARCHAR(20) NOT NULL,
    MemberID          VARCHAR(20) NOT NULL, 
    Address           VARCHAR(20) NOT NULL,
    Position          VARCHAR(20),
    Status            VARCHAR(8) DEFAULT 'active' CHECK (Status IN ('active', 'expire')) NOT NULL,
    PRIMARY KEY (StaffId)
    FOREIGN KEY (MemberID) References Member (MemberID)
            On Update Cascade On Delete NO ACTION
)

CREATE TABLE Resources (
    resourceID         VARCHAR(10) NOT NULL,
	Name               VARCHAR(50) NOT NULL,
    Number             CHAR(20) NOT NULL,
    Model              VARCHAR(20) NOT NULL,
    Brand              VARCHAR(20) NOT NULL,
	Status             VARCHAR(20) DEFAULT 'available' CHECK (Status IN ('available', 'occupied', 'damaged'))NOT NULL, 
	categoryID         INT,
	locationID         INT,
	PRIMARY KEY (resourceID),
	FOREIGN KEY (categoryID) REFERENCES Category (CategoryId) 
            ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY (locationID) REFERENCES Location (LocationId)  
            ON UPDATE CASCADE ON DELETE NO ACTION 
)

CREATE TABLE Moveable (
    MovableID           VARCHAR(20) NOT NULL,
    ResourceID          VARCHAR(10) NOT NULL,
    Value               VARCHAR(15) NOT NULL,
	PRIMARY KEY (MovableID),
	FOREIGN KEY (resourceID) REFERENCES Resources(resourceID)
			ON UPDATE CASCADE ON DELETE NO ACTION

);

CREATE TABLE immoveable (
    ImmovableID         VARCHAR(20) NOT NULL,
    ResourceID          VARCHAR(10) NOT NULL,
    RoomNumber          VARCHAR(20) NOT NULL,
    Capacity            INT NOT NULL,
	PRIMARY KEY (ImmovableID),
	FOREIGN KEY (resourceID) REFERENCES resource(resourceID) 
            ON UPDATE CASCADE ON DELETE NO ACTION

	)

CREATE TABLE Category (
    categoryID          INT identity(1,1) NOT NULL,
	name                VARCHAR(20),
    Descriptions        VARCHAR(50),
	PRIMARY KEY (categoryID),
	)


CREATE TABLE Location  (
    locationID          INT  identity(1,1) NOT NULL,
	Room                VARCHAR(20),
	building            VARCHAR(20),
	campus              VARCHAR(20),
	PRIMARY KEY (locationID)
)

CREATE TABLE Privilege (
    PrivilegeID         VARCHAR(20) NOT NULL,
    CategoryId          VARCHAR(20 NOT NULL),
    MaxAmount           INT NOT NULL,
    MaxPeriod           DATETIME NOT NULL,
    PRIMARY KEY (PrivilegeID)
    FOREIGN KEY categoryID references Category(categoryID)
              ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE CourseOfferings (
    OfferingID          VARCHAR(20) NOT NULL,
    privilegeID         VARCHAR(20) NOT NULL,
    year offered        DATETIME NOT NULL,
    semester offered    INT NOT NULL,
    begin/End date      DATETIME NOT NULL,
    PRIMARY KEY (OfferingID)
    Foreign KEY privilegeID references Privilege (privilegeID)
            ON UPDATE CASCADE, ON DELETE CASCADE
)

CREATE TABLE Invoice (
    ReturnDate          DATETIME NOT NULL,
    PRIMARY KEY (ReturnDate)
)

CREATE TABLE Loan (
    LoanID              VARCHAR(20) NOT NULL,
    MovableID           VARCHAR(20) NOT NULL,
    MemberID            VARCHAR(20) NOT NULL,
    PRIMARY KEY (LoanID)
    Foreign Key Movable ID References Movable (MovableID)
               ON UPDATE CASCADE, ON DELETE CASCADE
    Foreign Key memberID references Members (memberID)
              ON UPDATE CASCADE, ON DELETE CASCADE

)

 CREATE TABLE Reservation (
     ReservationID        VARCHAR(20) NOT NULL,
     Date&Time            DATETIME NOT NULL,
     PRIMARY KEY (ReservationID)
     Foreign Key memberID references Members(memberID)
              ON UPDATE CASCADE, ON DELETE CASCADE
     Foreign Key resourceID references resource (resourceID)
               ON UPDATE CASCADE, ON DELETE CASCADE
 )

 CREATE TABLE Admin (
     AdminID               VARCHAR(20) NOT NULL,
     StaffID               VARCHAR(20) NOT NULL,
     PRIMARY KEY (AdminID)
     Foreign Key acqusitionID references Acquisition (acquisitionID)
              ON UPDATE CASCADE, ON DELETE CASCADE


 )

 CREATE TABLE Acquisition (
     AcquisitionID          VARCHAR(20) NOT NULL,
     name                   VARCHAR(20) NOT NULL, 
     model                  VARCHAR(30) NOT NULL,
     brand                  VARCHAR(20) NOT NULL,
     description            VARCHAR(20) NOT NULL,
     urgency                VARCHAR(20) NOT NULL,
     status                 VARCHAR(20) DEFAULT 'available' CHECK (Status IN ('available', 'occupied', 'damaged'))NOT NULL,
     vendorCode             VARCHAR(20) NOT NULL,
     price                  INT NOT NULL,
     PRIMARY KEY (AcquisitionID)
     Foreign Key memberID references member(memberID)
              ON UPDATE CASCADE, ON DELETE CASCADE

 )