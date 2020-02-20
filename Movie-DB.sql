DROP TABLE SERIES CASCADE CONSTRAINTS;
DROP TABLE STAFF  CASCADE CONSTRAINTS;
DROP TABLE CREATORS CASCADE CONSTRAINTS;
DROP TABLE PRODUCERS CASCADE CONSTRAINTS;
DROP TABLE GENRE CASCADE CONSTRAINTS;
DROP TABLE HAS_TYPE CASCADE CONSTRAINTS;
DROP TABLE SEASON CASCADE CONSTRAINTS;
DROP TABLE EPISODE CASCADE CONSTRAINTS;
DROP TABLE ACTOR CASCADE CONSTRAINTS;
DROP TABLE WRITER CASCADE CONSTRAINTS;
DROP TABLE ACTING CASCADE CONSTRAINTS;
DROP TABLE WRITTEN_BY CASCADE CONSTRAINTS;
DROP TABLE USERS CASCADE CONSTRAINTS;
DROP TABLE GRADE_SERIES CASCADE CONSTRAINTS;
DROP TABLE GRADE_EPISODE CASCADE CONSTRAINTS;
DROP TABLE MESSAGE CASCADE CONSTRAINTS;

/*-================================= SERIES TABLE ======================================-*/

CREATE TABLE SERIES
(
ID_SERIES           NUMBER(4)               NOT NULL,
TITLE               VARCHAR2(24)            CONSTRAINT NN_TITLE NOT NULL,
YEAR                DATE                    CONSTRAINT NN_DATE NOT NULL,
COUNTRY             VARCHAR2(24)            CONSTRAINT NN_COUNTRY NOT NULL,
CONSTRAINT PK_SERIES PRIMARY KEY (ID_SERIES)
);

/*-================================= STAFF TABLE =======================================-*/

CREATE TABLE STAFF
(
ID_STAFF            NUMBER(4)               NOT NULL,
NAME                VARCHAR2(24)            CONSTRAINT NN_NAME NOT NULL,
SURNAME             VARCHAR2(24)            CONSTRAINT NN_SURNAME NOT NULL,
CONSTRAINT PK_STAFF PRIMARY KEY (ID_STAFF)
);

/*-================================= CREATORS TABLE ====================================-*/

CREATE TABLE CREATORS
(
ID_SERIES           NUMBER(4)               NOT NULL,
ID_STAFF            NUMBER(4)               NOT NULL,
CONSTRAINT PK_CREATORS PRIMARY KEY (ID_SERIES, ID_STAFF),
CONSTRAINT FK_ID_STAFF_C FOREIGN KEY (ID_STAFF) REFERENCES STAFF (ID_STAFF),
CONSTRAINT FK_ID_SERIES_C FOREIGN KEY (ID_SERIES) REFERENCES SERIES (ID_SERIES)
);

/*-================================ PRODUCERS TABLE ====================================-*/

CREATE TABLE PRODUCERS
(
ID_SERIES           NUMBER(4)               NOT NULL,
ID_STAFF            NUMBER(4)               NOT NULL,
CONSTRAINT PK_PRODUCERS PRIMARY KEY (ID_SERIES, ID_STAFF),
CONSTRAINT FK_ID_STAFF_P FOREIGN KEY (ID_STAFF) REFERENCES STAFF (ID_STAFF),
CONSTRAINT FK_ID_SERIES_P FOREIGN KEY (ID_SERIES) REFERENCES SERIES (ID_SERIES)
);

/*-================================ GENRES TABLE =======================================-*/
CREATE TABLE GENRE
(
ID_GENRE            NUMBER(2)               NOT NULL,
NAME_GENRE          VARCHAR2(24)            CONSTRAINT NN_NAME_GENRE NOT NULL,
CONSTRAINT PK_GENRE PRIMARY KEY (ID_GENRE)
);

/*-=============================== HAS_TYPE ============================================-*/
CREATE TABLE HAS_TYPE
(
ID_SERIES           NUMBER(4)               NOT NULL,
ID_GENRE            NUMBER(2)               NOT NULL,
CONSTRAINT PK_HAS_TYPE PRIMARY KEY (ID_SERIES, ID_GENRE),
CONSTRAINT FK_SERIES_T FOREIGN KEY (ID_SERIES) REFERENCES SERIES (ID_SERIES),
CONSTRAINT FK_GENRE FOREIGN KEY (ID_GENRE) REFERENCES GENRE(ID_GENRE)
);

/*-================================ SEASON TABLE =======================================-*/

CREATE TABLE SEASON
(
ID_SEASON           VARCHAR2(30)            NOT NULL,
ID_SERIES           NUMBER(4)               NOT NULL,
CONSTRAINT PK_SEASON PRIMARY KEY (ID_SEASON),
CONSTRAINT FK_ID_SERIES FOREIGN KEY (ID_SERIES) REFERENCES SERIES (ID_SERIES)
);

/*-================================ EPISODE TABLE =======================================-*/

CREATE TABLE EPISODE
(
ID_EPISODE          NUMBER(2)               NOT NULL,
TITLE_EP            VARCHAR2(30)            CONSTRAINT NN_TITLE_EP NOT NULL,
DURATION            NUMBER(3)               CONSTRAINT NN_DURATION NOT NULL,
RELEASE_DATE        DATE                    CONSTRAINT NN_RELEASE_DATE NOT NULL,
RESUME              VARCHAR2(300)           CONSTRAINT NN_RESUME NOT NULL,
ID_SEASON           VARCHAR2(30)            NOT NULL,
CONSTRAINT PK_EPISODE PRIMARY KEY (ID_EPISODE, TITLE_EP),
CONSTRAINT FK_ID_SEASON FOREIGN KEY (ID_SEASON) REFERENCES SEASON (ID_SEASON)
);

/*-================================= ACTORS TABLE =======================================-*/
CREATE TABLE ACTOR
(
ID_ACTOR            NUMBER(4)               NOT NULL,
A_NAME              VARCHAR2(24)            CONSTRAINT NN_A_NAME NOT NULL,
A_SURNAME           VARCHAR2(24)            CONSTRAINT NN_A_SURNAME NOT NULL,
CONSTRAINT PK_ACTOR PRIMARY KEY (ID_ACTOR)
);

/*-================================= WRITER TABLE =====================================-*/
CREATE TABLE WRITER
(
ID_WRITER           NUMBER(4)               NOT NULL,
W_NAME              VARCHAR2(24)            CONSTRAINT NN_W_NAME NOT NULL,
W_SURNAME           VARCHAR2(24)            CONSTRAINT NN_W_SURNAME NOT NULL,
CONSTRAINT PK_WRITER PRIMARY KEY (ID_WRITER)
);

/*-================================ ACTING TABLE ========================================-*/
CREATE TABLE ACTING
(
ID_EPISODE          NUMBER(2)               NOT NULL,
TITLE_EP            VARCHAR2(30)            NOT NULL,
ID_ACTOR            NUMBER(4)               NOT NULL,
CONSTRAINT PK_ACTING PRIMARY KEY (ID_EPISODE, TITLE_EP, ID_ACTOR),
CONSTRAINT FK_ID_EPISODE_A FOREIGN KEY (ID_EPISODE, TITLE_EP) REFERENCES EPISODE (ID_EPISODE, TITLE_EP),
CONSTRAINT FK_ID_ACTOR FOREIGN KEY(ID_ACTOR) REFERENCES ACTOR(ID_ACTOR)
);

