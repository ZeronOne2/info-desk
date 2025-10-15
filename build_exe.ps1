# Info-Desk EXE Builder (PowerShell Version)
Set-Location $PSScriptRoot

Write-Host "========================================"  -ForegroundColor Cyan
Write-Host "Info-Desk EXE Builder" -ForegroundColor Green
Write-Host "========================================"  -ForegroundColor Cyan
Write-Host ""

# Check Python
try {
    $pythonVersion = python --version 2>$null
    Write-Host "Python found: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Python is not installed." -ForegroundColor Red
    Write-Host "Please install Python 3.8+ first." -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

# Install packages
Write-Host "[1/4] Installing required packages..." -ForegroundColor Yellow
pip install -r requirements.txt
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Package installation failed." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Clean previous builds
Write-Host ""
Write-Host "[2/4] Cleaning previous builds..." -ForegroundColor Yellow
Remove-Item -Path "build" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "dist" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "*.spec" -Force -ErrorAction SilentlyContinue

# Build EXE
Write-Host ""
Write-Host "[3/4] Building EXE file..." -ForegroundColor Yellow
Write-Host "This may take a few minutes..." -ForegroundColor Gray

$buildCommand = @(
    "pyinstaller",
    "--onefile",
    "--windowed",
    "--name=`"Info-Desk`"",
    "--add-data=`"config;config`"",
    "--add-data=`"data;data`"",
    "--distpath=`"dist`"",
    "--workpath=`"build`"",
    "--clean",
    "--noconfirm",
    "main.py"
)

& python -m PyInstaller $buildCommand.Substring(1)

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "[ERROR] Build failed!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "[4/4] Build completed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "========================================"  -ForegroundColor Cyan
Write-Host "RESULT: dist\Info-Desk.exe" -ForegroundColor Green
Write-Host "Size: ~50-60 MB" -ForegroundColor Yellow
Write-Host "========================================"  -ForegroundColor Cyan

Read-Host "`nPress Enter to exit"
