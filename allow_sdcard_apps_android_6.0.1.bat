@echo off
cd [.adb]
adb devices
pause
adb shell sm list-disks
adb shell sm list-volumes all
adb shell sm set-force-adoptable true
:: doesnt show in explorer and sets as emulated
adb shell sm partition disk:179,64 private
:: does show in explorer and sets as portable storage
:: adb shell sm partition disk:179,64 public
:: does show in explorer and sets as ???
:: adb shell sm partition disk:179,64 mixed
adb shell sm set-force-adoptable false
adb shell sm list-volumes all
adb reboot