/*================================= Writer TABLE =====================================-*/
CREATE TABLE WRITTEN_BY
(
ID_EPISODE          NUMBER(2)               NOT NULL,
TITLE_EP            VARCHAR2(30)            NOT NULL,
ID_WRITER           NUMBER(4)               NOT NULL,
CONSTRAINT PK_WRITTEN_BY PRIMARY KEY (ID_EPISODE, TITLE_EP, ID_WRITER),
CONSTRAINT FK_ID_EPISODE_D FOREIGN KEY (ID_EPISODE, TITLE_EP) REFERENCES EPISODE (ID_EPISODE, TITLE_EP),
CONSTRAINT FK_ID_WRITER FOREIGN KEY (ID_WRITER) REFERENCES WRITER (ID_WRITER)
);

/*-============================== USER TABLE ============================================-*/
CREATE TABLE USERS
(
ID_USER             NUMBER(4)               NOT NULL,
USERNAME            VARCHAR2(24)            CONSTRAINT NN_USERNAME NOT NULL UNIQUE,
REGISTER_DATE       DATE                    CONSTRAINT NN_REGISTER_DATE NOT NULL,
AGE                 NUMBER(2)               CONSTRAINT CK_AGE CHECK (AGE>12),
SEX                 VARCHAR2(1)             CONSTRAINT CK_SEX CHECK (SEX IN ('M','F')),
CONSTRAINT PK_USERS PRIMARY KEY (ID_USER)
);

/*-============================= GRADES_SERIES TABLE ====================================-*/
CREATE TABLE GRADE_SERIES
(
ID_USER             NUMBER(4)               NOT NULL,
ID_SERIES           NUMBER(4)               NOT NULL,
GRADE_SERIES        NUMBER(2)               CONSTRAINT CK_GRADE_SERIES CHECK (GRADE_SERIES<=10 and GRADE_SERIES >=0),
REVIEW_SERIES       VARCHAR2(300)           CONSTRAINT NN_REVIEW_SERIES NOT NULL,
CONSTRAINT PK_GRADES_SERIES PRIMARY KEY (ID_USER, ID_SERIES),
CONSTRAINT FK_ID_USER_1 FOREIGN KEY (ID_USER) REFERENCES USERS(ID_USER),
CONSTRAINT FK_SERIES FOREIGN KEY (ID_SERIES) REFERENCES SERIES (ID_SERIES)
);

/*-============================ GRADES_EPISODE TABLE ====================================-*/
CREATE TABLE GRADE_EPISODE
(
ID_USER             NUMBER(4)               NOT NULL,
ID_EPISODE          Number(2)               NOT NULL,
TITLE_EP            VARCHAR2(30)            NOT NULL,
GRADE_EPISODE       NUMBER(2)               CONSTRAINT CK_GRADE_EPISODE CHECK (GRADE_EPISODE<=10 and GRADE_EPISODE >=0),
REVIEW_EPISODE      VARCHAR2(300)           CONSTRAINT NN_REVIEW_EPISODE NOT NULL,
CONSTRAINT PK_GRADE_EPISODE PRIMARY KEY (ID_USER, ID_EPISODE, TITLE_EP),
CONSTRAINT FK_ID_USER_2 FOREIGN KEY (ID_USER) REFERENCES USERS (ID_USER),
CONSTRAINT FK_EPISODE FOREIGN KEY (ID_EPISODE, TITLE_EP) REFERENCES EPISODE (ID_EPISODE, TITLE_EP)
);

/*-============================ MESSAGE TABLE ==========================================-*/
CREATE TABLE MESSAGE
(
ID_MESSAGE          NUMBER(4)               NOT NULL,
LVL_MSG             NUMBER(4)               NOT NULL,
ID_PARENT_MESSAGE   NUMBER(4),
ID_USER             NUMBER(4)               NOT NULL,
TITLE               VARCHAR2(24),
CONTENT             VARCHAR2(300)           CONSTRAINT NN_CONTENT NOT NULL,
CONSTRAINT PK_MESSAGE PRIMARY KEY (ID_MESSAGE),
CONSTRAINT FK_ID_PARENT_MESSAGE FOREIGN KEY (ID_PARENT_MESSAGE) REFERENCES MESSAGE (ID_MESSAGE),
CONSTRAINT FK_ID_USER_3 FOREIGN KEY (ID_USER) REFERENCES USERS (ID_USER)
);



/*-===========================================================================================================================================================================================================-*/
/*-====================================================================================== INSERTION ==========================================================================================================-*/
/*-===========================================================================================================================================================================================================-*/


-----------------------------------------------------------------------------------------SERIES---------------------------------------------------------------------------------------------------
INSERT INTO SERIES(ID_SERIES, TITLE, YEAR, COUNTRY)
VALUES (1, 'Breaking Bad','01-20-2008', 'USA'); 
INSERT INTO SERIES(ID_SERIES, TITLE, YEAR, COUNTRY)
VALUES (2, 'Midnight Dinner','10-21-2016', 'Japan');
INSERT INTO SERIES(ID_SERIES, TITLE, YEAR, COUNTRY)
VALUES (3, 'The Orville','09-10-2017', 'USA');
INSERT INTO SERIES(ID_SERIES, TITLE, YEAR, COUNTRY)
VALUES (4, 'Amazing Stories','09-29-1985', 'USA');
INSERT INTO SERIES(ID_SERIES, TITLE, YEAR, COUNTRY)
VALUES (5, 'High Incident','03-04-1996', 'USA');
INSERT INTO SERIES(ID_SERIES, TITLE, YEAR, COUNTRY)
VALUES (6, 'Big Bang Theory','09-24-2007', 'USA');
INSERT INTO SERIES(ID_SERIES, TITLE, YEAR, COUNTRY)
VALUES (7, 'Malcom in the Middle','01-09-2000', 'USA');



/*-====================================================================================== STAFF =================================================================================================-*/


INSERT INTO STAFF(ID_STAFF, NAME, SURNAME)
VALUES (1, 'Vince', 'Gilligan');
INSERT INTO STAFF(ID_STAFF, NAME, SURNAME)
VALUES (2, 'George', 'Mastras');
INSERT INTO STAFF(ID_STAFF, NAME, SURNAME)
VALUES (3, 'John', 'Shiban');
INSERT INTO STAFF(ID_STAFF, NAME, SURNAME)
VALUES (4, 'Takeshi', 'Moriya');
INSERT INTO STAFF(ID_STAFF, NAME, SURNAME)
VALUES (5, 'Shinya', 'Shokudō');
INSERT INTO STAFF(ID_STAFF, NAME, SURNAME)
VALUES (6, 'Seth', 'MacFarlane');
INSERT INTO STAFF(ID_STAFF, NAME, SURNAME)
VALUES (7, 'Brannon', 'Braga');
INSERT INTO STAFF(ID_STAFF, NAME, SURNAME)
VALUES (8, 'Jason', 'Clark');
INSERT INTO STAFF(ID_STAFF, NAME, SURNAME)
VALUES (9, 'Jon', 'Cassar');
INSERT INTO STAFF(ID_STAFF, NAME, SURNAME)
VALUES (10, 'Jon', 'Cammar');
INSERT INTO STAFF(ID_STAFF, NAME, SURNAME)
VALUES (11, 'Spielberg', 'Steven');
INSERT INTO STAFF(ID_STAFF, NAME, SURNAME)
VALUES (12, 'Bogosian', 'Eric');
INSERT INTO STAFF(ID_STAFF, NAME, SURNAME)
VALUES (13, 'Donahue', 'Ann');
INSERT INTO STAFF(ID_STAFF, NAME, SURNAME)
VALUES (14, 'Boomer', 'Linwood');
INSERT INTO STAFF(ID_STAFF, NAME, SURNAME)
VALUES (15, 'Carlson', 'Matthew');




