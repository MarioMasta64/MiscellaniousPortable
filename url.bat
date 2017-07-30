@echo off
cls

set /p url=<url.txt

if exist "%PROGRAMFILES(X86)%\Google\Chrome\Application\chrome.exe" goto chrome64
if exist "%PROGRAMFILES%\Google\Chrome\Application\chrome.exe" goto chrome86
if exist "%PROGRAMFILES(X86)%\Mozilla Firefox\firefox.exe" goto firefox64
if exist "%PROGRAMFILES%\Mozilla Firefox\firefox.exe" goto firefox86
if exist "%PROGRAMFILES(X86)%\Opera\opera.exe" goto opera64
if exist "%PROGRAMFILES%\Opera\opera.exe" goto opera86
if exist "%PROGRAMFILES(X86)%\Opera\launcher.exe" goto oldopera64
if exist "%PROGRAMFILES%\Opera\launcher.exe" goto oldopera86
if exist "%PROGRAMFILES(X86)%\Internet Explorer\IEXPLORE.exe" goto ie64
if exist "%PROGRAMFILES%\Internet Explorer\IEXPLORE.exe" goto ie86


goto error

:chrome64
"%PROGRAMFILES(X86)%\Google\Chrome\Application\chrome.exe" --app="%url%"
goto eof

:chrome86
"%PROGRAMFILES%\Google\Chrome\Application\chrome.exe" --app="%url%"
goto eof

:firefox64
"%PROGRAMFILES(X86)%\Mozilla Firefox\firefox.exe" -url "%url%" -fullscreen
goto eof

:firefox86
"%PROGRAMFILES%\Mozilla Firefox\firefox.exe" -url "%url%" -fullscreen
goto eof

:opera64
"%PROGRAMFILES(X86)%\Opera\opera.exe" /KioskMode %url%
goto eof

:opera86
"%PROGRAMFILES%\Opera\opera.exe" /KioskMode %url%
goto eof

:oldopera64
"%PROGRAMFILES(X86)%\Opera\launcher.exe" /KioskMode %url%
goto eof

:oldopera86
"%PROGRAMFILES%\Opera\launcher.exe" /KioskMode %url%
goto eof

:ie64
"%PROGRAMFILES(X86)%\Internet Explorer\iexplore.exe" -k %url%
goto eof

:ie86
"%PROGRAMFILES%\Internet Explorer\iexplore.exe" -k %url%
goto eof

:error
start %url%
goto :eof