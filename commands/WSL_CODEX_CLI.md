# WSL · Codex CLI 빠른 명령 모음

시험 중 자주 쓰는 명령을 정리했습니다. WSL 터미널 명령은 터미널에 입력하고, `/`로 시작하는 명령은 Codex 대화 화면에 입력합니다. 경로 예시는 실제 과제 폴더에 맞게 바꿔 주세요.

## WSL 터미널

### 과제 폴더와 파일

```bash
# Windows 과제 폴더로 이동 (계정명과 폴더명을 실제 경로로 바꾸기)
cd "/mnt/c/Users/Windows사용자/바탕 화면/과제폴더"

pwd                     # 현재 위치
ls -la                  # 숨김 파일 포함 목록
cd ..                   # 상위 폴더로 이동
mkdir -p docs           # 폴더 생성 (이미 있어도 괜찮음)
cp -n 원본 대상          # 대상 파일이 있으면 덮어쓰지 않고 복사
rg -n "검색어" .        # 현재 폴더에서 문자열 검색
wslpath -w "$PWD"       # 현재 WSL 경로를 Windows 경로로 변환
explorer.exe .          # 현재 폴더를 Windows 파일 탐색기로 열기
```

하네스 파일을 스크립트 없이 직접 복사할 때는 과제 폴더에서 실행합니다.

```bash
mkdir -p docs
cp -n jshch13-harness/AGENTS.md ./AGENTS.md
cp -n jshch13-harness/templates/AGREEMENT.md docs/AGREEMENT.md
cp -n jshch13-harness/templates/DECISIONS.md docs/DECISIONS.md
cp -n jshch13-harness/templates/VERIFICATION.md docs/VERIFICATION.md
cp -n jshch13-harness/templates/HANDOFF.md docs/HANDOFF.md
```

### Git 확인과 기록

```bash
git status --short         # 변경 파일 확인
git diff -- README.md      # 파일 변경 내용 확인
git diff --check           # 공백 오류 확인
git add 파일명             # 지정한 파일을 커밋에 포함
git commit -m "메시지"     # 로컬 커밋 생성
git log --oneline -5       # 최근 커밋 확인
```

시험 환경 규칙에 따라 `git push`는 사용하지 않습니다.

## Codex CLI

### 터미널에서 실행하는 명령

```bash
codex                 # 현재 폴더를 작업 공간으로 Codex 시작
codex --version       # 설치 버전 확인
codex --help          # 설치 버전에서 지원하는 명령과 옵션 확인
codex resume          # 저장된 대화 목록에서 이어서 열기
codex resume --last   # 현재 폴더의 가장 최근 대화 이어서 열기
```

Codex를 시작하기 전에 과제 폴더로 이동하세요. 그래야 그 폴더의 `AGENTS.md`와 파일을 기준으로 작업합니다.

### Codex 대화 화면에서 쓰는 슬래시 명령

| 명령 | 용도 |
|---|---|
| `/status` | 현재 대화와 실행 설정 확인 |
| `/model` | 사용 모델 선택 |
| `/plan` | 여러 단계 작업의 계획 모드 전환 |
| `/review` | 현재 변경 사항 검토 요청 |
| `/compact` | 긴 대화를 요약해 문맥 공간 확보 |
| `/new` | 같은 폴더에서 새 대화 시작 |
| `/resume` | 저장된 대화 다시 열기 |
파일을 대화에 넣으려면 `@`를 입력하고 파일을 선택할 수 있습니다. `!명령`은 대화 화면에서 로컬 셸 명령을 실행하지만, 시험 규칙과 현재 권한 안에서만 사용하세요. 플랫폼 설정이나 감독·연결 프로세스 설정은 바꾸지 않습니다.

Codex 명령은 버전에 따라 달라질 수 있으므로 `codex --help`와 `/` 자동 완성 목록을 기준으로 합니다. 자세한 내용은 [OpenAI Docs의 Codex CLI 안내](https://developers.openai.com/codex/cli/)와 [명령 레퍼런스](https://developers.openai.com/codex/cli/reference)를 확인하세요.
