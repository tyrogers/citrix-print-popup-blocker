@echo off
setlocal enabledelayedexpansion

:: 1. CHECK FOR ADMIN PRIVILEGES [cite: 1]
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ======================================================
    echo ERROR: YOU MUST RUN THIS AS ADMINISTRATOR [cite: 1]
    echo ======================================================
    echo Please right-click this file and select "Run as Administrator". [cite: 1]
    pause
    exit
)

:MENU
cls
echo ======================================================
echo          HEALTHCARE AGENCY IT - MASTER TOOLBOX [cite: 1]
echo ======================================================
echo.
echo [1] Launch Citrix Popup_Blocker (Self-Healing)
echo [2] Apply Print to PDF DLP Protocol (Disable Feature) 
echo [3] Apply BOTH (Standard Clinical Lockdown) 
echo ------------------------------------------------------
echo [4] REVERT: Enable Microsoft Print to PDF 
echo ------------------------------------------------------
echo [Q] Quit 
echo.
set /p choice="Select an option (1-4 or Q): " [cite: 3]

if /i "%choice%"=="1" goto POPUP
if /i "%choice%"=="2" goto DLP
if /i "%choice%"=="3" goto BOTH
if /i "%choice%"=="4" goto REV_DLP
if /i "%choice%"=="q" exit
goto MENU

:POPUP
echo Launching Citrix Popup_Blocker...
:: Running the new self-healing script
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Popup_Blocker.ps1"
pause
goto MENU

:DLP
echo Running DLP Protocol... 
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Print_DLP.ps1" 
pause
goto MENU

:BOTH
echo Running Full Lockdown... 
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Popup_Blocker.ps1"
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Print_DLP.ps1" 
pause
goto MENU

:REV_DLP
echo Reverting DLP Protocol... 
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Revert_Print_DLP.ps1" 
pause
goto MENU



