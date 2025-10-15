# Info-Desk Smart Installation Script
Set-Location $PSScriptRoot
Write-Host "Installing Info-Desk..." -ForegroundColor Green
Write-Host "Current directory: $(Get-Location)" -ForegroundColor Cyan

# Check Python installation
try {
    $pythonVersion = python --version 2>$null
    Write-Host "Python found: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Python is not installed or not in PATH." -ForegroundColor Red
    Write-Host "Please download Python 3.8+ from: https://python.org" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

# Function to try installation
function Try-Installation($requirementsFile) {
    Write-Host "Trying installation with $requirementsFile..." -ForegroundColor Yellow
    try {
        pip install -r $requirementsFile
        return $LASTEXITCODE -eq 0
    } catch {
        return $false
    }
}

# Try different installation methods
$installationMethods = @(
    "requirements.txt",
    "requirements_stable.txt", 
    "requirements_minimal.txt"
)

$success = $false
foreach ($method in $installationMethods) {
    if (Test-Path $method) {
        if (Try-Installation $method) {
            Write-Host "Installation successful with $method!" -ForegroundColor Green
            $success = $true
            break
        }
    }
}

# Manual installation as last resort
if (-not $success) {
    Write-Host "All automatic methods failed. Trying manual installation..." -ForegroundColor Yellow
    try {
        pip install PyQt5 openpyxl
        if ($LASTEXITCODE -eq 0) {
            Write-Host "Manual installation successful!" -ForegroundColor Green
            $success = $true
        }
    } catch {
        # Continue to error handling
    }
}

if ($success) {
    Write-Host "`n========================================" -ForegroundColor Green
    Write-Host "Installation completed successfully!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "You can now run 'python main.py' or double-click run.bat" -ForegroundColor Cyan
} else {
    Write-Host "`nERROR: All installation methods failed." -ForegroundColor Red
    Write-Host "Please try manually:" -ForegroundColor Yellow
    Write-Host "1. pip install --upgrade pip" -ForegroundColor White
    Write-Host "2. pip install PyQt5" -ForegroundColor White  
    Write-Host "3. pip install openpyxl" -ForegroundColor White
}

Read-Host "`nPress Enter to exit"
