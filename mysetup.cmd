set InstallDir=WININST\WIN0



@title BootDev - Windows install
@echo off
@color 37
@cls

for %%I in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist %%I:\%InstallDir% set BootDev=%%I:

if exist %BootDev%\%InstallDir%\install.wim (
 set WinImage=%BootDev%\%InstallDir%\install.wim
 goto :installwim
)
if exist %BootDev%\%InstallDir%\install.esd (
 set WinImage=%BootDev%\%InstallDir%\install.esd
 goto :installwim
)
if exist %BootDev%\%InstallDir%\sources\setup.exe (
 goto :virtualdrive
)

:installwim

echo Found %WinImage%, continue installation...

If exist %BootDev%\%InstallDir%\setup.exe (
 %BootDev%\%InstallDir%\setup.exe /installfrom:%WinImage%
 goto :reboot
)

if not exist X:\setup.exe (
 goto :error
) else (
 X:\setup.exe /installfrom:%WinImage%
 goto :reboot
)


:virtualdrive
echo Creating virtual drive z: for %BootDev%\%InstallDir%
subst z: %BootDev%\%InstallDir%
echo Start installation...
cd z:\sources
z:\setup.exe || z:\sources\setup.exe
goto :reboot

:error
echo Cannot find "setup.exe" !
echo Press any key to reboot...

:reboot
wpeutil reboot
pause !
echo Press any key to reboot...

:reboot
wpeutil reboot
pause