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


-- sample data for branches
INSERT INTO branches (branch_name , parish) VALUES
 ('May Pen Branch','Clarendon'), 
 ('Spanish Town Branch','St Catherine'),
 ('Old Hope Road Branch','KINGSTON'),
 ('Mandevelle Branch','Manchester'),
 ('Santa Cruz Branch','St Elizabeth');
 
 -- sample data for customers
 INSERT INTO customers (first_name, last_name, email, phone, branch_id) VALUES 
	('Mary','Brown','marybrow@gmail.com','876-236-2483',1),
    ('John','Doe','doejohn@yahoo.com','876-394-2342',2),
    ('Jasmine','Burke','burkejas1@gmail.com','876-937-2342',3),
    ('Amanda','James','james12@gmail.com','876-602-1341',4),
    ('Cathrime','Henry','cathen28@yahoo.com','876-263-8363',5);
 
-- sample employee data 
INSERT INTO employee (first_name, last_name, email, phone, job_title, branch_id, hire_date, employee_status)
VALUES 
('Jodony','Dunn', 'jodonydunn@gmail.com','876-348-7520','Branch Supervisor', 1, '2024-08-20','Active'),
('Kenika','Johnson', 'kennyjo12@gmail.com','876-873-3642','Branch Manager', 2, '2023-10-16','Active'),
('Martha','Brae', 'martha123@gmail.com','876-763-4728','IT Support', 3, '2023-02-09','Active'),
('Daniel','Campbell', 'danielcambp10@gmail.com','876-647-3335','Customer_Service', 4, '2024-03-12','On Leave'),
('Garth','Jackson', 'jackocgarth@gmail.com','876-337-7832', 'IT Technician', 5, '2022-09-25','On Leave');

--  sample accounts data
INSERT INTO accounts (customer_id, account_type, balance, account_status) VALUES
(1, 'Savings', 50000.00, 'Active'),
(2, 'Checking', 25000.00, 'Active'),
(3, 'Savings', 75000.00, 'Active'),
(4, 'Fixed Deposit', 100000.00, 'Active'),
(5, 'Checking', 15000.00, 'Inactive'),
(1, 'Checking', 12000.00, 'Active'),
(3, 'Fixed Deposit', 200000.00, 'Active'),
(2, 'Savings', 1.00, 'Closed');


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



