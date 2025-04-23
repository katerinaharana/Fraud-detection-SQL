use FraudDetection
--1 Basic Statistics
SELECT
    COUNT(*) AS total_transactions,
    SUM(CAST(isFraud AS INT)) AS total_fraud_cases,
    ROUND(100.0 * SUM(CAST(isFraud AS INT)) / COUNT(*), 2) AS fraud_rate_percent
FROM transactions;

--2a Top 10 Fraud Users
SELECT TOP 10
    u.name AS user_name,
    COUNT(*) AS fraud_count,
    SUM(t.amount) AS total_fraud_amount
FROM transactions t
JOIN users u ON t.origin_user_id = u.user_id
WHERE t.isFraud = 1
GROUP BY u.name
ORDER BY total_fraud_amount DESC;

--2b Top 10 Fraud Receivers
SELECT TOP 10
    nameDest,
    COUNT(*) AS num_frauds_received,
    SUM(amount) AS total_received_fraud
FROM sample
WHERE isFraud = 1
GROUP BY nameDest
ORDER BY total_received_fraud DESC;


--3 Fraud by transaction type
SELECT
    tt.type_name,
    COUNT(*) AS total_frauds,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM transactions WHERE isFraud = 1), 2) AS fraud_pct
FROM transactions t
JOIN transaction_types tt ON t.type_id = tt.type_id
WHERE t.isFraud = 1
GROUP BY tt.type_name
ORDER BY total_frauds DESC;

--4 Fraud over time
SELECT    step,
    COUNT(*) AS fraud_count
FROM transactions
WHERE isFraud = 1
GROUP BY step
ORDER BY step;

--5 Fraud detection accuracy
SELECT
    SUM(CASE WHEN isFraud = 1 AND isFlaggedFraud = 1 THEN 1 ELSE 0 END) AS correctly_flagged,
    SUM(CASE WHEN isFraud = 1 AND isFlaggedFraud = 0 THEN 1 ELSE 0 END) AS missed_frauds,
    SUM(CASE WHEN isFraud = 0 AND isFlaggedFraud = 1 THEN 1 ELSE 0 END) AS false_positives
FROM transactions;


