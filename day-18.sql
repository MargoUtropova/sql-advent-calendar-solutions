-- SQL Advent Calendar - Day 18
-- Title: 12 Days of Data - Progress Tracking
-- Difficulty: hard
--
-- Question:
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--

-- Table Schema:
-- Table: daily_quiz_scores
--   subject: VARCHAR
--   quiz_date: DATE
--   score: INTEGER
--

-- My Solution:

select subject, quiz_date, score
  from

(select subject, quiz_date, score, RANK() OVER(PARTITION BY subject order by quiz_date) as first,
  RANK() OVER(PARTITION BY subject order by quiz_date desc) as last
  from daily_quiz_scores) as t
where first = 1 or last = 1