/*-==================================================================================== CREATORS ================================================================================================-*/

INSERT INTO CREATORS(ID_SERIES, ID_STAFF)
VALUES (1, 1);
INSERT INTO CREATORS(ID_SERIES, ID_STAFF)
VALUES (2, 5);
INSERT INTO CREATORS(ID_SERIES, ID_STAFF)
VALUES (3, 6);
INSERT INTO CREATORS(ID_SERIES, ID_STAFF)
VALUES (4, 11);
INSERT INTO CREATORS(ID_SERIES, ID_STAFF)
VALUES (5, 11);
INSERT INTO CREATORS(ID_SERIES, ID_STAFF)
VALUES (5, 12);
INSERT INTO CREATORS(ID_SERIES, ID_STAFF)
VALUES (7, 14);


/*-==================================================================================== PRODUCERS ===============================================================================================-*/

INSERT INTO PRODUCERS(ID_SERIES, ID_STAFF)
VALUES (1, 2);
INSERT INTO PRODUCERS(ID_SERIES, ID_STAFF)
VALUES (1, 3);
INSERT INTO PRODUCERS(ID_SERIES, ID_STAFF)
VALUES (2, 4);
INSERT INTO PRODUCERS(ID_SERIES, ID_STAFF)
VALUES (3, 6);
INSERT INTO PRODUCERS(ID_SERIES, ID_STAFF)
VALUES (3, 7);
INSERT INTO PRODUCERS(ID_SERIES, ID_STAFF)
VALUES (3, 8);
INSERT INTO PRODUCERS(ID_SERIES, ID_STAFF)
VALUES (3, 9);
INSERT INTO PRODUCERS(ID_SERIES, ID_STAFF)
VALUES (3, 10);
INSERT INTO PRODUCERS(ID_SERIES, ID_STAFF)
VALUES (4, 11);
INSERT INTO PRODUCERS(ID_SERIES, ID_STAFF)
VALUES (5, 11);
INSERT INTO PRODUCERS(ID_SERIES, ID_STAFF)
VALUES (5, 12);
INSERT INTO PRODUCERS(ID_SERIES, ID_STAFF)
VALUES (5, 13);

INSERT INTO PRODUCERS(ID_SERIES, ID_STAFF)
VALUES (7, 14);
INSERT INTO PRODUCERS(ID_SERIES, ID_STAFF)
VALUES (7, 15);


/*-===================================================================================== SEASONS =============================================================================================-*/

INSERT INTO SEASON(ID_SEASON, ID_SERIES)
VALUES ('Breaking Bad I', 1);
INSERT INTO SEASON(ID_SEASON, ID_SERIES)
VALUES ('Breaking Bad II', 1);
INSERT INTO SEASON(ID_SEASON, ID_SERIES)
VALUES ('Breaking Bad III', 1);
INSERT INTO SEASON(ID_SEASON, ID_SERIES)
VALUES ('Breaking Bad IV', 1);
INSERT INTO SEASON(ID_SEASON, ID_SERIES)
VALUES ('Breaking Bad V', 1);

INSERT INTO SEASON(ID_SEASON, ID_SERIES)
VALUES ('Midnight Dinner I', 2);
INSERT INTO SEASON(ID_SEASON, ID_SERIES)
VALUES ('Midnight Dinner II', 2);
INSERT INTO SEASON(ID_SEASON, ID_SERIES)
VALUES ('Midnight Dinner III', 2);

INSERT INTO SEASON(ID_SEASON, ID_SERIES)
VALUES ('The Orville I', 3);
INSERT INTO SEASON(ID_SEASON, ID_SERIES)
VALUES ('The Orville II', 3);

INSERT INTO SEASON(ID_SEASON, ID_SERIES)
VALUES ('Amazing Stories I', 4);
INSERT INTO SEASON(ID_SEASON, ID_SERIES)
VALUES ('Amazing Stories II', 4);

INSERT INTO SEASON(ID_SEASON, ID_SERIES)
VALUES ('High Incident I', 5);
INSERT INTO SEASON(ID_SEASON, ID_SERIES)
VALUES ('High Incident II', 5);

INSERT INTO SEASON(ID_SEASON, ID_SERIES)
VALUES ('Malcolm in the Middle I', 7);
INSERT INTO SEASON(ID_SEASON, ID_SERIES)
VALUES ('Malcolm in the Middle II', 7);
INSERT INTO SEASON(ID_SEASON, ID_SERIES)
VALUES ('Malcolm in the Middle III', 7);
INSERT INTO SEASON(ID_SEASON, ID_SERIES)
VALUES ('Malcolm in the Middle IV', 7);
INSERT INTO SEASON(ID_SEASON, ID_SERIES)
VALUES ('Malcolm in the Middle V', 7);
INSERT INTO SEASON(ID_SEASON, ID_SERIES)
VALUES ('Malcolm in the Middle VI', 7);
INSERT INTO SEASON(ID_SEASON, ID_SERIES)
VALUES ('Malcolm in the Middle VII', 7);


/*-=================================================================================== EPISODES ==============================================================================================-*/

INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (1, 'Pilot', 56, '01-20-2008', '"Pilot" (titled "Breaking Bad" on DVD and Blu-ray releases) is the pilot episode and series premiere of the American television drama series Breaking Bad. It originally aired on AMC on January 20, 2008, and was written and directed by series creator and showrunner Vince Gilligan.', 'Breaking Bad I');
INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (2, 'Cats in the Bag', 55, '01-27-2008', 'Walt and Jesse try to dispose of the two bodies in the RV, which becomes increasingly complicated when one of them, Krazy-8, wakes up. They eventually imprison him in Jesses basement.', 'Breaking Bad I');
INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (3, 'And the Bags in the River', 58, '02-10-2008', 'Walt cannot decide whether to kill Krazy-8. Meanwhile, Marie believes that Walter Jr. is smoking marijuana and asks Hank to scare him straight. Walt brings Krazy-8 food, but he collapses while descending the basement stairs.', 'Breaking Bad I');
INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (4, 'Cancer Man', 56, '02-17-2008', 'Hank starts looking for the new drug kingpin around town, unaware that its Walt. At a family barbecue, Walt reveals that he has cancer.', 'Breaking Bad I');
INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (5, 'Gray Matter', 55, '02-24-2008', 'Walt declines an offer of financial help from an old friend. Jesse attempts to cook meth on his own but cannot replicate the quality of Walts product, while Walter Jr. gets caught trying to buy beer.', 'Breaking Bad I');
INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (6, 'Crazy Handful or Nothin', 51, '03-02-2008', 'Walt and Jesse come to an agreement: Walt will cook the meth while Jesse sells it. He eventually discovers Walts purpose in collaborating with him.', 'Breaking Bad I');
INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (7, 'A No-Rough-Stuff-Type_Deal', 52, '03-09-2008', 'Walt and Jesse face difficulties producing the large amount of meth promised to Tuco. Skyler confronts Marie about her shoplifting after being detained at the jewelry store where Marie stole the expensive babys tiara she gave Skyler at her baby shower.', 'Breaking Bad I');

INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (1, 'Seven Thirty-Seven', 53, '03-08-2009', 'No-Doze dies from the beating Tuco inflicted on him, and Gonzo leaves to hide the body. Walt and Jesse are horrified by Tucos violent tendencies, as well as the mysterious appearance of an ominous black SUV.', 'Breaking Bad II');
INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (2, 'Grilled', 55, '03-15-2009', 'Tuco takes Walt and Jesse at gunpoint to a remote desert hideout, where he takes care of his sick uncle, a former drug kingpin who is now incapacitated due to a stroke and can only communicate with a bell.', 'Breaking Bad II');


----------------------------------------------------------------------------------------

INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (1, 'Tan-Men', 30, '10-21-2016', 'A chef embarks on a secret mission to cook something to surprise his guests', 'Midnight Dinner I');

----------------------------------------------------------------------------------------

INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (1, 'Old Wounds', 57, '09-10-2017', 'Twenty-fifth-century Union command officer Ed Mercer divorces his wife, Kelly Grayson, after catching her cheating on him, prompting an emotional crisis that severely affects his career.', 'The Orville I');
INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (2, 'Command Performance', 54, '09-17-2017', 'The technologically advanced Calivon capture and imprison Mercer and Grayson for a new exhibit in a zoo filled with humanoid species from throughout the galaxy.', 'The Orville I');
INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (3, 'About a Girl', 55, '09-21-2017', 'When Doctor Finn refuses Bortus and Klydens request for her to perform sex reassignment surgery on their daughter, a standard Moclan practice on the rare occasion a female is born, they petition Mercer to order the procedure.', 'The Orville I');
INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (4, 'If the Stars Should Appear', 50, '09-28-2017', 'The Orville encounters an immense, 2,000-year-old derelict ship drifting into a star. Mercer, Grayson, Kitan, Finn, and Isaac enter, discovering an artificial biosphere and a civilization of three million who worship an entity called Dorahl.', 'The Orville I');


-----------------------------------------------------------------------------------------

INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (1, 'Ghost Train', 40, '09-29-1985', 'A grandfather (Roberts Blossom) disapproves of his son building a country home on the site of a train accident from 75 years ago.', 'Amazing Stories I');
INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (2, 'The Main Attraction', 41, '10-06-1985', 'A high school jock (Scott Clough) up for Prom King develops a "magnetic" personality.', 'Amazing Stories I');
INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (3, 'Alamo Jobe', 39, '10-20-1985', 'A young man (Kelly Reno) travels through time to 20th-century San Antonio.', 'Amazing Stories I');
INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (4, 'Mummy Daddy', 44, '10-27-1985', 'An actor (Tom Harrison) cast as a mummy in a horror movie rushes to be with his wife when she goes into labor.', 'Amazing Stories I');
INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (5, 'The Mission', 37, '11-03-1985', 'A belly turret gunner (Casey Siemaszko) is trapped in the compartment of a WWII bomber. Also starring Kevin Costner and Kiefer Sutherland with Anthony LaPaglia in a minor role.', 'Amazing Stories I');

------------------------------------------------------------------------------------------

INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (1, 'Till Death Do Us Part', 57, '03-04-1996', 'ECPD is called in when the brides family is ready to kill the groom. Gayles father, a career marine, spends the day riding with Gayle and Richie.', 'High Incident I');
INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (2, 'Coroners Day Off', 56, '03-11-1996', 'Marsh, whos been slapped with a sexual-harassment charge by Bonner (Lucinda Jenney), recommends her for undercover-hooker detail', 'High Incident I');
INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (3, 'Women and Children First', 56, '03-18-1996', 'Officers Van Camp and Fernandez brave downed power lines to reach a father and son trapped in an overturned vehicle.', 'High Incident I');
INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (4, 'Sometimes a Vague Notion', 55, '04-01-1996', 'Terry believes that a missing boy (Jordan Blake Warkol) is trapped in a pipe at a construction site---and hell move heaven and earth to prove hes right.', 'High Incident I');
INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (5, 'Father Knows Best', 57, '04-08-1996', 'Marsh takes some drastic measures to ensure that his rebellious daughter (Mena Suvari) remains on the straight and narrow. Meanwhile, Van Camp finds herself on the business end of a stun gun.', 'High Incident I');
INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (6, 'Follow the Leader', 56, '04-15-1996', 'Lenny is back on patrol. Willitz finds himself in a hostage-situation standoff with a man (Cotter Smith) who shot his wife.', 'High Incident I');

---------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------

INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (1, 'Pillot', 53, '01-09-2000', '11-year-old Malcolm (Frankie Muniz) lives with his dysfunctional family: neurotic father, Hal (Bryan Cranston), control-freak mother Lois (Jane Kaczmarek), dim-witted bully 12-year-old Reese (Justin Berfield), and odd 6-year-old Dewey (Erik Per Sullivan).', 'Malcolm in the Middle I');
INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (2, 'Red Dress', 52, '01-16-2000', 'Lois is supposed to meet Hal at an expensive restaurant for their anniversary date, but Lois forgets to go after she finds her red dress burned and flushed down the toilet, sending her into a violent rage.', 'Malcolm in the Middle I');
INSERT INTO EPISODE(ID_EPISODE, TITLE_EP, DURATION, RELEASE_DATE, RESUME, ID_SEASON)
VALUES (3, 'Home Alone 4', 54, '01-23-2000', 'While Hal and Lois are away for the weekend, Francis comes home from military school to babysit.', 'Malcolm in the Middle I');

/*-===========================================================================  ACTORS ===================================================================================================-*/

INSERT INTO ACTOR(ID_ACTOR, A_NAME, A_SURNAME)
VALUES(1, 'Aaron', 'Paul');

 ---------------------------------------------

INSERT INTO ACTOR(ID_ACTOR, A_NAME, A_SURNAME)
VALUES(2, 'Takeshi', 'Moriya');

 ---------------------------------------------

INSERT INTO ACTOR(ID_ACTOR, A_NAME, A_SURNAME)
VALUES(3, 'Grimes', 'Scott');
INSERT INTO ACTOR(ID_ACTOR, A_NAME, A_SURNAME)
VALUES(4, 'Macon', 'Peter');
INSERT INTO ACTOR(ID_ACTOR, A_NAME, A_SURNAME)
VALUES(5, 'Lee', 'J');

