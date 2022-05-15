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
        m.seek (0, 2) # ������ ������ � ����� �����
        m.write (str) # ���������� �������� str � ����� �����
    return str

def GetListIsoFiles():
    files = os.listdir()
    isos = list(filter(lambda x: x.endswith('.iso'), files))
    print(isos)
    for i, iso in enumerate(isos):
        print(i + 1, iso)
    return isos

def CopyFileToDisk(NameDisk, NameFile):
    os.system ("copy " + NameFile + " " + NameDisk +":\\")

def main():
    drives = ['%s:' % d for d in string.ascii_uppercase if os.path.exists('%s:' % d)]
    print (drives)
    print("Input Disk: ")
    SelectedDisk = input()
    print(SelectedDisk)
    isos = GetListIsoFiles()
    print("Input Number of file:")
    NumberFile = int (input())
    file = isos[NumberFile - 1]
    #file = "myfile.iso"
    #disk = "C"
    if SelectedDisk in drives:
        CopyFileToDisk(SelectedDisk, file)
main()



