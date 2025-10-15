# Info-Desk

> 행사 참가자 정보 관리 시스템

## 프로젝트 개요

Info-Desk는 행사 참가자의 정보를 실시간으로 수집하고 관리할 수 있는 데스크톱 애플리케이션입니다.

## 주요 기능

- **참가자 정보 입력**: 소속사, 이름, ID, 전화번호 입력
- **실시간 데이터 검증**: ID 및 전화번호 형식 자동 검증
- **자동 저장**: 입력 즉시 JSON 파일로 자동 저장
- **개인정보 보호**: ID와 전화번호 마스킹 표시
- **엑셀 내보내기**: 참가자 목록을 Excel 파일로 내보내기
- **안내문구 관리**: 행사 안내 메시지 편집 기능
- **데이터 관리**: 전체 데이터 삭제 및 목록 관리

## 설치 및 실행

### 요구사항

- Python 3.8 이상
- PyQt5 5.15.9
- openpyxl 3.1.2

### 설치 방법

1. **저장소 클론**
   ```bash
   git clone <repository-url>
   cd info-desk
   ```

2. **의존성 설치**
   ```bash
   pip install -r requirements.txt
   ```

3. **애플리케이션 실행**
   ```bash
   python main.py
   ```

## 프로젝트 구조

```
info-desk/
├── main.py              # 메인 진입점
├── requirements.txt     # 패키지 의존성
├── README.md           # 프로젝트 설명
├── CLAUDE.md           # 개발 계획서
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
├── assets/             # 리소스 파일 (아이콘 등)
└── build/              # 빌드 결과물
```

## 사용 방법

### 1. 참가자 정보 입력
- 소속사를 드롭다운에서 선택
- 이름, ID, 전화번호 입력
- ID 형식: `000000-0000000` (6자리-7자리 숫자)
- 전화번호 형식: `010-XXXX-XXXX`
- "저장" 버튼 클릭

### 2. 데이터 관리
- **참가자 목록**: 입력된 데이터를 테이블로 확인 (개인정보 마스킹)
- **목록 숨기기/보기**: 테이블 표시 토글
- **엑셀 내보내기**: 모든 데이터를 Excel 파일로 저장

### 3. 안내문구 편집
- 상단의 🔓 버튼을 클릭하여 편집 모드 활성화
- 안내문구 수정 후 자동 저장
- 🔒 버튼으로 편집 잠금

### 4. 데이터 삭제
- "⚠️ 데이터 전체 삭제" 버튼으로 모든 데이터 삭제
- 2단계 확인 절차로 안전성 확보

## 데이터 형식

### 참가자 데이터 (JSON)
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

### 소속사 설정 (JSON)
```json
{
  "organizations": [
    "회사A",
    "회사B",
    "회사C",
    "개인"
  ]
}
```

## 빌드 (실행 파일 생성)

PyInstaller를 사용하여 독립 실행 파일 생성:

```bash
pip install pyinstaller
pyinstaller --onefile --windowed --name="Info-Desk" --add-data="config;config" main.py
```

생성된 실행 파일은 `dist/Info-Desk.exe`에서 확인할 수 있습니다.

## 기술 스택

- **GUI Framework**: PyQt5
- **데이터 저장**: JSON
- **Excel 처리**: openpyxl
- **패키징**: PyInstaller
- **언어**: Python 3.8+

## 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다.

## 문의

프로젝트에 대한 문의사항이나 버그 리포트는 이슈 트래커를 통해 제출해 주세요.