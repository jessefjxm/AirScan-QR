@echo off
setlocal
title Cimbar 离线模式启动器

set "PF86=%ProgramFiles(x86)%"
set "CHROME="
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" set "CHROME=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if not defined CHROME if exist "%PF86%\Google\Chrome\Application\chrome.exe" set "CHROME=%PF86%\Google\Chrome\Application\chrome.exe"
if not defined CHROME if exist "%LocalAppData%\Google\Chrome\Application\chrome.exe" set "CHROME=%LocalAppData%\Google\Chrome\Application\chrome.exe"
if not defined CHROME goto nochrome

set "PAGE=%~dp0cimbar-transfer.html"
if not exist "%PAGE%" goto nopage

set "PROFILE=%~dp0.chrome-cimbar-profile"
if not exist "%PROFILE%" mkdir "%PROFILE%" >nul 2>nul

echo.
echo   正在以「离线模式」启动 Chrome ...
echo     页面 : %PAGE%
echo     配置 : %PROFILE%
echo.
echo   本方式使用独立配置目录 + --allow-file-access-from-files 启动，
echo   因此「发送端」与「接收端」都可以正常使用（摄像头也可用），
echo   并且完全不影响你平时使用的 Chrome。
echo.

start "" "%CHROME%" --allow-file-access-from-files --user-data-dir="%PROFILE%" --no-first-run --no-default-browser-check "%PAGE%"
exit /b 0

:nochrome
echo.
echo   [错误] 没有找到 Google Chrome。
echo.
echo   请先安装 Chrome，或手动执行下面这条命令：
echo     chrome.exe --allow-file-access-from-files --user-data-dir="本目录\.chrome-cimbar-profile" "本目录\cimbar-transfer.html"
echo.
pause
exit /b 1

:nopage
echo.
echo   [错误] 在本目录下找不到 cimbar-transfer.html
echo   请把整个 AirScan-QR 目录（含 cimbar-deps 子目录）完整复制过来。
echo.
pause
exit /b 1