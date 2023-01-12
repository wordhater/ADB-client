@echo off
title ADB client
echo %CD%
adb start-server
pause

echo Turn on debug over wifi on the device you wish to connect to.
echo If you do not know what or where this option is, search how to turn on adb debugging on your device
pause


set /p input= insert 1 if you are connecting to a phone leave blank for anything else
if %input% == 1 goto point_1
goto point_1.5
:point_1
echo Type the ip that appears below the switch, E.g: 192.255.255.255:5555
set /p input=

adb connect %input%

if not errorlevel 1 goto point_2

echo An error occurred during connecting
goto point_1
:point_1.5
echo Type the ip that appears below the switch, E.g: 192.255.255.255:5555
echo if there is none resarch where it is for your device
echo if this is the first time you are connecting your phone or tablet you will need to manually pair your device to adb do your resarch on how to do that on your device as it is different in each device
set /p input=
adb pair %input%
if errorlevel 0 goto point_2
adb connect %input%
if errorlevel 0 goto point_2
goto point_1.5

:point_2
echo connected
adb devices
pause

echo =============================================================
echo Select device type
echo [1] Watch
echo [2] Phone
echo =============================================================
:point_3
set /p input= ENTER OPTION HERE

if %input% == 1 goto Main_watch
if %input% == 2 goto Main_phone
if %input% gtr 2 goto point_3

:Main_watch
echo =============================================================
echo [1] load apk to device and install
echo [2] Reboot device
echo [3] Close server and end program
echo =============================================================
set /p input= ENTER OPTION HERE
if %input% == 1 goto 1_watch
if %input% == 2 goto 2_watch
if %input% == 3 goto 3_watch

:1_watch
echo Copy APK into ADB platform-tools folder
pause
echo copy full filename INCLUDING EXTENTION and paste below
set /p input=
adb push %input% /sdcard/
adb -e install %input%
goto Main_watch

:2_watch
adb reboot
goto Main_watch

:3_watch
adb kill-server
timeout 2 >nul
exit
goto Main_watch

:Main_phone
echo =============================================================
echo [1] load apk to device and install
echo [2] Reboot device
echo [3] Close server and end program
echo =============================================================
set /p input= ENTER OPTION HERE
if %input% == 1 goto 1_phone
if %input% == 2 goto 2_phone
if %input% == 3 goto 3_phone

:1_phone
echo Copy APK into ADB platform-tools folder
pause
echo copy full filename INCLUDING EXTENTION and paste below
set /p input=
adb install %input%
goto Main_phone

:2_phone
adb reboot
goto Main_phone

:3_phone
adb kill-server
timeout 2 >nul
exit
goto Main_phone
