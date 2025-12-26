-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

SELECT 
    t.sender_id, 
    u.user_name, 
    t.date, 
    t.message_count
FROM (
    SELECT 
        sender_id, 
        sent_at::date AS date, 
        COUNT(*) AS message_count,
        RANK() OVER (PARTITION BY sent_at::date ORDER BY COUNT(*) DESC) AS rank_pos
    FROM npn_messages
    GROUP BY sender_id, sent_at::date
) AS t
LEFT JOIN npn_users u ON t.sender_id = u.user_id
WHERE t.rank_pos = 1
ORDER BY t.date, u.user_name;
