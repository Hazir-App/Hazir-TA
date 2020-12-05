const init_database =
'''
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

DROP TABLE IF EXISTS Booking;
CREATE TABLE Booking (id_booking INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, booked_by_user VARCHAR REFERENCES HazirUser (id_user) NOT NULL, booked_session INTEGER REFERENCES Session (id_session) NOT NULL, tutored_by_user STRING REFERENCES HazirUser (id_user) NOT NULL);
INSERT INTO Booking (id_booking, booked_by_user, booked_session, tutored_by_user) VALUES (1, 'ar06194', 2, 'sa06195');
INSERT INTO Booking (id_booking, booked_by_user, booked_session, tutored_by_user) VALUES (2, 'ar06195', 1, 'sa06195');
INSERT INTO Booking (id_booking, booked_by_user, booked_session, tutored_by_user) VALUES (3, 'ar06195', 4, 'sa06195');
INSERT INTO Booking (id_booking, booked_by_user, booked_session, tutored_by_user) VALUES (4, 'ar06195', 5, 'sa06195');
INSERT INTO Booking (id_booking, booked_by_user, booked_session, tutored_by_user) VALUES (5, 'ar06195', 3, 'sa06195');
INSERT INTO Booking (id_booking, booked_by_user, booked_session, tutored_by_user) VALUES (6, 'ar06195', 7, 'sa06195');
INSERT INTO Booking (id_booking, booked_by_user, booked_session, tutored_by_user) VALUES (7, 'ar06195', 6, 'sa06195');


DROP TABLE IF EXISTS Course;
CREATE TABLE Course (
course_id          INTEGER PRIMARY KEY AUTOINCREMENT
NOT NULL,
course_name        VARCHAR NOT NULL,
    course_code        VARCHAR NOT NULL,
course_semester_id INTEGER REFERENCES Semester (semester_id)
NOT NULL
);
INSERT INTO Course (course_id, course_name, course_code, course_semester_id) VALUES (0, 'Database Systems', 'CS335', 1);
INSERT INTO Course (course_id, course_name, course_code, course_semester_id) VALUES (1, 'Modernity', 'CORE102', 1);
INSERT INTO Course (course_id, course_name, course_code, course_semester_id) VALUES (2, 'Programming Fundamentals', 'CS101', 1);
INSERT INTO Course (course_id, course_name, course_code, course_semester_id) VALUES (3, 'CS Freshman Seminar', 'CS100', 1);
INSERT INTO Course (course_id, course_name, course_code, course_semester_id) VALUES (4, 'Cell Biology', 'BIO101', 1);
INSERT INTO Course (course_id, course_name, course_code, course_semester_id) VALUES (5, 'Mechanics & Thermodynamics', 'PHY101', 1);
INSERT INTO Course (course_id, course_name, course_code, course_semester_id) VALUES (6, 'Discrete Maths', 'CS113', 1);
INSERT INTO Course (course_id, course_name, course_code, course_semester_id) VALUES (7, 'Rhetoric & Communication', 'CORE101', 1);
INSERT INTO Course (course_id, course_name, course_code, course_semester_id) VALUES (8, 'Data Structures & Algo', 'CS102', 1);
INSERT INTO Course (course_id, course_name, course_code, course_semester_id) VALUES (9, 'Calculus I', 'MATH101', 1);
INSERT INTO Course (course_id, course_name, course_code, course_semester_id) VALUES (10, 'Calculus II', 'MATH102', 1);
INSERT INTO Course (course_id, course_name, course_code, course_semester_id) VALUES (11, 'Engineering Mathematics', 'MATH103', 1);
INSERT INTO Course (course_id, course_name, course_code, course_semester_id) VALUES (12, 'Pamsa', 'CORE201', 1);


DROP TABLE IF EXISTS EnrolledCourse;
CREATE TABLE EnrolledCourse (
enrolled_courses_id INTEGER NOT NULL
PRIMARY KEY AUTOINCREMENT,
enrolled_by_user_id VARCHAR REFERENCES HazirUser (id_user)
NOT NULL,
    enrolled_section_id INTEGER REFERENCES Section (section_id)
NOT NULL
);
INSERT INTO EnrolledCourse (enrolled_courses_id, enrolled_by_user_id, enrolled_section_id) VALUES (1, 'ar06194', 1);
INSERT INTO EnrolledCourse (enrolled_courses_id, enrolled_by_user_id, enrolled_section_id) VALUES (2, 'ar06194', 50);
INSERT INTO EnrolledCourse (enrolled_courses_id, enrolled_by_user_id, enrolled_section_id) VALUES (3, 'ar06194', 54);
INSERT INTO EnrolledCourse (enrolled_courses_id, enrolled_by_user_id, enrolled_section_id) VALUES (4, 'ar06194', 58);
INSERT INTO EnrolledCourse (enrolled_courses_id, enrolled_by_user_id, enrolled_section_id) VALUES (5, 'ar06194', 62);
INSERT INTO EnrolledCourse (enrolled_courses_id, enrolled_by_user_id, enrolled_section_id) VALUES (6, 'sa06195', 66);
INSERT INTO EnrolledCourse (enrolled_courses_id, enrolled_by_user_id, enrolled_section_id) VALUES (7, 'sa06195', 70);
INSERT INTO EnrolledCourse (enrolled_courses_id, enrolled_by_user_id, enrolled_section_id) VALUES (8, 'sa06195', 74);
INSERT INTO EnrolledCourse (enrolled_courses_id, enrolled_by_user_id, enrolled_section_id) VALUES (9, 'sa06195', 78);


DROP TABLE IF EXISTS HazirUser;
CREATE TABLE HazirUser (id_user VARCHAR PRIMARY KEY NOT NULL, first_name VARCHAR NOT NULL, last_name VARCHAR NOT NULL, email VARCHAR NOT NULL, user_password VARCHAR NOT NULL DEFAULT (12345), profile_url VARCHAR, user_role REFERENCES Roles (role_id) NOT NULL);
INSERT INTO HazirUser (id_user, first_name, last_name, email, user_password, profile_url, user_role) VALUES ('sa06195', 'Faaz', 'Abidi', 'sa06195@st.habib.edu.pk', '12345678', NULL, 1);
INSERT INTO HazirUser (id_user, first_name, last_name, email, user_password, profile_url, user_role) VALUES ('ar06194', 'Abuzar', 'Rasool', 'ar06194@st.habib.edu.pk', '12345678', NULL, 0);


DROP TABLE IF EXISTS Instructors;
CREATE TABLE Instructors (
instructor_id   INTEGER PRIMARY KEY AUTOINCREMENT
NOT NULL,
instructor_name VARCHAR NOT NULL
);
INSERT INTO Instructors (instructor_id, instructor_name) VALUES (1, 'Saad Baig');
INSERT INTO Instructors (instructor_id, instructor_name) VALUES (2, 'Qasim Pasta');
INSERT INTO Instructors (instructor_id, instructor_name) VALUES (3, 'Nauman Naqvi');
INSERT INTO Instructors (instructor_id, instructor_name) VALUES (4, 'Waqar Saleem');
INSERT INTO Instructors (instructor_id, instructor_name) VALUES (5, 'Shahid Hussain');
INSERT INTO Instructors (instructor_id, instructor_name) VALUES (6, 'Humera Qureshi');
INSERT INTO Instructors (instructor_id, instructor_name) VALUES (7, 'Abdullah Khalid');
INSERT INTO Instructors (instructor_id, instructor_name) VALUES (8, 'Sajal Rana');
INSERT INTO Instructors (instructor_id, instructor_name) VALUES (9, 'Ramiz Raghib');


DROP TABLE IF EXISTS Rating;
CREATE TABLE Rating (
rating_id        INTEGER PRIMARY KEY AUTOINCREMENT
NOT NULL,
rating_provider  VARCHAR REFERENCES HazirUser (id_user)
NOT NULL,
    rating_consumer  VARCHAR REFERENCES HazirUser (id_user)
NOT NULL,
    rating_given     INTEGER NOT NULL,
rating_course_id INTEGER REFERENCES Course (course_id)
NOT NULL
);


DROP TABLE IF EXISTS ResearchAssistants;
CREATE TABLE ResearchAssistants (
ra_id   INTEGER PRIMARY KEY AUTOINCREMENT
NOT NULL,
ra_name VARCHAR NOT NULL
);
INSERT INTO ResearchAssistants (ra_id, ra_name) VALUES (1, 'Aisha Batool');
INSERT INTO ResearchAssistants (ra_id, ra_name) VALUES (2, 'Zeeshan Nafees');
INSERT INTO ResearchAssistants (ra_id, ra_name) VALUES (3, 'Talha Amin');
INSERT INTO ResearchAssistants (ra_id, ra_name) VALUES (4, 'Hasan Shah');


DROP TABLE IF EXISTS Roles;
CREATE TABLE Roles (
role_id   INTEGER PRIMARY KEY AUTOINCREMENT
NOT NULL,
role_name VARCHAR NOT NULL
);
INSERT INTO Roles (role_id, role_name) VALUES (0, 'Student');
INSERT INTO Roles (role_id, role_name) VALUES (1, 'Tutor');


DROP TABLE IF EXISTS Section;
CREATE TABLE Section (
section_id             INTEGER PRIMARY KEY AUTOINCREMENT
NOT NULL,
section_code           VARCHAR NOT NULL,
    section_ra_id          INTEGER REFERENCES ResearchAssistants (ra_id)
NOT NULL,
    section_instrucutor_id INTEGER REFERENCES Instructors (instructor_id)
NOT NULL,
    section_course_id      VARCHAR REFERENCES Course (course_id)
NOT NULL
);
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (1, 'L1', 1, 1, '0');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (2, 'L2', 2, 2, '0');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (3, 'L3', 3, 3, '0');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (4, 'L4', 4, 4, '0');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (50, 'L1', 3, 1, '1');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (51, 'L2', 2, 7, '1');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (52, 'L3', 2, 5, '1');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (53, 'L4', 1, 4, '1');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (54, 'L1', 3, 2, '2');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (55, 'L2', 2, 4, '2');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (56, 'L3', 1, 9, '2');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (57, 'L4', 1, 1, '2');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (58, 'L1', 2, 9, '3');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (59, 'L2', 4, 2, '3');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (60, 'L3', 2, 2, '3');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (61, 'L4', 4, 7, '3');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (62, 'L1', 3, 2, '4');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (63, 'L2', 1, 4, '4');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (64, 'L3', 4, 1, '4');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (65, 'L4', 2, 2, '4');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (66, 'L1', 1, 7, '5');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (67, 'L2', 4, 5, '5');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (68, 'L3', 2, 8, '5');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (69, 'L4', 1, 8, '5');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (70, 'L1', 4, 1, '6');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (71, 'L2', 2, 3, '6');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (72, 'L3', 2, 3, '6');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (73, 'L4', 2, 6, '6');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (74, 'L1', 4, 5, '7');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (75, 'L2', 4, 1, '7');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (76, 'L3', 2, 4, '7');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (77, 'L4', 1, 1, '7');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (78, 'L1', 3, 2, '8');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (79, 'L2', 4, 3, '8');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (80, 'L3', 2, 3, '8');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (81, 'L4', 4, 7, '8');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (82, 'L1', 4, 7, '9');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (83, 'L2', 4, 3, '9');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (84, 'L3', 1, 2, '9');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (85, 'L4', 1, 8, '9');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (86, 'L1', 3, 2, '10');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (87, 'L2', 3, 8, '10');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (88, 'L3', 2, 9, '10');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (89, 'L4', 2, 8, '10');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (90, 'L1', 3, 3, '11');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (91, 'L2', 1, 1, '11');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (92, 'L3', 2, 4, '11');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (93, 'L4', 4, 4, '11');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (94, 'L1', 3, 9, '12');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (95, 'L2', 3, 8, '12');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (96, 'L3', 1, 6, '12');
INSERT INTO Section (section_id, section_code, section_ra_id, section_instrucutor_id, section_course_id) VALUES (97, 'L4', 4, 6, '12');


DROP TABLE IF EXISTS Semester;
CREATE TABLE Semester (
semester_id   INTEGER PRIMARY KEY AUTOINCREMENT
NOT NULL,
semester_name VARCHAR NOT NULL
);
INSERT INTO Semester (semester_id, semester_name) VALUES (1, 'Spring 2020');


DROP TABLE IF EXISTS Session;
CREATE TABLE Session (id_session INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, session_name VARCHAR NOT NULL, session_date DATE NOT NULL, session_start_time TIME NOT NULL, session_end_time TIME NOT NULL, bookable BOOLEAN NOT NULL, max_students INTEGER, course_id int REFERENCES Course (course_id), section_id INTEGER REFERENCES Section (section_id));
INSERT INTO Session (id_session, session_name, session_date, session_start_time, session_end_time, bookable, max_students, course_id, section_id) VALUES (1, 'General Session', '2020-12-04', '00:17:00', '00:18:00', 0, 30, 1, 1);
INSERT INTO Session (id_session, session_name, session_date, session_start_time, session_end_time, bookable, max_students, course_id, section_id) VALUES (2, 'General Session', '2020-12-04', '00:17:00', '00:18:00', 0, 30, 1, 1);
INSERT INTO Session (id_session, session_name, session_date, session_start_time, session_end_time, bookable, max_students, course_id, section_id) VALUES (3, 'General Session', '2020-12-03', '00:17:00', '00:18:00', 0, 30, 2, 1);
INSERT INTO Session (id_session, session_name, session_date, session_start_time, session_end_time, bookable, max_students, course_id, section_id) VALUES (4, 'General Session', '2020-12-04', '00:17:00', '00:18:00', 0, 30, 2, 2);
INSERT INTO Session (id_session, session_name, session_date, session_start_time, session_end_time, bookable, max_students, course_id, section_id) VALUES (5, 'General Session', '2020-12-08', '00:17:00', '00:18:00', 0, 30, 3, 2);
INSERT INTO Session (id_session, session_name, session_date, session_start_time, session_end_time, bookable, max_students, course_id, section_id) VALUES (6, 'General Session', '2020-12-06', '00:17:00', '00:18:00', 0, 30, 4, 2);
INSERT INTO Session (id_session, session_name, session_date, session_start_time, session_end_time, bookable, max_students, course_id, section_id) VALUES (7, 'General Session', '2020-12-04', '00:17:00', '00:18:00', 0, 30, 5, 2);


DROP TABLE IF EXISTS TutoredCourse;
CREATE TABLE TutoredCourse (
tutored_courses_id INTEGER NOT NULL
PRIMARY KEY AUTOINCREMENT,
tutored_by_user_id VARCHAR REFERENCES HazirUser (id_user)
NOT NULL,
    tutored_section_id INTEGER REFERENCES Section (section_id)
NOT NULL,
    approved           BOOLEAN NOT NULL
);
INSERT INTO TutoredCourse (tutored_courses_id, tutored_by_user_id, tutored_section_id, approved) VALUES (1, 'sa06195', 1, 1);
INSERT INTO TutoredCourse (tutored_courses_id, tutored_by_user_id, tutored_section_id, approved) VALUES (2, 'sa06195', 50, 1);
INSERT INTO TutoredCourse (tutored_courses_id, tutored_by_user_id, tutored_section_id, approved) VALUES (3, 'sa06195', 54, 1);
INSERT INTO TutoredCourse (tutored_courses_id, tutored_by_user_id, tutored_section_id, approved) VALUES (4, 'sa06195', 58, 0);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;''';