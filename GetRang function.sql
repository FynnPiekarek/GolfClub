USE Golfclub;
GO

DROP FUNCTION IF EXISTS fn_GetRang;
GO

CREATE FUNCTION fn_GetRang(@Mitgliedid INT, @Turnierid INT)
RETURNS INT
AS BEGIN
    DECLARE @SpielerRank INT = 1;
    DECLARE @SpielerAverageRank FLOAT;
    DECLARE @ParticipationCount INT;
    DECLARE @WeightedRank FLOAT;

    --Prüfen, ob Mitgliedid gültig ist.
    IF @Mitgliedid IS NULL OR @Mitgliedid NOT IN (SELECT MitgliederID FROM Mitglied)
    BEGIN
      RETURN -1; -- Fehlercode: Mitglied ungültig
    END

    -- Prüfen, ob Turnierid gültig ist. Wenn Turnier null ist, gibt es den allgemeinen Rang des Spielers aus.
    IF @Turnierid IS NULL
    BEGIN
    if @Mitgliedid not in (select fk_MitgliederID from TurnierMitglied)
    begin
      set @SpielerRank = (select count(DISTINCT fk_MitgliederID) from TurnierMitglied) + 1
      return @SpielerRank;
    end

      SET @SpielerAverageRank = (SELECT AVG(CAST(Rang AS FLOAT)) FROM TurnierMitglied
                                 WHERE fk_MitgliederID = @Mitgliedid);
      SET @ParticipationCount = (SELECT COUNT(*) FROM TurnierMitglied
                                 WHERE fk_MitgliederID = @Mitgliedid);

      SET @WeightedRank = @SpielerAverageRank * (1 + (1.0 / @ParticipationCount));

      -- Rang Aussrechenen 
      SELECT @SpielerRank = COUNT(DISTINCT otherWeightedRank) + 1
      FROM (SELECT AVG(CAST(Rang AS FLOAT)) * (1 + (1.0 / COUNT(*))) AS otherWeightedRank 
            FROM TurnierMitglied
            GROUP BY fk_MitgliederID) AS SubQuery
      WHERE otherWeightedRank < @WeightedRank;

      RETURN @SpielerRank;
    END
    ELSE IF @Turnierid NOT IN (SELECT TurnierID FROM Turnier)
    BEGIN
      RETURN -2; -- Fehlercode: Turnier ungültig
    END

    -- Prüfen, ob Spieler am Turnier teilgenommen hat.
    IF @Mitgliedid NOT IN (SELECT fk_MitgliederID FROM TurnierMitglied WHERE @Turnierid = fk_TurnierID)
    BEGIN
      RETURN -3 ; -- Fehlercode: Spieler nicht in diesem Turnier
    END

    SET @SpielerRank = (SELECT Rang FROM TurnierMitglied WHERE fk_MitgliederID = @Mitgliedid AND fk_TurnierID = @Turnierid);

    RETURN @SpielerRank;
END;
GO

--Tesfälle
--print dbo.fn_GetRang(12,2) -- korekte eingabe beider Werte
--print dbo.fn_GetRang(10,10) --korekte eingabe beider Werte

--print dbo.fn_GetRang(6, 5) --Mitglied6 hat nicht bei Turnier5 Mitgemacht. Fehlercode -3
    
--print dbo.fn_GetRang(23, 5) --Mitglied existiert nicht. Fehlercode -1
--print dbo.fn_GetRang(null,4) --Mitglied existiert nicht oder wurde nicht übergeben. Fehlercode -1

--print dbo.fn_GetRang(13, 43) --Turnier existiert nicht. Fehlercode -2
--print dbo.fn_GetRang(13, null) --Korrekte eingabe um den Allgemeinen Ranglistenplatz von 13 auszurechnen.
