USE Golfclub;
--Normaler Testfall
DECLARE @MitgliederIDs VARCHAR(MAX) = '1,3;2,4;3,2;4,2';
EXEC ErstelleNeuesTurnier
    '2023-8-08',
    453,
    1,
    @MitgliederIDs;