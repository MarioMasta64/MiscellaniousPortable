@echo off
title HAX0R ACTIVATED
setlocal EnableDelayedExpansion
set 0=0
set 1=1
set 2=2
set 3=3
set 4=4
set 5=5
set 6=6
set 7=7
set 8=8
set 9=9
set 10=A
set 11=B
set 12=C
set 13=D
set 14=E
set 15=F
echo test

:reset
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
set Color1=0
set Color2=-1

:loop1
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
set /a Color2+=1
if %Color2%==%Color1% set /a Color2+=1
if %Color2%==16 set Color2=-1 & goto loop2
echo Color !%Color1%!!%Color2%! > run.bat
start run.bat
goto loop1

:loop2
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
set /a Color1+=1
if %Color2%==%Color1% set /a Color1+=1
if %Color1%==16 goto reset
echo Color !%Color1%!!%Color2%! > run.bat
start run.bat
goto loop1