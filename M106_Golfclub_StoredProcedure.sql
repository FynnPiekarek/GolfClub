use Golfclub
go
DROP PROCEDURE IF EXISTS dbo.ErstelleNeuesTurnier;
go
CREATE PROCEDURE ErstelleNeuesTurnier
    @Datum DATE = NULL,
    @Dauer INT = NULL,
    @StandortID INT = NULL,
    @MitgliederIDs VARCHAR(MAX) = NULL
AS
BEGIN
  -- Prüfe und setze Standardwerte
  IF @Datum IS NULL
      SET @Datum = GETDATE();

  -- Überprüfe auf leere Werte
  IF @MitgliederIDs IS NULL
      BEGIN
          THROW 50000, 'Fehler: MitgliederID darf nicht leer sein.', 1;
          RETURN;
      END;

  -- Füge neues Turnier hinzu
  DECLARE @NeueTurnierID INT;
  INSERT INTO Turnier (Datum, Dauer, fk_StandortID)
  VALUES (@Datum, @Dauer, @StandortID);

  SET @NeueTurnierID = SCOPE_IDENTITY();

  -- Füge Mitglieder zum Turnier hinzu
  DECLARE @HatPreisGewonnen BIT;

  DECLARE @MitgliedID INT;
  DECLARE @Rang INT;

  DECLARE MitgliederCursor CURSOR FOR
      SELECT 
          TRY_CAST(SUBSTRING(value, 1, CHARINDEX(',', value) - 1) AS INT) AS MitgliedID,
          TRY_CAST(SUBSTRING(value, CHARINDEX(',', value) + 1, LEN(value)) AS INT) AS Rang
      FROM STRING_SPLIT(@MitgliederIDs, ';');

  OPEN MitgliederCursor;
  FETCH NEXT FROM MitgliederCursor INTO @MitgliedID, @Rang;

  WHILE @@FETCH_STATUS = 0
  BEGIN
      -- Überprüfe auf leere MitgliederID
      IF @MitgliedID IS NULL
      BEGIN
          THROW 50000, 'Fehler: MitgliederID darf nicht leer sein.', 1;
          CLOSE MitgliederCursor;
          DEALLOCATE MitgliederCursor;
          RETURN;
      END;
  
      -- Überprüfe auf leeren Rang
    IF @Rang IS NULL
    BEGIN
        THROW 50000, 'Fehler: Rang darf nicht leer sein.', 1;
        CLOSE MitgliederCursor;
        DEALLOCATE MitgliederCursor;
        RETURN;
    end;

    -- Füge Mitglied zum Turnier hinzu
    INSERT INTO TurnierMitglied (Rang, fk_MitgliederID, fk_TurnierID, HatPreisGewonnen) VALUES (@Rang, @MitgliedID, @NeueTurnierID, NULL)

    -- Überprüfe und setze HatPreisGewonnen
    SET @HatPreisGewonnen = CASE WHEN @Rang <= 3 THEN 1 ELSE 0 END;

    UPDATE TurnierMitglied
    SET HatPreisGewonnen = @HatPreisGewonnen
    WHERE TurnierMitgliedID = SCOPE_IDENTITY();

    FETCH NEXT FROM MitgliederCursor INTO @MitgliedID, @Rang;
  END;
END;