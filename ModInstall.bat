@echo off
mkdir C:\dism
dism /mount-wim /wimfile:D:\boot.wim /index:2 /mountdir:C:\dism
dism /unmount-wim /mountdir:C:\dism /commit
;rmdir C:\dism
pause