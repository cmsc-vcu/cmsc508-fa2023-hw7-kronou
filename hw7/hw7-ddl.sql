# hw7-ddl.sql

## DO NOT RENAME OR OTHERWISE CHANGE THE SECTION TITLES OR ORDER.
## The autograder will look for specific code sections. If it can't find them, you'll get a "0"

# Code specifications.
# 0. Where there a conflict between the problem statement in the google doc and this file, this file wins.
# 1. Complete all sections below.
# 2. Table names must MATCH EXACTLY to schemas provided.
# 3. Define primary keys in each table as appropriate.
# 4. Define foreign keys connecting tables as appropriate.
# 5. Assign ID to skills, people, roles manually (you must pick the ID number!)
# 6. Assign ID in the peopleskills and peopleroles automatically (use auto_increment)
# 7. Data types: ONLY use "int", "varchar(256)", "varchar(4096)" or "date" as appropriate.

# Section 1
# Drops all tables.  This section should be amended as new tables are added.

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS peopleskills;
DROP TABLE IF EXISTS peopleroles;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS skills;
SET FOREIGN_KEY_CHECKS=1;

# Section 2
# Create skills( id,name, description, tag, url, time_commitment)
# ID, name, description and tag cannot be NULL. Other fields can default to NULL.
# tag is a skill category grouping.  You can assign it based on your skill descriptions.
# time committment offers some sense of how much time was required (or will be required) to gain the skill.
# You can assign the skill descriptions.  Please be creative!

DROP TABLE IF EXISTS skills;
CREATE TABLE skills (
    id INT AUTO_INCREMENT,
    name VARCHAR(256) NOT NULL UNIQUE,
    description VARCHAR(256) NOT NULL,
    tag VARCHAR(256) NOT NULL,
    url VARCHAR(256),
    time_commitment INT,
    PRIMARY KEY(id)
);

# Section 3
# Populate skills
# Populates the skills table with eight skills, their tag fields must exactly contain “Skill 1”, “Skill 2”, etc.
# You can assign skill names.  Please be creative!

insert INTO skills (name, description, url, tag, time_commitment) values
    ("Beat boxing", "Boots and pants!", NULL, "Skill 1", 60),
    ("Hula hooping", "Those hips don't lie!", NULL, "Skill 2", 30),
    ("Robotics", "Robot go beep boop.", "https://www.youtube.com/watch?v=JcniyQYFU6M&list=FLLfWAX1JybwhuAUna0F62xw&index=40", "Skill 3", NULL),
    ("Speed napping", "Not to confuse with speed sleeping.", NULL, "Skill 4", 480),
    ("Shin kicking", "A very real sport.", "https://youtu.be/3ZkXyFvi4wE?si=Ee8Rt_tRyrUXntT5", "Skill 5", NULL),
    ("Jerry Seinfeld impersonation", "What's the deal with databases?", NULL, "Skill 6", NULL),
    ("Irish step dancing", "Pitter patter!", NULL, "Skill 7", NULL),
    ("French horn", "The least popular band instrument.", NULL, "Skill 8", NULL);

# Section 4
# Create people( id,first_name, last_name, email, linkedin_url, headshot_url, discord_handle, brief_bio, date_joined)
# ID cannot be null, Last name cannot be null, date joined cannot be NULL.
# All other fields can default to NULL.

DROP TABLE IF EXISTS people;
CREATE TABLE people (
    id INT AUTO_INCREMENT,
    first_name VARCHAR(256),
    last_name VARCHAR(256) NOT NULL,
    email VARCHAR(256),
    linkedin_url VARCHAR(256),
    headshot_url VARCHAR(256),
    discord_handle VARCHAR(256),
    brief_bio VARCHAR(256),
    date_joined DATE DEFAULT (CURRENT_DATE),
    PRIMARY KEY(id)
);

# Section 5
# Populate people with ten people.
# Their last names must exactly be “Person 1”, “Person 2”, etc.
# Other fields are for you to assign.

insert INTO people (first_name, last_name, email, linkedin_url, headshot_url, discord_handle, brief_bio, date_joined) values
    ("Shrek", "Person 1", "getoutofmyswamp@gmail.com", NULL, NULL, NULL, "Ogres are like onions.", '2001-04-22'),
    ("Benson", "Person 2", "gumballs@gmail.com", NULL, NULL, NULL, "Get back to work or YOU'RE FIRED!", '2010-09-06'),
    ("Springtrap", "Person 3", "williamafton@hotmail.com", NULL, NULL, "purpleguy", "I always come back", '2014-08-08'),
    ("Rachel", "Person 4", "farzanrl@vcu.edu", "linkedin.com/in/rachelfarzan/", NULL, "kronou", "Hey it's me, the person that made this database!", NULL),
    ("Oswald", "Person 5", NULL, NULL, NULL, "monkey_business", NULL, NULL),
    ("Beyonce", "Person 6", NULL, NULL, NULL, "beyonce", NULL, '2003-05-14'),
    ("Dracula", "Person 7", "bloodlvr@yahoo.com", NULL, NULL, NULL, "I vant to suck your blood!", '1897-05-26'),
    ("Santa", "Person 8", NULL, NULL, NULL, "merry_xmas", "Ho ho ho!", NULL),
    ("Jerry", "Person 9", "jerryseinfeld@gmail.com", NULL, NULL, "jseinfeld", "I'm definitely not Jerry Seinfeld.", NULL),
    ("Mario", "Person 10", "yahoo@yahoo.com", NULL, NULL, NULL, "It's-a-me!", '1985-09-13');


