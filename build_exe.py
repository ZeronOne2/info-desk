#!/usr/bin/env python3
"""
Info-Desk EXE Builder (Python Version)
"""

import os
import sys
import shutil
import subprocess

def build_exe():
    print("="*40)
    print("Info-Desk EXE Builder")
    print("="*40)
    
    # Change to script directory
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    
    # Install requirements
    print("\n[1/4] Installing required packages...")
    result = subprocess.run([sys.executable, '-m', 'pip', 'install', '-r', 'requirements.txt'])
    if result.returncode != 0:
        print("[ERROR] Package installation failed.")
        return False
    
    # Clean previous builds
    print("\n[2/4] Cleaning previous builds...")
    for path in ['build', 'dist', '*.spec']:
        if os.path.exists(path):
            if os.path.isdir(path):
                shutil.rmtree(path)
            else:
                os.remove(path)
    
    # Build EXE
    print("\n[3/4] Building EXE file...")
    print("This may take a few minutes...")
    
    cmd = [
        sys.executable, '-m', 'PyInstaller',
        '--onefile',
        '--windowed', 
        '--name=Info-Desk',
        '--add-data=config;config',
        '--add-data=data;data',
        '--distpath=dist',
        '--workpath=build',
        '--clean',
        '--noconfirm',
        'main.py'
    ]
    
    result = subprocess.run(cmd)
    if result.returncode != 0:
        print("\n[ERROR] Build failed!")
        return False
    
    print("\n[4/4] Build completed successfully!")
    print("\n" + "="*40)
    print("RESULT: dist/Info-Desk.exe")
    print("Size: ~50-60 MB")
    print("="*40)
    
    return True

if __name__ == "__main__":
    success = build_exe()
    input("\nPress Enter to exit...")
    sys.exit(0 if success else 1)
