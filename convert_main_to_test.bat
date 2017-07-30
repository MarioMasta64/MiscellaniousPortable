@echo off

	title=MAIN_TO_TEST
	Color 0A
	MODE CON: COLS=32 LINES=4

	set local enableextensions disabledelayedexpansion
	cls

	echo creating a new backup for launcher.bat
	del launcher.bat.bak
	copy launcher.bat launcher.bat.bak

	echo replacing words
	call :REPLACETEXT version.txt testversion.txt launcher.bat
	call :REPLACETEXT launcher.bat testlauncher.bat launcher.bat
	call :REPLACETEXT -beta -test launcher.bat

	del testlauncher.bat
	copy launcher.bat testlauncher.bat
	del launcher.bat
	ren launcher.bat.bak launcher.bat

	echo conversion complete
	pause
	
exit

:REPLACETEXT

	set "search=%1"
	set "replace=%2"
	set "file=%3"

	echo search: %search%
	echo replace: %replace%
	echo file: %file%

	for /f "delims=" %%i in ('type "%file%" ^& break ^> "%file%" ') do (
		set "line=%%i"
		setlocal enabledelayedexpansion
		>> "%file%" echo(!line:%search%=%replace%!
		endlocal
	)

exit /b

:REMOVELINE

	set "string=%1"
	set "file=%2"

	echo string: %string%
	echo file: %file%

	type %file% | findstr /v %string% > output_%file%
	del %file%
	ren output_%file% %file%

exit /b