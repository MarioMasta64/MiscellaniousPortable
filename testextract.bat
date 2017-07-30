::no path
:: drop a file onto here
cd /d "%~dp0"
"%CD%\bin\7-ZipPortable\App\7-Zip64\7z.exe" e "%~f1" *.* -o%CD%\test
:: full path
:: "%CD%\bin\7-ZipPortable\App\7-Zip64\7z.exe" x "%~f1" *.* -o%CD%\test