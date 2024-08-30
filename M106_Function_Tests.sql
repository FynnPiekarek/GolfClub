use Golfclub
go

print dbo.fn_GetRang(12,2) -- korekte eingabe beider Werte

print dbo.fn_GetRang(6, null) --Korrekte eingabe um den Allgemeinen Ranglistenplatz von 6 auszurechnen.

print dbo.fn_GetRang(6, 5) --Mitglied6 hat nicht bei Turnier5 Mitgemacht. Fehlercode -3
    
print dbo.fn_GetRang(23, 5) --Mitglied existiert nicht. Fehlercode -1

print dbo.fn_GetRang(null,4) --Mitglied wurde nicht übergeben. Fehlercode -1

print dbo.fn_GetRang(13, 43) --Turnier existiert nicht. Fehlercode -2

