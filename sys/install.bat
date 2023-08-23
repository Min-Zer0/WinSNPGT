@echo off

(echo Set WshShell=CreateObject("WScript.Shell"^)
	echo Set oShellLink=WshShell.CreateShortcut("%~dp0/URL.lnk"^)
	echo oShellLink.TargetPath="http://localhost/"
	echo oShellLink.Description="URL"
	echo oShellLink.Save)>makeurl.vbs
makeurl.vbs
del /f /q makeurl.vbs
attrib +h "%~dp0"\URL.lnk

(echo Set WshShell=CreateObject("WScript.Shell"^)
	echo Set oShellLink=WshShell.CreateShortcut("%~dp0/../WinSNPGT.lnk"^)
	echo oShellLink.TargetPath="%~dp0/WinSNPGT.bat"
	echo oShellLink.Windowstyle=7
	echo oShellLink.Description="WinSNPGT"
	echo oShellLink.IconLocation="%~dp0/BgPic/SNPGT.ico"
	echo oShellLink.Save) > SNPGT.vbs
SNPGT.vbs
del /f /q SNPGT.vbs

(echo Set WshShell=CreateObject("WScript.Shell"^)
	echo strDesKtop=WshShell.SPEcialFolders("DesKtop"^)
	echo Set oShellLink=WshShell.CreateShortcut(strDesKtop^&"\WinSNPGT.lnk"^)
	echo oShellLink.TargetPath="%~dp0/WinSNPGT.bat"
	echo oShellLink.Windowstyle=7
	echo oShellLink.Description="WinSNPGT"
	echo oShellLink.IconLocation="%~dp0/BgPic/SNPGT.ico"
	echo oShellLink.Save) > desktoplnk.vbs
desktoplnk.vbs
del /f /q desktoplnk.vbs
echo "%~dp0\..\" > "%~dp0\home\install_dir"
cd /d "%~dp0\bin" && .\bash --login -i