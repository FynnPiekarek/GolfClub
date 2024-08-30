USE Golfclub;
--Testfall mit heutigem Datum
DECLARE @MitgliederIDs VARCHAR(MAX) = '1,3;2,4;3,2;4,2';
EXEC ErstelleNeuesTurnier
    NULL,
    310,
    3,
    @MitgliederIDs;