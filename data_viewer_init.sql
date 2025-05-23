CREATE TABLE grand_prix (
    gp_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    circuit VARCHAR(255) NOT NULL
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
    session_id INT UNIQUE NOT NULL,
    name TEXT,
    url TEXT NOT NULL,
    duration FLOAT NOT NULL,
    total_frames int not null,
    status TEXT not null,
    FOREIGN KEY (session_id) REFERENCES Session(session_id)
);

CREATE TABLE Frame (
    frame_id SERIAL PRIMARY KEY,
    video_id INT NOT NULL,
    seq INT NOT NULL,
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
    onboard_frame_id SERIAL PRIMARY KEY,
    frame_id INT NOT NULL,
    driver_id INT,
    timestamp TIMESTAMP NOT NULL,
    FOREIGN KEY (frame_id) REFERENCES Frame(frame_id),
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id)
);

CREATE TABLE Drivereye_Frame (
    drivereye_frame_id SERIAL PRIMARY KEY,
    frame_id INT NOT NULL,
    driver_id INT,
    timestamp TIMESTAMP NOT NULL,
    FOREIGN KEY (frame_id) REFERENCES Frame(frame_id),
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id)
);

CREATE TABLE Pitboost_Frame (
    pitboost_frame_id SERIAL PRIMARY KEY,
    frame_id INT NOT NULL,
    status INT,
    timestamp TIMESTAMP NOT NULL,
    FOREIGN KEY (frame_id) REFERENCES Frame(frame_id)
);

CREATE TABLE Pitboost_frame_Driver (
    pitboost_frame_id INT NOT NULL,
    driver_id INT NOT NULL,
    PRIMARY KEY (pitboost_frame_id, driver_id),
    FOREIGN KEY (pitboost_frame_id) REFERENCES Pitboost_Frame(pitboost_frame_id) ON DELETE CASCADE,
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id) ON DELETE CASCADE
);


CREATE TABLE Wideshot_Frame (
    wideshot_frame_id SERIAL PRIMARY KEY,
    frame_id INT NOT NULL,
    timestamp TIMESTAMP NOT NULL,
    video_url TEXT,
    duration FLOAT NOT NULL,
    FOREIGN KEY (frame_id) REFERENCES Frame(frame_id)
);

CREATE TABLE Wideshot_Frame_Driver (
    driver_id INT NOT NULL,
    wideshot_frame_id INT NOT NULL,
    PRIMARY KEY (driver_id, wideshot_frame_id),
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id),
    FOREIGN KEY (wideshot_frame_id) REFERENCES Wideshot_Frame(wideshot_frame_id)
);

