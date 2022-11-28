# Monday November 28, 2022
I just finished Course 5 0f 8 on coursera google certificate course (Course: Analyze Data to Answer Questions). Pause for a while to practice SQL querries.
I came accross this problem: SQL Interview Query for Data Analyst online, I downloaded the CSV files, uploaded them on Bigquerry to try solve the challenge.

#THE CHALLENGE
Data Analytics Intern – Task 1

We conduct Olympiad exam for our partner schools every year to evaluate the standard of the students. Here we have provided you with the sample data for the exam. To get a proper insight about the exam you need all the 4 tables, data for all those 4 tables are given in the csv file. 

List of tables:
Student_list
Student_response
Correct_answers
Question_paper_code

Table 1: student_list - List of students who attended the Olympiad exam from Google Public School.
Table 2: student_response - The Learn Basics Olympiad is an objective exam, student response for every question was recorded in this table.
5 options ("A', 'B', 'C, 'D' and 'E') are provided for each question
Out of 5 options only "A', 'B', 'C' and D' are the valid options, students can pick E' option when they think they haven't learnt the concept yet.
Table 3: correct_answers - This table has the correct answer for all the questions in math and science.
Table 4: question_paper_code - Since we are dealing with 3 classes and 2 subjects, we are maintaining a separate question paper code for each class and each subject.

Required output of task 1:
Now, the objective is to validate the student response and present it in a single table with list of columns mentioned below using SQL. 
Required output table with column data,

OUTPUT_TABLE_COLUMN_NAMES
Roll_number
Student_name
Class
Section
School_name
Math_correct
Math_wrong
Math_yet_to_learn
Math_score
Math_percentage
Science_correct
Science_wrong
Science_yet_learn
Science_score
Science_percentage
