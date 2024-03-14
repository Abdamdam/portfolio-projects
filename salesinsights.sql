-- Count the total number of records in the 'customers' table 
SELECT COUNT(*) FROM sales.customers;

-- Retrieve all records from the 'transactions' table where the market code is 'Mark001' // any market 
SELECT * FROM sales.transactions WHERE market_code='Mark001';

--  Retrieve distinct product codes sold in chennai market
SELECT DISTINCT product_code FROM sales.transactions WHERE market_code='Mark001';

-- Retrieve all records from the 'transactions' table where the currency is "USD".
SELECT * FROM sales.transactions WHERE currency="USD";

-- Retrieve all the 'transactions' in 2020 using join 
SELECT transactions.*, date.*
FROM sales.transactions
INNER JOIN sales.date ON transactions.order_date = date.date AND date.year = 2020;

-- Calculate the revenue in 2020 
SELECT SUM(transactions.sales_amount) FROM sales.transactions 
INNER JOIN sales.date 
ON transactions.order_date=date.date WHERE date.year=2020 
AND (transactions.currency="INR\r" OR transactions.currency="USD\r");

-- Calculate the revenue in jan 2020 // any month
SELECT SUM(transactions.sales_amount) FROM sales.transactions 
INNER JOIN sales.date 
ON transactions.order_date=date.date WHERE date.year=2020 
AND date.month_name="January" AND (transactions.currency="INR\r" OR transactions.currency="USD\r");

-- calculate revenue in 2020 in chennai //certain market
SELECT SUM(transactions.sales_amount) FROM sales.transactions 
INNER JOIN sales.date ON transactions.order_date=date.date WHERE date.year=2020 
AND transactions.market_code="Mark001";


