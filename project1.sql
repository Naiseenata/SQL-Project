create database library;
use library;
create table Branch(Branch_no int primary key,Manager_id int,
Branch_address varchar(100),contact_no int);
insert into branch values(1,1001,"Ernakulam",898392786);
insert into branch values(2,1002,"Trissur",927765655);
insert into branch values(3,1003,"Kollam",932763257);
insert into branch values(4,1004,"Alappuzha",937487473);
insert into branch values(5,1005,"Idukki",974823475);
insert into branch values(1,1006,"Ernakulam",956456456);
insert into branch values(1,1007,"Ernakulam",942323234);
insert into branch values(3,1008,"Kollam",9425436545);
insert into branch values(5,1009,"Idukki",978675645);
select * from Branch;


create table Employee(Emp_id int primary key,Emp_name varchar(30),
Position varchar(30),Salary decimal(10,3));
insert into Employee values(1001,"Kiran Kumar","Manager",55000);
insert into Employee values(1002,"Jyothi S","Assistant Manager",50500);
insert into Employee values(1003,"Hari KP","Librarian",28625);
insert into Employee values(1004,"Sneha Shekhar","Clerk",25000);
insert into Employee values(1005,"John Paul","Clerk",25000);
select * from Employee;

create table Customer(Customer_id int primary key,Customer_name varchar(30),
Customer_address varchar(30),Reg_date date);
insert into Customer values(1,"Jeny John","ABC street","2020-12-11");
insert into Customer values(2,"Jilu Benny","PQR street","2022-4-2");
insert into Customer values(3,"Nathanel P","KLM street","2021-1-22");
insert into Customer values(4,"Adam Aali Imran","STU street","2023-6-5");
insert into Customer values(5,"Riyana Sreedhar","MNO street","2022-2-13");
insert into Customer values(6,"Shabin K S","BNM street","2020-7-11");
insert into Customer values(7,"Kiran Das","ASD street","2021-5-10");
select * from Customer;

create table IssueStatus(Issue_id int primary key,Issued_cust int,Issued_book_name varchar(30),
Issue_date date,Isbn_book varchar(20),foreign key(Issued_cust) references Customer(Customer_id),
foreign key(Isbn_book) references Books(Isbn));
insert into IssueStatus values(1,1,"book1","2020-12-21","ISBN123456");
insert into IssueStatus values(2,2,"book2","2022-4-12","ISBN789012");
insert into IssueStatus values(3,3,"book3","2021-1-30","ISBN456789");
insert into IssueStatus values(4,4,"book4","2023-6-15","ISBN234567");
insert into IssueStatus values(5,5,"book5","2022-2-13","ISBN901234");
select * from IssueStatus;

create table ReturnStatus(Return_id int,Return_cust int,Return_book_name varchar(30),
 Return_date date,Isbn_book2 varchar(20),foreign key(Isbn_book2) references Books(Isbn));
insert into ReturnStatus values(1,1,"book1","2020-12-31","ISBN123456");
insert into ReturnStatus values(2,2,"book2","2022-4-22","ISBN789012");
insert into ReturnStatus values(3,3,"book3","2021-2-10","ISBN456789");
insert into ReturnStatus values(4,4,"book4","2023-6-25","ISBN234567");
insert into ReturnStatus values(5,5,"book5","2022-2-23","ISBN901234");
select * from ReturnStatus;

create table Books(ISBN varchar(20) primary key,Book_title varchar(30),
Category varchar(30),Rental_Price decimal(10,3),Status_ varchar(5),Author varchar(20),
Publisher varchar(30));
insert into Books values("ISBN123456","Book1","Thriller",10,"YES","Author1","Publisher1");
insert into Books values("ISBN789012","Book2","Fiction",12.5,"YES","Author2","Publisher2");
insert into Books values("ISBN456789","Book3","Romance",8.45,"NO","Author3","Publisher3");
insert into Books values("ISBN234567","Book4","Thriller",11,"YES","Author4","Publisher4");
insert into Books values("ISBN901234","Book5","Mystery",12,"NO","Author5","Publisher5");
insert into Books values("ISBN354355","Book6","History",10,"YES","Author6","Publisher6");
insert into Books values("ISBN565454","Book7","History",11.50,"YES","Author7","Publisher7");
select * from Books;

-- 1) Retrieve the book title, category, and rental price of all available books
select Book_title,Category,Rental_Price from Books where Status_="YES";


-- 2) List the employee names and their respective salaries in descending order of salary. 
select Emp_name,Salary from Employee order by Salary desc;


-- 3)  Retrieve the book titles and the corresponding customers who have issued those books.
select Book_title,Customer_name from IssueStatus join books on IssueStatus.Isbn_book = books.ISBN
join customer on IssueStatus.Issued_cust = customer.customer_id;


-- 4) Display the total count of books in each category. 
select Category, count(*) as Total_Count from Books group by Category;


-- 5) Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000. 
select Emp_name,Position from Employee where Salary>50000;


-- 6) List the customer names who registered before 2022-01-01 and have not issued any books yet.
select Customer_name from Customer where Reg_date<"2022-01-01" and 
Customer_id not in(select Issued_cust from IssueStatus);


-- 7) Display the branch numbers and the total count of employees in each branch.
 set sql_safe_updates=0;
alter table branch add column Employee_Count int;
update branch set Employee_Count=floor(rand()*15)+1;
select Branch_no,Employee_Count as Total_Count_Of_Employees from Branch;


-- 8)Display the names of customers who have issued books in the month of June 2023
select Customer_name from Customer join IssueStatus on Customer.Customer_id= IssueStatus.Issued_Cust
where month(Issue_Date)= 6 and year(Issue_Date)= 2023;


-- 9) Retrieve book_title from book table containing history. 
select Book_Title from Books where Category="History";


-- 10) Retrieve the branch numbers along with the count of employees for branches 
-- having more than 5 employees.
select Branch_no,Employee_Count as Total_Count_Of_Employees from Branch where employee_Count>5;