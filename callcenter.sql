
-- Fetch the first 10 rows from the "call center" table
SELECT * FROM callcenter.`call center` LIMIT 10;

-- Convert the "call_timestamp" column from string to date format
SET SQL_SAFE_UPDATES = 0;
UPDATE callcenter.`call center` SET call_timestamp = STR_TO_DATE(call_timestamp, "%m/%d/%Y");
SET SQL_SAFE_UPDATES = 1;

-- Set the "csat_score" column to NULL where the value is 0
UPDATE callcenter.`call center` SET csat_score = NULL WHERE csat_score = 0;

-- data exploration

-- Check the number of rows in the "call center" table
SELECT COUNT(*) AS rows_num FROM callcenter.`call center`;

-- Check the distinct values of selected columns
SELECT DISTINCT sentiment FROM callcenter.`call center`;
SELECT DISTINCT reason FROM callcenter.`call center`;
SELECT DISTINCT channel FROM callcenter.`call center`;
SELECT DISTINCT response_time FROM callcenter.`call center`;
SELECT DISTINCT call_center FROM callcenter.`call center`;

-- Calculate the count and percentage of each distinct value in the "sentiment" column
SELECT sentiment, COUNT(*), ROUND((COUNT(*) / (SELECT COUNT(*) FROM callcenter.`call center`)) * 100, 1) AS pct
FROM callcenter.`call center` GROUP BY 1 ORDER BY 3 DESC;

-- Calculate the count and percentage of each distinct value in the "reason" column
SELECT reason, COUNT(*), ROUND((COUNT(*) / (SELECT COUNT(*) FROM callcenter.`call center`)) * 100, 1) AS pct
FROM callcenter.`call center` GROUP BY 1 ORDER BY 3 DESC;

-- Calculate the count and percentage of each distinct value in the "channel" column
SELECT channel, COUNT(*), ROUND((COUNT(*) / (SELECT COUNT(*) FROM callcenter.`call center`)) * 100, 1) AS pct
FROM callcenter.`call center` GROUP BY 1 ORDER BY 3 DESC;

-- Calculate the count and percentage of each distinct value in the "response_time" column
SELECT response_time, COUNT(*), ROUND((COUNT(*) / (SELECT COUNT(*) FROM callcenter.`call center`)) * 100, 1) AS pct
FROM callcenter.`call center` GROUP BY 1 ORDER BY 3 DESC;

-- Calculate the count and percentage of each distinct value in the "call_center" column
SELECT call_center, COUNT(*), ROUND((COUNT(*) / (SELECT COUNT(*) FROM callcenter.`call center`)) * 100, 1) AS pct
FROM callcenter.`call center` GROUP BY 1 ORDER BY 3 DESC;

-- Count the number of occurrences for each state
SELECT state, COUNT(*) FROM callcenter.`call center` GROUP BY 1 ORDER BY 2 DESC;

-- Count the number of calls for each day of the week
SELECT DAYNAME(call_timestamp) AS Day_of_call, COUNT(*) num_of_calls FROM callcenter.`call center` GROUP BY 1 ORDER BY 2 DESC;


-- Calculate the minimum, maximum, and average CSAT scores (excluding 0 values)
SELECT MIN(csat_score) AS min_score, MAX(csat_score) AS max_score, ROUND(AVG(csat_score), 1) AS avg_score
FROM callcenter.`call center` WHERE csat_score IS NOT NULL;

-- Find the earliest and most recent call timestamps
SELECT MIN(call_timestamp) AS earliest_date, MAX(call_timestamp) AS most_recent FROM callcenter.`call center`;

-- Calculate the minimum, maximum, and average call durations
SELECT MIN(call_duration_minutes) AS min_call_duration, MAX(call_duration_minutes) AS max_call_duration, AVG(call_duration_minutes) AS avg_call_duration
FROM callcenter.`call center`;

-- Count the number of calls for each call center and response time combination
SELECT call_center, response_time, COUNT(*) AS count
FROM callcenter.`call center` GROUP BY 1, 2 ORDER BY 1, 3 DESC;

-- Calculate the average call duration for each call center
SELECT call_center, AVG(call_duration_minutes) FROM callcenter.`call center` GROUP BY 1 ORDER BY 2 DESC;

-- Calculate the average call duration for each channel
SELECT channel, AVG(call_duration_minutes) FROM callcenter.`call center` GROUP BY 1 ORDER BY 2 DESC;

-- Count the number of calls for each state
SELECT state, COUNT(*) FROM callcenter.`call center` GROUP BY 1 ORDER BY 2 DESC;

-- Count the number of calls for each state and reason combination
SELECT state, reason, COUNT(*) FROM callcenter.`call center` GROUP BY 1, 2 ORDER BY 1, 2, 3 DESC;

-- Count the number of calls for each state and sentiment combination
SELECT state, sentiment, COUNT(*) FROM callcenter.`call center` GROUP BY 1, 2 ORDER BY 1, 3 DESC;

-- Calculate the average CSAT score for each state (excluding 0 values)
SELECT state, AVG(csat_score) AS avg_csat_score FROM callcenter.`call center` WHERE csat_score IS NOT NULL GROUP BY 1 ORDER BY 2 DESC;

-- Calculate the average call duration for each sentiment
SELECT sentiment, AVG(call_duration_minutes) FROM callcenter.`call center` GROUP BY 1 ORDER BY 2 DESC;

-- Find the maximum call duration for each call timestamp group
SELECT call_timestamp, MAX(call_duration_minutes) OVER (PARTITION BY call_timestamp) AS max_call_duration
FROM callcenter.`call center` GROUP BY 1 ORDER BY 2 DESC;