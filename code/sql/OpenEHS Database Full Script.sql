/*****************************************************************************
 * Project: Open Electronic Healthcare System
 * Group: Ghana Team
 * Date: Jan-3-2011
 * Version: Final
 * 
 * Author: Cameron Harp (charp5257@gmail.com)
 *****************************************************************************/
 
 /*************************************************************************************
 * Database Notes:
 *
 * Download:
 *      Go to my sql.com and download the 5.2+ community server and workbench
 * 
 * Run Script:
 *      See .txt file in SQL folder
 *
 * IsActive:
 *      In every table there is a field 'IsActive', this field is used to determin
 *      if the table is active or inactive aka 'DELETED'. This field is automatically
 *      defaulted to 1 which is set to active. When deleting a table from the database
 *      you are really only doing an update to change the bit field to 0 which means
 *      inactive.
 * 
 *************************************************************************************/

GRANT USAGE ON *.* TO "OpenEHS_admin"@"localhost";
DROP USER "OpenEHS_admin"@"localhost";

DROP DATABASE IF EXISTS OpenEHS_database;

CREATE DATABASE OpenEHS_database;

USE OpenEHS_database;

CREATE USER "OpenEHS_admin"@"localhost" IDENTIFIED BY "password";
GRANT ALL ON OpenEHS_database.* TO "OpenEHS_admin"@"localhost";

#----------------------------------------------------------------------------------------------------------
#--------------------------------------------------Tables--------------------------------------------------
#----------------------------------------------------------------------------------------------------------

CREATE TABLE Address
(
AddressID           int                 AUTO_INCREMENT          PRIMARY KEY         NOT NULL,
Street1             varchar(50)         NOT NULL,
Street2             varchar(50)         NULL,
City                varchar(30)         NOT NULL,
Region              varchar(30)         NOT NULL,
Country             varchar(30)         NOT NULL                DEFAULT 'Ghana',
IsActive            bit(1)              NOT NULL                DEFAULT 1
);

CREATE TABLE EmergencyContact
(
EmergencyContactID          int              AUTO_INCREMENT          PRIMARY KEY         NOT NULL,
FirstName                   varchar(30)      NOT NULL,
LastName                    varchar(30)      NOT NULL,
PhoneNumber                 varchar(20)      NOT NULL,
Relationship                bit(3)           NOT NULL,
AddressID                   int              NOT NULL,
IsActive                    bit(1)           NOT NULL                DEFAULT 1
);

/**************************************
*Notes on Patient:
*
*DOB:
* The DOB will be stored in the DB as a
* date, but the UI for KorleBu will be
* entered as a age and needs to be 
* converted into a date. MLKMC will be
* entered in as a normal date.
**************************************/

CREATE TABLE Patient
(
PatientID                   int                 AUTO_INCREMENT          PRIMARY KEY         NOT NULL,
FirstName                   varchar(30)         NOT NULL,
MiddleName                  varchar(30)         NULL,
LastName                    varchar(30)         NOT NULL,
DateOfBirth                 Date                NOT NULL,
Gender                      char(10)            NOT NULL,
PhoneNumber                 varchar(20)         NULL,
AddressID                   int                 NOT NULL,
BloodType                   varchar(10)         NULL,
TribeRace                   varchar(30)         NULL,
Religion                    varchar(30)         NULL,
OldPhysicalRecordNumb       int                 Null,
EmergencyContactID          int                 NULL,
IsActive                    bit(1)              NOT NULL                DEFAULT 1
) AUTO_INCREMENT= 100000;

CREATE TABLE Allergy
(
AllergyID               int             AUTO_INCREMENT              PRIMARY KEY         NOT NULL,
`Name`                    varchar(30)     NULL,
Medication              varchar(30)     NULL,
PatientID               int             NOT NULL,
IsActive                bit(1)          NOT NULL                    DEFAULT 1
);

CREATE TABLE Problem
(
ProblemID           int             AUTO_INCREMENT          PRIMARY KEY     NOT NULL,
ProblemName         varchar(30)     NOT NULL
);

CREATE TABLE PatientProblem
(
PatientProblemID        int         AUTO_INCREMENT          PRIMARY KEY         NOT NULL,
PatientID               int         NOT NULL,
ProblemID               int         NOT NULL
);

CREATE TABLE PatientCheckIn
(
PatientCheckInID            int             AUTO_INCREMENT              PRIMARY KEY         NOT NULL,
CheckinTime                 timestamp       NOT NULL,
PatientType                 tinyint         NOT NULL,
PatientID                   int             NOT NULL,
PatientStatus               int             NOT NULL,
CheckOutTime                timestamp       NULL,
IsActive                    bit             NOT NULL                    DEFAULT 1
);

CREATE TABLE FeedChart
(
FeedChartID             int             AUTO_INCREMENT              PRIMARY KEY         NOT NULL,
PatientCheckInID        int             NOT NULL,
FeddTime                timestamp       NOT NULL                    DEFAULT NOW(),
FeedType                varchar(30)     NULL,
Amountffered            float           NULL,
AmountTaken             float           NULL,
Vomit                   varchar(20)     NULL,
Urine                   varchar(20)     NULL,
Stool                   varchar(20)     NULL,
Comments                text            NULL
);

CREATE TABLE Output
(
OutputID            int             AUTO_INCREMENT          PRIMARY KEY         NOT NULL,
NGSuctionAmount     float           NULL,
NGSuctionColor      varchar(15)     NULL,
UrineAmount         float           NULL,
StoolAmount         float           NULL,
StoolColor          varchar(15)     NULL
);

CREATE TABLE Intake
(
InTakeID            int             AUTO_INCREMENT          PRIMARY KEY         NOT NULL,
IntakeType          varchar(30)     NULL,
IntakeAmount        float           NULL
);

CREATE TABLE FluidChart
(
FluidChartID                int             AUTO_INCREMENT              PRIMARY KEY         NOT NULL,
PatientCheckInID            int             NOT NULL,
CheckTime                   timestamp       NOT NULL,
OutputID                    int             NULL,
IntakeID                    int             NULL
);

