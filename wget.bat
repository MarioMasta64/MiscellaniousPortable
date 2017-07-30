@echo off

if not exist wget.exe cd wget
if not exist wget64.exe cd wget
if not exist downloads mkdir downloads
set wget=%cd%

title WGET Downloader - By MarioMasta64

:file
cls
set /p file="File To Download:"
set dir=".\downloads\"
set /p dir="Directory To Download To (.\downloads\):"

:checkos
if exist "%PROGRAMFILES(X86)%" goto x64
goto x86
goto error

:x86
if not exist %dir% mkdir %dir%
cd %dir%
%wget%\wget "%file%"
goto eof

:x64
if not exist %dir% mkdir %dir%
cd %dir%
%wget%\wget64 "%file%"
:goto eof

:error
echo ERROR OCCURED
goto loop

:loop
goto loop