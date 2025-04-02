CREATE TABLE grand_prix (
    gp_id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    fecha DATE NOT NULL,
    circuito VARCHAR(255) NOT NULL
);

CREATE TABLE Session_Type (
    session_type_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE Session (
    session_id SERIAL PRIMARY KEY,
    gp_id INT NOT NULL,
    session_type_id INT NOT NULL,
    date TIMESTAMP NOT NULL,
    FOREIGN KEY (gp_id) REFERENCES Grand_Prix(gp_id),
    FOREIGN KEY (session_type_id) REFERENCES Session_Type(session_type_id)
);

CREATE TABLE Video (
    video_id SERIAL PRIMARY KEY,
    Session_id INT UNIQUE NOT NULL,
    name TEXT,
    url TEXT NOT NULL,
    duration FLOAT NOT NULL,
    FOREIGN KEY (Session_id) REFERENCES Session(Session_id) 
);

CREATE TABLE Frame (
    frame_id SERIAL PRIMARY KEY,
    video_id INT NOT NULL,
    timestamp TIMESTAMP NOT NULL,
    FOREIGN KEY (video_id) REFERENCES Video(video_id) 
);

CREATE TABLE Team (
    team_id SERIAL PRIMARY KEY,
    name TEXT not null
);

CREATE TABLE Driver (
    driver_id SERIAL PRIMARY KEY,
    team_id INT NOT NULL,
    name TEXT not null,
    number INT not null,
    FOREIGN KEY (team_id) REFERENCES Team(team_id)
);

CREATE TABLE Onboard_Frame (
    onboard_id SERIAL PRIMARY KEY,
    frame_id INT NOT NULL,
    driver_id INT,
    timestamp TIMESTAMP NOT NULL,
    FOREIGN KEY (frame_id) REFERENCES Frame(frame_id),
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id) 
);

CREATE TABLE Drivereye_Frame (
    drivereye_id SERIAL PRIMARY KEY,
    frame_id INT NOT NULL,
    driver_id INT,
    timestamp TIMESTAMP NOT NULL,
    FOREIGN KEY (frame_id) REFERENCES Frame(frame_id),
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id)
);

CREATE TABLE Pitboost_Frame (
    pitboost_id SERIAL PRIMARY KEY,
    frame_id INT NOT NULL,
    driver_id INT,
    status INT,
    timestamp TIMESTAMP NOT NULL,
    FOREIGN KEY (frame_id) REFERENCES Frame(frame_id),
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id)
);

CREATE TABLE Wideshot_Frame (
    wideshot_id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP NOT NULL,
    video_url TEXT,
    duration FLOAT NOT NULL
);

CREATE TABLE Driver_Wideshot_Frame (
    driver_id INT NOT NULL,
    wideshot_id INT NOT NULL,
    PRIMARY KEY (driver_id, wideshot_id),
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id),
    FOREIGN KEY (wideshot_id) REFERENCES Wideshot_Frame(wideshot_id)
);