CREATE TABLE Invoice
(
InvoiceID               int             AUTO_INCREMENT          PRIMARY KEY         NOT NULL,
Total                   decimal(6,2)    NOT NULL                DEFAULT 0.00,
`Date`                  timestamp       NOT NULL                DEFAULT CURRENT_TIMESTAMP,
PatientCheckInID        int             NOT NULL,
IsActive                bit(1)          NOT NULL                DEFAULT 1
);

CREATE TABLE Payment
(
PaymentID               int               AUTO_INCREMENT          PRIMARY KEY         NOT NULL,
CashAmount              decimal(6,2)      NOT NULL,
PaymentDate             timestamp         NOT NULL                DEFAULT CURRENT_TIMESTAMP,
InvoiceID               int               NOT NULL,
IsActive                bit(1)            NOT NULL                DEFAULT 1
);

CREATE TABLE InvoiceItem
(
    InvoiceItemID               int                 AUTO_INCREMENT             PRIMARY KEY         NOT NULL,
    InvoiceID                   int                 NOT NULL,
    ProductID                   int                 NULL,
    ServiceID                   int                 NULL,
    Quantity                    float               NULL,
    IsActive                    bit(1)              NOT NULL                DEFAULT 1
);

CREATE TABLE Category
(
    CategoryID                  int                 AUTO_INCREMENT              PRIMARY KEY         NOT NULL,
    `Name`                      varchar(30)         NOT NULL,
    Description                 text                NULL,
    DateCreated                 timestamp           NOT NULL                    DEFAULT NOW(),
    IsActive                    bit                 NOT NULL                    DEFAULT 1
);

CREATE TABLE Product
(
    ProductID                   int                 AUTO_INCREMENT          PRIMARY KEY         NOT NULL,
    `Name`                      varchar(50)         NOT NULL,
    Unit                        varchar(10)         NOT NULL,
    CategoryID                  int                 NOT NULL,
    ProductCost                 decimal(6,2)        NOT NULL,
    QuantityOnHand              int                 NOT NULL,
    Counter                     int                 NOT NULL                DEFAULT 1,
    IsActive                    bit(1)              NOT NULL                DEFAULT 1
);

CREATE TABLE Service
(
    ServiceID                   int                 AUTO_INCREMENT          PRIMARY KEY         NOT NULL,
    `Name`                      varchar(30)         NOT NULL,
    ServiceCost                 decimal(6, 2)       NOT NULL,
    IsActive                    bit(1)              NOT NULL                DEFAULT 1
);

CREATE TABLE `User`
(
    UserID                      int                 AUTO_INCREMENT          PRIMARY KEY         NOT NULL,
    Username                    varchar(30)         NOT NULL,
    EmailAddress                varchar(50)         NULL,
    ApplicationName             varchar(30)         NULL,
    `Password`                  varchar(30)         NOT NULL,
    PasswordQuestion            varchar(50)         NULL,
    PasswordAnswer              varchar(50)         NULL,
    DateCreated                 timestamp           NOT NULL                DEFAULT NOW(),
    LastLogin                   datetime            NULL,
    IsOnline                    bit(1)              NOT NULL                DEFAULT 0,
    IpAddress                   varchar(20)         NULL,
    IsLockedOut                 bit(1)              NOT NULL                DEFAULT 0,
    FailedPasswordAttemptCount  int                 NOT NULL                DEFAULT 0,
    IsApproved                  bit(1)              NOT NULL                DEFAULT 0,
    IsActive                    bit(1)              NOT NULL                DEFAULT 1
);

CREATE TABLE UserRole
(
    UserRoleID                  int                 NOT NULL                PRIMARY KEY         AUTO_INCREMENT,
    UserID                      int                 NOT NULL,
    RoleID                      int                 NOT NULL
);

CREATE TABLE Staff
(
    StaffID                     int                 AUTO_INCREMENT          PRIMARY KEY         NOT NULL,
    FirstName                   varchar(30)         NOT NULL,
    MiddleName                  varchar(30)         NULL,
    LastName                    varchar(30)         NOT NULL,
    PhoneNumber                 varchar(20)         NOT NULL,
    StaffType                   tinyint(1)          NOT NULL,
    LicenseNumber               varchar(20)         NULL                    Default NULL,
    AddressID                   int                 NOT NULL,
    UserID                      int                 NOT NULL,
    IsActive                    bit(1)              NOT NULL                DEFAULT 1
);

CREATE TABLE PatientEncounter
(
    PatientEncounterID          int                 AUTO_INCREMENT          PRIMARY KEY         NOT NULL,
    PatientCheckinID            int                 NOT NULL,
    TimeIn                      time                NOT NULL,
    TimeOut                     time                NULL,
    Comments                    text                NULL,
    Location                    int                 NULL,
    Diagnosis                   text                NULL,
    StaffID                     int                 NOT NULL,
    AdmitReason                 varchar(50)         NULL,
    IsActive                    bit                 NOT NULL                DEFAULT 1
);

CREATE TABLE Vitals
(
    VitalsID                    int                 AUTO_INCREMENT          PRIMARY KEY         NOT NULL,
    `Time`                      timestamp           NOT NULL,
    `Type`                      bit(5)              NOT NULL,
    Height                      varchar(5)          NOT NULL,
    Weight                      varchar(5)          NOT NULL,
    HeartRate                   tinyint             NOT NULL,
    Temperature                 decimal(4,1)        NOT NULL,
    BPSystolic                  int                 NOT NULL,
    BPDiastolic                 int                 NOT NULL,
    RespirtoryRate              tinyint             NOT NULL,
    PatientEncounterID          int                 NOT NULL,
    IsActive                    bit(1)              NOT NULL                DEFAULT 1
);

CREATE TABLE Surgery
(
    SurgeryID                   int                 AUTO_INCREMENT          PRIMARY KEY         NOT NULL,
    SurgeryType                 text                NOT NULL,
    StartTime                   time                NOT NULL,
    EndTime                     time                NULL,
    RoomNumber                  int                 NULL,
    Comments                    text                NULL,
    PatientEncounterID          int                 NOT NULL
);

CREATE TABLE SurgeryStaff
(
    SurgeryStaffID              int                 AUTO_INCREMENT          PRIMARY KEY         NOT NULL,
    StaffID                     int                 NOT NULL,
    SurgeryID                   int                 NOT NULL
);

