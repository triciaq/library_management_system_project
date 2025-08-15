--library management system
--create branch table
DROP TABLE IF EXISTS branch;
CREATE TABLE branch
			(branch_id VARCHAR(20) PRIMARY KEY,
			manager_id VARCHAR(20) ,
		   branch_address VARCHAR(50),
		   contact_no VARCHAR(20)
);

--insert values
COPY branch 
FROM 'D:\projects\ZERO\branch.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
	emp_id VARCHAR(20) PRIMARY KEY ,
	emp_name VARCHAR(50),
	position VARCHAR(20),
	salary FLOAT,
	branch_id VARCHAR(20)
);

--insert values
COPY employees 
FROM 'D:\projects\ZERO\employees.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS books;
CREATE TABLE books(
	isbn VARCHAR(30) PRIMARY KEY,
	book_title VARCHAR(200),
	category VARCHAR(100),
	rental_price FLOAT,
	status VARCHAR(100),
	author VARCHAR(200),
	publisher VARCHAR(200)
);

--insert values
COPY books 
FROM 'D:\projects\ZERO\books.csv'
DELIMITER ','
CSV HEADER;


DROP TABLE IF EXISTS issued_status;
CREATE TABLE issued_status(
	issued_id VARCHAR(100) PRIMARY KEY,
	issued_member_id VARCHAR(100),
	issued_book_name VARCHAR(200),
	issued_date DATE,
	issued_book_isbn VARCHAR(100),
	issued_emp_id VARCHAR(100)
);

--insert values
COPY issued_status 
FROM 'D:\projects\ZERO\issued_status.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS members;
CREATE TABLE members(
	member_id VARCHAR(100) PRIMARY KEY,
	member_name VARCHAR(100),
	member_address VARCHAR(100),
	reg_date DATE
);

--insert values
COPY members 
FROM 'D:\projects\ZERO\members.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS return_status;
CREATE TABLE return_status(
		return_id VARCHAR(50),
		issued_id VARCHAR(50),
		return_book_name VARCHAR(50),
		return_date DATE,
		return_book_isbn VARCHAR(50)
		)

--insert values
COPY return_status 
FROM 'D:\projects\ZERO\return_status.csv'
DELIMITER ','
CSV HEADER;		

--add primary key
ALTER TABLE return_status
ADD CONSTRAINT return_status_pkey PRIMARY KEY (return_id);

--foreign keys
ALTER TABLE issued_status
ADD CONSTRAINT members_fk
FOREIGN KEY (issued_member_id)
REFERENCES members(member_id);


ALTER TABLE books
ADD CONSTRAINT books_fk
FOREIGN KEY (issued_book_isbn)
REFERENCES books(isbn);

ALTER TABLE issued_status
ADD CONSTRAINT issued_status_fk
FOREIGN KEY (issued_book_isbn)
REFERENCES books(isbn);

ALTER TABLE issued_status
ADD CONSTRAINT fk_employees
FOREIGN KEY (issued_emp_id)
REFERENCES employees(emp_id);

ALTER TABLE employees
ADD CONSTRAINT fk_branch
FOREIGN KEY (branch_id)
REFERENCES branch(branch_id);

ALTER TABLE return_status
ADD CONSTRAINT fk_issued_status
FOREIGN KEY (issued_id)
REFERENCES issued_status(issued_id);

 
