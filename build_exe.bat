@echo off
cd /d "%~dp0"
echo ========================================
echo Info-Desk EXE Builder
echo ========================================
echo.

REM Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python is not installed.
    echo Please install Python 3.8+ first.
    pause
    exit /b 1
)

REM Install packages
echo [1/4] Installing required packages...
pip install -r requirements.txt
if errorlevel 1 (
    echo [ERROR] Package installation failed.
    pause
    exit /b 1
)

echo.
echo [2/4] Cleaning previous builds...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist
if exist *.spec del *.spec

echo.
echo [3/4] Building EXE file...
echo This may take a few minutes...

REM Run PyInstaller
pyinstaller --onefile --windowed --name="Info-Desk" --add-data="config;config" --add-data="data;data" --distpath="dist" --workpath="build" --clean --noconfirm main.py

if errorlevel 1 (
    echo.
    echo [ERROR] Build failed!
    pause
    exit /b 1
)

echo.
echo [4/4] Build completed successfully!
echo.
echo ========================================
echo RESULT: dist\Info-Desk.exe
echo Size: ~50-60 MB
echo ========================================
pause
