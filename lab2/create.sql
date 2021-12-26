-- delete tables if it was created earlier !

DROP TABLE IF EXISTS Beers Cascade;
DROP TABLE IF EXISTS Breweries Cascade;
DROP TABLE IF EXISTS Styles Cascade;
DROP TABLE IF EXISTS Locations Cascade;
DROP TABLE IF EXISTS Types Cascade;
DROP TABLE IF EXISTS Breweries_Types Cascade;

---------------------------
-- Create main tables
---------------------------

CREATE TABLE Beers
(
    beer_id     int         NOT NULL UNIQUE ,
    brewery_id  int         NOT NULL ,
    style_id    int         NULL ,
    name        char(128)   NULL ,
    abv         float       NULL
);

CREATE TABLE Breweries
(
    brewery_id  int         NOT NULL UNIQUE ,
    loc_id      int         NULL ,
    name        char(128)   NOT NULL
);

---------------------------
-- Create extra tables
---------------------------

CREATE TABLE Styles
(
    style_id    int         NOT NULL UNIQUE ,
    name        char(128)   NOT NULL
);


CREATE TABLE Locations
(
    loc_id      int         NOT NULL UNIQUE ,
    country     char(32)    NOT NULL ,
    state       char(32)    NULL ,
    city        char(32)    NULL
);

CREATE TABLE Types
(
    type_id     int         NOT NULL UNIQUE ,
    name        char(64)    NOT NULL
);

CREATE TABLE Breweries_Types
(
    brewery_id  int         NOT NULL,
    type_id     int         NOT NULL

);

---------------------------
-- Define primary keys
---------------------------

ALTER TABLE Beers ADD CONSTRAINT PK_Beers
    PRIMARY KEY (beer_id);
ALTER TABLE Breweries ADD CONSTRAINT PK_Breweries
    PRIMARY KEY (brewery_id);
ALTER TABLE Styles ADD CONSTRAINT PK_Styles
    PRIMARY KEY (style_id);
ALTER TABLE Locations ADD CONSTRAINT PK_Locations
    PRIMARY KEY (loc_id);
ALTER TABLE Types ADD CONSTRAINT PK_Types
    PRIMARY KEY (type_id);
ALTER TABLE Breweries_Types ADD CONSTRAINT PK_Breweries_Types
    PRIMARY KEY (brewery_id, type_id);

---------------------------
-- Define foreign keys
---------------------------

ALTER TABLE Beers ADD CONSTRAINT FK_Beer_Brewery
    FOREIGN KEY (brewery_id) REFERENCES Breweries (brewery_id);
ALTER TABLE Beers ADD CONSTRAINT FK_Beer_Style
    FOREIGN KEY (style_id) REFERENCES Styles (style_id);
ALTER TABLE Breweries ADD CONSTRAINT FK_Brewery_Location
    FOREIGN KEY (loc_id) REFERENCES Locations (loc_id);
ALTER TABLE Breweries_Types ADD CONSTRAINT FK_Breweries_Types_Brewery
    FOREIGN KEY (brewery_id) REFERENCES Breweries (brewery_id);
ALTER TABLE Breweries_Types ADD CONSTRAINT FK_Breweries_Types_Type
    FOREIGN KEY (type_id) REFERENCES Types (type_id);
