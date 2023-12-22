SHOW databases;
USE SHASHANK;


DROP TABLE author;
CREATE TABLE author (email varchar(100) primary key ,first_name varchar(50) ,last_name varchar(50));
CREATE TABLE paper (id INT primary key auto_increment, title varchar(200), abstract text, file_name varchar(100), Contact_author text);
CREATE TABLE review (id INT primary key auto_increment, committee_comments text, author_comments text, recommendation varchar(100), scores int);
CREATE TABLE reviewer (r_email varchar(100) primary key, r_first_name varchar(50), r_last_name varchar(50), Ph varchar(20), Affiliation varchar(100), Topics_of_interest varchar(100));
CREATE TABLE topic (t_name varchar(50) primary key, description text);
ALTER TABLE topic
CHANGE COLUMN description description_text text;
ALTER TABLE paper
ADD INDEX idx_paper_id_title (id, title);


DROP TABLE writes;
-- CREATE TABLE writes (p_id INT, title varchar(200), author_f_name varchar(50), author_email varchar(100), foreign key (p_id) references paper(id),foreign key (title) references paper(title), foreign key (author_email) references author(email));
ALTER TABLE reviewer
ADD INDEX idx_reviewer_email_f_name (r_email, r_first_name);

DROP TABLE of_interests_for;
CREATE TABLE of_interests_for ( t_name varchar(50), r_email varchar(100), r_first_name varchar(50), foreign key (t_name) references topic(t_name), foreign key (r_email,r_first_name) references reviewer(r_email,r_first_name));
ALTER TABLE paper
ADD INDEX idx_paper_title_id (title, id);
CREATE TABLE generates ( score int, recommendation varchar(50), p_title varchar(100), p_id int, foreign key (p_title,p_id) references paper(title,id));


-- Now we are done with the creating of all the tables therefore now we move forward to populating them
DROP TABLE author;
CREATE TABLE author (email varchar(100) primary key ,first_name varchar(50) ,last_name varchar(50));
INSERT INTO author (email, first_name,last_name)
VALUES
('xx1', 'John', 'Doe'),
('xx2', 'Jane', 'Smith'),
('xx3', 'Michael', 'Johnson'),
('xx4', 'Emily', 'Williams'),
('xx5', 'David', 'Brown');

INSERT INTO paper (title, abstract, file_name)
VALUES
('Paper Title 1', 'Abstract for paper 1', 'paper1.pdf'),
('Paper Title 2', 'Abstract for paper 2', 'paper2.pdf'),
('Paper Title 3', 'Abstract for paper 3', 'paper3.pdf'),
('Paper Title 4', 'Abstract for paper 4', 'paper4.pdf'),
('Paper Title 5', 'Abstract for paper 5', 'paper5.pdf');

INSERT INTO review (committee_comments, author_comments, recommendation,scores)
VALUES 
('Positive review', 'Author comments on the review', 'Accept', 9),
('Neutral review', 'No specific comments', 'Neutral', 7),
('Negative review', 'Critical feedback provided', 'Reject', 5),
('Positive review', 'Author comments on the review', 'Accept', 8),
('Neutral review', 'No specific comments', 'Neutral', 6);

INSERT INTO reviewer (r_email, r_first_name, r_last_name, Ph, Affiliation)
VALUES
('reviewer1@gmail.com', 'Alice', 'Johnson', '123-456-7890', 'University A'),
('reviewer2@gmail.com', 'Bob', 'Smith', '987-654-3210', 'University B'),
('reviewer3@yahoo.in', 'Carol', 'Williams', '555-123-4567', 'University C'),
('reviewer4@hotmail.com', 'Daniel', 'Brown', '777-888-9999', 'University D'),
('reviewer5@gmail.com', 'Eva', 'Davis', '111-222-3333', 'University E');
SELECT * FROM reviewer;
INSERT INTO topic (t_name, description_text)
VALUES
('Technology', 'Articles related to technology and innovation'),
('Science', 'Scientific research and findings'),
('Environment', 'Environmental issues and conservation'),
('security', 'Cyber security'),
('Business', 'Business and economic trends');
DROP TABLE writes;
CREATE TABLE writes (p_id INT, title varchar(200), author_f_name varchar(50), author_email varchar(100), foreign key (p_id) references paper(id),foreign key (title) references paper(title), foreign key (author_email) references author(email));
INSERT INTO writes ( p_id,title, author_f_name,author_email)
VALUES 
('1','Paper Title 1','John','xx1'),
('2','Paper Title 2','Jane','xx2'),
('3','Paper Title 3','Michael','xx3'),
('4','Paper Title 4','Emily','xx4'),
('5','Paper Title 5','David','xx5');
SELECT * FROM writes;

INSERT INTO of_interests_for (t_name, r_email, r_first_name)
VALUES
    ('Technology', 'reviewer1@gmail.com', 'Alice'),
    ('Science', 'reviewer2@gmail.com', 'Bob'),
    ('Environment', 'reviewer3@yahoo.in', 'Carol'),
    ('security', 'reviewer4@hotmail.com', 'Daniel'),
    ('Business', 'reviewer5@gmail.com', 'Eva');
SELECT * FROM of_interests_for;
INSERT INTO generates (score, recommendation, p_title, p_id)
VALUES
    (8, 'Accept', 'Paper Title 1', 1),
    (7, 'Neutral', 'Paper Title 2', 2),
    (5, 'Reject', 'Paper Title 3', 3),
    (9, 'Accept', 'Paper Title 4', 4),
    (6, 'Neutral', 'Paper Title 5', 5);

SELECT * FROM paper;
-- now we are done with the populating the tables and all the tables are successfully created.

-- therefore now moving forward to retrieval of queries.

-- Query 1 :- Retrieve distinct and complete names and emails of the authors who have submitted at least one paper for review.

SELECT DISTINCT a.email, concat(a.first_name, ' ', a.last_name) AS full_name
FROM author a
INNER JOIN writes w ON a.email=w.author_email;

-- Query 2 :- Retrieve the email and id, title of the paper submitted by the author that has an average score of 7 or more on its review.

SELECT DISTINCT a.email, p.id, p.title
FROM author a
INNER JOIN writes w ON a.email = w.author_email
INNER JOIN generates g ON w.p_id = g.p_id
INNER JOIN paper p ON g.p_id = p.id
GROUP BY a.email, p.id, p.title
HAVING AVG(g.score) >= 7;


-- Query 3:- Retrieve the paper id, title, and score, which is the lowest in the review process received.
SELECT p.id, p.title, MIN(g.score) AS lowest_score
FROM paper p
INNER JOIN generates g ON p.id=g.p_id
GROUP BY p.id,p.title;

-- Query 4 :- Retrieve distinct emails and names of reviewers who are interested, typically in the topic “security.”

SELECT DISTINCT r.r_email, CONCAT(r.r_first_name, ' ', r.r_last_name) AS full_name
FROM reviewer r
INNER JOIN of_interests_for f ON r.r_email=f.r_email
INNER JOIN topic t ON f.t_name=t.t_name
WHERE t.t_name='security';

-- Query 5:- Retrieve the paper id and title of papers along with the author's name and email such that the author is also a reviewer.

SELECT p.id, p.title, CONCAT(a.first_name, ' ', a.last_name) AS author_name, a.email AS author_email
FROM paper p
INNER JOIN writes w ON w.p_id=p.id
INNER JOIN author a ON w.author_email=a.email
INNER JOIN reviewer r ON a.email=r.r_email;











