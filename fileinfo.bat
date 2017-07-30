@echo off
rem lines are equal to the amount of lines however columns are counted as half lines
mode con: cols=101 lines=29
:LOOP
REM %~1 is the dropped file minus quotes
REM if their is no file exit
if "%~1"=="" exit

REM variable work where %n is the numbered file / folder
cls
echo ====================================================================================================
echo file attributes:
echo %~a1
echo ====================================================================================================
echo drive:
echo %~d1
echo ====================================================================================================
echo full pathname:
echo %~f1
echo ====================================================================================================
echo file name:
echo %~n1
echo ====================================================================================================
echo path (without drive):
echo %~p1
echo ====================================================================================================
echo shortname:
echo %~s1
echo ====================================================================================================
echo time stamp:
echo %~t1
echo ====================================================================================================
echo extension:
echo %~x1
echo ====================================================================================================
echo size:
echo %~z1
echo ====================================================================================================
pause

REM shifts each file down one so the next file can be loaded
shift

goto LOOP