CREATE TABLE Note
(
    NoteID                      int                 AUTO_INCREMENT          PRIMARY KEY                      NOT NULL,
    Title                       varchar(30)         NOT NULL,
    Body                        longtext            NOT NULL,
    DateCreated                 timestamp           NOT NULL                DEFAULT CURRENT_TIMESTAMP,
    StaffID                     int                 NOT NULL,
    PatientEncounterID          int                 NOT NULL,
    IsActive                    bit(1)              NOT NULL                DEFAULT 1
);

CREATE TABLE TemplateCategory
(
    TemplateCategoryID          int                 AUTO_INCREMENT          PRIMARY KEY         NOT NULL,
    TemplateCategoryName        varchar(30)         NOT NULL,
    TemplateCategoryDescription text                NULL
);

CREATE TABLE Template
(
    TemplateID                  int                 AUTO_INCREMENT          PRIMARY KEY         NOT NULL,
    TemplateBody                longtext            NOT NULL,
    TemplateCategoryID          int                 NOT NULL,
    StaffID                     int                 NOT NULL,
    IsActive                    bit(1)              NOT NULL                DEFAULT 1
);

CREATE TABLE Role
(
    RoleID                      int                 AUTO_INCREMENT          PRIMARY KEY         NOT NULL,
    `Name`                      varchar(30)         NOT NULL,
    Description                 varchar(130)        NULL,
    DateCreated                 timestamp           NOT NULL                DEFAULT NOW()
);

#----------------------------------------------------------------------------------------------------------
#---------------------------------------------------FK's---------------------------------------------------
#----------------------------------------------------------------------------------------------------------

ALTER TABLE EmergencyContact
ADD CONSTRAINT FK_EmergencyContactMustHaveAddressID
FOREIGN KEY (AddressID) REFERENCES Address(AddressID);

ALTER TABLE Patient
ADD CONSTRAINT FK_PatientMustHaveAddressID
FOREIGN KEY (AddressID) REFERENCES Address(AddressID);

ALTER TABLE Patient
ADD CONSTRAINT FK_PatientMustHaveEmergencyContactID
FOREIGN KEY (EmergencyContactID) REFERENCES EmergencyContact(EmergencyContactID);

ALTER TABLE Staff
ADD CONSTRAINT FK_StaffMustHaveAddressID
FOREIGN KEY (AddressID) REFERENCES Address(AddressID);

ALTER TABLE Staff
ADD CONSTRAINT FK_StaffMustHaveUserID
FOREIGN KEY (UserID) REFERENCES User(UserID);

ALTER TABLE Allergy
ADD CONSTRAINT FK_AllergyMustHavePatientID
FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);

ALTER TABLE PatientCheckIn
ADD CONSTRAINT FK_PatientCheckInMustHavePatientID
FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);

ALTER TABLE FeedChart
ADD CONSTRAINT FK_FeedChartMustHavePatientCheckInID
FOREIGN KEY (PatientCheckInID) REFERENCES PatientCheckIn(PatientCheckInID);

ALTER TABLE FluidChart
ADD CONSTRAINT FK_FluidChartMustHavePatientCheckInID
FOREIGN KEY (PatientCheckInID) REFERENCES PatientCheckIn(PatientCheckInID);

ALTER TABLE FluidChart
ADD CONSTRAINT FK_FluidChartMustHaveOutputID
FOREIGN KEY (OutputID) REFERENCES Output(OutputID);

ALTER TABLE FluidChart
ADD CONSTRAINT FK_FluidChartMustHaveIntakeID
FOREIGN KEY (IntakeID) REFERENCES Intake(IntakeID);

ALTER TABLE Invoice
ADD CONSTRAINT FK_InvoiceMustHavePatientCheckInID
FOREIGN KEY (PatientCheckInID) REFERENCES PatientCheckIn(PatientCheckInID);

ALTER TABLE InvoiceItem
ADD CONSTRAINT FK_InvoiceItemMustHaveInvoiceID
FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID);

ALTER TABLE InvoiceItem
ADD CONSTRAINT FK_InvoiceItemMustHaveProductID
FOREIGN KEY (ProductID) REFERENCES Product(ProductID);

ALTER TABLE InvoiceItem
ADD CONSTRAINT FK_InvoiceItemMustHaveServiceID
FOREIGN KEY (ServiceID) REFERENCES Service(ServiceID);

ALTER TABLE Payment
ADD CONSTRAINT FK_PaymentMustHaveInvoiceID
FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID);

ALTER TABLE Note
ADD CONSTRAINT FK_NoteMustHaveStaffID
FOREIGN KEY (StaffID) REFERENCES Staff(StaffID);

ALTER TABLE Note
ADD CONSTRAINT FK_NoteMustHavePatientEncounterID
FOREIGN KEY (PatientEncounterID) REFERENCES PatientEncounter(PatientEncounterID);

ALTER TABLE Surgery
ADD CONSTRAINT FK_SurgeryMustHavePatientEncounterID
FOREIGN KEY (PatientEncounterID) REFERENCES PatientEncounter(PatientEncounterID);

ALTER TABLE SurgeryStaff
ADD CONSTRAINT FK_SurgeryStaffMustHaveStaffID
FOREIGN KEY (StaffID) REFERENCES Staff(StaffID);

ALTER TABLE SurgeryStaff
ADD CONSTRAINT FK_SurgeryStaffMustHaveSurgeryID
FOREIGN KEY (SurgeryID) REFERENCES Surgery(SurgeryID);

ALTER TABLE PatientEncounter
ADD CONSTRAINT FK_PatientEncounterMustHaveStaffID
FOREIGN KEY (StaffID) REFERENCES Staff(StaffID);

ALTER TABLE PatientEncounter
ADD CONSTRAINT FK_PatientEncounterMustHavePatientCheckInID
FOREIGN KEY (PatientCheckInID) REFERENCES PatientCheckIn(PatientCheckInID);

ALTER TABLE Vitals
ADD CONSTRAINT FK_VitalsMustHavePatientEncounterID
FOREIGN KEY (PatientEncounterID) REFERENCES PatientEncounter(PatientEncounterID);

