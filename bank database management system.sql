DROP DATABASE IF EXISTS bank_db; -- deletes and rebuilds the entire db once the script is ran 
CREATE DATABASE bank_db;
USE bank_db;

-- Tables 

CREATE TABLE branches (
	branch_id INT auto_increment PRIMARY KEY, 
    branch_name varchar(100) NOT NULL, 
    parish varchar(30) NOT NULL
);


CREATE TABLE customers (
	customer_id INT auto_increment primary key,
    first_name varchar(50) NOT NULL, 
    last_name varchar(50) NOT NULL,
    email varchar (100) NOT NULL UNIQUE,
    phone varchar(20), 
    branch_id INT NOT NULL, 
    create_at DATETIME NOT NULL DEFAULT current_timestamp,
    CONSTRAINT fk_customers_branch FOREIGN KEY (branch_id) references branches (branch_id)
);


-- SAMPLE DATA 
INSERT INTO branches (branch_name , parish) VALUES
 ('May Pen Branch','Clarendon'), 
 ('Spanish Town Branch','St Catherine'),
 ('Old Hope Road Branch','KINGSTON'),
 ('Mandivelle Branch','Manchester'),
 ('Santa Cruz Branch','St Elizabeth');
 
 
 INSERT INTO customers (first_name, last_name, email, phone, branch_id) VALUES 
	('Mary','Brown','marybrow@gmail.com','876-236-2483',1),
    ('John','Doe','doejohn@yahoo.com','876-394-2342',2),
    ('Jasmine','Burke','burkejas1@gmail.com','876-937-2342',3),
    ('Amanda','James','james12@gmail.com','876-602-1341',4),
    ('Cathrime','Henry','cathen28@yahoo.com','876-263-8363',5);
    
-- query #1-2 to display branches and customers table
SELECT* FROM branches;
SELECT* FROM customers;

CREATE TABLE accounts(
	account_id INT auto_increment primary key,
    customer_id INT NOT NULL,
    account_type varchar(50) NOT NULL,
    balance decimal (12,2) NOT NULL DEFAULT 0.00,
    account_status varchar(20) NOT NULL DEFAULT 'Active',
    created_at DATETIME NOT NULL DEFAULT current_timestamp,
    
    CONSTRAINT fk_accounts_customer FOREIGN KEY (customer_id) references customers(customer_id),
    
    CONSTRAINT check_account_balance
    CHECK (balance >= 0),
    
	CONSTRAINT check_account_type
	CHECK (account_type IN ('Checking', 'Savings', 'Fixed Deposit')),
    
    CONSTRAINT check_account_status
    CHECK (account_status IN ('Active','Inactive', 'Closed'))
);

CREATE TABLE transactions (
	transaction_id INT auto_increment primary key,
    account_id INT NOT NULL, 
    transaction_type varchar(50) NOT NULL, 
    amount DECIMAL(12,2) NOT NULL, 
    transaction_date DATETIME NOT NULL DEFAULT current_timestamp, 
    descriptio varchar (255), 
    
    CONSTRAINT fk_transaction_account FOREIGN KEY (account_id) references accounts(account_id), 
    
    CONSTRAINT check_transaction_type 
    CHECK (transaction_type IN ('Deposit','Withdrawal', 'Transfer')),
    
    CONSTRAINT check_transaction_amount 
    CHECK (amount > 0)
);

CREATE TABLE employee(
	employee_id INT auto_increment primary key,
    first_name varchar(50) NOT NULL, 
    last_name varchar (50) NOT NULL, 
    email varchar(100) NOT NULL UNIQUE, 
    phone varchar(20) NOT NULL, 
    job_title varchar(50) NOT NULL, 
    branch_id INT NOT NULL, 
    hire_date DATE NOT NULL, 
    employee_status varchar (50) NOT NULL DEFAULT 'Active',
    
    CONSTRAINT fk_employee_branch FOREIGN KEY (branch_id) references branches(branch_id), 
    
    CONSTRAINT check_employee_status 
    CHECK (employee_status IN ('Active', 'On Leave'))
);

SHOW TABLES; -- query #3 shows all the tables that exists

DESCRIBE accounts; -- query #4 used to check the structre of the accounts tbale

