@echo off
setlocal enabledelayedexpansion
set 1=jan
set 2=feb
set 3=mar
set 4=apr
set 5=may
set 6=jun
set 7=jul
set 8=aug
set 9=sep
set 10=oct
set 11=nov
set 12=dec
call :reset_year
call :reset_month

:monthloop
if %month%==13 call :reset_month
echo !%month%! %year%
set /a month=%month%+1
goto monthloop

:reset_month
set /a year=%year%+1
if %year%==2000 call :reset_year
set /a month=1
exit /b

:reset_year
set /a year=1700
echo !%month%! %year%
echo welcome to the 2k bug
pause
goto :reset_month