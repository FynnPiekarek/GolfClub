use Golfclub;
--Testfall mit fehlenden ID's
DECLARE @MitgliederIDs VARCHAR(MAX) = NULL;
EXEC ErstelleNeuesTurnier
    '2025-7-01',
    421,
    2,
    @MitgliederIDs;