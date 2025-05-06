-- Create Database
CREATE DATABASE ClinicBookings;
USE ClinicBookings;

-- Patients Table
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    contact VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    address TEXT NOT NULL
);

-- Doctors Table
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    contact VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Appointments Table
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE
);

-- Services Table
CREATE TABLE Services (
    service_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

-- Appointment Services (Many-to-Many Relationship)
CREATE TABLE Appointment_Services (
    appointment_id INT NOT NULL,
    service_id INT NOT NULL,
    PRIMARY KEY (appointment_id, service_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES Services(service_id) ON DELETE CASCADE
);

-- Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT UNIQUE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Cash', 'Card', 'Insurance') NOT NULL,
    payment_date DATETIME NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE
);

-- Insert sample patients
INSERT INTO Patients (name, date_of_birth, contact, email, address) VALUES
('Alice Johnson', '1990-05-10', '0712345678', 'alice@outlook.com', '123 Main St, Nairobi'),
('Bob Smith', '1985-09-22', '0723456789', 'bob@outlook.com', '45 West Ave, Nairobi');

-- Insert sample doctors
INSERT INTO Doctors (name, specialization, contact, email) VALUES
('Dr. Jane Defore', 'Cardiology', '0744567890', 'jane.doe@hopkins.com'),
('Dr. John Green', 'Dermatology', '0755678901', 'john.green@hopkins.com');

-- Insert sample appointments
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2025-05-10 10:00:00', 'Scheduled'),
(2, 2, '2025-05-12 14:30:00', 'Scheduled');

-- Insert sample services
INSERT INTO Services (name, description, price) VALUES
('Heart Checkup', 'Comprehensive heart examination', 5000.00),
('Skin Treatment', 'Advanced dermatological care', 3000.00);

-- Link appointments to services
INSERT INTO Appointment_Services (appointment_id, service_id) VALUES
(1, 1), -- Alice Johnson getting a heart checkup
(2, 2); -- Bob Smith getting skin treatment

-- Insert sample payments
INSERT INTO Payments (appointment_id, amount, payment_method, payment_date) VALUES
(1, 5000.00, 'Card', '2025-05-10 11:00:00'),
(2, 3000.00, 'Cash', '2025-05-12 15:00:00');
