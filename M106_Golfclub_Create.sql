use master
go
drop database if exists Golfclub
go
create database Golfclub
go
use Golfclub
go
CREATE TABLE Mitglied (
    MitgliederID INT identity,
    Vorname VARCHAR(50),
    Nachname VARCHAR(50),
    Geburtsdatum DATE,
    Telefonnummer VARCHAR(20),
    WeitesterSchuss INT,
    primary key(MitgliederID)
);

CREATE TABLE Standort (
    StandortID int identity,
    Bezeichnung VARCHAR(100),
    Fläche Float,
    Postleitzahl VARCHAR(10),
    primary key(StandortID)
);
go
CREATE TABLE Material (
    MaterialID INT identity,
    Bezeichnung VARCHAR(100),
    Marke VARCHAR(50),
    primary key(MaterialID),
);
go
CREATE TABLE MitgliederMaterial (
    MitgliederMaterialID INT identity,
    Anzahl INT,
    fk_MitgliederID INT,
    fk_MaterialID INT,
    primary key(MitgliederMaterialID),
    FOREIGN KEY (fk_MitgliederID) REFERENCES Mitglied(MitgliederID),
    FOREIGN KEY (fk_MaterialID) REFERENCES Material(MaterialID)
);

CREATE TABLE Turnier (
    TurnierID INT identity,
    Datum DATE,
    Dauer INT,
    fk_StandortID INT,
    primary key (TurnierID),
    FOREIGN KEY (fk_StandortID) REFERENCES Standort(StandortID)
);
go
CREATE TABLE TurnierMitglied (
    TurnierMitgliedID INT identity,
    Rang INT,
    fk_MitgliederID INT,
    fk_TurnierID INT,
    HatPreisGewonnen bit,
    primary key(TurnierMitgliedID),
    FOREIGN KEY (fk_MitgliederID) REFERENCES Mitglied(MitgliederID),
    FOREIGN KEY (fk_TurnierID) REFERENCES Turnier(TurnierID)
);
