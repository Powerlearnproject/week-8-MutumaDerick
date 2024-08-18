USE `week-8-assignment` ;
-- Create tables
CREATE TABLE HealthFacility (
    FacilityID INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(100),
    FacilityType VARCHAR(50)
);

CREATE TABLE Patient (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Address VARCHAR(150),
    ContactInfo VARCHAR(100)
);

CREATE TABLE Visit (
    VisitID INT PRIMARY KEY,
    PatientID INT,
    FacilityID INT,
    Date DATE,
    PrenatalStage VARCHAR(50),
    Complications TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (FacilityID) REFERENCES HealthFacility(FacilityID)
);

CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    Name VARCHAR(100),
    Role VARCHAR(50),
    FacilityID INT,
    FOREIGN KEY (FacilityID) REFERENCES HealthFacility(FacilityID)
);

CREATE TABLE Treatment (
    TreatmentID INT PRIMARY KEY,
    VisitID INT,
    TreatmentType VARCHAR(100),
    Notes TEXT,
    FOREIGN KEY (VisitID) REFERENCES Visit(VisitID)
);
-- Insert sample data into HealthFacility
INSERT INTO HealthFacility (FacilityID, Name, Location, FacilityType)
VALUES (1, 'Rural Health Center A', 'Village 1', 'Clinic'),
       (2, 'Urban Hospital B', 'City 2', 'Hospital');

-- Insert sample data into Patient
INSERT INTO Patient (PatientID, Name, Age, Address, ContactInfo)
VALUES (1, 'Jane Doe', 28, 'Village 1', '1234567890'),
       (2, 'Mary Smith', 32, 'City 2', '0987654321');

-- Insert sample data into Visit
INSERT INTO Visit (VisitID, PatientID, FacilityID, Date, PrenatalStage, Complications)
VALUES (1, 1, 1, '2024-07-15', 'First Trimester', NULL),
       (2, 2, 2, '2024-07-16', 'Second Trimester', 'High Blood Pressure');

-- Insert sample data into Staff
INSERT INTO Staff (StaffID, Name, Role, FacilityID)
VALUES (1, 'Dr. John', 'Obstetrician', 1),
       (2, 'Nurse Betty', 'Nurse', 2);

-- Insert sample data into Treatment
INSERT INTO Treatment (TreatmentID, VisitID, TreatmentType, Notes)
VALUES (1, 1, 'Ultrasound', 'Normal Development'),
       (2, 2, 'Blood Pressure Check', 'Monitored');
       
-- Retrive all patients and their respective visits 
SELECT Patient.Name, Visit.Date, Visit.PrenatalStage, HealthFacility.Name AS FacilityName
FROM Patient
JOIN Visit ON Patient.PatientID = Visit.PatientID
JOIN HealthFacility ON Visit.FacilityID = HealthFacility.FacilityID;

-- Analyze complications reprted in different facilities;
SELECT HealthFacility.Name AS FacilityName, COUNT(Visit.VisitID) AS ComplicationCount
FROM Visit
JOIN HealthFacility ON Visit.FacilityID = HealthFacility.FacilityID
WHERE Visit.Complications IS NOT NULL
GROUP BY HealthFacility.Name;


-- Identify the most common treatments provided during visits
SELECT TreatmentType, COUNT(TreatmentID) AS TreatmentCount
FROM Treatment
GROUP BY TreatmentType
ORDER BY TreatmentCount DESC;

