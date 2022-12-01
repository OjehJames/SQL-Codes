-- selecting the 4 tables
SELECT * FROM `practice22.sql_practice1.correct_answer`;
SELECT * FROM `practice22.sql_practice1.student_list`;
SELECT * FROM `practice22.sql_practice1.question_paper_code`;
SELECT * FROM `practice22.sql_practice1.student_response`;


-- OUTPUT_TABLE_COLUMN_NAMES: Roll_number, Student_name, Class, Section, School_name, Math_correct, Math_wrong, Math_yet_to_learn, Math_score, Math_percentage, Science_correct, Science_wrong, Science_yet_learn, Science_score, Science_percentage.

-- Joining the 4 tables
SELECT *
FROM `practice22.sql_practice1.student_list` AS sl
JOIN `practice22.sql_practice1.student_response` AS sr ON sl.roll_number=sr.roll_number
JOIN `practice22.sql_practice1.correct_answer` AS ca ON sr.question_paper_code=ca.question_paper_code AND ca.question_number=sr.question_number
Join `practice22.sql_practice1.question_paper_code` AS pc ON pc.paper_code=ca.question_paper_code;

-- Selecting the appropriate columns and narrowing down to one student to make it easier...
SELECT sl.roll_number, sl.student_name, sl.class,sl.section,sl.school_name
FROM `practice22.sql_practice1.student_list` AS sl
JOIN `practice22.sql_practice1.student_response` AS sr ON sl.roll_number=sr.roll_number
JOIN `practice22.sql_practice1.correct_answer` AS ca ON sr.question_paper_code=ca.question_paper_code AND ca.question_number=sr.question_number
Join `practice22.sql_practice1.question_paper_code` AS pc ON pc.paper_code=ca.question_paper_code
WHERE sl.roll_number=10001;

-- solving for Math_correct, Math_wrong, Math_yet_to_learn, Science_correct, Science_wrong and Science_yet_learn
SELECT 
  sl.roll_number, sl.student_name, sl.class,sl.section,sl.school_name, pc.subject, sr.option_marked, ca.correct_option,
case when pc.subject = 'Math' and sr.option_marked = ca.correct_option and sr.option_marked <> 'e' then 1 else 0 end as math_correct,
case when pc.subject = 'Math' and sr.option_marked <> ca.correct_option and sr.option_marked <> 'e' then 1 else 0 end as math_wrong,
case when pc.subject = 'Math' and sr.option_marked = 'e' then 1 else 0 end as math_yet_to_learn,
case when pc.subject = 'Science' and sr.option_marked = ca.correct_option and sr.option_marked <> 'e' then 1 else 0 end as Science_correct,
case when pc.subject = 'Science' and sr.option_marked <> ca.correct_option and sr.option_marked <> 'e' then 1 else 0 end as Science_wrong,
case when pc.subject = 'Science' and sr.option_marked = 'e' then 1 else 0 end as Science_yet_to_learn
FROM   `practice22.sql_practice1.student_list` AS sl
join   `practice22.sql_practice1.student_response` AS sr ON sr.roll_number=sl.roll_number 
join   `practice22.sql_practice1.correct_answer` AS ca 
  ON ca.question_paper_code = sr.question_paper_code and ca.question_number = sr.question_number
join   `practice22.sql_practice1.question_paper_code` AS pc ON pc.paper_code = ca.question_paper_code
WHERE sl.roll_number=10159;
 
 --- I Summed up and grouped: Getting math_total and science_total to use for calculating percentage...
SELECT 
  sl.roll_number, sl.student_name, sl.class,sl.section,sl.school_name,
sum (case when pc.subject = 'Math' and sr.option_marked = ca.correct_option and sr.option_marked <> 'e' then 1 else 0 end) as math_correct,
sum (case when pc.subject = 'Math' and sr.option_marked <> ca.correct_option and sr.option_marked <> 'e' then 1 else 0 end) as math_wrong,
sum (case when pc.subject = 'Math' and sr.option_marked = 'e' then 1 else 0 end) as math_yet_to_learn,
sum (case when pc.subject = 'Science' and sr.option_marked = ca.correct_option and sr.option_marked <> 'e' then 1 else 0 end) as science_correct,
sum (case when pc.subject = 'Science' and sr.option_marked <> ca.correct_option and sr.option_marked <> 'e' then 1 else 0 end) as science_wrong,
sum (case when pc.subject = 'Science' and sr.option_marked = 'e' then 1 else 0 end) as Science_yet_to_learn,
sum (case when pc.subject = 'Science' then 1 else 0 end) as science_total,
sum (case when pc.subject = 'Math' then 1 else 0 end) as math_total,
FROM   `practice22.sql_practice1.student_list` AS sl
join   `practice22.sql_practice1.student_response` AS sr ON sr.roll_number=sl.roll_number 
join   `practice22.sql_practice1.correct_answer` AS ca 
  ON ca.question_paper_code = sr.question_paper_code and ca.question_number = sr.question_number
join   `practice22.sql_practice1.question_paper_code` AS pc ON pc.paper_code = ca.question_paper_code
WHERE sl.roll_number=10159
GROUP BY sl.roll_number, sl.student_name, sl.class,sl.section,sl.school_name;

--- Using Temp tables and solving the challenge., i also removed the where clause.
WITH sql_practice AS
( SELECT 
    sl.roll_number, sl.student_name, sl.class,sl.section,sl.school_name,
  sum (case when pc.subject = 'Math' and sr.option_marked = ca.correct_option and sr.option_marked <> 'e' then 1 else 0 end) as math_correct,
  sum (case when pc.subject = 'Math' and sr.option_marked <> ca.correct_option and sr.option_marked <> 'e' then 1 else 0 end) as math_wrong,
  sum (case when pc.subject = 'Math' and sr.option_marked = 'e' then 1 else 0 end) as math_yet_to_learn,
  sum (case when pc.subject = 'Science' and sr.option_marked = ca.correct_option and sr.option_marked <> 'e' then 1 else 0 end) as science_correct,
  sum (case when pc.subject = 'Science' and sr.option_marked <> ca.correct_option and sr.option_marked <> 'e' then 1 else 0 end) as science_wrong,
  sum (case when pc.subject = 'Science' and sr.option_marked = 'e' then 1 else 0 end) as Science_yet_to_learn,
  sum (case when pc.subject = 'Science' then 1 else 0 end) as science_total,
  sum (case when pc.subject = 'Math' then 1 else 0 end) as math_total,
  FROM   `practice22.sql_practice1.student_list` AS sl
  join   `practice22.sql_practice1.student_response` AS sr ON sr.roll_number=sl.roll_number 
  join   `practice22.sql_practice1.correct_answer` AS ca 
    ON ca.question_paper_code = sr.question_paper_code and ca.question_number = sr.question_number
  join   `practice22.sql_practice1.question_paper_code` AS pc ON pc.paper_code = ca.question_paper_code
  GROUP BY sl.roll_number, sl.student_name, sl.class,sl.section,sl.school_name
)
SELECT 
  roll_number,student_name,class,section,school_name,
  math_correct,math_wrong,math_yet_to_learn,math_correct AS math_score, round((math_correct/math_total)*100,2) AS math_percentage,
  science_correct,science_wrong,science_yet_to_learn,science_correct AS science_score, round((science_correct/science_total)*100,2) AS math_percentage,
FROM sql_practice;

--- Thank you.