# Section 6
# Create peopleskills( id, skills_id, people_id, date_acquired )
# None of the fields can be NULL. ID can be auto_increment.

DROP TABLE IF EXISTS peopleskills;
CREATE TABLE peopleskills (
    id INT AUTO_INCREMENT,
    people_id INT NOT NULL,
    skills_id INT NOT NULL,
    date_aquired DATE,
    PRIMARY KEY(id),
    FOREIGN KEY(people_id)
        REFERENCES people (id)
        ON DELETE CASCADE,
    FOREIGN KEY(skills_id)
        REFERENCES skills (id)
        ON DELETE CASCADE,
    UNIQUE (skills_id, people_id)
);

# Section 7
# Populate peopleskills such that:
# Person 1 has skills 1,3,6;
# Person 2 has skills 3,4,5;
# Person 3 has skills 1,5;
# Person 4 has no skills;
# Person 5 has skills 3,6;
# Person 6 has skills 2,3,4;
# Person 7 has skills 3,5,6;
# Person 8 has skills 1,3,5,6;
# Person 9 has skills 2,5,6;
# Person 10 has skills 1,4,5;
# Note that no one has yet acquired skills 7 and 8.
 
INSERT INTO peopleskills (people_id, skills_id) values
    (1, 1),
    (1, 3),
    (1, 6),
    (2, 3),
    (2, 4),
    (2, 5),
    (3, 1),
    (3, 5),
    (5, 3),
    (5, 6),
    (6, 2),
    (6, 3),
    (6, 4),
    (7, 3),
    (7, 5),
    (7, 6),
    (8, 1),
    (8, 3),
    (8, 5),
    (8, 6),
    (9, 2),
    (9, 5),
    (9, 6),
    (10, 1),
    (10, 4),
    (10, 5);

# Section 8
# Create roles( id, name, sort_priority )
# sort_priority is an integer and is used to provide an order for sorting roles

DROP TABLE IF EXISTS roles;
CREATE TABLE roles (
    id INT AUTO_INCREMENT,
    name VARCHAR(256) NOT NULL,
    sort_priority INT NOT NULL,
    PRIMARY KEY(id)
);

# Section 9
# Populate roles
# Designer, Developer, Recruit, Team Lead, Boss, Mentor
# Sort priority is assigned numerically in the order listed above (Designer=10, Developer=20, Recruit=30, etc.)

INSERT INTO roles (name, sort_priority) values
    ("Designer", 10),
    ("Developer", 20),
    ("Recruit", 30),
    ("Team Lead", 40),
    ("Boss", 50),
    ("Mentor", 60);

# Section 10
# Create peopleroles( id, people_id, role_id, date_assigned )
# None of the fields can be null.  ID can be auto_increment

DROP TABLE IF EXISTS peopleroles;
CREATE TABLE peopleroles (
    id INT AUTO_INCREMENT,
    people_id INT NOT NULL,
    role_id INT NOT NULL,
    date_aquired DATE,
    PRIMARY KEY(id),
    FOREIGN KEY(people_id)
        REFERENCES people (id)
        ON DELETE CASCADE,
    FOREIGN KEY(role_id)
        REFERENCES roles (id)
        ON DELETE CASCADE,
    UNIQUE (role_id, people_id)
);

# Section 11
# Populate peopleroles
# Person 1 is Developer 
# Person 2 is Boss, Mentor
# Person 3 is Developer and Team Lead
# Person 4 is Recruit
# person 5 is Recruit
# Person 6 is Developer and Designer
# Person 7 is Designer
# Person 8 is Designer and Team Lead
# Person 9 is Developer
# Person 10 is Developer and Designer

INSERT INTO peopleroles (people_id, role_id) values
    (1, 2),
    (2, 5),
    (2, 6),
    (3, 2),
    (3, 4),
    (4, 3),
    (5, 3),
    (6, 2),
    (6, 1),
    (7, 1),
    (8, 1),
    (8, 4),
    (9, 2),
    (10, 2),
    (10, 1);