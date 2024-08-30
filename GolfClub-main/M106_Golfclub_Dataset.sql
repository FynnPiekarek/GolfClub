use Golfclub

INSERT INTO Mitglied (Vorname, Nachname, Geburtsdatum, Telefonnummer, WeitesterSchuss)
VALUES
('Max', 'Mustermann', '1990-01-01', '123456789', 250),
('Anna', 'Musterfrau', '1985-05-15', '987654321', 220),
('Peter', 'Schmidt', '1995-09-30', '555666777', 200),
('Lena', 'Meier', '1988-07-20', '111222333', 230),
('Markus', 'Schulz', '1992-03-12', '999888777', 260),
('Sabine', 'Wagner', '1983-11-05', '444333222', 210),
('Thomas', 'Becker', '1998-02-28', '777888999', 240),
('Julia', 'Koch', '1987-06-18', '666555444', 215),
('Michael', 'Lange', '1991-09-15', '333444555', 225),
('Christina', 'Hofmann', '1984-12-10', '222111000', 255),
('Andreas', 'Bauer', '1993-04-25', '888999000', 205),
('Nicole', 'Fischer', '1986-08-30', '777666555', 235),
('Daniel', 'Schwarz', '1997-01-05', '666555444', 245),
('Lisa', 'Schmidt', '1989-05-22', '555444333', 225),
('Patrick', 'Müller', '1994-10-15', '444333222', 260);

-- Daten für Standorte-Tabelle einfügen
INSERT INTO Standort (Bezeichnung, Fläche, Postleitzahl)
VALUES
('Luzern', 150.5, '6005'),
('Oberkirch', 200.2, '6208'),
('Goldenberg', 180.0, '6124'),
('Bubikon', 160.8, '6420'),
('Limpach', 190.3, '4001');

-- Daten für Material-Tabelle einfügen
INSERT INTO Material (Bezeichnung, Marke)
VALUES
('Golfball', 'Nike'),
('Schläger', 'Callaway'),
('Golfschuhe', 'Rebook'),
('Golftasche', 'Rebook'),
('Golfball','Rebook'),
('Golftasche', 'TaylorMade'),
('Schläger', 'Nike'),
('Golfball', 'Callaway'),
('Golfball', 'TaylorMade'),
('Golfschuhe', 'Adidas'),
('Golfball', 'Adidas'),
('Golfball', 'Puma'),
('Schläger', 'Adidas'),
('Schläger', 'Rebook'),
('Golftasche', 'Nike');

INSERT INTO MitgliederMaterial (Anzahl, fk_MitgliederID, fk_MaterialID) VALUES
    (3, 6, 1),
    (5, 7, 2),
    (2, 8, 3),
    (4, 9, 4),
    (1, 10, 5),
    (2, 11, 6),
    (3, 12, 7),
    (5, 13, 8),
    (4, 14, 9),
    (3, 15, 10),
    (6, 1, 11),
    (2, 2, 12),
    (4, 3, 13),
    (3, 4, 14),
    (5, 5, 15),
    (2, 4, 11),
    (3, 6, 5),
    (1, 8, 15),
    (4, 10, 3),
    (2, 15, 9);
-- Daten für Turniere-Tabelle einfügen
-- Daten für Turniere-Tabelle einfügen
INSERT INTO Turnier (Datum, Dauer, fk_StandortID)
VALUES
('2023-03-01', 120, 4),
('2023-04-15', 200, 3),
('2023-06-10', 170, 1),
('2023-07-20', 310, 5),
('2023-09-05', 100, 2),
('2023-10-12', 445, 3),
('2023-11-25', 375, 1),
('2024-01-08', 290, 5),
('2024-03-15', 315, 2),
('2024-05-02', 400, 3);
 
 --Daten für TurnierMitglied-Tabelle einfügen
-- Daten für Turniere-Tabelle einfügen
INSERT INTO TurnierMitglied (Rang, fk_MitgliederID, fk_TurnierID, HatPreisGewonnen) VALUES
(6, 1, 1, 0),
(4, 2, 2, 0),
(7, 3, 3, 0),
(5, 4, 4, 0),
(2, 5, 5, 1),
(3, 6, 6, 1),
(4, 7, 7, 0),
(1, 8, 8, 1),
(6, 9, 9, 0),
(2, 10, 10, 1),
(5, 11, 1, 0),
(3, 12, 2, 0),
(4, 13, 3, 0),
(7, 14, 4, 0),
(2, 1, 6, 0),
(3, 2, 7, 0),
(5, 3, 8, 0),
(4, 4, 9, 0),
(6, 5, 10, 0),
(1, 6, 1, 1),
(7, 7, 2, 0),
(2, 8, 3, 1),
(3, 9, 4, 0),
(5, 10, 5, 0),
(4, 11, 6, 0),
(6, 12, 7, 0),
(1, 13, 8, 1),
(7, 14, 9, 0);
