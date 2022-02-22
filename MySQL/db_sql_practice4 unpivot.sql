USE Practice;

DROP TABLE IF EXISTS course_grade_pivoted;
CREATE TABLE course_grade_pivoted AS
SELECT
  name
  ,MAX(CASE WHEN course = 'CS106B' THEN grade ELSE NULL END) AS 'CS106B'
  ,MAX(CASE WHEN course = 'CS229' THEN grade ELSE NULL END) AS 'CS229'
  ,MAX(CASE WHEN course = 'CS224N' THEN grade ELSE NULL END) AS 'CS224N'
FROM CourseGrade
GROUP BY name;

USE Grocery;
DROP TABLE IF EXISTS expenses_pivoted;
CREATE TABLE expenses_pivoted AS
SELECT
  category
  ,SUM(CASE WHEN EXTRACT(MONTH FROM time) = 12 THEN cost ELSE 0 END) AS 'Dec_'
  ,SUM(CASE WHEN EXTRACT(MONTH FROM time) = 11 THEN cost ELSE 0 END) AS 'Nov'
  ,SUM(CASE WHEN EXTRACT(MONTH FROM time) = 10 THEN cost ELSE 0 END) AS 'Oct'
  ,SUM(CASE WHEN EXTRACT(MONTH FROM time) = 09 THEN cost ELSE 0 END) AS 'Sep'
  ,SUM(CASE WHEN EXTRACT(MONTH FROM time) = 08 THEN cost ELSE 0 END) AS 'Aug'
  ,SUM(CASE WHEN EXTRACT(MONTH FROM time) = 07 THEN cost ELSE 0 END) AS 'Jul'
  ,SUM(CASE WHEN EXTRACT(MONTH FROM time) = 06 THEN cost ELSE 0 END) AS 'Jun'
  ,SUM(CASE WHEN EXTRACT(MONTH FROM time) = 05 THEN cost ELSE 0 END) AS 'May'
  ,SUM(CASE WHEN EXTRACT(MONTH FROM time) = 04 THEN cost ELSE 0 END) AS 'Apr'
  ,SUM(CASE WHEN EXTRACT(MONTH FROM time) = 03 THEN cost ELSE 0 END) AS 'Mar'
  ,SUM(CASE WHEN EXTRACT(MONTH FROM time) = 02 THEN cost ELSE 0 END) AS 'Feb'
  ,SUM(CASE WHEN EXTRACT(MONTH FROM time) = 01 THEN cost ELSE 0 END) AS 'Jan'
FROM Expenses
GROUP BY category;