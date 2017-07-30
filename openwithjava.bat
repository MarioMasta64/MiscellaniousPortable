:LOOP
REM %~1 is the dropped file minus quotes
REM if their is no file exit
if "%~1"=="" exit

REM execute the variable
echo start "%CD%\commonfiles\java\bin\javaw.exe" "%~1" > run.bat
echo exit >> run.bat
start run.bat
del run.bat

REM shifts each file down one so the next file can be loaded
shift

goto LOOP