ALTER TABLE PatientProblem
ADD CONSTRAINT FK_PatientProblemMustHavePatientID
FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);

ALTER TABLE PatientProblem
ADD CONSTRAINT FK_PatientProblemMustHaveProblemID
FOREIGN KEY (ProblemID) REFERENCES Problem(ProblemID);

ALTER TABLE Template
ADD CONSTRAINT TemplateMustHaveStaffID
FOREIGN KEY (StaffID) REFERENCES Staff(StaffID);

ALTER TABLE Template
ADD CONSTRAINT TemplateMustHaveTemplateCategoryID
FOREIGN KEY (TemplateCategoryID) REFERENCES TemplateCategory(TemplateCategoryID);

ALTER TABLE Product
ADD CONSTRAINT ProductMustHaveCategoryID
FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID);

#----------------------------------------------------------------------------------------------------------
#-------------------------------------------------TRIGGERS-------------------------------------------------
#----------------------------------------------------------------------------------------------------------

#----------Auto Correct Patient Name----------

DELIMITER $$
CREATE TRIGGER tr_AutoCorrectFormatPatientInfo
BEFORE INSERT ON Patient

FOR EACH ROW

BEGIN
    SET NEW.FirstName = CONCAT(UCASE(substr(NEW.FirstName,1,1)), substr(NEW.FirstName,2));
    SET NEW.MiddleName = CONCAT(UCASE(substr(NEW.MiddleName,1,1)), substr(NEW.MiddleName,2));
    SET NEW.LastName = CONCAT(UCASE(substr(NEW.LastName,1,1)), substr(NEW.LastName,2));
    SET NEW.TribeRace = CONCAT(UCASE(substr(NEW.TribeRace,1,1)), substr(NEW.TribeRace,2));
    SET NEW.Religion = CONCAT(UCASE(substr(NEW.Religion,1,1)), substr(NEW.Religion,2));
END;
$$
DELIMITER ;

#----------Auto Correct Emergency Contact Name----------

DELIMITER $$
CREATE TRIGGER tr_AutoCorrectFormatEmergencyContactName
BEFORE INSERT ON EmergencyContact

FOR EACH ROW

BEGIN
    SET NEW.FirstName = CONCAT(UCASE(substr(NEW.FirstName,1,1)), substr(NEW.FirstName,2));
    SET NEW.LastName = CONCAT(UCASE(substr(NEW.LastName,1,1)), substr(NEW.LastName,2));
END;
$$
DELIMITER ;

#----------Auto Correct Staff Name----------

DELIMITER $$
CREATE TRIGGER tr_AutoCorrectFormatStaffName
BEFORE INSERT ON Staff

FOR EACH ROW

BEGIN
    SET NEW.FirstName = CONCAT(UCASE(substr(NEW.FirstName,1,1)), substr(NEW.FirstName,2));
    SET NEW.MiddleName = CONCAT(UCASE(substr(NEW.MiddleName,1,1)), substr(NEW.MiddleName,2));
    SET NEW.LastName = CONCAT(UCASE(substr(NEW.LastName,1,1)), substr(NEW.LastName,2));
END;
$$
DELIMITER ;

#----------Auto Correct City and Region and Country In Address----------

DELIMITER $$
CREATE TRIGGER tr_AutoCorrectFormatCityRegionCountryInAddress
BEFORE INSERT ON Address

FOR EACH ROW

BEGIN
    SET NEW.City = CONCAT(UCASE(substr(NEW.City,1,1)), substr(NEW.City,2));
    SET NEW.Region = CONCAT(UCASE(substr(NEW.Region,1,1)), substr(NEW.Region,2));
    SET NEW.Country = CONCAT(UCASE(substr(NEW.Country,1,1)), substr(NEW.Country,2));
END;
$$
DELIMITER ;

#--------------------------------------------------------------------------------------------------------------
#-------------------------------------------------Stored Procs-------------------------------------------------
#--------------------------------------------------------------------------------------------------------------


#--------------Delete Patient Table--------------
/************************************
* sp_deletePatient updates
* Patient IsActive to 0. Must pass 
* patientID.
************************************/

DELIMITER |
CREATE PROCEDURE sp_deletePatient
(
IN i_Patient        int
)

BEGIN

UPDATE Patient SET
IsActive = 0
WHERE i_PatientID = PatientID;

END ||
DELIMITER ;

#--------------Insert Staff Table--------------
/************************************
* sp_insertStaff inserts into 
* Staff table.
************************************/

DELIMITER | 
CREATE PROCEDURE sp_insertStaff
(
IN i_Street1                varchar(30),
IN i_Street2                varchar(30),
IN i_City                   varchar(30),
IN i_Region                 varchar(30),
IN i_Country                varchar(30),
IN i_UserName               varchar(30),
IN i_Password               varchar(30),
IN i_LIP                    char(1),
IN i_FirstName              varchar(30),
IN i_MiddleName             varchar(30),
IN i_LastName               varchar(30),
IN i_PhoneNumber            varchar(20),
IN i_StaffType              tinyint(1),
IN i_LN                     varchar(20)
)

BEGIN

DECLARE _returnAddID int;
DECLARE _returnUserID int;

INSERT INTO Address
(
Street1,
Street2,
City,
Region,
Country
)
VALUES
(
i_Street1,
i_Street2,
i_City,
i_Region,
i_Country
);

SELECT LAST_INSERT_ID() INTO _returnAddID;

INSERT INTO User
(
UserName,
`Password`
)
VALUES
(
i_UserName,
i_Password
);

SELECT LAST_INSERT_ID() INTO _returnUserID;

INSERT INTO Staff
(
FirstName,
MiddleName,
LastName,
PhoneNumber,
StaffType,
LicenseNumber,
AddressID,
UserID
)
VALUES
(
i_FirstName,
i_MiddleName,
i_LastName,
i_PhoneNumber,
i_StaffType,
i_LN,
_returnAddID,
_returnUserID
);

END ||
DELIMITER ;

#--------------Update Staff Table--------------
/************************************
* sp_updateStaff updates into 
* Staff table.
************************************/

