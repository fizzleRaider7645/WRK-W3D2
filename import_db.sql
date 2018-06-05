DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
  
);

DROP TABLE if exists questions;
  
CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,
  
  
  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE if exists question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE if exists replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,
  
  
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);

DROP TABLE if exists question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Doug', 'Uretsky'),
  ('Derick', 'Castillo');

INSERT INTO
  questions(title, body, author_id)
VALUES
  ('Question 1', 'body of question 1', 1),
  ('Question 2', 'body of question 2', 2);


INSERT INTO
  question_follows(user_id, question_id)
VALUES
  (1, 1),
  (2, 2),
  (1, 2);
  
  INSERT INTO
    replies(body, user_id, question_id, parent_reply_id)
  VALUES
  ('reply from doug about question 1', 1, 1,1),
  ('reply from derick about question 1', 2, 1,2),
  ('reply from doug about queston 2',1, 2,1);
  
  INSERT INTO
    question_likes(question_id, user_id)
  VALUES
  (1, 1),
  (2, 1),
  (1, 2);
  
