-- query #1-5 to display branches and customers table
SELECT* FROM branches;
SELECT* FROM customers;
SELECT * FROM employee; 
SELECT * FROM accounts; 
SELECT * FROM transactions; 

SHOW TABLES; # query 6 shows all the tables that exists

DESCRIBE accounts; # query #7 used to check the structre of the accounts tbale

-- query #8 displays customers with their branch name  JOIN used to connect customers to the branches they are registered
SELECT 
	c.customer_id, c.first_name, c.last_name, c.email, b.branch_name
FROM customers c 
JOIN branches b ON c.branch_id = b.branch_id;

-- query #9 finding customers who have active accounts usimg WHERE clause to show only active accounts 
SELECT  
	c.first_name, c.last_name, a.balance, a.account_type, a.account_status
FROM  customers c 
JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.account_status = 'Active';

-- query #10 displays the accounts with balance less than 50000 using order by to display balance in ASC (lowest)
SELECT 
	c.first_name, c.last_name, a.account_type, a.balance
FROM customers c 
JOIN accounts a ON c.customer_id = a.customer_id 
WHERE a.balance < 50000
ORDER BY a.balance ASC;

-- query #11 search for customers with no account LEFT JOIN keeps all customers including those with no acounts
-- IS NULL shows customer with no matching account 
SELECT 
	c.customer_id, c.first_name, c.last_name
FROM customers c 
LEFT JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.account_id IS NULL;
    
-- USING AGGREGATES 
-- query #12 calculates the total balance across active accounts using AS to give an alias 
SELECT 
	sum(balance)AS total 
FROM accounts 
WHERE account_status = 'Active';

-- query #13 count active accounts and calculate the total balance by type 
-- COUNT adds up all the accounts SUM calculates the balance for each account type WHERE account stauts is Active and GROUP BY account type
SELECT 
	account_type, count(*) AS total_accounts, sum(balance) AS total_balance
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
	account_id, customer_id, account_type, balance
FROM accounts
ORDER BY balance DESC
LIMIT 1;

-- query #17 selects employees who work at the may pen branch 
SELECT
	e.first_name, e.last_name, e.job_title, b.branch_name
FROM employee e
JOIN branches b ON e.branch_id = b.branch_id
WHERE b.branch_name = 'May Pen Branch';

-- Query #18 displays transactions with customer and account details, first JOIN connects transactions to accounts
-- The second JOIN connects accounts to their customers and ORDER BY displays the latest transactions first
SELECT 
	t.transaction_id, c.first_name, c.last_name, a.account_type, t.transaction_type, t.amount, t.transaction_date,t.descriptio
FROM transactions t 
JOIN accounts a ON t.account_id = a.account_id
JOIN customers c ON a.customer_id = c.customer_id
ORDER BY t.transaction_date DESC;

-- query #19 find customers who doesn't have a phone number 
SELECT 
	customer_id, first_name, last_name, email 
FROM customers 
WHERE phone IS NULL;

-- query #20 Calculate the combined active account balance for each customer
-- SUM adds the balances of each customer's active accounts GROUP BY creates a result for each customer ORDER BY ranks customers by their combined balance
SELECT 
	c.customer_id, c.first_name, c.last_name, sum(a.balance) AS total_active
FROM customers c 
JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.account_type = 'Active'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_active ASC;