----------------------------------------------
INSERT INTO ACTOR(ID_ACTOR, A_NAME, A_SURNAME)
VALUES(6, 'Hooper', 'Tobi');
INSERT INTO ACTOR(ID_ACTOR, A_NAME, A_SURNAME)
VALUES(7, 'DeVito', 'Danny');
 INSERT INTO ACTOR(ID_ACTOR, A_NAME, A_SURNAME)
VALUES(8, 'Garris', 'Mick');

----------------------------------------------
 INSERT INTO ACTOR(ID_ACTOR, A_NAME, A_SURNAME)
VALUES(9, 'Keith', 'David');
 INSERT INTO ACTOR(ID_ACTOR, A_NAME, A_SURNAME)
VALUES(10, 'Craven', 'Matt');
 INSERT INTO ACTOR(ID_ACTOR, A_NAME, A_SURNAME)
VALUES(11, 'Vidal', 'Lisa');
 INSERT INTO ACTOR(ID_ACTOR, A_NAME, A_SURNAME)
VALUES(12, 'Davis', 'Wendy');

 INSERT INTO ACTOR(ID_ACTOR, A_NAME, A_SURNAME)
VALUES(13, 'Cranston', 'Bryan');





/*-=================================================================================== ACTING ===============================================================================================-*/

INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(1, 'Pilot', 1);

INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(1, 'Pilot', 13);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(2, 'Cats in the Bag', 13);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(3, 'And the Bags in the River', 13);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(4, 'Cancer Man', 13);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(5, 'Gray Matter', 13);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(6, 'Crazy Handful or Nothin', 13);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(7, 'A No-Rough-Stuff-Type_Deal', 13);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(1, 'Seven Thirty-Seven', 13);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(2, 'Grilled', 13);

INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(1, 'Pillot', 13);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(2, 'Red Dress', 13);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(3, 'Home Alone 4', 13);

--------------------------------------------------


INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(1, 'Tan-Men', 2);

-------------------------------------------------

INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(1, 'Old Wounds', 3);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(2, 'Command Performance', 3);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(3, 'About a Girl', 3);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(4, 'If the Stars Should Appear', 3);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(1, 'Old Wounds', 4);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(2, 'Command Performance', 4);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(3, 'About a Girl', 4);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(4, 'If the Stars Should Appear', 4);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(1, 'Old Wounds', 5);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(2, 'Command Performance', 5);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(3, 'About a Girl', 5);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(4, 'If the Stars Should Appear', 5);

-------------------------------------------------

INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(1, 'Ghost Train', 6);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(2, 'The Main Attraction', 6);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(3, 'Alamo Jobe', 6);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(4, 'Mummy Daddy', 6);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(5, 'The Mission', 6);

INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(1, 'Ghost Train', 7);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(2, 'The Main Attraction', 7);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(3, 'Alamo Jobe', 7);

INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(1, 'Ghost Train', 8);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(2, 'The Main Attraction', 8);

--------------------------------------------------

INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(1, 'Till Death Do Us Part', 9);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(2, 'Coroners Day Off', 9);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(3, 'Women and Children First', 9);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(4, 'Sometimes a Vague Notion', 9);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(5, 'Father Knows Best', 9);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(6, 'Follow the Leader', 9);

INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(1, 'Till Death Do Us Part', 10);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(2, 'Coroners Day Off', 10);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(3, 'Women and Children First', 10);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(4, 'Sometimes a Vague Notion', 10);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(5, 'Father Knows Best', 10);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(6, 'Follow the Leader', 10);

INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(1, 'Till Death Do Us Part', 11);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(2, 'Coroners Day Off', 11);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(3, 'Women and Children First', 11);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(4, 'Sometimes a Vague Notion', 11);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(5, 'Father Knows Best', 11);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(6, 'Follow the Leader', 11);

INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(1, 'Till Death Do Us Part', 12);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(2, 'Coroners Day Off', 12);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(3, 'Women and Children First', 12);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(4, 'Sometimes a Vague Notion', 12);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(5, 'Father Knows Best', 12);
INSERT INTO ACTING(ID_EPISODE, TITLE_EP, ID_ACTOR)
VALUES(6, 'Follow the Leader', 12);

/*-=====================================================================================================  WRITER =====================================================================================================-*/

INSERT INTO WRITER(ID_WRITER, W_NAME, W_SURNAME)
VALUES(1, 'Gilligan', 'Vince');

-------------------------------------------------

INSERT INTO WRITER(ID_WRITER, W_NAME, W_SURNAME)
VALUES(2, 'Yarō', 'Abe');

------------------------------------------------

INSERT INTO WRITER(ID_WRITER, W_NAME, W_SURNAME)
VALUES(3, 'Sage', 'Halston');

------------------------------------------------

INSERT INTO WRITER(ID_WRITER, W_NAME, W_SURNAME)
VALUES(4, 'Robins', 'Matthew');
INSERT INTO WRITER(ID_WRITER, W_NAME, W_SURNAME)
VALUES(5, 'Dear', 'William');

------------------------------------------------
INSERT INTO WRITER(ID_WRITER, W_NAME, W_SURNAME)
VALUES(6, 'Haid', 'Charles');

INSERT INTO WRITER(ID_WRITER, W_NAME, W_SURNAME)
VALUES(7, 'Vidal', 'Lisa');



/*-====================================================================================================== WRITTEN BY  ========================================================================================================-*/

INSERT INTO WRITTEN_BY(ID_EPISODE, TITLE_EP, ID_WRITER)
VALUES(1, 'Pilot', 1);

-------------------------------------------------

INSERT INTO WRITTEN_BY(ID_EPISODE, TITLE_EP, ID_WRITER)
VALUES(1, 'Tan-Men', 2);

-------------------------------------------------

INSERT INTO WRITTEN_BY(ID_EPISODE, TITLE_EP, ID_WRITER)
VALUES(1, 'Old Wounds', 3);
INSERT INTO WRITTEN_BY(ID_EPISODE, TITLE_EP, ID_WRITER)
VALUES(2, 'Command Performance', 3);
INSERT INTO WRITTEN_BY(ID_EPISODE, TITLE_EP, ID_WRITER)
VALUES(3, 'About a Girl', 3);
INSERT INTO WRITTEN_BY(ID_EPISODE, TITLE_EP, ID_WRITER)
VALUES(4, 'If the Stars Should Appear', 3);

----------------------------------------------------

INSERT INTO WRITTEN_BY(ID_EPISODE, TITLE_EP, ID_WRITER)
VALUES(1, 'Ghost Train', 4);
INSERT INTO WRITTEN_BY(ID_EPISODE, TITLE_EP, ID_WRITER)
VALUES(2, 'The Main Attraction', 4);
INSERT INTO WRITTEN_BY(ID_EPISODE, TITLE_EP, ID_WRITER)
VALUES(3, 'Alamo Jobe', 5);
INSERT INTO WRITTEN_BY(ID_EPISODE, TITLE_EP, ID_WRITER)
VALUES(4, 'Mummy Daddy', 4);
INSERT INTO WRITTEN_BY(ID_EPISODE, TITLE_EP, ID_WRITER)
VALUES(5, 'The Mission', 7);

