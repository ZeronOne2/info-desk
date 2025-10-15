# Info-Desk 프로젝트 개발계획서

> 행사 참가자 정보 관리 시스템

## 1. 프로젝트 개요

### 1.1 프로젝트 명
**Info-Desk**

### 1.2 프로젝트 목적
행사 참가자의 정보를 실시간으로 수집하고 관리할 수 있는 데스크톱 응용프로그램을 개발하여, 행사 운영의 효율성을 높이고 참가자 데이터를 체계적으로 관리합니다.

### 1.3 주요 특징
- 간단하고 직관적인 사용자 인터페이스
- 실시간 데이터 저장으로 데이터 손실 방지
- 입력 데이터 검증을 통한 정확한 정보 수집
- 개인정보 보호를 위한 마스킹 기능
- 엑셀 형식 데이터 내보내기 기능

## 2. 요구사항 분석

### 2.1 기능적 요구사항

#### 2.1.1 데이터 입력
- **소속사**: 드롭다운 리스트에서 선택
- **이름**: 텍스트 입력 (필수)
- **ID**: 6자리 숫자-7자리 숫자 형식 검증
- **전화번호**: 010-XXXX-XXXX 형식 검증

#### 2.1.2 데이터 유효성 검증
- **ID 형식**: 6자리 숫자-7자리 숫자
- **전화번호 형식**: 010-XXXX-XXXX (하이픈 포함)
- **형식 오류 시 경고 메시지 표시**

#### 2.1.3 데이터 표시
- 입력된 데이터를 테이블 형태로 표시
- 소속사와 이름만 표시, ID와 전화번호는 마스킹
  - ID: `123***-*******`
  - 전화번호: `010-****-****`
- 리스트 숨김/보이기 토글 기능

#### 2.1.4 데이터 저장
- 각 데이터 입력 시 즉시 로컬 파일에 저장
- 저장 위치: `./data/`
- 파일 형식: JSON

#### 2.1.5 데이터 내보내기
- 엑셀 파일(.xlsx) 형식으로 내보내기
- 모든 정보(마스킹 없이) 포함

#### 2.1.6 데이터 전체 삭제
- 저장된 모든 참가자 데이터 삭제
- 2단계 확인 절차 (경고 팝업)
- 백업 없이 완전 삭제
- 되돌리기 불가 명시

### 2.2 비기능적 요구사항
- **성능**: 20명 내외의 데이터 처리에 최적화
- **사용성**: 최소한의 학습으로 사용 가능한 직관적 UI
- **신뢰성**: 데이터 손실 방지를 위한 실시간 저장
- **보안**: 민감정보 마스킹 처리
- **이식성**: Windows 환경에서 실행 가능한 독립 실행 파일

## 3. 기술 스택

| 구분 | 기술/도구 |
|------|-----------|
| 프로그래밍 언어 | Python 3.8+ |
| GUI 프레임워크 | PyQt5 |
| 데이터 저장 | JSON 파일 |
| 엑셀 처리 | openpyxl |
| 패키징 | PyInstaller |

## 4. 시스템 아키텍처

### 4.1 전체 구조
Info-Desk는 MVC(Model-View-Controller) 패턴을 기반으로 설계됩니다.

#### 4.1.1 Model (데이터 계층)
- 참가자 정보 데이터 구조 정의
- 데이터 저장/로드 로직
- 데이터 검증 로직

#### 4.1.2 View (UI 계층)
- 메인 윈도우 (입력 폼)
- 참가자 리스트 테이블
- 버튼 및 컨트롤

#### 4.1.3 Controller (제어 계층)
- 사용자 입력 처리
- Model과 View 간 데이터 흐름 제어
- 이벤트 핸들링

### 4.2 디렉토리 구조

```
info-desk/
│
├── main.py              # 메인 진입점
├── requirements.txt     # 패키지 의존성
├── README.md           # 프로젝트 설명
│
├── src/                # 소스 코드
│   ├── __init__.py
│   ├── models.py       # 데이터 모델
│   ├── views.py        # UI 구성
│   ├── controllers.py  # 제어 로직
│   ├── validators.py   # 유효성 검증
│   └── utils.py        # 유틸리티 함수
│
├── data/               # 데이터 저장소
│   └── participants.json
│
├── config/             # 설정 파일
│   ├── organizations.json  # 소속사 리스트
│   └── notice.txt      # 안내문구
│
├── assets/             # 리소스 파일
│   └── icon.ico        # 앱 아이콘
│
└── build/              # 빌드 결과물
    └── info-desk.exe
```

