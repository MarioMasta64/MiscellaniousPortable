@echo off

	title=TEST_TO_MAIN
	Color 0A
	MODE CON: COLS=32 LINES=4

	set local enableextensions disabledelayedexpansion
	cls

	echo creating a new backup for testlauncher.bat
	del testlauncher.bat.bak
	copy testlauncher.bat testlauncher.bat.bak

	echo replacing words
	call :REPLACETEXT testversion.txt version.txt testlauncher.bat
	call :REPLACETEXT testlauncher.bat launcher.bat testlauncher.bat
	call :REPLACETEXT -test -beta testlauncher.bat
	call :REPLACETEXT :: REM testlauncher.bat

	echo removing lines
	call :REMOVELINE REM testlauncher.bat

	del launcher.bat
	copy testlauncher.bat launcher.bat
	del testlauncher.bat
	ren testlauncher.bat.bak testlauncher.bat

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