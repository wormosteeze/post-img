@ECHO OFF && echo.

echo Working, please wait. . . && echo.
echo Checking for admin privileges. . .

::check for admin
net session >NUL 2>NUL && echo Is admin! && echo. || echo Not admin, exiting. Please relaunch this script as admin. && timeout /t 5 && echo This message will self destruct in 5 seconds. . . && exit /b

::::set power settings to never sleep - currently ignoring to keep default county settings...
::powercfg /change standby-timeout-ac 60
::powercfg /change standby-timeout-dc 60
::powercfg /change monitor-timeout-ac 5
::powercfg /change monitor-timeout-dc 5
::powercfg /change hibernate-timeout-ac 0
::powercfg /change hibernate-timeout-dc 0
::echo Power settings applied. Monitor (5) and standby (60). && echo.

::check for VPN
FOR /f %%j in ('hostname') do if not defined hona set hona=%%j
IF /i "%hona:~0,3%"=="ABC" (xcopy %~d0\Misc\Preferences.xml "C:\ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Profile\" /i /y /q && taskkill /T /F /IM vpnui.exe && start "" "C:\Program Files (x86)\Cisco\Cisco AnyConnect Secure Mobility Client\vpnui.exe")
IF %ErrorLevel% == 1 (echo Something went wrong applying the VPN settings. && echo. && GOTO end)
IF /i "%hona:~0,3%"=="ABC" (echo Cisco AnyConnect ABC profile installed. && echo.)
IF /i "%hona:~0,3%" NEQ "ABC" (echo Not an ABC device. Skipping VPN profile. && echo.)

::tw?
IF /i "%hona:~0,2%"=="tw" (GOTO tw)
IF /i NOT "%hona:~0,2%"=="tw" (GOTO manuselect)

::install ASDF and CaONE on TW devices
:tw
echo TW detected, installing ASDF and CaONE for all users. && echo Please follow the installation prompts. . . && echo.
xcopy %~d0\Misc\asdf32.msi C:\IT\IGM\ /i /y /q
C:\IT\IGM\asdf32.msi
del "C:\Users\Public\desktop\asdf.lnk"
xcopy %~d0\Misc\asdf.lnk C:\Users\Public\Desktop\ /y
if errorlevel 1 (echo Error occurred while copying desktop link. && echo. && GOTO manuselect)
xcopy %~d0\Misc\user.config C:\IT\ /y
if errorlevel 1 (echo Error occurred while copying user config. && GOTO manuselect)
echo. && echo Successfully installed ASDF. . . && echo.
xcopy %~d0\Misc\CaONEDesktopSetup.exe C:\IT\ /i /y /q
C:\IT\CaONEDesktopSetup.exe -p
echo. && echo Successfully installed CaONE. . . && echo.


::set device manufacturer
:manuselect
for /f "skip=1 delims= " %%i in ('wmic baseboard get manufacturer') do if not defined manu set manu=%%i
IF /i %manu% == LENOVO (GOTO leno)
IF /i NOT %manu% == LENOVO (GOTO other)

:leno
echo Lenovo detected. && echo.
xcopy %~d0\Scripts\Lenovo.ps1 C:\IT\IGM\ /i /y /q
xcopy %~d0\Scripts\rundel.bat C:\IT\IGM\ /y /q
ren c:\IT\IGM\Lenovo.ps1 joinscript.ps1
goto end

:other
CHOICE /c yn /m "Is this device a Dell? "
IF %ERRORLEVEL% EQU 2 goto wifionly
IF %ERRORLEVEL% EQU 1 goto dell

:dell
echo Dell selected. Update drivers using the web pages that open. && echo.
xcopy %~d0\Scripts\Dell.ps1 C:\IT\IGM\ /i /y /q
xcopy %~d0\Scripts\rundel.bat C:\IT\IGM\ /y /q
ren c:\IT\IGM\Dell.ps1 joinscript.ps1
goto end

:wifionly
echo Copying Wi-Fi only. Please update drivers manually. && echo.
xcopy %~d0\Scripts\WifiOnly.ps1 C:\IT\IGM\ /i /y /q
xcopy %~d0\Scripts\rundel.bat C:\IT\IGM\ /y /q
ren c:\IT\IGM\WifiOnly_HHSA.ps1 joinscript.ps1
goto end

:end
timeout /t 5

start C:\IT\IGM\rundel.bat