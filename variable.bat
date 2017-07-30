@echo off
title Variable Modifier - By MarioMasta64
:main
cls
echo SET: set a variable
echo VIEW: view a variable
set /p goto="What Would You Like To Do:"
set /p var="Enter The Variable You Wish To %goto%:"
goto %goto%
goto main

:set
cls
set /p val="Enter A Value For %var%:"
setx %var% %val%
rem /m to set global
pause
goto main

:view
cls
echo not implemented
pause
goto main