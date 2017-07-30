Color 0A
ren SteamSetup.exe.done SteamSetup.exe
set COMMONPROGRAMFILES(X86)=%CD%\bin\commonfiles\
set LOCALAPPDATA=%CD%\data\appdata\local
set APPDATA=%CD%\data\appdata\roaming
%CD%\SteamSetup.exe
ren SteamSetup.exe SteamSetup.exe.done