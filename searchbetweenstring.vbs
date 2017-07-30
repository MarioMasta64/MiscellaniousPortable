strFileName = Wscript.Arguments(0) 
Const ForReading = 1 
Set objFSO = CreateObject("Scripting.FileSystemObject") 
Set objFile = objFSO.OpenTextFile("temp.txt", ForReading) 
strContents = objFile.ReadAll 
objFile.Close 
strStartText = Wscript.Arguments(1) 
strEndText = Wscript.Arguments(2) 
intStart = InStr(strContents, strStartText) 
intStart = intStart + Len(strStartText) 
intEnd = InStr(strContents, strEndText) 
intCharacters = intEnd - intStart 
strText = Mid(strContents, intStart, intCharacters) 
Wscript.Echo strText 
