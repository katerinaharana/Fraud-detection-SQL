## SQL-Based Fraud Detection Using PaySim Dataset

This project uses SQL to analyze a synthetic mobile money transaction dataset and explore fraud detection challenges.

## Project Overview

## Data Source

- [PaySim Dataset on Kaggle](https://www.kaggle.com/datasets/ntnu-testimon/paysim1)
- **Note:** For this project, only the **first 10,000 rows** of the dataset were used to simplify analysis and improve performance within Microsoft SQL Server.




##  Folder Structure

| File          | Description                                |
|---------------|--------------------------------------------|
| `schema.sql`  | Creates `users`, `transactions`, `transaction_types` tables |
| `seed.sql`    | Populates tables from raw PaySim data      |
| `queries.sql` | Exploratory queries and fraud detection logic |

##  Schema Design

- `users`: all unique user IDs from senders/receivers
- `transaction_types`: unique transaction types (e.g. TRANSFER, CASH_OUT)
- `transactions`: main table linking users, types, and fraud indicators

##  Key Insights

- Out of 10,000 transactions, 68 were marked as real fraud (`isFraud = 1`)
- The built-in fraud detection rule (`isFlaggedFraud`) failed to detect any of them (0% success)
- Fraudsters often use TRANSFER and CASH_OUT types


##  Limitations

- Dataset is synthetic and simplified (10k rows used from full 6M+)
- Balance columns can't be used to detect fraud


## Future Work

- Apply this logic to full dataset for deeper patterns
- Build custom fraud flagging logic in SQL
- Create dashboards using Power BI

##  Source

- [PaySim Dataset on Kaggle](https://www.kaggle.com/datasets/ntnu-testimon/paysim1)

---
