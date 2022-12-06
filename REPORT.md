# Database Final Report

Note: please read this document from the repository to have a pretty markdown: https://github.com/Nellousan/Database-Final/blob/main/REPORT.md

## The idea

For their studies, art student must learn to recognize famous work of art and must memorize various information about it, such as the author, date, and a
small description. These information about a piece of is called a Cartel.\
Our system's goal is to provide to teachers and students a flash-card system, where you would have an image of a piece of art on one side, and the corresponding
cartel.\
Our system provide the basics of an intranet built around the flash-card system.

## The repository files

- `tables.sql`: the script that creates all the tables.
- `inserts.sql`: the script that inserts some data to the tables.
- `notebook.ipynb`: the jupyter notebook (please note that we did not use colab, we work on our local machines)
- `erd.png`: this is the Entity Relation Diagram we made for the project.
- `REPORT.md`: this file.
- `Cartel Database.pdf`: our ppt presentation.
- `Cargo.lock`, `Cargo.toml`, `src/`, `docker-compose.yml`, `Dockerfile`, `pgtables.sql` : explained in the "Bonus" section below.

## The tables

We have a total of 9 tables:

- `User`: This is ou user class nothing special, the difference between a teacher is defined by the `role` field, 0 means student, 1 means teacher. We decided
to not separate teachers and student in 2 different tables because we think this would not be wise. On most website or system, the admin users are not separated
in another table, it is just a matter of permissions, so that is why we decided to keep teacher and student as Users.
- `Class`: This table is used to represent a course on our system. A course have a name and a teacher as a foreign key. 
- `Enrollment`: This is a many to many relationship to map Users(students) to Classes, representing the courses the student is enrolled to.
- `Session`: This table represents the different class session a course has, it has a one to many relationship from class to sessions
- `Document`: This table represent the documents attached to a session by the teacher (ie. class material). At first we thought about storing the document directly
in binary in the database, turns out this is bad practice and it is better to store a file path and the in the filesystem that storing the document directly in the
database.
- `SessionCards`: This is the many to many relationship between cards and session, a session can have multiple cards and a card can be used in multiple different
session.
- `Cards`: Represent the actual flash card, the point of the project, the cards contains an image and a cartel as foreign keys.
- `Image`: This is an image for the cards to have. Same as for the document: we only store a filepath to the image and not the image itself.
- `Cartel`: A cartel contains informations about a work of art, such as the author, date, description.

It is important for this kind of system to keep track of what is going on. For this purpose, our tables have the six following fields: `created_by`, `created_time`,
`updated_by`, `updated_time`, `deleted_by`, `deleted_time`.

## Bonus

As a bonus, I wanted to make use of an actual real database system, instead of only work with sqlite. I could have stuck with the idea of deployign a database and connecting to it via jupyter but i wanted something a little bit more sophisticated than this, and that use more technologies that are actually used in production.\
That is why i decided to make an http server with a very basic rest API that would allow to run query on the database using HTTP requests.

The stack used in this bonus is composed of:
- Rust: rust is a low level programming language known for its compile time features and security philosophy. I decided to go with rust because i wanted to learn this language
for quite a while now.
- Actix: actix is a powerful rust framework for making http servers.
- Postgresql: I decided to go with postgresql because I often see it on the tech stack of other applications so I wanted to give it a try.
- Docker: I made use of docker and docker-compose because it is a standard in the industry now, and it is actually simpler to use containers than installing the db on my
computer.

let's explain the roles of the different files real quick:
- `Cargo.toml`: cargo's configuration file (`cargo` is rust's package manager, like `pip` for python, if you will)
- `src/`: the rust source files, ie. the actual code of the HTTP server, thereis only one file, actually.
- `pgtables.sql`: I had to make slight modification to `tables.sql` for it to be compliant with postrgesql.
- `Dockerfile`: it is the file to tell Docker how to build the http server.
- `docker-compose.yml`: it is the `docker-compose` configuration file.

The feature of this bonus is very simple, we can send a POST request on the "/" route of the server, containing a SQL query in the body. The server will respond with the
result of the query, roughly formatted in a readable way.

Here is an example on how we can use `curl` to send a request to the server and see the response:
```
$ curl -X POST localhost:8080/ -d "SELECT * FROM \"User\";"
id: 1	role: 0	first_name: seraphin	last_name: perrot	email: seraphin.perrot@epitech.eu	password: PwInClearAreABadHabbitLol	created_by: 1	created_time: 8375 modified_by: NULL	modified_time: NULL deleted_by: NULL	deleted_time: NULL	
id: 2	role: 1	first_name: mehdi	last_name: pirahandeh	email: mehdi.pirahandeh@inha.kr	password: Password created_by: 2	created_time: 8375	modified_by: NULL	modified_time: NULL	deleted_by: NULL    deleted_time: NULL
```