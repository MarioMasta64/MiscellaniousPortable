@echo off

call :cabexpander
exit

:cabexpander
del dir.txt
for %%i in (*.cab) do @echo %%~ni >> dir.txt
for /F "tokens=*" %%a in ('type test.txt') do call :expand %%a
del dir.txt
exit /b

:expand
set line=%1
if exist %line%.cab expand %line%.cab -f:*.dll "%CD%\dll"
exit /b