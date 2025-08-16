--Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

SELECT *
FROM books
INSERT INTO books
VALUES 
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')

--Update an Existing Member's Address

SELECT *
FROM members

UPDATE members
SET member_address = '125 Main St'
WHERE member_id = 'C101'

--Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
SELECT *
FROM issued_status

DELETE FROM issued_status
WHERE issued_id = 'IS121'


--Retrieve All Books Issued by a Specific Employee
--Select all books issued by the employee with emp_id = 'E101'.
SELECT *
FROM employees
WHERE  emp_id = 'E101'

--List Members Who Have Issued More Than One Book
--Use GROUP BY to find members who have issued more than one book.
SELECT 
	issued_emp_id, 
	COUNT(issued_id)
FROM issued_status
GROUP BY issued_emp_id
HAVING COUNT(issued_id) > 1

--Create Summary Tables: 
--Used CTAS(create table as select statement) to generate new tables based on query results 
-- each book and total book_issued_cnt**
CREATE TABLE book_counts
AS
SELECT 
	b.book_title,
	count(i.issued_id) as no_issued
FROM books as b
JOIN 
issued_status as i
on b.isbn = i.issued_book_isbn
GROUP BY 1
ORDER BY 2 DESC;

SELECT *
FROM book_counts

--Retrieve All Books in a Specific Category:
SELECT*
FROM BOOKS
WHERE category = 'Literary Fiction'


--Total Rental Income by Category:
SELECT 
b.category,
count(i.issued_id),
COALESCE(SUM(b.rental_price),0) as total_revenue
FROM books as b
LEFT JOIN
issued_status as i
on b.isbn = i.issued_book_isbn 
GROUP BY 1
ORDER BY 3 DESC

--List Members Who Registered in the Last 1600 Days:
SELECT *
FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '1600 days'

--List Employees with Their Branch Manager's Name and their branch details:
SELECT 
    e1.emp_id,
    e1.emp_name,
    e1.position,
    e1.salary,
    b.*,
    e2.emp_name as manager
FROM employees as e1
JOIN 
branch as b
ON e1.branch_id = b.branch_id    
JOIN
employees as e2
ON e2.emp_id = b.manager_id


--Create a Table of Books with Rental Price Above a Certain Threshold
DROP TABLE  IF EXISTS high_books_price;
CREATE TABLE high_books_price
AS
SELECT *
FROM books
WHERE rental_price > 7

--Retrieve the List of Books Not Yet Returned

SELECT i.*
FROM issued_status AS i
LEFT JOIN
return_status AS r
ON i.issued_id = r.issued_id
WHERE r.issued_id IS NULL;








