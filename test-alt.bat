@echo off
cls
Color 0A
for /f "tokens=1,* delims=" %%i in (zeuslinks.txt) do (
  echo %%i > temp.txt
  cscript searchbetweenstring-alt.vbs o zeuslinks.txt "(" ")"
)
pause