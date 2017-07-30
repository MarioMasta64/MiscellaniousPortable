@echo off
cls
Color 0A

:: set /a cycle1=0
:: set /a cycle2=0
:: set /a cycle3=-1

set /a cycle1=2
set /a cycle2=5
set /a cycle3=0

if not exist .\extra\ mkdir .\extra\
for /f "delims=" %%i in ('dir /b /s /a-d ^| findstr /i "dolphin_*.exe"') do del "%%~i"

goto skipcheck

if exist index.html del index.html
.\bin\wget.exe -q --show-progress https://dolphin-emu.org/download/
pause

if not exist index.html goto Start-Dolphin
for /f tokens^=2delims^=^" %%A in (
  'findstr /i /c:"https://dl-mirror.dolphin-emu.org/" /c:"https://dl-mirror.dolphin-emu.org/" index.html'
) Do > dolphin_link.txt Echo:%%A
set /p dolphin_link=<dolphin_link.txt
if %dolphin_link:~37,1%==/ set dolphin_ver=%dolphin_link:~34,3%
if %dolphin_link:~37,1%==. set dolphin_ver=%dolphin_link:~34,5%
echo %dolphin_ver%
:: if %dolphin_link:~37,1%==/ echo %dolphin_link:~38,99%
:: if %dolphin_link:~37,1%==. echo %dolphin_link:~40,99%
pause
if exist dolphin_link.txt del dolphin_link.txt
if exist index.html del index.html
pause

:skipcheck

:loop
if %cycle1% LSS 4 (
  set /a cycle3+=0
  set /a cycle2+=5
)
if %cycle1% GEQ 4 (
  set /a cycle3+=1
)
if %cycle3%==10 set /a cycle3=0 & set /a cycle2+=1
if %cycle2%==10 set /a cycle2=0 & set /a cycle1+=1
if %cycle1%==10 set /a cycle1=0 & echo done archiving & pause & exit
if %cycle3% EQU 0 set dolphin-ver=%cycle1%.%cycle2%
if %cycle3% NEQ 0 set dolphin-ver=%cycle1%.%cycle2%.%cycle3%
if %cycle1% GEQ 4 set dolphin-domain=dl-mirror.dolphin-emu.org/%dolphin-ver%
if %cycle1% LSS 4 set dolphin-domain=dl.dolphin-emu.org/releases
if %cycle1%%cycle2%%cycle3% LEQ 400 set file=dolphin-%dolphin-ver%-x64.exe
if %cycle1%%cycle2%%cycle3% GTR 400 set file=dolphin-x64-%dolphin-ver%.exe
call :download
goto loop

:download
title Downloading https://%dolphin-domain%/%file% - Dolphin Archiver - By MarioMasta64
if exist %file% del /s /q %file% >nul
if exist .\extra\%file% echo https://%dolphin-domain%/%file% is already archived & (goto) 2>nul
if not exist %file% .\bin\wget.exe -q --show-progress https://%dolphin-domain%/%file%
if exist %file% move %file% .\extra\%file% >nul
if "https://%dolphin-domain%/%file%"=="%dolphin_link%" echo done archiving & pause >nul & exit
(goto) 2>nul