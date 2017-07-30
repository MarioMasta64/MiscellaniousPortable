@echo off
cls
Color 0A
title Cemu Always Updated Version

if exist index.html del index.html
.\bin\wget.exe -q --show-progress http://cemu.info/
pause

if not exist index.html goto Start-Cemu
for /f tokens^=2delims^=^" %%A in (
  'findstr /i /c:"http://cemu.info/releases/" /c:"http://cemu.info/releases/" index.html'
) Do > cemu_link.txt Echo:%%A
set /p cemu_link=<cemu_link.txt
set cemu_zip=%cemu_link:~26,20%
if exist index.html del index.html

if not exist .\extra\%cemu_zip% (
  .\bin\wget.exe -q --show-progress %cemu_link%
  move %cemu_zip% .\extra\%cemu_zip%
)
if exist cemu_link.txt call :extract-zip "bin\cemu" "extra\%cemu_zip%"
goto Move-Cemu

:: if exist cemu_ver.txt set /p cemu_ver=<.\doc\.\doc\cemu_zip.txt

:: make sure updating using the menu removes cemu_ver.txt

:Extract-Zip
set "dir=%1"
set "file=%2"
set folder=%CD%
if %CD%==%~d0\ set folder=%CD:~0,2%
cscript .\bin\extractzip.vbs "%folder%\%file%" "%folder%\%dir%"
(goto) 2>nul

:: replace the cemu code with this.

:Move-Cemu
cd bin
if exist cemu cd cemu
if exist cemu* cd cemu*
if not exist ..\wget.exe (
  if not exist ..\cemu_always_updated.bat (
    xcopy * ..\ /e /i /y
    cd ..
  )
)
if exist temp.txt del temp.txt
for /D %%A IN ("cemu*") DO echo "%%A">temp.txt
if exist temp.txt set /p dir=<temp.txt
if exist temp.txt rmdir /s /q %dir%
if exist temp.txt del temp.txt
if exist ..\wget.exe cd ..
if exist ..\cemu_always_updated.bat cd ..

:Start-Cemu
if not exist .\bin\cemu\Cemu.exe goto Not-Installed
start .\bin\cemu\Cemu.exe
exit

:Not-Installed
echo cemu is not installed.
pause
exit