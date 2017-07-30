@echo off
Color 0A
cls
echo TYPE YOUR CHOICE
echo NEW: set version to the newest build
echo DEV: set version to a dev build / early release
echo OLD: set version to the oldest build possible
set /p choice="choice: "
goto %choice%

:OLD
cls
echo just press the X button when done
echo new version set to newest build
:OLDLOOP
echo 999 > testversion.txt
goto OLDLOOP

:DEV
cls
echo just press the X button when done
echo new version set to dev build / early build
:DEVLOOP
echo 0 > testversion.txt
goto DEVLOOP

:NEW
cls
echo just press the X button when done
echo new version set to oldest build possible
:NEWLOOP
copy %CD%\doc\testversion.txt testversion.txt > log.txt
goto NEWLOOP