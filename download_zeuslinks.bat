@echo off
cls
Color 0A
title Download All The Links

for /f "delims=" %%i in ('dir /b /s /a-d ^| findstr /i "*.pkg"') do del "%%~i"

echo type local to use a local links.txt file
echo make sure the url ends with a zeuslinks.txt
set /p url="enter the url to download zeuslinks.txt from: "
if "%url%"=="local" goto Download

if not exist wget.exe cscript downloadwget.vbs

cls
title Downloading File
if exist zeuslinks.txt.bak del zeuslinks.txt.bak
:: -m to clone entire directory up to it
wget.exe -q --show-progress --user-agent="Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/534.3 (KHTML, like Gecko) Chrome/6.0.472.63 Safari/534.3" %url%
if exist zeuslinks.txt.1 rename zeuslinks.txt zeuslinks.txt.bak
if exist zeuslinks.txt.bak rename zeuslinks.txt.1 zeuslinks.txt

setlocal enabledelayedexpansion

cls
set Counter=0
for /f "tokens=1,* delims=" %%i in (zeuslinks.txt) do (
  set /a Counter+=1
  title Lines In File: !Counter!
)
set Max-Lines=!Counter!

cls
echo. > temp2.txt
set Counter=0
for /f "tokens=1,* delims=" %%i in (zeuslinks.txt) do (
  set /a Counter+=1
  title Searching Line: !Counter! Out Of !Max-Lines!
  echo %%i
  echo.
  echo %%i > temp.txt
  cscript searchbetweenstring.vbs zeuslinks.txt "http://" ".pkg" >> temp2.txt
  :: line 56 was lost here
  if not "%1"==""  (
    set url=%1
	echo %url% >> temp2.txt
  )
)

endlocal

cls
title Removing Specific Lines
cscript replacetext.vbs temp2.txt "Microsoft (R) Windows Script Host Version 5.812" ""
cscript replacetext.vbs temp2.txt "Copyright (C) Microsoft Corporation. All rights reserved." ""

setlocal enabledelayedexpansion

cls
set Counter=0
for /f "tokens=1,* delims=" %%i in (temp2.txt) do (
  set /a Counter+=1
  title Lines In File: !Counter!
)
set Max-Lines=!Counter!

cls
echo. > temp3.txt
set Counter=0
for /f "tokens=1,* delims=" %%i in (temp2.txt) do (
  set /a Counter+=1
  title Checking For Empty Lines: !Counter! Out Of !Max-Lines!
  if "%%i" NEQ "" echo %%i >> temp3.txt
)

endlocal

setlocal enabledelayedexpansion

cls
set Counter=0
for /f "tokens=1,* delims=" %%i in (temp3.txt) do (
  set /a Counter+=1
  title Lines In File: !Counter!
)
set Max-Lines=!Counter!

cls
echo. > temp4.txt
echo. > fix.txt
set Counter=0
for /f "tokens=1,* delims=" %%i in (temp3.txt) do (
  set /a Counter+=1
  title Checking For Bad URL: !Counter! Out Of !Max-Lines!
  set "i=%%i"
  
  if "!i:~0,23!" EQU "zeus.dl.playstation.net" echo %%i >> temp4.txt
  if "!i:~0,23!" EQU "ares.dl.playstation.net" echo %%i >> temp4.txt
  if "!i:~0,27!" EQU "hakoniwa.dl.playstation.net" echo %%i >> temp4.txt
  if "!i:~0,25!" EQU "apollo.dl.playstation.net" echo %%i >> temp4.txt
  if "!i:~0,25!" EQU "qmusic.dl.playstation.net" echo %%i >> temp4.txt
  if "!i:~0,27!" EQU "b0.ww.np.dl.playstation.net" echo %%i >> temp4.txt
  if "!i:~0,30!" EQU "videoeditor.dl.playstation.net" echo %%i >> temp4.txt

  if "!i:~0,23!" NEQ "zeus.dl.playstation.net" (
    if "!i:~0,23!" NEQ "ares.dl.playstation.net" (
      if "!i:~0,27!" NEQ "hakoniwa.dl.playstation.net" (
        if "!i:~0,25!" NEQ "apollo.dl.playstation.net" (
          if "!i:~0,25!" NEQ "qmusic.dl.playstation.net" (
            if "!i:~0,27!" NEQ "b0.ww.np.dl.playstation.net" (
              if "!i:~0,30!" NEQ "videoeditor.dl.playstation.net" echo %%i >> fix.txt
            )
          )
		)
      )
	)
  )

)

endlocal

setlocal enabledelayedexpansion

cls
set Counter=0
for /f "tokens=1,* delims=" %%i in (fix.txt) do (
  set /a Counter+=1
  title Lines In File: !Counter!
)
set Max-Lines=!Counter!

