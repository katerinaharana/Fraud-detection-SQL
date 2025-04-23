
USE FraudDetection
-- 1: Insert unique users from origin
INSERT INTO users (name)
SELECT DISTINCT nameOrig
FROM sample
WHERE nameOrig IS NOT NULL

UNION

-- 2: Insert unique users from destination
SELECT DISTINCT nameDest
FROM sample
WHERE nameDest IS NOT NULL;


-- 3: Insert unique transaction types
INSERT INTO transaction_types (type_name)
SELECT DISTINCT type
FROM sample
WHERE type IS NOT NULL;

--4: Insert data to transaction table 
INSERT INTO transactions (
    step, type_id, amount,
    origin_user_id, dest_user_id,
    oldbalanceOrg, newbalanceOrg,
    oldbalanceDest, newbalanceDest,
    isFraud, isFlaggedFraud
)
SELECT
    s.step,
    tt.type_id,
    s.amount,
    u1.user_id AS origin_user_id,
    u2.user_id AS dest_user_id,
    s.oldbalanceOrg,
    s.newbalanceOrig,
    s.oldbalanceDest,
    s.newbalanceDest,
    s.isFraud,
    s.isFlaggedFraud
FROM sample s
JOIN transaction_types tt
    ON s.type = tt.type_name
JOIN users u1
    ON s.nameOrig = u1.name
JOIN users u2
    ON s.nameDest = u2.name;
