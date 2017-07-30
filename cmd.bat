@echo off
cls
color 0A
title Command Prompt - By MarioMasta64
ver
echo (C) Copyright Microsoft Corporation. All rights reserved
echo.
:cmd
set /p "cmd=%cd%>"
%cmd%
echo.
goto cmd