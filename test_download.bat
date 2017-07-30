@echo off
call :DOWNLOAD https://eternallybored.org/misc/wget/current/wget.exe wget.exe
pause
exit

:DOWNLOAD
set url=%1
set file=%2
echo ' Set your settings > download.vbs
echo    strFileURL = "%url%" >> download.vbs
echo    strHDLocation = "%file%" >> download.vbs
echo. >> download.vbs
echo ' Fetch the file >> download.vbs
echo     Set objXMLHTTP = CreateObject("MSXML2.XMLHTTP") >> download.vbs
echo. >> download.vbs
echo     objXMLHTTP.open "GET", strFileURL, false >> download.vbs
echo     objXMLHTTP.send() >> download.vbs
echo. >> download.vbs
echo If objXMLHTTP.Status = 200 Then >> download.vbs
echo Set objADOStream = CreateObject("ADODB.Stream") >> download.vbs
echo objADOStream.Open >> download.vbs
echo objADOStream.Type = 1 'adTypeBinary >> download.vbs
echo. >> download.vbs
echo objADOStream.Write objXMLHTTP.ResponseBody >> download.vbs
echo objADOStream.Position = 0    'Set the stream position to the start >> download.vbs
echo. >> download.vbs
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> download.vbs
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> download.vbs
echo Set objFSO = Nothing >> download.vbs
echo. >> download.vbs
echo objADOStream.SaveToFile strHDLocation >> download.vbs
echo objADOStream.Close >> download.vbs
echo Set objADOStream = Nothing >> download.vbs
echo End if >> download.vbs
echo. >> download.vbs
echo Set objXMLHTTP = Nothing >> download.vbs
cscript.exe download.vbs
exit /b