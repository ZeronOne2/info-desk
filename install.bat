@echo off
cd /d "%~dp0"
chcp 65001 >nul
echo Installing Info-Desk...
echo Current directory: %CD%

REM Check Python installation
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python is not installed.
    echo Please download Python 3.8+ from: https://python.org
    echo Make sure to check "Add Python to PATH" during installation
    pause
    exit /b 1
)

echo Installing required packages...

REM Try basic requirements first
echo Trying basic installation...
pip install -r requirements.txt
if not errorlevel 1 (
    echo Installation successful!
    goto :success
)

REM If that fails, try stable versions
echo Basic installation failed, trying stable versions...
pip install -r requirements_stable.txt
if not errorlevel 1 (
    echo Installation with stable versions successful!
    goto :success
)

REM If that fails, try minimal requirements
echo Stable installation failed, trying minimal installation...
pip install -r requirements_minimal.txt
if not errorlevel 1 (
    echo Minimal installation successful!
    goto :success
)

REM If all fail, try manual installation
echo All automatic installations failed, trying manual installation...
pip install PyQt5 openpyxl
if not errorlevel 1 (
    echo Manual installation successful!
    goto :success
)

REM Final fallback
echo [ERROR] All installation methods failed.
echo Please try the following manually:
echo 1. pip install --upgrade pip
echo 2. pip install PyQt5
echo 3. pip install openpyxl
echo.
echo If you still have issues, try:
echo - pip install PyQt5==5.15.2
echo - pip install openpyxl==3.1.2
pause
exit /b 1

:success
echo.
echo ========================================
echo Installation completed successfully!
echo ========================================
echo Double-click run.bat to start Info-Desk
pause