DELIMITER | 
CREATE PROCEDURE sp_updateStaff
(
IN i_StaffID                int,
IN i_Street1                varchar(30),
IN i_Street2                varchar(30),
IN i_City                   varchar(30),
IN i_Region                 varchar(30),
IN i_Country                varchar(30),
IN i_UserName               varchar(30),
IN i_Password               varchar(30),
IN i_FirstName              varchar(30),
IN i_MiddleName             varchar(30),
IN i_LastName               varchar(30),
IN i_PhoneNumber            varchar(20),
IN i_StaffType              tinyint(1),
IN i_LN                     varchar(20)
)

BEGIN

DECLARE _AddressID  int;
DECLARE _UserID    int;

SELECT AddressID FROM Staff WHERE StaffID = i_StaffID INTO _AddressID;

SELECT UserID FROM Staff WHERE StaffID = i_StaffID INTO _UserID;

UPDATE Address SET
Street1 = i_Street1,
Street2 = i_Street2,
City = i_City,
Region = i_Region,
Country = i_Country
WHERE _AddressID = AddressID;

UPDATE User SET
UserName = i_UserName,
Password = i_Password
WHERE _UserID = UserID;

UPDATE Staff SET
FirstName = i_Firstname,
MiddleName = i_MiddleName,
LastName = i_LastName,
PhoneNumber = i_PhoneNumber,
StaffType = i_StaffType,
LicenseNumber = i_LN
WHERE i_StaffID = StaffID;

END ||
DELIMITER ;

#--------------Delete(update) Staff Table--------------
/************************************
* sp_deleteStaff deletes(update) into 
* Staff table changing IsActive to 0.
************************************/

DELIMITER | 
CREATE PROCEDURE sp_deleteStaff
(
IN i_StaffID    int
)

BEGIN

UPDATE Staff SET
IsActive = 0
WHERE i_StaffID = StaffID;

END ||
DELIMITER ;

#--------------Update EmergencyContact Table--------------
/************************************
* sp_updateEmergencyContact updates
* EmergencyContact table. Must pass 
* patientID.
************************************/

DELIMITER |
CREATE PROCEDURE sp_updateEmergencyContact
(
IN i_Street1        varchar(30),
IN i_Street2        varchar(30),
IN i_City           varchar(30),
IN i_Region         varchar(30),
IN i_Country        varchar(30),
IN i_PatientID      int,
IN i_FirstName      varchar(30),
IN i_LastName       varchar(30),
IN i_PhoneNumber    varchar(20),
IN i_Relationship   bit(3)
)

BEGIN

DECLARE _AddressID      int;

SELECT AddressID FROM EmergencyContact WHERE PatientID = i_PatientID INTO _AddressID;

UPDATE Address SET
Street1 = i_Street1,
Street2 = i_Street2,
City = i_City,
Region = i_Region,
Country = i_Country
WHERE _AddressID = AddressID;

UPDATE EmergencyContact SET
FirstName = i_FirstName,
LastName = i_LastName,
PhoneNumber = i_PhoneNumber,
Relationship = i_Relationship
WHERE i_PatientID = PatientID;

END ||
DELIMITER ;


#--------------Insert Allergy Table--------------
/************************************
* sp_insertAllergy inserts into 
* Allergy tables. Must pass patientID.
************************************/

DELIMITER |
CREATE PROCEDURE sp_insertAllergy
(
IN i_Name          varchar(50),
IN i_Medication    varchar(50),
IN i_PatientID     int
)

BEGIN

INSERT INTO Allergy
(
Name,
Medication,
PatientID
)
VALUES
(
i_Name,
i_Medication,
i_PatientID
);

END ||
DELIMITER ;

#--------------Insert Invoice & PatientCheckIn Table--------------
/**************************************
* sp_insertPatientCheckIn inserts into 
* PatientCheckIn table and creates the
* blank Invoice table.
**************************************/

DELIMITER |
CREATE PROCEDURE sp_insertPatientCheckIn
(
IN i_CheckinTime     timestamp,
IN i_PatientType     bit(1),
IN i_PatientStatus   bit(1),
IN i_PatientID       int
)

BEGIN

DECLARE _PCIID  int;

INSERT INTO PatientCheckIn
(
CheckinTime,
PatientType,
PatientStatus,
PatientID
)
VALUES
(
i_CheckinTime,
i_PatientType,
i_PatientStatus,
i_PatientID
);

SELECT LAST_INSERT_ID() INTO _PCIID;

INSERT INTO Invoice
(
PatientCheckInID
)
VALUES
(
_PCIID
);

END ||
DELIMITER ;

#--------------Update Invoice Table--------------
/************************************
* sp_updateInvoice updates into 
* Service table after invoice amount
* has been calculated.
************************************/

DELIMITER |
CREATE PROCEDURE sp_updateInvoice
(
IN i_InvoiceID      int,
IN i_Total          decimal(6,2)
)

BEGIN

UPDATE Invoice SET
Total = i_Total
WHERE i_InvoiceID = InvoiceID;

END ||
DELIMITER ;

#--------------insert Service Table--------------
/************************************
* sp_insertService inserts into the
* Service table.
************************************/

DELIMITER | 
CREATE PROCEDURE sp_insertService
(
IN i_Name           varchar(30),
IN i_ServiceCost    decimal(6, 2)
)

BEGIN

INSERT INTO Service
(
Name,
ServiceCost
)
VALUES
(
i_Name,
i_ServiceCost
);

END ||
DELIMITER ;

#--------------update Service Table--------------
/************************************
* sp_updateService updates the
* Service table.
************************************/

DELIMITER | 
CREATE PROCEDURE sp_updateService
(
IN i_ServiceID      int,
IN i_Name           varchar(30),
IN i_ServiceCost    decimal(6, 2)
)

BEGIN

UPDATE Service SET
Name = i_Name,
ServiceCost = i_ServiceCost
WHERE ServiceID = i_ServiceID;

END ||
DELIMITER ;

#--------------delete Service Table--------------
/************************************
* sp_deleteService deletes(updates)
* Service table IsActice to 0.
************************************/

DELIMITER | 
CREATE PROCEDURE sp_deleteService
(
IN i_ServiceID      int
)

BEGIN

UPDATE Service SET
IsActice = 0
WHERE ServiceID = i_ServiceID;

END ||
DELIMITER ;

