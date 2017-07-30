@echo off
cls
Color 0A

echo 1. delet self w/ error
echo 2. delet self w/o error
echo 3. delet self with wtf
set /p goto="which way do you want me to suicide? :D "
goto %goto%

:1
echo i suicided by deleting %~f0 (self reference) > im_dead.txt
DEL "%~f0"

:2
echo i suicided by deleting %~f0 (self reference) without error message > im_dead.txt
start /b "" cmd /c del "%~f0"&exit /b

:3
echo i suicided by deleting %~f0 (self reference) (goto) 2 acts as a exit /b > im_dead.txt
(goto) 2>nul & del "%~f0"