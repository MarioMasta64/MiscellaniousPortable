@echo off

setlocal enabledelayedexpansion
set Counter=1
for /f "DELIMS=" %%i in (test.txt) do (
set "Line_!Counter!=%%i"
set /a Counter+=1
)
set /a NumLines=Counter - 1

echo %Line_1%
echo %Line_2%
echo %Line_3%
echo %Line_4%
echo %Line_5%
echo %Line_6%

set Counter=1

:readprofiles
if %Counter%==%NumLines% goto pause
echo %Counter%. %Line_!Counter!%
set /a Counter+=1
goto readprofiles

:pause
pause