#--------------insert Products Table--------------
/************************************
* sp_insertProducts inserts into the
* Products table.
************************************/

DELIMITER | 
CREATE PROCEDURE sp_insertProduct
(
IN i_Name               varchar(30),
IN i_Unit               varchar(10),
IN i_CategoryID         int,
IN i_ProductCost        decimal(6, 2),
IN i_QuantityOnHand     int
)

BEGIN

INSERT INTO Product
(
Name,
Unit,
CategoryID,
ProductCost,
QuantityOnHand
)
VALUES
(
i_Name,
i_Unit,
i_CategoryID,
i_ProductCost,
i_QuantityOnHand
);

END ||
DELIMITER ;

#--------------update Products Table--------------
/************************************
* sp_updateProducts updates the
* Service table.
************************************/

DELIMITER | 
CREATE PROCEDURE sp_updateProduct
(
IN i_ProductID          int,
IN i_Name               varchar(30),
IN i_Unit               varchar(10),
IN i_CategoryID         int,
IN i_ProductCost        decimal(6, 2),
IN i_QuantityOnHand     int
)

BEGIN

UPDATE Product SET
Name = i_Name,
Unit = i_Unit,
CategoryID = i_CategoryID,
ProductCost = i_ProductCost,
QuantityOnHand = i_QuantityOnHand
WHERE ProductID = i_ProductID;

END ||
DELIMITER ;

#--------------delete Product Table--------------
/************************************
* sp_deleteService deletes(updates)
* Service table IsActice to 0.
************************************/

DELIMITER | 
CREATE PROCEDURE sp_deleteProduct
(
IN i_ProductID      int
)

BEGIN

UPDATE Product SET
IsActice = 0
WHERE ProductID = i_ProductID;

END ||
DELIMITER ;

#--------------insert Payment/Updates Invoice Table--------------
/************************************
* sp_insertPayment inserts into the
* Payment table and updates invoice.
************************************/

DELIMITER | 
CREATE PROCEDURE sp_insertPayment
(
IN i_InvoiceID      int,
IN i_CashAmount     decimal(6,2),
IN i_PaymentDate    timestamp
)

BEGIN

DECLARE _Itotal decimal(6,2);

SELECT Total FROM Invoice WHERE InvoiceID = i_InvoiceID INTO _Itotal;

INSERT INTO Payment
(
CashAmount,
PaymentDate,
InvoiceID
)
VALUES
(
i_CashAmount,
i_PaymentDate,
i_InvoiceID
);

UPDATE Invoice SET
Total = (_Itotal - i_CashAmount)
WHERE InvoiceID = i_InvoiceID;

END ||
DELIMITER ;

#--------------insert into Note Table--------------
/************************************
* sp_insertNote inserts into the
* Note table.
************************************/

DELIMITER |
CREATE PROCEDURE sp_insertNote
(
IN i_Title              varchar(50),
IN i_Body               text,
IN i_DateCreated        timestamp,
IN i_staffFN            varchar(30),
IN i_staffLN            varchar(30),
IN i_PatientEncounterID int
)

BEGIN

DECLARE _staffID int;

SELECT StaffID FROM Staff WHERE FirstName LIKE i_staffFN && LastName LIKE i_staffLN INTO _staffID;

INSERT INTO Note
(
Title,
Body,
DateCreated,
StaffID,
PatientEncounterID
)
VALUES
(
i_Title,
i_Body,
i_DateCreated,
_StaffID,
i_PatientEncounterID
);

END ||
DELIMITER ;

#--------------insert into TemplateCategory Table--------------
/******************************************
* sp_insertTemplateCategory inserts into the
* TemplateCategory table.
******************************************/

DELIMITER |
CREATE PROCEDURE sp_insertTemplateCategory
(
IN i_TCName         text,
IN i_TCDescription  text
)

BEGIN

INSERT INTO TemplateCategory
(
TemplateCategoryName,
TemplateCategoryDescription
)
VALUES
(
i_TCName,
i_TCDescription
);

END ||
DELIMITER ;

#--------------insert into Template Table--------------
/******************************************
* sp_insertTemplate inserts into the
* Template table.
******************************************/

DELIMITER |
CREATE PROCEDURE sp_insertTemplate
(
IN i_TemplateBody           text,
IN i_TemplateCategoryID     int,
IN i_StaffID                int
#IN i_staffFN            varchar(30),
#IN i_staffLN            varchar(30)
)

BEGIN

#DECLARE _staffID int;

#SELECT StaffID FROM Staff WHERE FirstName LIKE i_staffFN && LastName LIKE i_staffLN INTO _staffID;

INSERT INTO Template
(
TemplateBody,
TemplateCategoryID,
StaffID
#StaffID
)
VALUES
(
i_TemplateBody,
i_TemplateCategoryID,
i_StaffID
#_staffID
);

END ||
DELIMITER ;

#--------------Delete Template Table--------------
/******************************************
* sp_deleteTemplate updates the
* Template table by changing IsActive to 0.
******************************************/

DELIMITER |
CREATE PROCEDURE sp_delectTemplate
(
IN i_TemplateID     int,
IN i_StaffID        int
)

BEGIN

UPDATE Template SET
IsActive = 0
WHERE TemplateID = i_Template && StaffID = i_StaffID;

END ||
DELIMITER ;



#--------------insert into PatientEncounter Table--------------
/******************************************
* sp_insertPatientEncounter inserts into the
* PatientEncounter table.
******************************************/

DELIMITER |
CREATE PROCEDURE sp_insertPatientEncounter
(
IN i_PatientCheckInID   int,
IN i_TimeIn             time,
IN i_TimeOut            time,
IN i_Comments           text,
IN i_Location           int,
IN i_Diagnosis          text,
IN i_staffFN            varchar(30),
IN i_staffLN            varchar(30),
IN i_AdmitReason        varchar(10)
)

BEGIN

DECLARE _staffID int;

SELECT StaffID FROM Staff WHERE FirstName LIKE i_staffFN && LastName LIKE i_staffLN INTO _staffID;

