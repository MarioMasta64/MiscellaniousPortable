@echo off
Color 0A
:main
if not exist .\note\ mkdir .\note\
title checking for message of the day
echo checking for message of the day
.\bin\wget.exe -q --show-progress https://github.com/MarioMasta64/EverythingPortable/raw/master/note/index.txt
if exist index.txt del .\note\*.txt
if exist index.txt move index.txt .\note\index.txt > nul
if exist .\note\index.txt for /f "DELIMS=" %%i in ('type .\note\index.txt') do (
	:: check update\
	if %%i NEQ "" .\bin\wget.exe -q --show-progress https://github.com/MarioMasta64/EverythingPortable/raw/master/note/%%i.txt
	move %%i.txt .\note\%%i.txt > nul
)
del .\note\index.txt
cls
if exist .\note\head.txt call :readtext .\note\head.txt
echo ==========================
echo = 1. welcome             =
echo = 2. choose              =
echo = 3. meh                 =
echo ==========================
if exist .\note\foot.txt call :readtext .\note\foot.txt
pause
exit

:readtext
set file=%1
for /f "DELIMS=" %%i in ('type %file%') do (echo %%i)
exit /b