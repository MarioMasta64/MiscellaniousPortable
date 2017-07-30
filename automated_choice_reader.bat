@echo off
setlocal enabledelayedexpansion

:: list only folders
del test.txt
dir /ad /b %CD%\* > test.txt

set Counter=0
echo type default for default profile
for /f "DELIMS=" %%i in (test.txt) do (
    set /a Counter+=1
    set "Line_!Counter!=%%i"
)

For /L %%C in (1,1,%Counter%) Do (echo %%C. !Line_%%C!)

set /p choice="choice: "
set profile=!Line_%choice%!
echo %profile%

Pause