----------------------------------------------------
INSERT INTO WRITTEN_BY(ID_EPISODE, TITLE_EP, ID_WRITER)
VALUES(1, 'Till Death Do Us Part', 6);
INSERT INTO WRITTEN_BY(ID_EPISODE, TITLE_EP, ID_WRITER)
VALUES(2, 'Coroners Day Off', 6);
INSERT INTO WRITTEN_BY(ID_EPISODE, TITLE_EP, ID_WRITER)
VALUES(3, 'Women and Children First', 6);
INSERT INTO WRITTEN_BY(ID_EPISODE, TITLE_EP, ID_WRITER)
VALUES(4, 'Sometimes a Vague Notion', 6);
INSERT INTO WRITTEN_BY(ID_EPISODE, TITLE_EP, ID_WRITER)
VALUES(5, 'Father Knows Best', 6);
INSERT INTO WRITTEN_BY(ID_EPISODE, TITLE_EP, ID_WRITER)
VALUES(6, 'Follow the Leader', 6);

/*-========================================================================================================================================   USERS =====================================================================================================-*/

INSERT INTO USERS(ID_USER, USERNAME, REGISTER_DATE, AGE, SEX)
VALUES(1, 'Mavil', '02-22-2007', 23, 'M');
INSERT INTO USERS(ID_USER, USERNAME, REGISTER_DATE, AGE, SEX)
VALUES(2, 'Serah', '02-25-2006', 22, 'M');
INSERT INTO USERS(ID_USER, USERNAME, REGISTER_DATE, AGE, SEX)
VALUES(3, 'HOTFLAMES30', '01-21-2004', 26, 'M');
INSERT INTO USERS(ID_USER, USERNAME, REGISTER_DATE, AGE, SEX)
VALUES(4, 'Summer', '02-22-2001', 28, 'F');
INSERT INTO USERS(ID_USER, USERNAME, REGISTER_DATE, AGE, SEX)
VALUES(5, 'Azrod95', '01-01-2001', 15, 'M');

/*-========================================================================================================================================== GRADE SERIES ===============================================================================================-*/

INSERT INTO GRADE_SERIES(ID_USER, ID_SERIES, GRADE_SERIES, REVIEW_SERIES)
VALUES(1, 1, 9, 'I really enjoyed this series. Watching the main guy go from a good hearted teacher to a villain was really entertaining');
INSERT INTO GRADE_SERIES(ID_USER, ID_SERIES, GRADE_SERIES, REVIEW_SERIES)
VALUES(1, 2, 5, 'Meh, im not really into this stuff but its ok i guess');
INSERT INTO GRADE_SERIES(ID_USER, ID_SERIES, GRADE_SERIES, REVIEW_SERIES)
VALUES(1, 3, 6, 'Meh, it was aight');
INSERT INTO GRADE_SERIES(ID_USER, ID_SERIES, GRADE_SERIES, REVIEW_SERIES)
VALUES(1, 4, 1, 'I hate Horror');
INSERT INTO GRADE_SERIES(ID_USER, ID_SERIES, GRADE_SERIES, REVIEW_SERIES)
VALUES(1, 5, 3, 'Not really into old stuff');
INSERT INTO GRADE_SERIES(ID_USER, ID_SERIES, GRADE_SERIES, REVIEW_SERIES)
VALUES(1, 6, 10, 'Amazing');
INSERT INTO GRADE_SERIES(ID_USER, ID_SERIES, GRADE_SERIES, REVIEW_SERIES)
VALUES(1, 7, 5, 'Just Average!');


INSERT INTO GRADE_SERIES(ID_USER, ID_SERIES, GRADE_SERIES, REVIEW_SERIES)
VALUES(2, 6, 8, 'Very cool');
INSERT INTO GRADE_SERIES(ID_USER, ID_SERIES, GRADE_SERIES, REVIEW_SERIES)
VALUES(3, 6, 9, 'Very nice stuff happening here');
INSERT INTO GRADE_SERIES(ID_USER, ID_SERIES, GRADE_SERIES, REVIEW_SERIES)
VALUES(4, 6, 5, 'Its way too brainy for me');
INSERT INTO GRADE_SERIES(ID_USER, ID_SERIES, GRADE_SERIES, REVIEW_SERIES)
VALUES(4, 7, 10, 'I love this actor');


INSERT INTO GRADE_SERIES(ID_USER, ID_SERIES, GRADE_SERIES, REVIEW_SERIES)
VALUES(5, 7, 10, 'My first ever series! I love it!');



/*-============================================================================================================================================= GRADE_EPISODE =======================================================================================================-*/

INSERT INTO GRADE_EPISODE(ID_USER, ID_EPISODE, TITLE_EP, GRADE_EPISODE, REVIEW_EPISODE)
VALUES(1, 1, 'Pilot', 10, 'I liked it. Nice start');
INSERT INTO GRADE_EPISODE(ID_USER, ID_EPISODE, TITLE_EP, GRADE_EPISODE, REVIEW_EPISODE)
VALUES(2, 1, 'Pilot', 8, 'Watching this with my friend. Really enjoyed it');
INSERT INTO GRADE_EPISODE(ID_USER, ID_EPISODE, TITLE_EP, GRADE_EPISODE, REVIEW_EPISODE)
VALUES(1, 2, 'Cats in the Bag' ,10, 'Was pretty nice continuation');
INSERT INTO GRADE_EPISODE(ID_USER, ID_EPISODE, TITLE_EP, GRADE_EPISODE, REVIEW_EPISODE)
VALUES(1, 3, 'And the Bags in the River', 8, 'Nice Start');


INSERT INTO GRADE_EPISODE(ID_USER, ID_EPISODE, TITLE_EP, GRADE_EPISODE, REVIEW_EPISODE)
VALUES(1, 1, 'Tan-Men', 1, 'Nope! No horror for me');
INSERT INTO GRADE_EPISODE(ID_USER, ID_EPISODE, TITLE_EP, GRADE_EPISODE, REVIEW_EPISODE)
VALUES(2, 1, 'Tan-Men', 5, 'NOT SCARY ENOUGH!');


INSERT INTO GRADE_EPISODE(ID_USER, ID_EPISODE, TITLE_EP, GRADE_EPISODE, REVIEW_EPISODE)
VALUES(1, 3, 'Women and Children First', 5, 'Yeah ugh, this is not for me');
INSERT INTO GRADE_EPISODE(ID_USER, ID_EPISODE, TITLE_EP, GRADE_EPISODE, REVIEW_EPISODE)
VALUES(4, 3, 'Women and Children First', 9, 'As a feminist i really love this!');

/*-================================================================================================================================================== GENRE ======================================================================================================================-*/

