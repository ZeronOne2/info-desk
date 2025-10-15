@echo off
cd /d "%~dp0"
chcp 65001 >nul
title Info-Desk - Event Participant Management System

echo Starting Info-Desk...
python main.py

if errorlevel 1 (
    echo.
    echo [ERROR] Failed to run application.
    echo.
    echo Possible solutions:
    echo 1. Run install.bat to install packages
    echo 2. Check Python installation
    echo 3. Try: python check_environment.py
    echo.
    pause
)