INSERT INTO PatientEncounter
(
PatientCheckInID,
TimeIn,
TimeOut,
Comments,
Location,
Diagnosis,
StaffID,
AdmitReason
)
VALUES
(
i_PatientCheckInID,
i_TimeIn,
i_TimeOut,
i_Comments,
i_Location,
i_Diagnosis,
_staffID,
AdmitReason
);

END ||
DELIMITER ;

#--------------updates PatientEncounter Table--------------
/******************************************
* sp_updatePatientEncounter updates the
* PatientEncounter table.
******************************************/

DELIMITER |
CREATE PROCEDURE sp_updatePatientEncounter
(
IN i_PatientEncounterID int,
IN i_TimeOut            time,
IN i_Comments           text,
IN i_Location           int,
IN i_Diagnosis          text,
IN i_staffFN            varchar(30),
IN i_staffLN            varchar(30),
IN i_AdmitReason        varchar(50)
)

BEGIN

DECLARE _staffID int;

SELECT StaffID FROM Staff WHERE FirstName LIKE i_staffFN && LastName LIKE i_staffLN INTO _staffID;

UPDATE PatientEncounter SET
TimeOut = i_TimeOut,
Comments = i_Comments,
Location = i_Location,
Diagnosis = i_Diagnosis,
StaffID = _staffID,
AdmitReason = i_AdmitReason
WHERE PatientEncounterID = i_PatientEncounterID;

END ||
DELIMITER ;

#--------------insert into Surgery Table--------------
/******************************************
* sp_insertSurgery inserts into the
* Surgery table.
******************************************/

DELIMITER |
CREATE PROCEDURE sp_insertSurgery
(
IN i_SurgeryType        text,
IN i_StartTime          time,
IN i_EndTime            time,
IN i_RoomNumber         int,
IN i_Comments           text,
IN i_PatientEncounterID int
)

BEGIN

INSERT INTO Surgery
(
SurgeryType,
StartTime,
EndTime,
RoomNumber,
Comments,
PatientEncounterID
)
VALUES
(
i_SurgeryType,
i_StartTime,
i_EndTime,
i_RoomNumber,
i_Comments,
i_PatientEncounterID
);

END ||
DELIMITER ;

#--------------update Surgery Table--------------
/******************************************
* sp_updateSurgery updates the
* Surgery table.
******************************************/

DELIMITER |
CREATE PROCEDURE sp_updateSurgery
(
IN i_SurgeryID          int,
IN i_EndTime            time,
IN i_RoomNumber         int,
IN i_Comments           text
)

BEGIN

UPDATE Surgery SET
EndTime = i_EndTime,
RoomNumber = i_RoomNumber,
Comments = i_Comments
WHERE SurgeryID = i_SurgeryID;

END ||
DELIMITER ;

#--------------insert SurgeryStaff Table--------------
/******************************************
* sp_insertSurgeryStaff inserts into the
* SurgeryStaff table.
******************************************/

DELIMITER |
CREATE PROCEDURE sp_insertSurgeryStaff
(
IN i_staffFN        varchar(30),
IN i_staffLN        varchar(30),
IN i_SurgeryID      int
)

BEGIN

DECLARE _staffID int;

SELECT StaffID FROM Staff WHERE FirstName LIKE i_staffFN && LastName LIKE i_staffLN INTO _staffID;

INSERT INTO SurgeryStaff
(
StaffID,
SurgeryID
)
VALUES
(
_staffID,
i_SurgeryID
);

END ||
DELIMITER ;

#--------------insert Problem/PatientProblem Table--------------
/******************************************
* sp_insertProblem inserts into the
* Problem table.
******************************************/

DELIMITER |
CREATE PROCEDURE sp_insertProblem
(
IN i_ProblemName        varchar(30),
IN i_PatientID          int
)

BEGIN

DECLARE _problemID  int;

INSERT INTO Problem
(
ProblemName
)
VALUES
(
i_ProblemName
);

SELECT LAST_INSERT_ID() INTO _problemID;

INSERT INTO PatientProblem
(
PatientID,
ProblemID
)
VALUES
(
i_PatientID,
_problemID
);

END ||
DELIMITER ;

#--------------insert InvoiceItem Table--------------
/******************************************
* sp_insertInvoiceItem inserts into the
* InvoiceItem table.
******************************************/

DELIMITER |
CREATE PROCEDURE sp_insertInvoiceItem
(
IN i_InvoiceID      int,
IN i_ProductID      int,
IN i_ServiceID      int,
IN i_Quantity       float
)

BEGIN

INSERT INTO InvoiceItem
(
InvoiceID,
ProductID,
ServiceID,
Quantity
)
VALUES
(
i_InvoiceID,
i_ProductID,
i_ServiceID,
i_Quantity
);

END ||
DELIMITER ;

#--------------insert Category Table--------------
/******************************************
* sp_insertCategory inserts into the
* Category table.
******************************************/

DELIMITER |
CREATE PROCEDURE sp_insertCategory
(
IN i_Name          varchar(30),
IN i_Description   text
)

BEGIN

INSERT INTO Category
(
Name,
Description
)
VALUES
(
i_Name,
i_Description
);

END ||
DELIMITER ;

#--------------update Product Count Table--------------
/******************************************
* sp_updateProductCount inserts into the
* Category table.
******************************************/

DELIMITER |
CREATE PROCEDURE sp_updateProductCount
(
IN i_ProductID      int
)

BEGIN

UPDATE Product SET
Counter = Counter + 1
WHERE ProductID = i_ProductID;

END ||
DELIMITER ;

#-----------------------------------------------------------------------------------------------------------
#-------------------------------------------------TEST DATA-------------------------------------------------
#-----------------------------------------------------------------------------------------------------------

INSERT INTO Address
(
Street1,
Street2,
City,
Region,
Country
)
VALUES
(
'12667 W. 85th Cir',
'',
'Arvada',
'Co',
'USA'
);

INSERT INTO Address
(
Street1,
Street2,
City,
Region,
Country
)
VALUES
(
'2558 S 1687 W',
'',
'Layton',
'Ut',
'USA'
);

INSERT INTO EmergencyContact
(
FirstName,
LastName,
PhoneNumber,
Relationship,
AddressID
)
VALUES
(
'Lila',
'Harp',
'303-421-3837',
4,
1
);

