
----- User stuff -----

INSERT INTO "User" (
    id,
    role,
    first_name,
    last_name,
    email,
    password,
    
    created_by,
    created_time
)
VALUES (
    1,
    0,
    'seraphin',
    'perrot',
    'seraphin.perrot@epitech.eu',
    'PwInClearAreABadHabbitLol',
    
    1,
    CURRENT_TIMESTAMP
);

INSERT INTO "User" (
    id,
    role,
    first_name,
    last_name,
    email,
    password,
    
    created_by,
    created_time
)
VALUES (
    2,
    1,
    'mehdi',
    'pirahandeh',
    'mehdi.pirahandeh@inha.kr',
    'Password',
    
    2,
    CURRENT_TIMESTAMP
);

-- O2M Teacher to Class 
INSERT INTO "Class" (
    id,
    class_name,
    teacher_id,

    created_by,
    created_time
)
VALUES (
    1,
    'Database',
    2,

    1,
    CURRENT_TIMESTAMP
);

INSERT INTO "Class" (
    id,
    class_name,
    teacher_id,

    created_by,
    created_time
)
VALUES (
    2,
    'Embedded System',
    2,

    1,
    CURRENT_TIMESTAMP
);


-- M2M Students to Classes
INSERT INTO "Enrollment" (
    id,
    student_id,
    class_id,

    created_by,
    created_time
)
VALUES (
    1,
    1,
    1,

    1,
    CURRENT_TIMESTAMP
);

----- Session stuff -----

-- O2M Class to Sessions
INSERT INTO "Session" (
    id,
    session_name,
    class_id,

    created_by,
    created_time
)
VALUES (
    1,
    'Week 1',
    1,

    1,
    CURRENT_TIMESTAMP
);

INSERT INTO "Session" (
    id,
    session_name,
    class_id,

    created_by,
    created_time
)
VALUES (
    2,
    'Week 1',
    2,

    1,
    CURRENT_TIMESTAMP
);

INSERT INTO "Session" (
    id,
    session_name,
    class_id,

    created_by,
    created_time
)
VALUES (
    3,
    'Week 2',
    1,

    1,
    CURRENT_TIMESTAMP
);

-- O2M Session to Documents
INSERT INTO "Document" (
    id,
    filepath,
    session_id,

    created_by,
    created_time
)
VALUES (
    1,
    '~/Documents/Ukiyo-e/TheGreatWaveOffKanagawa.png',
    1,

    1,
    CURRENT_TIMESTAMP
);

----- Cards stuff -----

-- O2O Artwork to Card
INSERT INTO "Artwork" (
    id,
    filepath,

    created_by,
    created_time
)
VALUES (
    1,
    '~/Artworks/Ukiyo-e/TheGreatWaveOffKanagawa.png',

    1,
    CURRENT_TIMESTAMP
);

-- O2O Cartel to Card
INSERT INTO "Cartel" (
    id,
    author,
    type,
    date,
    description,

    created_by,
    created_time
)
VALUES (
    1,
    'katsushika hokusai',
    'woodblock print', -- Sculpture, paint, movie, etc..
    '1831',
    'description TEXT',

    1,
    CURRENT_TIMESTAMP
);

-- Card table, referencing 1 Artwork and 1 Cartel
INSERT INTO "Card" (
    id,
    artwork_id,
    cartel_id,

    created_by,
    created_time
)
VALUES (
    1,
    1,
    1,

    1,
    CURRENT_TIMESTAMP
);

-- Card table, referencing 1 Artwork and 1 Cartel
INSERT INTO "Card" (
    id,
    artwork_id,
    cartel_id,

    created_by,
    created_time
)
VALUES (
    2,
    1,
    1,

    1,
    CURRENT_TIMESTAMP
);

-- M2M Cards to Sessions, linking sessions and cards together
INSERT INTO "SessionCards" (
    id,
    card_id,
    session_id,

    created_by,
    created_time
)
VALUES (
    1,
    1,
    1,

    1,
    CURRENT_TIMESTAMP
);

-- M2M Cards to Sessions, linking sessions and cards together
INSERT INTO "SessionCards" (
    id,
    card_id,
    session_id,

    created_by,
    created_time
)
VALUES (
    2,
    2,
    1,

    1,
    CURRENT_TIMESTAMP
);