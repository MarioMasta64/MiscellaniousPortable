@echo off
cd [.adb]
adb devices
pause
adb shell sm set-force-adoptable true