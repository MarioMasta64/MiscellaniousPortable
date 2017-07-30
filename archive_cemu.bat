@echo off
cls
Color 0A

set /a cycle1=0
set /a cycle2=0
set /a cycle3=-1

if not exist .\extra\ mkdir .\extra\
for /f "delims=" %%i in ('dir /b /s /a-d ^| findstr /i "cemu_*.zip"') do del "%%~i"

if exist index.html del index.html
.\bin\wget.exe -q --show-progress http://cemu.info/
if not exist index.html goto Start-Cemu
for /f tokens^=2delims^=^" %%A in (
  'findstr /i /c:"http://cemu.info/releases/" /c:"http://cemu.info/releases/" index.html'
) Do > cemu_link.txt Echo:%%A
set /p cemu_link=<cemu_link.txt
if exist cemu_link.txt del cemu_link.txt
if exist index.html del index.html

:loop
set /a cycle3+=1
if %cycle3%==10 set /a cycle3=0 & set /a cycle2+=1
if %cycle2%==10 set /a cycle2=0 & set /a cycle1+=1
if %cycle1%==10 set /a cycle1=0 & echo done archiving & pause & exit
call :download
goto loop

:download
title Downloading http://cemu.info/releases/cemu_%cycle1%.%cycle2%.%cycle3%.zip - Cemu Archiver - By MarioMasta64
if exist cemu_%cycle1%.%cycle2%.%cycle3%.zip del /s /q cemu_%cycle1%.%cycle2%.%cycle3%.zip >nul
if exist .\extra\cemu_%cycle1%.%cycle2%.%cycle3%.zip echo http://cemu.info/releases/cemu_%cycle1%.%cycle2%.%cycle3%.zip is already archived
if not exist .\extra\cemu_%cycle1%.%cycle2%.%cycle3%.zip .\bin\wget.exe -q --show-progress http://cemu.info/releases/cemu_%cycle1%.%cycle2%.%cycle3%.zip
if exist cemu_%cycle1%.%cycle2%.%cycle3%.zip move cemu_%cycle1%.%cycle2%.%cycle3%.zip .\extra\cemu_%cycle1%.%cycle2%.%cycle3%.zip >nul
if "http://cemu.info/releases/cemu_%cycle1%.%cycle2%.%cycle3%.zip"=="%cemu_link%" echo done archiving & pause >nul & exit
(goto) 2>nul