## 5. 주요 기능 명세

### 5.1 데이터 입력 기능

#### 기능 설명
행사 참가자의 정보를 입력받는 기능입니다. 각 필드는 적절한 입력 컨트롤을 사용하여 사용자 편의성을 높입니다.

#### 입력 필드
- **소속사**: QComboBox (드롭다운)
  - 미리 정의된 소속사 리스트에서 선택
  - `config/organizations.json`에서 로드

- **이름**: QLineEdit (텍스트 입력)
  - 필수 입력 필드

- **ID**: QLineEdit (텍스트 입력)
  - 실시간 형식 검증
  - 플레이스홀더: "000000-0000000"

- **전화번호**: QLineEdit (텍스트 입력)
  - 실시간 형식 검증
  - 플레이스홀더: "010-0000-0000"

- **안내문구**: QTextEdit (다중 라인 텍스트)
  - 사용자 편집 가능
  - 잠금/해제 토글 버튼 제공
  - 행사 안내, 주의사항 등 표시

### 5.2 데이터 검증 기능

#### 검증 규칙

**ID 형식**
- 정규표현식: `^\d{6}-\d{7}$`
- 6자리 숫자 + 하이픈 + 7자리 숫자
- 숫자와 하이픈만 허용
- 형식: 000000-0000000

**전화번호 형식**
- 정규표현식: `^010-\d{4}-\d{4}$`
- 010으로 시작
- 하이픈(-) 포함 필수
- 형식: 010-XXXX-XXXX

#### 오류 메시지
- ID 형식 오류: "ID는 000000-0000000 형식(6자리 숫자-7자리 숫자)이어야 합니다."
- 전화번호 형식 오류: "전화번호는 010-XXXX-XXXX 형식이어야 합니다."
- 필수 필드 누락: "이름은 필수 입력 항목입니다."

### 5.3 데이터 표시 기능

#### 테이블 구성
- QTableWidget 사용
- 컬럼: 소속사, 이름, ID, 전화번호
- 읽기 전용 모드

#### 마스킹 처리
- ID: 처음 3자리 숫자만 표시 (예: `123***-*******`)
- 전화번호: `010-****-****` 형식으로 마스킹

#### 숨김/보이기 기능
- 토글 버튼으로 테이블 표시/숨김 제어
- 숨김 상태에서도 데이터는 유지

### 5.4 데이터 저장 기능

#### 저장 방식
- 자동 저장: 데이터 입력 즉시 저장
- 파일 형식: JSON
- 저장 경로: `./data/participants.json`

#### 데이터 구조
```json
{
  "participants": [
    {
      "id": 1,
      "organization": "회사A",
      "name": "홍길동",
      "user_id": "123456-1234567",
      "phone": "010-1234-5678",
      "timestamp": "2025-10-15T10:30:00"
    }
  ]
}
```

### 5.5 엑셀 내보내기 기능

#### 기능 설명
저장된 모든 참가자 정보를 엑셀 파일로 내보냅니다.

#### 파일 형식
- 확장자: `.xlsx`
- 파일명: `participants_YYYYMMDD_HHMMSS.xlsx`
- 컬럼: 번호, 소속사, 이름, ID, 전화번호, 입력시각

#### 엑셀 파일 구성
- 헤더 행: 굵은 글씨, 배경색 적용
- 데이터 행: 전체 데이터 포함 (마스킹 없음)
- 자동 컬럼 너비 조정

### 5.6 안내문구 관리 기능

#### 기능 설명
행사 참가자에게 보여줄 안내 메시지를 관리하는 기능입니다.

#### 주요 기능
- 다중 라인 텍스트 편집 (QTextEdit)
- 편집 잠금/해제 토글 기능
  - 잠금 시: 읽기 전용 모드
  - 해제 시: 편집 가능 모드
- 실시간 저장 (`config/notice.txt`)
- 앱 시작 시 자동 로드

#### UI 구성
- 안내문구 표시 영역 (상단)
- 잠금 아이콘 버튼 (우측 상단)
  - 잠금 상태: 🔒 아이콘
  - 해제 상태: 🔓 아이콘

### 5.7 데이터 전체 삭제 기능

