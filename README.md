# Library Management System (MySQL)
A relational database project for managing library operations — books, authors, publishers, branches, borrowers, and loans — implemented in MySQL with sample analytical queries.
# Overview
This project demonstrates database design and SQL querying skills through a real-world scenario: a multi-branch library system that tracks book inventory, borrower records, and loan transactions.
Database Schema

# The system consists of the following tables:
publisher – Publisher name, address, and phone number
books – Book ID, title, and associated publisher
authors – Maps authors to books
library_branch – Branch ID, name, and address
book_copies – Number of copies of each book available at each branch
borrower – Borrower card number, name, address, and phone
book_loans – Tracks which books are loaned, to whom, from which branch, and due dates

# Entity Relationships

A book belongs to one publisher
A book can have multiple authors
A book can have multiple copies across multiple branches
A borrower can have multiple active loans
Each loan is tied to a book, branch, and borrower

# Sample Queries Included

Find the number of copies of a specific book at a specific branch
Find the number of copies of a specific book across all branches
List borrowers who currently have no books checked out
Get loan details (book, borrower, address) for a branch with a specific due date
Get total number of books loaned out per branch
List borrowers with more than 5 books checked out
List books by a specific author and their copy count at a specific branch



# Future Improvements

Add sample data (INSERT statements) for testing
Fix duplicate table definitions and primary key constraints
Add indexes for performance optimization
Build a front-end interface (e.g., using Python/Flask or Java)