INSERT INTO Patient
(
FirstName,
MiddleName,
LastName,
DateOfBirth,
Gender,
PhoneNumber,
AddressID,
BloodType,
TribeRace,
Religion,
OldPhysicalRecordNumb,
EmergencyContactID
)
VALUES
(
'Ed',
'',
'Harp',
'1940-02-10',
'Male',
'303-276-8557',
2,
'AB+',
'white',
'lDS',
1102547,
1
);

#--------

INSERT INTO Address
(
Street1,
Street2,
City,
Region,
Country
)
VALUES
(
'1965 S. 1275 E.',
'',
'Ogden',
'Ut',
'USA'
);

INSERT INTO Address
(
Street1,
Street2,
City,
Region,
Country
)
VALUES
(
'1234 N. 5678 S.',
'',
'Midvill',
'Ut',
'USA'
);

INSERT INTO EmergencyContact
(
FirstName,
LastName,
PhoneNumber,
Relationship,
AddressID
)
VALUES
(
'Bob',
'Smith',
'801-895-7452',
2,
3
);

INSERT INTO Patient
(
FirstName,
MiddleName,
LastName,
DateOfBirth,
Gender,
PhoneNumber,
AddressID,
BloodType,
TribeRace,
Religion,
OldPhysicalRecordNumb,
EmergencyContactID
)
VALUES
(
'Kim',
'',
'Hall',
'1970-10-15',
'Female',
'801-458-7895',
4,
'AB',
'white',
'N/A',
null,
2
);


CALL sp_insertProblem
(
'Aids',
100000
);

CALL sp_insertProblem
(
'Sickle Cell',
100000
);

#CALL sp_insertProblem
#(
#'STDs',
#100002
#);

CALL sp_insertProblem
(
'Diabetes',
100000
);

#CALL sp_insertProblem
#(
#'Diabetes',
#100003
#);

CALL sp_insertAllergy
(
'Pollen',
null,
100000
);

CALL sp_insertAllergy
(
'Neosporn',
null,
100000
);

CALL sp_insertAllergy
(
'Bees',
null,
100001
);

CALL sp_insertAllergy
(
'Chocolate',
null,
100001
);

CALL sp_insertAllergy
(
'Fruit',
null,
100001
);

CALL sp_insertAllergy
(
'Advil',
null,
100001
);

#CALL sp_insertAllergy
#(
#'Wheat',
#null,
#100002
#);

#CALL sp_insertAllergy
#(
#'Nuts',
#null,
#100002
#);

CALL sp_insertAllergy
(
'Morphine',
null,
100001
);

#CALL sp_insertAllergy
#(
#'Lactose',
#null,
#100003
#);

#CALL sp_insertAllergy
#(
#'Fish',
#null,
#100003
#);


CALL sp_insertStaff
(
'6666 N 8888 E',
'',
'Ogden',
'Ut',
'USA',
'JJimmy',
'Password',
'A',
'Jimmy',
'',
'John',
'801-895-7885',
4,
null
);

CALL sp_insertStaff
(
'1965 S 1275 E',
'',
'Ogden',
'Ut',
'USA',
'charp',
'Password',
'A',
'Cameron',
'',
'Harp',
'801-458-7687',
4,
null
);

CALL sp_insertPatientCheckIn
(
NOW(),
1,
1,
100000
);

CALL sp_updateInvoice
(
1000,
800.25
);

CALL sp_insertCategory
(
'Medical Equipment',
'This includes anything that monitors a bodily function and is used in patient care.'
);

CALL sp_insertCategory
(
'Pharmaceuticals',
'Drugs provided to a patient for care.'
);

CALL sp_insertCategory
(
'Miscellaneous',
'General products and supplies that do not fit under a specific category.'
);

CALL sp_insertCategory
(
'Diabetic Supplies',
'Anything used in the treatment of diabetes.'
);

CALL sp_insertCategory
(
'Catheters',
'You do not even want to know this one.'
);

CALL sp_insertProduct
(
'Large Catheter',
'each',
5,
12.25,
50
);

CALL sp_insertProduct
(
'Medium Catheter',
'each',
5,
9.98,
34
);

CALL sp_insertProduct
(
'Small Catheter',
'each',
5,
6.00,
101
);

CALL sp_insertProduct
(
'Aspirin',
'250mg',
2,
2.35,
2340
);

CALL sp_insertProduct
(
'Tylenol',
'500mg',
2,
4.43,
1920
);

CALL sp_insertProduct
(
'Paxil',
'50mg',
2,
6.34,
344
);

CALL sp_insertProduct
(
'Augmentin',
'750mg',
2,
10.54,
67
);

CALL sp_insertProduct
(
'Blood Pressure Cuff',
'each',
1,
45.00,
3
);

CALL sp_insertProduct
(
'Pulse Oximeters',
'each',
1,
2335.43,
3
);

CALL sp_insertService
(
'test service',
22.50
);

CALL sp_insertPatientEncounter
(
1,
NOW(),
null,
null,
null,
null,
'cameron',
'harp',
null
);

CALL sp_updatePatientEncounter
(
1,
NOW(),
'test comments',
2,
'test diagnosis',
'cameron',
'harp',
'reason'
);

CALL sp_insertNote
(
'test title',
'test body',
NOW(),
'jimmy',
'john',
1
);

CALL sp_insertTemplateCategory
(
'Diagnosis',
NULL
);

CALL sp_insertTemplateCategory
(
'Surgery',
NULL
);

CALL sp_insertTemplateCategory
(
'General Note',
NULL
);

CALL sp_insertTemplate
(
'Test diagnosis for Staff 1',
1,
1
);

CALL sp_insertTemplate
(
'Test diagnosis for Staff 2',
1,
2
);

CALL sp_insertSurgery
(
'test surgerytype',
NOW(),
null,
null,
null,
1
);

CALL sp_insertSurgeryStaff
(
'cameron',
'harp',
1
);

CALL sp_insertSurgeryStaff
(
'jimmy',
'john',
1
);

CALL sp_insertInvoiceItem
(
1,
1,
null,
2
);

CALL sp_insertInvoiceItem
(
1,
2,
null,
3
);

CALL sp_insertInvoiceItem
(
1,
4,
null,
10
);