#### 기능 설명
저장된 모든 참가자 데이터를 완전히 삭제하는 기능입니다.

#### 주요 기능
- 데이터 전체 삭제 버튼
  - 버튼 색상: 빨간색 계열 (위험 작업 표시)
  - 버튼 위치: 하단 영역, 분리 배치
- 2단계 확인 절차

#### 삭제 프로세스

**1단계: 삭제 버튼 클릭**
- 사용자가 '데이터 전체 삭제' 버튼 클릭

**2단계: 경고 팝업 표시**
- QMessageBox 경고 다이얼로그 표시
- 팝업 제목: "⚠️ 경고"
- 팝업 메시지:
  ```
  모든 참가자 데이터가 영구적으로 삭제됩니다.
  
  이 작업은 되돌릴 수 없으며 백업되지 않습니다.
  
  정말 삭제하시겠습니까?
  ```
- 버튼 옵션: [삭제] [취소]
  - 삭제 버튼: 빨간색
  - 취소 버튼: 기본 색상 (권장 선택)

**3단계: 데이터 삭제 실행**
- 사용자가 [삭제] 버튼 클릭 시:
  - `participants.json` 파일 내용 초기화
  - 화면의 테이블 내용 지우기
  - 완료 메시지 표시: "모든 데이터가 삭제되었습니다."
- 사용자가 [취소] 버튼 클릭 시: 작업 중단

#### 안전 장치
- 백업 없음 명시: 경고 메시지에서 명확히 안내
- 되돌리기 불가 경고: 복구 불가능함을 강조
- 버튼 색상 차별화: 위험한 작업임을 시각적으로 표시
- 취소 버튼 기본 포커스: Enter 키 실수 방지
- 버튼 분리 배치: 다른 기능 버튼과 물리적으로 분리

## 6. UI/UX 설계

### 6.1 메인 윈도우 레이아웃

#### 최상단 영역: 안내문구
- 안내문구 표시 영역 (QTextEdit)
  - 다중 라인 텍스트
  - 행사 안내, 주의사항 표시
- 잠금 토글 버튼 (우측 상단)
  - 아이콘: 🔒 (잠금) / 🔓 (편집)

#### 상단 영역: 입력 폼
- 제목: "행사 참가자 정보 등록"
- 입력 필드: 레이블 + 입력 컨트롤 세트
  - 소속사: 레이블(좌) + 콤보박스(우)
  - 이름: 레이블(좌) + 텍스트입력(우)
  - ID: 레이블(좌) + 텍스트입력(우)
  - 전화번호: 레이블(좌) + 텍스트입력(우)
- 버튼: 저장, 초기화

#### 중단 영역: 제어 버튼
- 리스트 토글: 참가자 목록 보기/숨기기
- 엑셀 내보내기: Excel 파일 생성

#### 하단 영역: 참가자 리스트
- 테이블 형태
- 스크롤 가능
- 숨김 상태 토글 가능

#### 최하단 영역: 위험 작업 버튼
- 데이터 전체 삭제 버튼
  - 버튼 텍스트: "⚠️ 데이터 전체 삭제"
  - 배경색: #FF6B6B (빨간색)
  - 텍스트 색상: 흰색
  - 배치: 하단 중앙, 다른 버튼과 구분된 영역
  - 여백: 상단 20px 이상 (실수 클릭 방지)

### 6.2 색상 체계
- **주 색상**: #2E5090 (네이비 블루)
- **보조 색상**: #FFFFFF (흰색)
- **경고 색상**: #FF6B6B (밝은 빨강)
- **성공 색상**: #51CF66 (밝은 녹색)

### 6.3 폰트
- **기본 폰트**: 맑은 고딕 10pt
- **제목 폰트**: 맑은 고딕 Bold 12pt
- **버튼 폰트**: 맑은 고딕 Bold 9pt

## 7. 개발 일정

| 단계 | 작업 내용 | 소요 기간 |
|------|-----------|-----------|
| 1단계 | 프로젝트 설정 및 환경 구축 | 1일 |
| 2단계 | 데이터 모델 및 검증 로직 구현 | 2일 |
| 3단계 | UI 구현 (입력 폼 + 테이블) | 3일 |
| 4단계 | 데이터 저장 기능 구현 | 1일 |
| 5단계 | 엑셀 내보내기 기능 구현 | 1일 |
| 6단계 | 통합 테스트 및 버그 수정 | 2일 |
| 7단계 | EXE 파일 패키징 및 배포 준비 | 1일 |
| **총 기간** | | **약 11일** |

