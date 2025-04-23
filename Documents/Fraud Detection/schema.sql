-- Create the database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'FraudDetection')
BEGIN
    CREATE DATABASE FraudDetection;
END
GO

-- Use the database
USE FraudDetection;
GO

-- Create Users table
CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50) UNIQUE
);

-- Create Transaction Types table
CREATE TABLE transaction_types (
    type_id INT IDENTITY(1,1) PRIMARY KEY,
    type_name NVARCHAR(50) UNIQUE
);

-- Create Transactions table
CREATE TABLE transactions (
    trans_id INT IDENTITY(1,1) PRIMARY KEY,
    step INT,
    type_id INT FOREIGN KEY REFERENCES transaction_types(type_id),
    amount FLOAT,
    origin_user_id INT FOREIGN KEY REFERENCES users(user_id),
    dest_user_id INT FOREIGN KEY REFERENCES users(user_id),
    oldbalanceOrg FLOAT,
    newbalanceOrg FLOAT,
    oldbalanceDest FLOAT,
    newbalanceDest FLOAT,
    isFraud BIT,
    isFlaggedFraud BIT
);
