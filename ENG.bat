@echo off
color 02
title Create Bootable USB disk
cls
:ret
color 02
wmic logicaldisk get caption,providername,drivetype,volumename
::echo list volume | diskpart                     ::Вызовем функцию вывода списка накопителей через внешнюю утилиту diskpart
set /p nd="Напишите букву диска:"
::res-Ставим false если чтот не так, true Если все правильно
set res=false
::Проверяем введеную букву диска, не даем выбрать диск C
if "%nd%"=="A" set res=true
if "%nd%"=="B" set res=true
if "%nd%"=="D" set res=true
if "%nd%"=="E" set res=true
if "%nd%"=="F" set res=true
if "%nd%"=="G" set res=true
if "%nd%"=="H" set res=true
if "%nd%"=="I" set res=true
if "%nd%"=="K" set res=true
if "%nd%"=="L" set res=true
if "%nd%"=="M" set res=true
if "%nd%"=="N" set res=true
if "%nd%"=="O" set res=true
if "%nd%"=="P" set res=true
if "%nd%"=="Q" set res=true
if "%nd%"=="R" set res=true
if "%nd%"=="S" set res=true
if "%nd%"=="T" set res=true
if "%nd%"=="U" set res=true
if "%nd%"=="V" set res=true
if "%nd%"=="W" set res=true
if "%nd%"=="X" set res=true
if "%nd%"=="Y" set res=true
if "%nd%"=="Z" set res=true

if "%nd%"=="a" set res=true
if "%nd%"=="b" set res=true
if "%nd%"=="d" set res=true
if "%nd%"=="e" set res=true
if "%nd%"=="f" set res=true
if "%nd%"=="g" set res=true
if "%nd%"=="h" set res=true
if "%nd%"=="i" set res=true
if "%nd%"=="k" set res=true
if "%nd%"=="l" set res=true
if "%nd%"=="m" set res=true
if "%nd%"=="n" set res=true
if "%nd%"=="o" set res=true
if "%nd%"=="p" set res=true
if "%nd%"=="q" set res=true
if "%nd%"=="r" set res=true
if "%nd%"=="s" set res=true
if "%nd%"=="t" set res=true
if "%nd%"=="u" set res=true
if "%nd%"=="v" set res=true
if "%nd%"=="w" set res=true
if "%nd%"=="x" set res=true
if "%nd%"=="y" set res=true
if "%nd%"=="z" set res=true
::Проверяем на существование корневого каталога введенного диска
if not exist %nd%: set res=false
::Окончательное ветвление на проверку
if "%res%"=="false" (
    echo Выбран неправильный диск
goto :err
) else (
    echo Выбран корректный диск
)
set /p ans="Вы уверены что хотите отформатировать диск %nd% (Y/N)?:"
set res=false
if "%ans%" == "N" set res=false
if "%ans%" == "Y" set res=true
if "%ans%" == "y" set res=true
if "%ans%" == "n" set res=false
if "%res%"=="false" (
    echo Вы отказались форматировать диск %nd%
goto :err
) else (
::Выбран существующий раздел диска и дано разрешение на форматирование
ECHO Начинаю работу                                   
format %nd%: /FS:NTFS /Q /V:METKA /X
::с помощью bootice переписываем mbr под загрузчик
bootice.exe /DEVICE=%nd%: /mbr /install /type=grub4dos /quiet
COPY linux.iso %nd%:\
COPY grldr %nd%:\
COPY moba.exe %nd%:\
COPY menu.lst %nd%:\
   
)
pause
exit

:err
::Идем сюда если чтото случилось(отмена или ошибка)
color 47
echo Выход из программы
set /p res="Хотите перезагрузить программу?(Y/N):"
cls
if "%res%"=="Y" goto:ret
if "%res%"=="y" goto:ret
color 02          
pause
exit