## 8. 배포 계획

### 8.1 PyInstaller를 이용한 EXE 생성

#### 빌드 명령어
```bash
pyinstaller --onefile --windowed \
  --name="Info-Desk" \
  --icon="assets/icon.ico" \
  --add-data="config;config" \
  --add-data="assets;assets" \
  main.py
```

#### 빌드 옵션 설명
- `--onefile`: 단일 실행 파일로 패키징
- `--windowed`: 콘솔 창 숨김 (GUI 앱)
- `--name`: 실행 파일 이름 지정
- `--icon`: 애플리케이션 아이콘 지정 (.ico 파일)
- `--add-data`: 설정 파일 및 리소스 포함

#### 아이콘 준비 사항
- 파일 형식: .ico (Windows 아이콘 형식)
- 권장 크기: 256x256 픽셀
- 위치: `assets/icon.ico`
- 준비 방법: PNG 이미지를 온라인 도구로 ICO 변환 (예: convertio.co)

### 8.2 배포 패키지 구성

최종 배포 패키지는 다음과 같이 구성됩니다:

```
Info-Desk_v1.0/
│
├── Info-Desk.exe       # 실행 파일
├── README.txt          # 사용 설명서
│
├── config/             # 설정 파일
│   └── organizations.json
│
└── data/               # 데이터 폴더 (자동 생성)
```

### 8.3 설치 및 실행 가이드

#### 설치 방법
1. Info-Desk_v1.0 폴더를 원하는 위치에 복사
2. Info-Desk.exe를 더블클릭하여 실행

#### 시스템 요구사항
- 운영체제: Windows 10 이상
- 메모리: 최소 2GB RAM
- 디스크 공간: 최소 50MB

## 9. 부록

### 9.1 주요 패키지 버전

| 패키지 | 권장 버전 |
|--------|-----------|
| Python | 3.8+ |
| PyQt5 | 5.15.9 |
| openpyxl | 3.1.2 |
| PyInstaller | 5.13.0 |

### 9.2 샘플 코드: 데이터 검증

```python
# validators.py
import re

def validate_user_id(user_id):
    """ID 형식 검증"""
    pattern = r'^\d{6}-\d{7}$'
    return bool(re.match(pattern, user_id))

def validate_phone(phone):
    """전화번호 형식 검증"""
    pattern = r'^010-\d{4}-\d{4}$'
    return bool(re.match(pattern, phone))
```

### 9.3 샘플 설정 파일

```json
// config/organizations.json
{
  "organizations": [
    "회사A",
    "회사B", 
    "회사C",
    "개인"
  ]
}
```

### 9.4 샘플 코드: 데이터 삭제 기능

```python
# controllers.py 일부
from PyQt5.QtWidgets import QMessageBox

def delete_all_data(self):
    """모든 데이터 삭제 (경고 팝업 포함)"""
    # 경고 메시지 박스 생성
    msg_box = QMessageBox()
    msg_box.setIcon(QMessageBox.Warning)
    msg_box.setWindowTitle("⚠️ 경고")
    msg_box.setText(
        "모든 참가자 데이터가 영구적으로 삭제됩니다.\n\n"
        "이 작업은 되돌릴 수 없으며 백업되지 않습니다.\n\n"
        "정말 삭제하시겠습니까?"
    )
    
    # 버튼 설정
    msg_box.setStandardButtons(
        QMessageBox.Yes | QMessageBox.No
    )
    msg_box.setDefaultButton(QMessageBox.No)  # 취소 버튼 기본
    
    button_yes = msg_box.button(QMessageBox.Yes)
    button_yes.setText("삭제")
    
    button_no = msg_box.button(QMessageBox.No)
    button_no.setText("취소")
    
    # 사용자 응답 처리
    reply = msg_box.exec_()
    
    if reply == QMessageBox.Yes:
        # 데이터 파일 초기화
        self.data_manager.clear_all_data()
        # UI 테이블 초기화
        self.table.setRowCount(0)
        # 완료 메시지
        QMessageBox.information(
            self, "완료", "모든 데이터가 삭제되었습니다."
        )
```

### 9.5 아이콘 준비 가이드

#### 개요
Info-Desk 애플리케이션의 독자적인 아이콘을 설정하면 사용자 경험이 향상됩니다.

