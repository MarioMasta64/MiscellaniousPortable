 
'The location of the zip file. 
ZipFile="F:\extra\cemu_1.8.2.zip" 
'The folder the contents should be extracted to. 
ExtractTo="F:\bin\cemu\" 
 
'If the extraction location does not exist create it. 
Set fso = CreateObject("Scripting.FileSystemObject") 
If NOT fso.FolderExists(ExtractTo) Then 
   fso.CreateFolder(ExtractTo) 
End If 
 
'Extract the contants of the zip file. 
set objShell = CreateObject("Shell.Application") 
set FilesInZip=objShell.NameSpace(ZipFile).items 
objShell.NameSpace(ExtractTo).CopyHere(FilesInZip) 
Set fso = Nothing 
Set objShell = Nothing 
 
