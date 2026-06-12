Create Database Librarys;
use librarys;

show databases;

CREATE TABLE publisher (
    publisher_PublisherName VARCHAR(255) PRIMARY KEY,
    publisher_PublisherAddress TEXT,
    publisher_PublisherPhone VARCHAR(15)
);
select * from publisher;

-- Table: tbl_book
CREATE TABLE books (
    book_BookID INT PRIMARY KEY,
    book_Title VARCHAR(255),
    book_PublisherName VARCHAR(255),
    FOREIGN KEY (book_PublisherName) REFERENCES publisher(publisher_PublisherName)
);
select*from books;

-- Table: tbl_book_authors
CREATE TABLE authors (
    book_authors_BookID INT PRIMARY KEY AUTO_INCREMENT,
    book_authors_AuthorName VARCHAR(255),
    FOREIGN KEY (book_authors_BookID) REFERENCES books(book_BookID)
);
select*from authors;

-- Table: library_branch
create table if not exists library_branch (
library_branch_BranchID INT PRIMARY KEY auto_increment,
library_branch_BranchName VARCHAR(255),
library_branch_BranchAddress TEXT
);
select*from library_branch;

-- Table: tbl_book_copies
create table  book_copies (
-- book_copies_CopiesID INT PRIMARY KEY AUTO_INCREMENT,
book_copies_BookID INT,
book_copies_BranchID INT,
book_copies_No_Of_Copies INT,
FOREIGN KEY (book_copies_BookID) REFERENCES books(book_Bookid),
FOREIGN KEY (book_copies_BranchID) REFERENCES library_branch(library_branch_BranchID)
);

select*from book_copies;


-- Table: tbl_borrower
CREATE TABLE borrower (
    borrower_CardNo INT PRIMARY KEY,
    borrower_BorrowerName VARCHAR(255),
    borrower_BorrowerAddress TEXT,
    borrower_BorrowerPhone VARCHAR(15)
);

select*from borrower;
-- Table: tbl_book_loans
CREATE TABLE book_loans (
    book_loans_BookID INT primary key,
    book_loans_BranchID INT,
    book_loans_CardNo INT,
    book_loans_DateOut DATE,
    book_loans_DueDate DATE,
    FOREIGN KEY (book_loans_BookID) REFERENCES books(book_BookID),
    
    FOREIGN KEY (book_loans_CardNo) REFERENCES borrower(borrower_CardNo)
);


select*from library_branch;				
select*from publisher;
select*from books;
select*from book_copies;
select*from book_loans;
select*from borrower;
select*from authors;




create table book_copies (
book_copies_CopiesID INT PRIMARY KEY AUTO_INCREMENT,
book_copies_BookID INT,
book_copies_BranchID INT,
book_copies_No_Of_Copies INT,
FOREIGN KEY (book_copies_BookID) REFERENCES books(book_BookID),
FOREIGN KEY (book_copies_BranchID) REFERENCES library_branch(library_branch_BranchID)
);
select*from book_copies;







#********************************************************************************************************************************************************

-- 1.How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?

SELECT b.book_title, lb.library_branch_BranchName, bc.book_copies_No_Of_Copies
FROM book_copies AS bc
JOIN books AS b
ON b.book_BookID = bc.book_copies_BookID
JOIN library_branch AS lb
ON lb.library_branch_BranchID = bc.book_copies_BranchID
WHERE b.book_title = "The Lost Tribe"
AND lb.library_branch_BranchName = "Sharpstown";

#*****************************************************************************************************************************************************************

-- 2. How many copies of the book titled "The Lost Tribe" are owned by each library branch?

select b.book_title,lb.library_branch_BranchName,bc.book_copies_no_of_copies
from book_copies as bc
join books as b
on bc.book_copies_BookID = b.book_BookID
join library_branch as lb
ON bc.book_copies_BranchID = lb.library_branch_BranchID
where b.Book_title = "The Lost Tribe";




#*****************************************************************************************************************************************************************

-- 3.Retrieve the names of all borrowers who do not have any books checked out.

SELECT b.borrower_BorrowerName,
       b.borrower_CardNo,
       bl.book_loans_CardNo
FROM borrower b
LEFT JOIN book_loans bl
ON b.borrower_CardNo = bl.book_loans_CardNo
WHERE bl.book_loans_CardNo IS NULL;

#********************************************************************************************************************************************************************

-- 4 For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, retrieve the book title, the borrower's name, and the borrower's address. 

SELECT b.book_Title,
       br.borrower_BorrowerName,
       br.borrower_BorrowerAddress
FROM books b
JOIN book_loans bl
ON b.book_BookID = bl.book_loans_BookID
JOIN borrower br
ON bl.book_loans_CardNo = br.borrower_CardNo
JOIN library_branch lb
ON bl.book_loans_BranchID = lb.library_branch_BranchID
WHERE lb.library_branch_BranchName = 'Sharpstown'
AND bl.book_loans_DueDate = '0002-03-18';




#******************************************************************************************************************************************************************

-- 5.For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
select lb. library_branch_BranchID, lb.library_branch_BranchName,count(bl.book_loans_BookID) as totalbookloans
from library_branch as lb
left join book_loans as bl 
on lb.library_branch_BranchId = bl.book_loans_BranchID
group by lb. library_branch_BranchID;


#**************************************************************************************************************************************************************

-- 6.Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.

select br.borrower_BorrowerName,br.borrower_BorrowerAddress, count(bl.book_loans_BookId) as bookscheck
from borrower as br
inner join book_loans as bl on br.borrower_CardNo = bl.book_loans_CardNo
group by br.borrower_CardNo ,br.borrower_BorrowerName,br.borrower_BorrowerAddress
having count(bl.book_loans_BookID) >5;
  
  
  



#*******************************************************************************************************************************************************************

-- 7 For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".
-- select a.book_authors_authorName,

SELECT b.book_title, 
       bc.book_copies_No_Of_Copies AS NumberOfCopies, 
       ba.book_authors_AuthorName, 
       lb.library_branch_BranchName
FROM books AS b
JOIN authors AS ba 
    ON b.book_BookID = ba.book_authors_BookID
JOIN book_copies AS bc 
    ON b.book_BookID = bc.book_copies_BookID
JOIN library_branch AS lb 
    ON bc.book_copies_BranchID = lb.library_branch_BranchID
WHERE ba.book_authors_AuthorName = 'Stephen King'
AND lb.library_branch_BranchName = 'Central';