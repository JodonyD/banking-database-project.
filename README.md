# Banking Database Management System

## Project Overview

This Banking Database Management System is a SQL-based project designed to organize and manage banking information. 
It uses a relational database to store customer details, bank branches, account information, employee records, and transaction records.

This project demonstrates the use of SQL to retrieve, organize, filter, and summarize data for basic banking reports.

## Technologies Used

- **MySQL** — Relational database management system
- **SQL** — Database creation, data retrieval, filtering, and reporting
- **GitHub** — Project documentation and version control

## Database Structure

The database contains five main tables:

Table  and Description 
1. branches` - Stores bank branch names and parish locations. 
2. customers - Stores customer information and their associated branches. 
3. accounts - Stores account types, balances, statuses, and customer relationships. 
4. transactions - Stores transaction types, amounts, dates, and descriptions.
5. employees - Stores employee details, job titles, branch assignments, and employment statuses. 

## SQL Skills Demonstrated

This project includes SQL queries demonstrating:

1. SELECT — Retrieving records from database tables.
2. WHERE — Filtering records based on conditions.
3. ORDER BY — Sorting query results.
4. JOIN — Combining related information from multiple tables.
5. LEFT JOIN — Including records that do not have matching records in another table.
6. GROUP BY — Grouping records for reporting.
7. HAVING — Filtering grouped results.  
- Aggregate functions such as COUNT(), SUM(), and AVG().
8. IS NULL — Identifying missing values.
9. Date formatting and monthly transaction reporting.
10. Primary keys, foreign keys, and data integrity constraints.

## Example Reports

The database can be used to generate reports such as:

1. Customers and their associated bank branches.
2. Customers with active accounts.
3. Accounts with balances above a specified amount.
4. Total active account balances by account type.
5. Customer counts by branch.
6. Employee lists by branch.
7. Transaction totals by transaction type.
8. Monthly transaction summaries.
9. Customers with multiple accounts.
10. Accounts without recorded transactions.

## Project Files

- schema.sql — Database and table creation scripts.
- sample_data.sql — Sample records used to test the database.
- queries.sql — SQL queries for retrieving information and generating reports.

## How to Use

1. Install MySQL Server and a MySQL client, such as MySQL Workbench.
2. Clone or download this repository.
3. Open the SQL files in MySQL Workbench.
4. Execute the database schema script to create the tables.
5. Execute the sample data script to populate the tables.
6. Run the queries in `queries.sql` to explore the data and generate reports.

**Important:** 
Run the schema and sample data scripts in the correct order. If the schema script contains a `DROP DATABASE` statement, review it before running it because it can delete an existing database.

## Learning Objectives

This project was developed to strengthen practical SQL and relational database skills, including table relationships, data integrity, filtering, aggregation, and reporting.

## Disclaimer

This is an educational portfolio project. It uses sample data and is not connected to a real banking system. It does not process real financial transactions or store real customer banking information.
