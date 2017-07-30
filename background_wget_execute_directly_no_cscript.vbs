Dim oShell
Set oShell = WScript.CreateObject ("WSCript.shell")
oShell.run  "WGET.EXE https://github.com/MarioMasta64/EverythingPortable/raw/master/note/index.txt", 6, true
Set oShell = Nothing