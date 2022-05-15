from itertools import count
import os
import string
def AddLinuxSection(title):
    str = ("\ntitle "
          + title + "\n"
          + "ls (hd0,0)/" + title + ".iso && partnew (hd0,3) 0x00 /"+ title + ".iso\n"
          + "map /"+ title + ".iso (0xff)\n"
          + "echo -e \\r\\n " + "\n"
          + "map --hook" + "\n"
          + "chainloader (0xff)" + "\n")
    with open("menu.lst", "r+") as m:
        m.seek (0, 2)
        m.write (str)
    return str

def ConfBcdNoEfi():
    return

def AddWindowsInstall(title):
    wim = "*.wim"
    os.system("7zip\\7z e " + title + " -oC:\\UwU\\ " + wim + " -r")
    ListFoldersInDisk = os.listdir(SelectedDisk + ":\\WININST")
    i = len(ListFoldersInDisk)
    #set InstallDir=WININST\win{i}
    newfolder = "WIN" + str(i)
    addtofile = "set InstallDir=WININST\\" + newfolder
    os.mkdir(SelectedDisk + ":\\WININST\\" + newfolder)
    data = ""
    with open ("pattern_mysetup", "r") as pat: data = pat.read()
    with open("mysetup.cmd", "r+") as f: f.seek(0); f.write(addtofile + "\n" + data)
    os.mkdir("C:\\dismm")
    os.system("dism /mount-wim /wimfile:C:\\UwU\\boot.wim /index:2 /mountdir:C:\\dismm")
    os.system("copy mysetup.cmd C:\\dismm\\Windows\\system32")
    os.system("copy winplesh.ini C:\\dismm\\Windows\\system32")
    os.system("dism /unmount-wim /mountdir:C:\\dismm /commit")
    os.system("copy C:\\UwU\\boot.wim " + SelectedDisk + ":\\WININST\\" + newfolder)
    os.system("copy C:\\UwU\\install.wim " + SelectedDisk + ":\\WININST\\" + newfolder)
    os.rmdir("C:\\dismm")
    os.remove("C:\\UwU\\install.wim")
    os.remove("C:\\UwU\\boot.wim")
    os.rmdir("C:\\UwU")
    if (i != 0):
        maindir = os.getcwd()
        os.chdir(SelectedDisk + ":\\boot")
        os.system('bcdedit /store bcd /copy {default} /d "WIN' + str(i) + '" > temp')
        with open ("temp", "r") as tt: guid = tt.read()
        guid = guid[guid.find('{'):len(guid)-1]
        os.system('bcdedit /store bcd /set ' + guid + ' device "ramdisk=[boot]\\WININST\\' + newfolder + '\\boot.wim,{7619dcc8-fafe-11d9-b411-000476eba25f}')
        os.system('bcdedit /store bcd /set ' + guid + ' osdevice "ramdisk=[boot]\\WININST\\' + newfolder + '\\boot.wim,{7619dcc8-fafe-11d9-b411-000476eba25f}')
        os.chdir(maindir)
        return
    else:
        maindir = os.getcwd()
        os.chdir(SelectedDisk + ":\\")
        with open ("menu.lst", "r+") as menu: data = menu.read();
        os.chdir(maindir)
        return

def CopyMainFiles(Disk):
    os.system ("xcopy boot " + Disk + ":\\boot /e /i /h")
    os.system ("xcopy efi " + Disk + ":\\efi /e /i /h")
    os.system ("xcopy WININST " + Disk + ":\\WININST /e /i /h")
    os.system ("copy art.ico " + Disk + ":\\")
    os.system ("copy Autorun.inf " + Disk + ":\\")
    os.system ("copy bootmgr " + Disk + ":\\")
    os.system ("copy bootmgr.efi " + Disk + ":\\")
    os.system ("copy grldr " + Disk + ":\\")
    os.system ("copy grldr.mbr " + Disk + ":\\")
    os.system ("copy menu.lst " + Disk + ":\\")
    os.system ("copy moba.exe " + Disk + ":\\")
    os.system ("copy shifthd.bat " + Disk + ":\\")

def GetListIsoFiles():
    files = os.listdir()
    isos = list(filter(lambda x: x.endswith('.iso'), files))
    print(isos)
    for i, iso in enumerate(isos):
        print(i + 1, iso)
    return isos

def CopyFileToRootDisk(NameDisk, NameFile):
    os.system ("copy " + NameFile + " " + NameDisk +":\\")

def CopyFromDiskToHere(NameDisk, NameFile):
    Point = os.getcwd()
    os.system ("copy " + NameDisk + ":\\" + NameFile + " " + Point)

def FormatDiskAndConfig(NameDisk):# will format this drive and config
    print("Are you shure to format drive" + NameDisk + "?(y/n)")
    aF = input()
    if (aF == "y") or (aF == "Y"):
        os.system("format " + NameDisk + ": /FS:FAT32 /Q /V:BootableUSB /X /Y")
        os.system("bootice.exe /DEVICE=" + NameDisk + ": /mbr /install /type=grub4dos /quiet")
        CopyMainFiles(SelectedDisk)
        return
    elif (aF == "n") or (aF == "N"):
        return
    else:
        print("ERROR, please be careful")
        print("Will try again?(y/n)")
        aG = input()
        if (aG == "y") or (aG == "Y"): FormatDiskAndConfig(NameDisk)
        else: return
    return

def AskFirst():
    print("Are you first time work with this drive?(y/n)")
    a1 = input()
    if (a1 is "y") or (a1 is "Y"):
        #FORMAT DRIVE, copy mgr,grub,menuE
        print("OK i'll format you'r drive")
        FormatDiskAndConfig(SelectedDisk)
        return
    elif (a1 is "n") or (a1 is "N"):
        CopyFromDiskToHere(SelectedDisk, "menu.lst")
        return
    else: AskFirst()

def interface():
    print("1 - Add File\nF - Format and configure disk\n0 - Exit")
    a2 = input()
    if a2 is "1":
        print("Selected command 1\n")
        isos = GetListIsoFiles()
        print("Which file do you want to add?")
        NumberFile = int(input())
        if (NumberFile > len(isos)):
            print("ERROR, Very big number")
            interface()
        else:
            SelectedFile = isos[NumberFile - 1]
            print("What type of file is it?\n1 - UNIX\n2 - Windows(Setup)\n3 - I don't know(default)")
            TypeFile = int(input())
            if TypeFile is 1:
                CopyFileToRootDisk(SelectedDisk,SelectedFile)
                AddLinuxSection(SelectedFile)
                CopyFileToRootDisk(SelectedDisk,"menu.lst")
                interface()
            elif TypeFile is 2:
                print("WINDOWS\n\n\n\n")
                AddWindowsInstall(SelectedFile)
                interface()
            elif TypeFile is 3:
                print("uniq\n\n")
                interface()
            else:
                print("ERROR, unknow's type of file")
                interface()
    elif a2 is "0":

        return
    elif a2 is "F":
        FormatDiskAndConfig(SelectedDisk)
        interface()
    else:
        print("ERROR")
        interface()

drives = ['%s' % d for d in string.ascii_uppercase if os.path.exists('%s:' % d)]
print (drives)
print("Input Disk: ")
SelectedDisk = input()
if SelectedDisk in drives:
    print(SelectedDisk)
    AskFirst()
    interface()
