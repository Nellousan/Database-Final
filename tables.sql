
----- User stuff -----

CREATE TABLE User (
    id int NOT NULL,
    role int, -- 0 = student, 1 = teacher, not using ENUM because it is not standard to SQLite
    first_name varchar(32),
    last_name varchar(32),
    email varchar(32) NOT NULL,
    password varchar(32) NOT NULL,
    
    created_by int,
    created_time datetime,
    modified_by int,
    modified_time datetime,
    deleted_by int,
    deleted_time datetime,
    
    FOREIGN KEY (created_by) REFERENCES User(id),
    FOREIGN KEY (modified_by) REFERENCES User(id),
    FOREIGN KEY (deleted_by) REFERENCES User(id),
    
    PRIMARY KEY (id)
);

-- O2M Teacher to Class 
CREATE TABLE Class (
    id int NOT NULL,
    teacher_id int NOT NULL,

    created_by int,
    created_time datetime,
    modified_by int,
    modified_time datetime,
    deleted_by int,
    deleted_time datetime,
    
    FOREIGN KEY (created_by) REFERENCES User(id),
    FOREIGN KEY (modified_by) REFERENCES User(id),
    FOREIGN KEY (deleted_by) REFERENCES User(id),

    FOREIGN KEY (teacher_id) REFERENCES User(id),
    
    PRIMARY KEY (id)
);

-- M2M Students to Classes
CREATE TABLE Enrollment (
    id int NOT NULL,
    student_id int NOT NULL,
    class_id int NOT NULL,
    
    created_by int,
    created_time datetime,
    modified_by int,
    modified_time datetime,
    deleted_by int,
    deleted_time datetime,
    
    FOREIGN KEY (created_by) REFERENCES User(id),
    FOREIGN KEY (modified_by) REFERENCES User(id),
    FOREIGN KEY (deleted_by) REFERENCES User(id),

    FOREIGN KEY (student_id) REFERENCES User(id),
    FOREIGN KEY (class_id) REFERENCES Class(id),
    
    PRIMARY KEY (id)
);

----- Session stuff -----

-- O2M Class to Sessions
CREATE TABLE Session (
    id int NOT NULL,
    class_id int NOT NULL,

    created_by int,
    created_time datetime,
    modified_by int,
    modified_time datetime,
    deleted_by int,
    deleted_time datetime,
    
    FOREIGN KEY (created_by) REFERENCES User(id),
    FOREIGN KEY (modified_by) REFERENCES User(id),
    FOREIGN KEY (deleted_by) REFERENCES User(id),

    FOREIGN KEY (class_id) REFERENCES Class(id),
    
    PRIMARY KEY (id)
);

-- O2M Session to Documents
CREATE TABLE Document (
    id int NOT NULL,
    filepath TEXT, -- Documents are stored in filesystem
    session_id int NOT NULL,

    created_by int,
    created_time datetime,
    modified_by int,
    modified_time datetime,
    deleted_by int,
    deleted_time datetime,
    
    FOREIGN KEY (created_by) REFERENCES User(id),
    FOREIGN KEY (modified_by) REFERENCES User(id),
    FOREIGN KEY (deleted_by) REFERENCES User(id),

    FOREIGN KEY (session_id) REFERENCES Session(id),
    
    PRIMARY KEY (id)
);

----- Cards stuff -----

-- O2O Artwork to Card
CREATE TABLE Artwork (
    id int NOT NULL,
    filepath TEXT,

    created_by int,
    created_time datetime,
    modified_by int,
    modified_time datetime,
    deleted_by int,
    deleted_time datetime,
    
    FOREIGN KEY (created_by) REFERENCES User(id),
    FOREIGN KEY (modified_by) REFERENCES User(id),
    FOREIGN KEY (deleted_by) REFERENCES User(id),
  
    PRIMARY KEY (id)
);

-- O2O Cartel to Card
CREATE TABLE Cartel (
    id int NOT NULL,
    author varchar(128),
    type varchar(32), -- Sculpture, paint, movie, etc..
    date varchar(32),
    description TEXT,

    created_by int,
    created_time datetime,
    modified_by int,
    modified_time datetime,
    deleted_by int,
    deleted_time datetime,
    
    FOREIGN KEY (created_by) REFERENCES User(id),
    FOREIGN KEY (modified_by) REFERENCES User(id),
    FOREIGN KEY (deleted_by) REFERENCES User(id),
  
    PRIMARY KEY (id)
);

-- Card table, referencing 1 Artwork and 1 Cartel
CREATE TABLE Card (
    id int NOT NULL,
    artwork_id int NOT NULL,
    cartel_id int NOT NULL,

    
    created_by int,
    created_time datetime,
    modified_by int,
    modified_time datetime,
    deleted_by int,
    deleted_time datetime,
    
    FOREIGN KEY (created_by) REFERENCES User(id),
    FOREIGN KEY (modified_by) REFERENCES User(id),
    FOREIGN KEY (deleted_by) REFERENCES User(id),

    FOREIGN KEY (artwork_id) REFERENCES Artwork(id),
    FOREIGN KEY (cartel_id) REFERENCES Cartel(id),
  
    PRIMARY KEY (id)
);

-- M2M Cards to Sessions, linking sessions and cards together
CREATE TABLE SessionCards(
    id int NOT NULL,
    card_id int NOT NULL,
    session_id int NOT NULL,

    created_by int,
    created_time datetime,
    modified_by int,
    modified_time datetime,
    deleted_by int,
    deleted_time datetime,
    
    FOREIGN KEY (created_by) REFERENCES User(id),
    FOREIGN KEY (modified_by) REFERENCES User(id),
    FOREIGN KEY (deleted_by) REFERENCES User(id),

    FOREIGN KEY (card_id) REFERENCES Card(id),
    FOREIGN KEY (session_id) REFERENCES Session(id),
  
    PRIMARY KEY (id)
);