#!/usr/bin/env python3
"""
Info-Desk 환경 확인 및 자동 복구 스크립트
"""

import sys
import subprocess
import importlib.util

def check_python():
    """Python 버전 확인"""
    print(f"Python version: {sys.version}")
    print(f"Python executable: {sys.executable}")
    
    version_info = sys.version_info
    if version_info.major < 3 or (version_info.major == 3 and version_info.minor < 8):
        print("⚠️  Warning: Python 3.8+ is recommended")
        return False
    
    print("✓ Python version is compatible")
    return True

def check_package(package_name, import_name=None):
    """패키지 설치 확인"""
    if import_name is None:
        import_name = package_name
    
    try:
        if import_name == 'PyQt5':
            import PyQt5.QtWidgets
            print(f"✓ {package_name} is installed and working")
        else:
            spec = importlib.util.find_spec(import_name)
            if spec is not None:
                print(f"✓ {package_name} is installed")
            else:
                print(f"✗ {package_name} is NOT installed")
                return False
        return True
    except ImportError as e:
        print(f"✗ {package_name} import error: {e}")
        return False

def install_package(package_name):
    """패키지 설치"""
    print(f"Installing {package_name}...")
    try:
        subprocess.check_call([sys.executable, '-m', 'pip', 'install', package_name])
        return True
    except subprocess.CalledProcessError:
        return False

def smart_install_packages():
    """스마트 패키지 설치"""
    packages = {
        'PyQt5': 'PyQt5',
        'openpyxl': 'openpyxl'
    }
    
    missing_packages = []
    
    print("\n=== Checking Required Packages ===")
    for package, import_name in packages.items():
        if not check_package(package, import_name):
            missing_packages.append(package)
    
    if not missing_packages:
        print("\n✓ All required packages are installed!")
        return True
    
    print(f"\n📦 Installing missing packages: {', '.join(missing_packages)}")
    
    success = True
    for package in missing_packages:
        if not install_package(package):
            print(f"❌ Failed to install {package}")
            success = False
        else:
            print(f"✅ Successfully installed {package}")
    
    return success

def test_application():
    """애플리케이션 테스트"""
    print("\n=== Testing Application Components ===")
    
    try:
        # PyQt5 테스트
        from PyQt5.QtWidgets import QApplication
        print("✓ PyQt5 import successful")
        
        # openpyxl 테스트  
        import openpyxl
        print("✓ openpyxl import successful")
        
        # 모델 테스트
        sys.path.append('.')
        from src.models import Participant, DataManager
        print("✓ Data models import successful")
        
        # 검증 테스트
        from src.validators import Validator
        print("✓ Validators import successful")
        
        print("\n🎉 All components are working correctly!")
        return True
        
    except Exception as e:
        print(f"❌ Component test failed: {e}")
        return False

def main():
    """메인 함수"""
    print("=" * 50)
    print("Info-Desk Environment Check & Auto-Fix")
    print("=" * 50)
    
    # Python 확인
    python_ok = check_python()
    
    # 패키지 설치
    packages_ok = smart_install_packages()
    
    if packages_ok:
        # 애플리케이션 테스트
        app_ok = test_application()
        
        if app_ok:
            print("\n" + "=" * 50)
            print("🚀 Ready to run Info-Desk!")
            print("Run: python main.py")
            print("=" * 50)
        else:
            print("\n❌ Application test failed")
            print("Check the error messages above")
    else:
        print("\n❌ Package installation failed")
        print("Try manual installation:")
        print("  pip install PyQt5")
        print("  pip install openpyxl")
    
    input("\nPress Enter to exit...")

if __name__ == "__main__":
    main()