#### 아이콘 파일 사양
- 파일 형식: .ico (Windows Icon)
- 권장 해상도: 256x256 픽셀
- 배경: 투명 또는 단색
- 저장 위치: `assets/icon.ico`

#### 아이콘 제작 방법

**방법 1: 온라인 도구 사용**
1. PNG 또는 JPG 이미지 준비 (256x256 권장)
2. 온라인 변환 사이트 접속 (예: convertio.co, favicon.io)
3. 이미지를 .ico 형식으로 변환
4. 다운로드한 파일을 `assets/icon.ico`로 저장

**방법 2: 그래픽 도구 사용**
- GIMP, Photoshop 등의 도구로 직접 .ico 파일 제작
- 여러 해상도(16x16, 32x32, 48x48, 256x256)를 포함하는 멀티 아이콘 생성 가능

#### 아이콘 디자인 팁
- 간결하고 명확한 디자인 (복잡한 세부사항은 작은 크기에서 보이지 않음)
- 브랜드 색상 활용
- 행사/정보 관련 심볼 사용 (예: 체크리스트, 명찰, 등록 부스 등)
- 작은 크기에서도 식별 가능한 형태

#### 개발 시 유의사항
아이콘 파일이 준비되지 않았을 경우, PyInstaller는 기본 Python 아이콘을 사용합니다. 전문적인 앱 외관을 위해 개발 초기에 커스텀 아이콘을 준비하는 것을 권장합니다.

#### 참고 자료
- 무료 아이콘: [flaticon.com](https://flaticon.com), [icons8.com](https://icons8.com)
- ICO 변환: [convertio.co/png-ico](https://convertio.co/png-ico), [favicon.io](https://favicon.io)
- 아이콘 에디터: GIMP (무료), Photoshop

---

## 프로젝트 초기화 및 개발 환경 설정

### 개발 환경
- Python 3.8+ (권장: Python 3.10)
- PyQt5 5.15.9
- 개발 OS: Windows/Linux/macOS
- IDE: VS Code 또는 PyCharm 권장

### 프로젝트 초기화 명령어

```bash
# 프로젝트 디렉토리 생성
mkdir info-desk
cd info-desk

# 가상환경 생성 및 활성화
python -m venv venv

# Windows:
venv\Scripts\activate

# Linux/macOS:
source venv/bin/activate

# 필수 패키지 설치
pip install PyQt5==5.15.9 openpyxl==3.1.2

# 개발용 추가 패키지
pip install pyinstaller==5.13.0

# requirements.txt 생성
pip freeze > requirements.txt
```

### 디렉토리 구조 초기화

```bash
# 디렉토리 생성
mkdir src data config assets build
touch main.py README.md
cd src
touch __init__.py models.py views.py controllers.py validators.py utils.py
cd ..

# 설정 파일 초기화 (config 디렉토리)
echo '{"organizations": ["회사A", "회사B", "회사C", "개인"]}' > config/organizations.json
echo "행사에 오신 것을 환영합니다.\n\n참가자 정보를 정확히 입력해 주세요." > config/notice.txt

# 데이터 디렉토리 초기화
echo '{"participants": []}' > data/participants.json
```

### 테스트 명령어

```bash
# PyQt5 설치 확인
python -c "import PyQt5; print('PyQt5 version:', PyQt5.Qt.PYQT_VERSION_STR)"

# 메인 애플리케이션 실행
python main.py
```

### 린트 및 타입 체크 명령어

```bash
# 코드 스타일 검사 (PEP8)
pip install flake8
flake8 . --max-line-length=120

# 타입 체크 (선택사항)
pip install mypy
mypy main.py --ignore-missing-imports
```

### 빌드 명령어 (Windows)

```bash
# 실행 파일 생성
pyinstaller --onefile --windowed --name="Info-Desk" --add-data="config;config" --add-data="assets;assets" main.py
```

### Git 초기화 (선택사항)

```bash
git init
echo "venv/" > .gitignore
echo "__pycache__/" >> .gitignore
echo "*.pyc" >> .gitignore
echo "build/" >> .gitignore
echo "dist/" >> .gitignore
echo "*.spec" >> .gitignore
echo "data/participants.json" >> .gitignore
git add .
git commit -m "Initial project setup"
```

---

**문서 작성일**: 2025년 1월 15일  
**버전**: 1.0