INSERT INTO GENRE(ID_GENRE, NAME_GENRE)
VALUES(1, 'Mature');
INSERT INTO GENRE(ID_GENRE, NAME_GENRE)
VALUES(2, 'Mystery');
INSERT INTO GENRE(ID_GENRE, NAME_GENRE)
VALUES(3, 'Comedy');
INSERT INTO GENRE(ID_GENRE, NAME_GENRE)
VALUES(4, 'Science-Fiction');
INSERT INTO GENRE(ID_GENRE, NAME_GENRE)
VALUES(5, 'Anthology');
INSERT INTO GENRE(ID_GENRE, NAME_GENRE)
VALUES(6, 'Fantasy');
INSERT INTO GENRE(ID_GENRE, NAME_GENRE)
VALUES(7, 'Horror');
INSERT INTO GENRE(ID_GENRE, NAME_GENRE)
VALUES(8, 'Comedy-Drama');
INSERT INTO GENRE(ID_GENRE, NAME_GENRE)
VALUES(9, 'Police-Drama');

/*-================================================================================================================================================== HAS_TYPE ==========================================================================================================================-*/

INSERT INTO HAS_TYPE(ID_SERIES, ID_GENRE)
VALUES(1,1);
INSERT INTO HAS_TYPE(ID_SERIES, ID_GENRE)
VALUES(1,2);
INSERT INTO HAS_TYPE(ID_SERIES, ID_GENRE)
VALUES(2,2);
INSERT INTO HAS_TYPE(ID_SERIES, ID_GENRE)
VALUES(3,3);
INSERT INTO HAS_TYPE(ID_SERIES, ID_GENRE)
VALUES(3,4);
INSERT INTO HAS_TYPE(ID_SERIES, ID_GENRE)
VALUES(4,5);
INSERT INTO HAS_TYPE(ID_SERIES, ID_GENRE)
VALUES(4,6);
INSERT INTO HAS_TYPE(ID_SERIES, ID_GENRE)
VALUES(4,7);
INSERT INTO HAS_TYPE(ID_SERIES, ID_GENRE)
VALUES(4,8);
INSERT INTO HAS_TYPE(ID_SERIES, ID_GENRE)
VALUES(4,4);
INSERT INTO HAS_TYPE(ID_SERIES, ID_GENRE)
VALUES(5,9);

/*-================================================================================================================================================= FORUM ==================================================================================================================================-*/

INSERT INTO MESSAGE(ID_MESSAGE, LVL_MSG, ID_PARENT_MESSAGE, ID_USER, TITLE, CONTENT)
VALUES(1, 1, NULL,5, 'Show was nice', 'Ok, so i started watching it today and i just cant stop');
INSERT INTO MESSAGE(ID_MESSAGE, LVL_MSG, ID_PARENT_MESSAGE, ID_USER, TITLE, CONTENT)
VALUES(2, 2, 1, 2, NULL, 'I kinda disagree with you, show couldve been better');
INSERT INTO MESSAGE(ID_MESSAGE, LVL_MSG, ID_PARENT_MESSAGE, ID_USER, TITLE, CONTENT)
VALUES(3, 3, 2, 3, NULL, 'Are you dumb, this is all i wanted from it!');
INSERT INTO MESSAGE(ID_MESSAGE, LVL_MSG, ID_PARENT_MESSAGE, ID_USER, TITLE, CONTENT)
VALUES(4, 4, 3, 4, NULL, 'Stop arguing you monkeys, Harambe didnt die for this');
INSERT INTO MESSAGE(ID_MESSAGE, LVL_MSG, ID_PARENT_MESSAGE, ID_USER, TITLE, CONTENT)
VALUES(5, 5, 4, 1, NULL, 'You are not very smart, are you?');

INSERT INTO MESSAGE(ID_MESSAGE, LVL_MSG, ID_PARENT_MESSAGE, ID_USER, TITLE, CONTENT)
VALUES(6, 1, NULL, 5, 'BORING', 'Dropped it instantly');
INSERT INTO MESSAGE(ID_MESSAGE, LVL_MSG, ID_PARENT_MESSAGE, ID_USER, TITLE, CONTENT)
VALUES(7, 2, 6, 1, NULL, 'Keep your opinions for yourself you scum');
INSERT INTO MESSAGE(ID_MESSAGE, LVL_MSG, ID_PARENT_MESSAGE, ID_USER, TITLE, CONTENT)
VALUES(8, 3, 7, 3, NULL, 'No need to be so hostile bro');
INSERT INTO MESSAGE(ID_MESSAGE, LVL_MSG, ID_PARENT_MESSAGE, ID_USER, TITLE, CONTENT)
VALUES(9, 4, 6, 2, NULL, 'Try rewatching man, its really good');
INSERT INTO MESSAGE(ID_MESSAGE, LVL_MSG, ID_PARENT_MESSAGE, ID_USER, TITLE, CONTENT)
VALUES(10, 5, 6, 4, NULL, 'How can you not like such masterpiece!');
INSERT INTO MESSAGE(ID_MESSAGE, LVL_MSG, ID_PARENT_MESSAGE, ID_USER, TITLE, CONTENT)
VALUES(11, 6, 6, 2, NULL, 'Man get out!');
INSERT INTO MESSAGE(ID_MESSAGE, LVL_MSG, ID_PARENT_MESSAGE, ID_USER, TITLE, CONTENT)
VALUES(12, 7, 6, 1, NULL, 'Whats wrong with you');
INSERT INTO MESSAGE(ID_MESSAGE, LVL_MSG, ID_PARENT_MESSAGE, ID_USER, TITLE, CONTENT)
VALUES(13, 8, 7, 5, NULL, 'Its a forum, learn to take criticism');

/*-============================================================================================================================================================================================================-*/
/*-====================================================================================== SELECT ZONE  =========================================================================================================-*/
/*-============================================================================================================================================================================================================-*/

-- 1 --
SELECT TITLE as Series FROM SERIES;

-- 2 --
SELECT UNIQUE COUNT(COUNTRY) as Different_Countries FROM SERIES;

-- 3 --
SELECT TITLE as Series FROM SERIES
WHERE COUNTRY = 'Japan'
ORDER BY TITLE;

-- 4 --

SELECT COUNT(ID_SERIES) as Nb_of_Series, COUNTRY FROM SERIES
GROUP BY COUNTRY;

-- 5 --
SELECT COUNT(ID_SERIES) as Series FROM SERIES
WHERE YEAR>= '01-01-2001' AND YEAR<='12-31-2015';

-- 6 --

SELECT TITLE FROM SERIES LEFT JOIN HAS_TYPE USING (ID_SERIES) LEFT JOIN GENRE USING (ID_GENRE)
WHERE NAME_GENRE = 'Comedy' and TITLE IN(
    SELECT TITLE FROM SERIES LEFT JOIN HAS_TYPE USING (ID_SERIES) LEFT JOIN GENRE USING (ID_GENRE)
    WHERE NAME_GENRE = 'Science-Fiction');
    
-- 7 --

SELECT TITLE, YEAR FROM SERIES LEFT JOIN PRODUCERS USING (ID_SERIES) LEFT JOIN STAFF USING (ID_STAFF)
WHERE NAME = 'Spielberg'
ORDER BY YEAR DESC;

-- 8 --

SELECT TITLE, COUNT(ID_SEASON) FROM SERIES LEFT JOIN SEASON USING (ID_SERIES)
WHERE COUNTRY = 'USA'
GROUP BY TITLE
ORDER BY COUNT(ID_SEASON) ASC;