-- sample employee data 
INSERT INTO employee (first_name, last_name, email, phone, job_title, branch_id, hire_date)
VALUES 
('Jodony','Dunn', 'jodonydunn@gmail.com','876-348-7520','Branch Supervisor', 1, '2024-08-20'),
('Kenika','Johnson', 'kennyjo12@gmail.com','876-873-3642','Branch Manager', 2, '2023-10-16'),
('Martha','Brae', 'martha123@gmail.com','876-763-4728','IT Support', 3, '2023-02-09'),
('Daniel','Campbell', 'danielcambp10@gmail.com','876-647-3335','Customer_Service', 4, '2024-03-12'),
('Garth','Jackson', 'jackocgarth@gmail.com','876-337-7832', 'IT Technician', 5, '2022-09-25');

SELECT * FROM employee; -- query #5 

--  sample accounts datat
INSERT INTO accounts (customer_id, account_type, balance, account_status) VALUES
(1, 'Savings', 50000.00, 'Active'),
(2, 'Checking', 25000.00, 'Active'),
(3, 'Savings', 75000.00, 'Active'),
(4, 'Fixed Deposit', 100000.00, 'Active'),
(5, 'Checking', 15000.00, 'Inactive'),
(1, 'Checking', 12000.00, 'Active'),
(3, 'Fixed Deposit', 200000.00, 'Active'),
(2, 'Savings', 1.00, 'Closed');

SELECT * FROM accounts; -- query #6

-- sample transaction data
INSERT INTO transactions (account_id, transaction_type, amount, descriptio) VALUES
(1,'Deposit', 10000.00, 'Teller Despoit'),
(2,'Withdrawal', 20000.00, 'ATM Withdrawal'),
(3,'Deposit', 35000.00, 'ATM Deposit'),
(4,'Transfer', 4000.00, 'Online Transfer'),
(3, 'Deposit', 20000.00, 'Savings deposit'),
(4, 'Deposit', 30000.00, 'Fixed deposit funding'),
(5, 'Withdrawal', 1000.00, 'Cash withdrawal'),
(1, 'Deposit', 3000.00, 'Additional deposit'),
(5, 'Transfer', 2000.00, 'Account transfer');

SELECT * FROM transactions; -- query #7 

-- query #8 displays customers with their branch name  JOIN used to connect customers to the branches they are registered
SELECT c.customer_id, 
	c.first_name, 
    c.last_name,  
    c.email,
	b.branch_name
FROM customers c 
JOIN branches b ON c.branch_id = b.branch_id;

-- query #9 finding customers who have active accounts usimg WHERE clause to show only active accounts 
SELECT  
	c.first_name, 
    c.last_name, 
    a.balance, 
    a.account_type,
    a.account_status
FROM  customers c 
JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.account_status = 'Active';

-- query #10 displays the accounts with balance less than 50000 using order by to display balance in ASC (lowest)
SELECT 
	c.first_name,
    c.last_name,
    a.account_type,
    a.balance
FROM customers c 
JOIN accounts a ON c.customer_id = a.customer_id 
WHERE a.balance < 50000
ORDER BY a.balance ASC;

-- query #11 search for customers with no account LEFT JOIN keeps all customers including those with no acounts
-- IS NULL shows customer with no matching account 
SELECT 
	c.customer_id,
	c.first_name, 
    c.last_name
FROM customers c 
LEFT JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.account_id IS NULL;
    
-- using the aggregates 

-- query #12 calculates the total balance across active accounts using AS to give an alias 
SELECT sum(balance)AS total 
FROM accounts 
WHERE account_status = 'Active';

-- query #13 count active accounts and calculate the total balance by type 
-- COUNT adds up all the accounts SUM calculates the balance for each account type WHERE account stauts is Active and GROUP BY account type
SELECT account_type, 
	count(*) AS total_accounts,
    sum(balance) AS total_balance
FROM accounts 
WHERE account_status ='Active'
GROUP BY account_type;
    
    
-- quest #14 COUNT accounts by status 
SELECT account_status, count(*) AS Accounts_by_status
FROM accounts 
GROUP BY account_status;

-- query #15 calculates the average balance of all active accounts 
SELECT 
avg(balance) AS Active_Average
FROM accounts
WHERE account_status = 'Active';

-- query #16 finding the account with the highest balance using order by to put in DESC and using LIMIT to display only 1
SELECT 
	account_id, 
	customer_id, 
    account_type, 
    balance
FROM accounts
ORDER BY balance DESC
LIMIT 1;

