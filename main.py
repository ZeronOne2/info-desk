#!/usr/bin/env python3
"""
Info-Desk 메인 애플리케이션 진입점
행사 참가자 정보 관리 시스템
"""

import sys
from PyQt5.QtWidgets import QApplication
from src.views import MainWindow


def main():
    app = QApplication(sys.argv)
    app.setApplicationName("Info-Desk")
    app.setApplicationVersion("1.0")
    
    window = MainWindow()
    window.show()
    
    sys.exit(app.exec_())


if __name__ == "__main__":
    main()