cls
cscript replacetext.vbs fix.txt "ECHO is off." ""
cscript replacetext.vbs fix.txt "?" ""
cscript replacetext.vbs fix.txt "'" ""
cscript replacetext.vbs fix.txt "%%3A" ":"
cscript replacetext.vbs fix.txt "%%2F" "/"
cscript replacetext.vbs fix.txt "plaasystation" "playstation"

cls
echo. > fix2.txt
set Counter=0
for /f "tokens=1,* delims=" %%i in (fix.txt) do (
  set /a Counter+=1
  title Fixing Bad URL: !Counter! Out Of !Max-Lines!
  if "%%i" NEQ "" (
    if "%%i" NEQ " " (
	  set i=%%i
      call :FixURL "%%i"
    )
  )
)

endlocal

setlocal enabledelayedexpansion

cls
set Counter=0
for /f "tokens=1,* delims=" %%i in (temp4.txt) do (
  set /a Counter+=1
  title Lines In File: !Counter!
)
set Max-Lines=!Counter!

cls
echo. > links.txt
set Counter=0
for /f "tokens=1,* delims= " %%i in (temp4.txt) do (
  set /a Counter+=1
  title Checking For Empty Lines: !Counter! Out Of !Max-Lines!
  if "%%i" NEQ "" echo %%i >> links.txt
)

endlocal

pause

:Download

setlocal enabledelayedexpansion

cls
set Counter=0
for /f "tokens=1,* delims=" %%i in (links.txt) do (
  set /a Counter+=1
  title Lines In File: !Counter!
)
set Max-Lines=!Counter!

cls
echo. > files.txt
echo. > error.txt
set Counter=0
for /f "tokens=1,* delims=" %%i in (links.txt) do (
  set /a Counter+=1
  title Getting Filename: Line !Counter! Out Of !Max-Lines!
  if "%%i" NEQ " " (
    set i=%%i
    set /a SlashCount=0
    call :FileName-Extractor
	set file=!file!.pkg
	if exist !file! del !file!
	if exist .\extra\!file! echo !file! is downloaded
	if not exist .\extra\!file! call :Download-File
  )
)

endlocal

echo zeus links downloaded & pause & exit

:fixURL
set "i=%1"

:FixURL-Loop
cls
set "i=!i:~1,-1!"
echo !i!
if "!i:~0,23!" EQU "zeus.dl.playstation.net" (
  echo !i! >> temp4.txt
  (goto) 2>nul
)
if "!i:~0,23!" EQU "ares.dl.playstation.net" (
  echo !i! >> temp4.txt
  (goto) 2>nul
)
if "!i:~0,27!" EQU "hakoniwa.dl.playstation.net" (
  echo !i! >> temp4.txt
  (goto) 2>nul
)
if "!i:~0,25!" EQU "apollo.dl.playstation.net" (
  echo !i! >> temp4.txt
  (goto) 2>nul
)
if "!i:~0,25!" EQU "qmusic.dl.playstation.net" (
  echo !i! >> temp4.txt
  (goto) 2>nul
)
if "!i:~0,27!" EQU "b0.ww.np.dl.playstation.net" (
  echo !i! >> temp4.txt
  (goto) 2>nul
)
if "!i:~0,30!" EQU "videoeditor.dl.playstation.net" (
  echo !i! >> temp4.txt
  (goto) 2>nul
)
if "!i:~0,17!" EQU "l.playstation.net" (
  echo !i! >> fix2.txt
  (goto) 2>nul
)
if "!i!"=="" (goto) 2>nul
goto FixURL-Loop

:Download-File
title Downloading File: Line !Counter! Out Of !Max-Lines!
  :: wget.exe -q --show-progress --user-agent="Mozilla/5.0 (PLAYSTATION 3; 3.55)" "http://!i:~0,-1!.pkg"
  wget.exe -q --show-progress --user-agent="Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/534.3 (KHTML, like Gecko) Chrome/6.0.472.63 Safari/534.3" "http://!i:~0,-1!.pkg"
)
move !file! .\extra\!file! >nul
(goto) 2>nul

:FileName-Extractor
set file=!i!

:FileName-Extractor-Loop
if "!file:~0,1!" EQU "/" (
  set /a SlashCount+=1
  set file=!file:~1,999!
  if !SlashCount! EQU 4 (
	set file=!file:~0,-1!
	echo !file! >> files.txt
	(goto) 2>nul
  )
)
if "!file:~0,1!" NEQ "/" (
  set file=!file:~1,999!
)
  if "!file:~0,1!" EQU "" (
  echo !i! >> error.txt & (goto) 2>nul
)
goto FileName-Extractor-Loop
(goto) 2>nul
