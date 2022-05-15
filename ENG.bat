@echo off
color 02
title Create Bootable USB disk
cls
:ret
color 02
wmic logicaldisk get caption,providername,drivetype,volumename
::echo list volume | diskpart                     ::������� ������� ������ ������ ����������� ����� ������� ������� diskpart
set /p nd="�������� ����� �����:"
::res-������ false ���� ���� �� ���, true ���� ��� ���������
set res=false
::��������� �������� ����� �����, �� ���� ������� ���� C
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
::��������� �� ������������� ��������� �������� ���������� �����
if not exist %nd%: set res=false
::������������� ��������� �� ��������
if "%res%"=="false" (
    echo ������ ������������ ����
goto :err
) else (
    echo ������ ���������� ����
)
set /p ans="�� ������� ��� ������ ��������������� ���� %nd% (Y/N)?:"
set res=false
if "%ans%" == "N" set res=false
if "%ans%" == "Y" set res=true
if "%ans%" == "y" set res=true
if "%ans%" == "n" set res=false
if "%res%"=="false" (
    echo �� ���������� ������������� ���� %nd%
goto :err
) else (
::������ ������������ ������ ����� � ���� ���������� �� ��������������
ECHO ������� ������                                   
format %nd%: /FS:NTFS /Q /V:METKA /X
::� ������� bootice ������������ mbr ��� ���������
bootice.exe /DEVICE=%nd%: /mbr /install /type=grub4dos /quiet
COPY linux.iso %nd%:\
COPY grldr %nd%:\
COPY moba.exe %nd%:\
COPY menu.lst %nd%:\
   
)
pause
exit

:err
::���� ���� ���� ����� ���������(������ ��� ������)
color 47
echo ����� �� ���������
set /p res="������ ������������� ���������?(Y/N):"
cls
if "%res%"=="Y" goto:ret
if "%res%"=="y" goto:ret
color 02          
pause
exit



