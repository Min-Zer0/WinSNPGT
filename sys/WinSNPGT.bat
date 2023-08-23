@echo off

setlocal enableextensions
set TERM=
del "%~dp0\home\%USERNAME%\.bashrc"
copy "%~dp0\bashrc.SNPGT" "%~dp0\home\%USERNAME%\.bashrc" > nul
cd /d "%~dp0\bin" 

REM bash
start "" /min .\bash --login -i

REM url
start "" "%~dp0"\URL.lnk
