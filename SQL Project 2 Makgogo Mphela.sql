create database project2;
set sql_safe_updates=0;
use project2;
select * from author_table;
select * from book_table;
select * from books;


-- The author who has written the most books in the database.
select authors, count(bookID) as book_count
from books
group by authors
order by book_count desc
limit 1;


-- using author_table and book_table Total number of pages written by each author
alter table author_table
add num_pages int;

update author_table
join book_table on author_table.title = book_table.title
set author_table.num_pages = book_table.num_pages;

SELECT authors AS author,SUM(num_pages) AS total_pages
FROM author_table
GROUP BY authors
ORDER BY total_pages DESC;

-- OR
-- using only books table to find Total number of pages written by each author
SELECT authors AS author, SUM(num_pages) AS total_pages
FROM books
GROUP BY authors
ORDER BY total_pages DESC;

-- From books table take ‘average rating’ and put it into author table.
ALTER TABLE author_table
ADD average_rating decimal(10,2);

update author_table
join books on  author_table.title = books.title
set author_table.average_rating = books.average_rating;

select * from author_table;


-- List the book titles that are available in more than one language.
SELECT title FROM books
GROUP BY title
HAVING COUNT(DISTINCT language_code) > 1;

-- The year with the highest average page count.
SELECT (publication_date) AS year, AVG(num_pages) AS avg_pages
FROM books
GROUP BY publication_date
ORDER BY avg_pages DESC
LIMIT 1;

-- OR
-- convert publication date to corect format date year-month-day
SELECT DATE_FORMAT(publication_date, '%Y/%m/%d') AS reformatted_date
FROM books
WHERE publication_date IS NOT NULL
  AND publication_date != ''
  AND STR_TO_DATE(publication_date, '%Y-%m-%d') IS NOT NULL;
  
-- extract a year from publication_date on books table to book_table
ALTER TABLE book_table
ADD year_publish INT;

UPDATE book_table
SET year_publish = (
    SELECT EXTRACT(YEAR FROM publication_date)
    FROM books
    WHERE book_table.bookid = books.bookid
);


-- The publisher with the most books published in a language other than English.
WITH NonEnglishBooks AS (
    SELECT publisher, language_code,
           ROW_NUMBER() OVER(PARTITION BY publisher ORDER BY COUNT(*) DESC) AS rn
    FROM books
    WHERE language_code != 'eng' and language_code != 'en-US' and language_code != 'en-GB'
    GROUP BY publisher, language_code
)
SELECT publisher, language_code
FROM NonEnglishBooks
WHERE rn = 1;





 