-- 9 --
SELECT TITLE, COUNT(ID_EPISODE) FROM SERIES LEFT JOIN SEASON USING (ID_SERIES) LEFT JOIN EPISODE USING (ID_SEASON)
Group by TITLE
HAVING COUNT(ID_EPISODE)=(
SELECT  Max(COUNT(ID_EPISODE)) FROM SERIES LEFT JOIN SEASON USING (ID_SERIES) LEFT JOIN EPISODE USING (ID_SEASON)
GROUP BY TITLE);

-- 10 --
SELECT SEX, AVG(GRADE_SERIES) FROM USERS LEFT JOIN GRADE_SERIES USING (ID_USER) LEFT JOIN SERIES USING (ID_SERIES)
WHERE TITLE = 'Big Bang Theory'
GROUP BY SEX
HAVING AVG(GRADE_SERIES)=(
SELECT MAX(AVG(GRADE_SERIES)) FROM USERS LEFT JOIN GRADE_SERIES USING (ID_USER) LEFT JOIN SERIES USING (ID_SERIES)
WHERE TITLE = 'Big Bang Theory'
Group by SEX);

-- 11 --
SELECT AVG(GRADE_SERIES), TITLE FROM SERIES RIGHT JOIN GRADE_SERIES USING (ID_SERIES)
GROUP BY TITLE
HAVING AVG(GRADE_SERIES)<5
ORDER BY AVG(GRADE_SERIES) ASC;

-- 12 --
SELECT TITLE, REVIEW_SERIES FROM(
SELECT ID_SERIES, REVIEW_SERIES FROM( SELECT ID_SERIES as IDMAX, MAX(GRADE_SERIES) as G_MAX FROM SERIES LEFT JOIN GRADE_SERIES USING (ID_SERIES)
GROUP BY ID_SERIES) LEFT JOIN GRADE_SERIES ON (IDMAX = ID_SERIES AND G_MAX = GRADE_SERIES)) LEFT JOIN SERIES USING (ID_SERIES);

-- 13 --

SELECT TITLE, AVG(GRADE_EPISODE) FROM GRADE_EPISODE LEFT JOIN EPISODE USING (ID_EPISODE, TITLE_EP) LEFT JOIN SEASON USING(ID_SEASON) LEFT JOIN SERIES USING (ID_SERIES)
GROUP BY TITLE
HAVING AVG(GRADE_EPISODE)>8;

-- 14 --
SELECT AVG(Episodes_acted) from(
SELECT COUNT(ID_EPISODE) as Episodes_acted FROM EPISODE LEFT JOIN ACTING USING (ID_EPISODE, TITLE_EP) LEFT JOIN ACTOR USING (ID_ACTOR) LEFT JOIN SEASON USING (ID_SEASON) LEFT JOIN SERIES USING (ID_SERIES)
WHERE A_NAME = 'Cranston'
GROUP BY TITLE);

-- 15 --

SELECT W_SURNAME, W_NAME FROM WRITER
WHERE W_SURNAME IN (SELECT A_SURNAME FROM ACTOR) AND W_NAME IN (SELECT A_NAME FROM ACTOR);

--16--
SELECT TITLE, A_NAME, A_SURNAME, EPISODES_ACTED, TOTAL FROM(
SELECT TITLE, A_NAME, A_SURNAME, Episodes_acted, TOTAL FROM( 
    SELECT TITLE,ID_ACTOR, COUNT(ID_EPISODE) as Episodes_acted FROM EPISODE LEFT JOIN ACTING USING (ID_EPISODE, TITLE_EP) LEFT JOIN ACTOR USING (ID_ACTOR) LEFT JOIN SEASON USING (ID_SEASON) LEFT JOIN SERIES USING (ID_SERIES)
        GROUP BY TITLE,ID_ACTOR) LEFT JOIN ACTOR USING (ID_ACTOR) LEFT JOIN(
                SELECT TITLE, COUNT(ID_EPISODE) as TOTAL FROM EPISODE LEFT JOIN SEASON USING (ID_SEASON) LEFT JOIN SERIES USING (ID_SERIES)
                GROUP BY TITLE) USING (TITLE))
WHERE (EPISODES_ACTED * 100) / TOTAL>80;

/*
1 - - - - - - - - - - - -  X
9  - - - - - - - - - - - - 100

X = EPISODES_ACTED x 100 / total
*/

-- 17 --
SELECT A_NAME, A_SURNAME FROM(
SELECT TITLE, ID_ACTOR, Count FROM(
Select TITLE, ID_ACTOR, count(ID_EPISODE) as Count FROM EPISODE LEFT JOIN ACTING USING (ID_EPISODE, TITLE_EP) LEFT JOIN ACTOR USING (ID_ACTOR) LEFT JOIN SEASON USING (ID_SEASON) LEFT JOIN SERIES USING (ID_SERIES)
GROUP BY TITLE, ID_ACTOR)
WHERE TITLE = 'Breaking Bad' and Count =(
        SELECT COUNT (ID_EPISODE) FROM EPISODE LEFT JOIN SEASON USING (ID_SEASON) LEFT JOIN SERIES USING (ID_SERIES)
        WHERE TITLE = 'Breaking Bad')) LEFT JOIN ACTOR USING (ID_ACTOR);

-- 18--

SELECT USERNAME from(
        SELECT ID_USER, COUNT(GRADE_SERIES) as GRADED_SERIES FROM GRADE_SERIES
        GROUP BY ID_USER) LEFT JOIN USERS USING (ID_USER)
        WHERE GRADED_SERIES = (
                SELECT count(ID_SERIES) as TOTAL from SERIES);

-- 19 --

SELECT LVL_MSG, TITLE FROM MESSAGE;

-- Chaque message de niveau 1 est le start de discussion donc il a un titre. Chaque autre message de type (REPLY) a le niveau incrementé et un lien vers un autre message.  

-- 20 --
SELECT AVG(COUNT_PER_AZROD_MSG) FROM(
SELECT COUNT(ID_MESSAGE) as COUNT_PER_AZROD_MSG FROM(
SELECT ID_MESSAGE as Azrod_ID FROM MESSAGE LEFT JOIN USERS USING (ID_USER)
WHERE USERNAME = 'Azrod95' and LVL_MSG = 1)
        LEFT JOIN MESSAGE ON (ID_PARENT_MESSAGE = Azrod_ID)
        GROUP BY AZROD_ID);


/*

TEST SECTION TO SEE IF EVERYTHING WORKS PROPERLY

SELECT * FROM SERIES;
SELECT * FROM STAFF;
SELECT * FROM CREATORS;
SELECT * FROM PRODUCERS;
SELECT * FROM SEASON;
SELECT * FROM EPISODE;
SELECT * FROM ACTOR;
SELECT * FROM ACTING;
SELECT * FROM WRITER;
SELECT * FROM WRITTEN_BY;
SELECT * FROM USERS;
SELECT * FROM GRADE_SERIES;
SELECT * FROM GRADE_SEASON;
SELECT * FROM GENRE;
SELECT * FROM HAS_TYPE;
SELECT * FROM MESSAGE;
*/